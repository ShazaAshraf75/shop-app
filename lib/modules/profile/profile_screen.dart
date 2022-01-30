// ignore_for_file: must_be_immutable, file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/states.dart';
import 'package:shopping_app/shared/styles/themes/theme.dart';


class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopUserModel = ShopCubit.get(context).shopUserModel;
        // var shopUpdateProfileModel = ShopCubit.get(context).shopUpdateProfileModel;
        nameController.text = shopUserModel!.data!.name!;
        emailController.text = shopUserModel.data!.email!;
        phoneController.text = shopUserModel.data!.phone!;
        return ConditionalBuilder(
            // ignore: unnecessary_null_comparison
            condition: shopUserModel != null,
            builder: (context) => Form(
                  key: formKey,
                  child: Scaffold(
                    appBar: AppBar(
                      toolbarHeight: 50,
                      backgroundColor: redColor,
                      title: Align(
                        // alignment: Alignment.centerLeft,
                        child: Text("Profile",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 35,
                                    letterSpacing: 2)),
                      ),
                    ),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: AlignmentDirectional.topCenter,
                            children: [
                              Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(200),
                                      bottomRight: Radius.circular(200)),
                                  color: redColor,
                                ),
                              ),
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Positioned(
                                    top: 60,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 10,
                                              color: Colors.black45,
                                              spreadRadius: 0.1)
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.person,
                                          size: 80,
                                          color: redColor!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (state is ShopLoadingUpdateUserDataState)
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: LinearProgressIndicator(),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultTextField(
                                  context: context,
                                  unactiveBorderColor: redColor,
                                  labelColor: Colors.grey[600],
                                  textColor: Colors.grey[600],
                                  controller: nameController,
                                  radius: 50,
                                  padding: 10,
                                  prefixIcon: Icons.person,
                                  label: "Full Name",
                                  textInputType: TextInputType.name,
                                  validate: (value) {}),
                              defaultTextField(
                                  context: context,
                                  unactiveBorderColor: redColor,
                                  labelColor: Colors.grey[600],
                                  textColor: Colors.grey[600],
                                  controller: emailController,
                                  radius: 50,
                                  padding: 10,
                                  prefixIcon: Icons.mail,
                                  label: "Email Address",
                                  textInputType: TextInputType.emailAddress,
                                  validate: (value) {}),
                              defaultTextField(
                                  context: context,
                                  unactiveBorderColor: redColor,
                                  labelColor: Colors.grey[600],
                                  textColor: Colors.grey[600],
                                  controller: phoneController,
                                  radius: 50,
                                  padding: 10,
                                  prefixIcon: Icons.phone_android,
                                  label: "Phone Number",
                                  textInputType: TextInputType.phone,
                                  validate: (value) {}),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    defaultButton(
                                      height: 60,
                                      backgroundColor: redColor!,
                                      radius: 50,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          ShopCubit.get(context).updateUserData(
                                              name: nameController.text,
                                              email: emailController.text,
                                              phone: phoneController.text);
                                        }
                                      },
                                      label: "Update",
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 24,
                                          ),
                                    ),
                                    const SizedBox(height: 10),
                                    defaultButton(
                                      height: 60,
                                      backgroundColor: redColor!,
                                      radius: 50,
                                      onPressed: () {
                                        signOut(context);
                                      },
                                      label: "Log Out",
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 24,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}
