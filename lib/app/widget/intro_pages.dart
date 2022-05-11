import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/size_config.dart';

class IntroScreenPageOne extends StatelessWidget {
  String imagePath;
  String heading;
  String subText;
  String buttonText;
  String skipContinue;
  double pageNumber;
  IntroScreenPageOne(
      {required this.imagePath,
        required this.heading,
        required this.buttonText,
        required this.skipContinue,
        required this.subText,
        required this.pageNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Stack(
            children: <Widget>[
              itemsOfScreen(context, imagePath, heading, subText, buttonText,
                  skipContinue, pageNumber),
            ],
          ),
        ),
    );
        // ListView(
        //   children: <Widget>[
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: <Widget>[
        //         itemsOfScreen(context, imagePath, heading, subText, buttonText,
        //             skipContinue, pageNumber),
        //         GestureDetector(
        //           onTap: () {},
        //           child: Container(
        //             margin: EdgeInsets.only(
        //                 top: SizeConfig.screenHeight * .18,
        //                 left: SizeConfig.seventyFivePercentWidth,
        //                 bottom: 20),
        //             child: Text(
        //               skipContinue,
        //               style: TextStyle(
        //                   fontSize: 20,
        //                   fontWeight: FontWeight.w900,
        //                   color: ColorsX.myblack),
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ],
        // ));
  }

  Widget itemsOfScreen(
      BuildContext context,
      String imagePath,
      String heading,
      String subText,
      String buttonText,
      String skipContinue,
      double pageNumber) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: SizeConfig.screenWidth,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.screenHeight * .78,
                  left: SizeConfig.seventyFivePercentWidth,
                  bottom: 20),
              child: Text(
                skipContinue,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: ColorsX.blue_lightest),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: DotsIndicator(
              dotsCount: 3,
              position: pageNumber,
              decorator: DotsDecorator(
                size: const Size.square(5.0),
                activeSize: const Size(30, 5.0),
                color: ColorsX.white,
                activeColor: Color(0xff34aecd),
                spacing: EdgeInsets.only(left: 2, right: 2),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Text(
              heading,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: ColorsX.white),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(
                  top: 20,
                  left: SizeConfig.tenPercentWidth,
                  right: SizeConfig.tenPercentWidth),
              child: Text(
                subText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: ColorsX.white,
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  //Navigator.pushNamed(context, '/ConnectWith');
                  // Get.toNamed(Routes.MAIN_CONTINUE_AS_SCREEN);
                  // Get.toNamed(Routes.CONNECT_WITH);
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 30,
                  ),
                  width: SizeConfig.eightyPercentWidth,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: ColorsX.blue_gradient_dark,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(buttonText,
                          style: const TextStyle(
                            fontSize: 16,
                            color: ColorsX.white,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  ),
                ),
              )),
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            color: const Color(0xff969B9B).withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
