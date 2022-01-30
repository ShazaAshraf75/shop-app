import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/shop_layout.dart';
import 'package:shopping_app/modules/login/shop_login_screen.dart';
import 'package:shopping_app/shared/network/local/cache_helper.dart';
import 'package:shopping_app/shared/styles/themes/theme.dart';


import 'cubit /cubit.dart';
import 'cubit /states.dart';

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController registerFullNameController = TextEditingController();
    TextEditingController registerPhoneController = TextEditingController();
    TextEditingController registerPasswordController = TextEditingController();
    TextEditingController registerEmailController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status!) {
              CacheHelper.saveData(
                      key: "Token", value: state.registerModel.data!.token)
                  .then((value) {
                token = state.registerModel.data!.token;
                navigateAndFinish(context, ShopLayout());
              });

              showToast(
                  text: state.registerModel.message!,
                  state: ToastStates.SUCCESS);
            } else {
              showToast(
                  text: state.registerModel.message!, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "Register",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Register now to browse our hot offers",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultTextField(
                        labelColor: greyColor,
                        preffixIconColor: greyColor,
                        unactiveBorderColor: greyColor,
                        context: context,
                        controller: registerFullNameController,
                        radius: 25,
                        padding: 0,
                        prefixIcon: Icons.person,
                        label: "Username",
                        textInputType: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your Full name";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultTextField(
                        context: context,
                        labelColor: greyColor,
                        preffixIconColor: greyColor,
                        unactiveBorderColor: greyColor,
                        controller: registerPhoneController,
                        radius: 25,
                        padding: 0,
                        prefixIcon: Icons.phone_android,
                        label: "Phone Number ",
                        textInputType: TextInputType.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your Phone Number";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultTextField(
                        context: context,
                        labelColor: greyColor,
                        preffixIconColor: greyColor,
                        unactiveBorderColor: greyColor,
                        controller: registerEmailController,
                        radius: 25,
                        padding: 0,
                        prefixIcon: Icons.email_outlined,
                        label: "Email Address ",
                        textInputType: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email address";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultTextField(
                        obsecure: ShopRegisterCubit.get(context).isObsecure,
                        labelColor: greyColor,
                        preffixIconColor: greyColor,
                        suffixIconColor: greyColor,
                        unactiveBorderColor: greyColor,
                        context: context,
                        controller: registerPasswordController,
                        radius: 25,
                        padding: 0,
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: ShopRegisterCubit.get(context).suffix,
                        suffixPressed: () {
                          ShopRegisterCubit.get(context)
                              .changePasswordVisibility();
                        },
                        label: "Password",
                        textInputType: TextInputType.visiblePassword,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    ConditionalBuilder(
                      condition: state is! ShopRegisterLoadingState,
                      builder: (context) => defaultButton(
                          height: 55,
                          backgroundColor: redColor!,
                          radius: 25,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // print(registerEmailController.text);
                              // print(registerPasswordController.text);
                              // print(registerFullNameController.text);
                              // print(registerPhoneController.text);
                              ShopRegisterCubit.get(context).userRegister(
                                  email: registerEmailController.text,
                                  password: registerPasswordController.text,
                                  name: registerFullNameController.text,
                                  phone: registerPhoneController.text);
                            }
                          },
                          label: "Sign In",
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white, fontSize: 20)),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ?",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        TextButton(
                            onPressed: () {
                              navigateAndFinish(
                                  context, const ShopLoginScreen());
                            },
                            child: Text(
                              "LOG IN",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: darkRedColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
