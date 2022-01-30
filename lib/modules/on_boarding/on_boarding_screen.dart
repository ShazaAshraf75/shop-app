// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/components/components.dart';
import 'package:shopping_app/modules/login/shop_login_screen.dart';
import 'package:shopping_app/shared/network/local/cache_helper.dart';
import 'package:shopping_app/shared/styles/themes/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({required this.image, required this.title, required this.body});
}

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
        image: "assets/images/board1.png",
        title: "Shopping Online",
        body:
            "Our new service makes it easy for you to work anywhere, there are new features will really help you."),
    BoardingModel(
        image: "assets/images/board2.png",
        title: "Track Your Order",
        body:
            "Our new service makes it easy for you to work anywhere, there are new features will really help you."),
    BoardingModel(
        image: "assets/images/board3.png",
        title: "Get Your Order",
        body:
            "Our new service makes it easy for you to work anywhere, there are new features will really help you."),
  ];
  void submit() {
    CacheHelper.saveData(key: "onBoarding", value: true).then((value) {
      if (value) {
        navigateAndFinish(context, const ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text(
                "SKIP  ",
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: redColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1)),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });

                    // navigateTo(context, const ShopLoginScreen());
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(context, boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      expansionFactor: 5,
                      dotColor: lightRedColor!,
                      activeDotColor: redColor!,
                      spacing: 5,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast == true) {
                        submit();
                      } else {
                        boardController.nextPage(
                            // ignore: prefer_const_constructors
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: redColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(context, BoardingModel model) => Column(
        children: [
          Expanded(
            child: Image.asset(
              model.image,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.body,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
}
