// ignore_for_file: prefer_if_null_operators, constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/modules/login/shop_login_screen.dart';
import 'package:shopping_app/shared/network/local/cache_helper.dart';
import 'package:shopping_app/shared/styles/themes/theme.dart';


String? token = "";

Widget defaultTextField({
  required BuildContext context,
  required TextEditingController controller,
  required double radius,
  required double padding,
  required IconData prefixIcon,
  required String label,
  required TextInputType textInputType,
  required String? Function(String?)? validate,
  IconData? suffixIcon,
  Color? unactiveBorderColor,
  Color? suffixIconColor,
  Color? preffixIconColor,
  Color? labelColor,
  Color? textColor = Colors.grey,
  void Function(String?)? onChange,
  void Function()? suffixPressed,
  bool obsecure = false,
}) =>
    Padding(
      padding: EdgeInsets.all(padding),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFormField(
          style: TextStyle(color: textColor),
          obscureText: obsecure,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: unactiveBorderColor == null
                        ? Colors.grey
                        : unactiveBorderColor,
                    width: 2),
                borderRadius: BorderRadius.all(Radius.circular(radius))),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius))),
            prefixIcon: Icon(
              prefixIcon,
              color: preffixIconColor == null ? Colors.grey : preffixIconColor,
            ),
            suffixIcon: IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffixIcon,
                  color:
                      suffixIconColor == null ? Colors.grey : suffixIconColor,
                )),
            labelText: label,
            labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: labelColor == null ? Colors.grey : labelColor,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
          ),
          controller: controller,
          keyboardType: textInputType,
          validator: validate,
          onChanged: onChange,
        )
      ]),
    );
Widget defaultButton({
  required double height,
  required Color backgroundColor,
  required double radius,
  required void Function()? onPressed,
  required String label,
  required TextStyle labelStyle,
}) =>
    Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(radius)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(label, style: labelStyle),
      ),
    );
void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);
void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void signOut(context) {
  CacheHelper.removeData(key: "Token").then((value) {
    if (value) {
      navigateAndFinish(context, const ShopLoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

Widget buildListProducts(item, context, {bool isOldPrice = true}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: NetworkImage(item.image!),
                    height: 120,
                    width: 120,
                  ),
                ),
                if (item.discount != 0 && isOldPrice)
                  Container(
                    padding: const EdgeInsets.all(3),
                    color: Colors.red[600],
                    child: const Text(
                      "Discount",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          letterSpacing: 0,
                          color: Colors.black,
                          height: 1.1),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${(item.price / 60).round()} KD",
                          style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 1,
                            color: redColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (item.discount != 0 && isOldPrice)
                          Text(
                            "${(item.oldPrice / 60).round()}",
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 1,
                              color: greyColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favourites[item.id]!
                                  ? redColor
                                  : greyColor,
                          radius: 14,
                          child: IconButton(
                              iconSize: 13,
                              onPressed: () {
                                ShopCubit.get(context)
                                    .changeFavourites(item.id!);
                              },
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
