// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/model/login_model.dart';
import 'package:shopping_app/modules/login/cubit%20/states.dart';
import 'package:shopping_app/shared/network/end_points.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isObsecure = true;
  late ShopLoginModel loginModel;

  void changePasswordVisibility() {
    isObsecure = !isObsecure;
    suffix =
        isObsecure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginChangePasswordVisibilityState());
  }

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {"email": email, "password": password})
        .then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel.status);
      print(loginModel.message);

      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}
