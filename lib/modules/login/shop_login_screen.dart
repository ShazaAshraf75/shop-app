// ignore_for_file: unnecessary_string_escapes, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/layout/shop_layout.dart';
import 'package:shopping_app/modules/register/shop_register_screen.dart';
import 'package:shopping_app/shared/network/local/cache_helper.dart';
import 'package:shopping_app/shared/styles/themes/theme.dart';

import 'cubit /cubit.dart';
import 'cubit /states.dart';


class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if (state is ShopLoginSuccessState) {
              if (state.loginModel.status) {
                CacheHelper.saveData(
                        key: "Token", value: state.loginModel.data!.token)
                    .then((value) {
                  token = state.loginModel.data!.token;
                  navigateAndFinish(context, ShopLayout());
                });

                showToast(
                    text: state.loginModel.message, state: ToastStates.SUCCESS);
              } else {
                showToast(
                    text: state.loginModel.message, state: ToastStates.ERROR);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: redColor),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Login now to browse our hot offers",
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
                          controller: emailController,
                          radius: 25,
                          padding: 0,
                          prefixIcon: Icons.email_outlined,
                          label: "Email",
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
                          obsecure: ShopLoginCubit.get(context).isObsecure,
                          labelColor: greyColor,
                          preffixIconColor: greyColor,
                          suffixIconColor: greyColor,
                          unactiveBorderColor: greyColor,
                          context: context,
                          controller: passwordController,
                          radius: 25,
                          padding: 0,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: ShopLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
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
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => defaultButton(
                            height: 55,
                            backgroundColor: redColor!,
                            radius: 25,
                            onPressed: () {
                              print(emailController.text);
                              print(passwordController.text);

                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            label: "LOG IN",
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
                            "Don\'t have an account ?",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          TextButton(
                              onPressed: () {
                                navigateAndFinish(
                                    context, const ShopRegisterScreen());
                              },
                              child: Text(
                                "REGISTER",
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
        ));
  }
}
