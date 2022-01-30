// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/model/register_model.dart';
import 'package:shopping_app/modules/register/cubit%20/states.dart';
import 'package:shopping_app/shared/network/end_points.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isObsecure = true;
  late ShopRegisterModel registerModel;

  void changePasswordVisibility() {
    isObsecure = !isObsecure;
    suffix =
        isObsecure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      "email": email,
      "password": password,
      "name": name,
      "phone": phone
    }).then((value) {
      registerModel = ShopRegisterModel.fromJson(value.data);
      // print(registerModel.status);

      emit(ShopRegisterSuccessState(registerModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}
