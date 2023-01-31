import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_pages.dart';
import '../utils/size_config.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseMessaging? messaging;
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging?.getToken().then((value) {
      print(value);
      saveTokenInLocal(value);
    });
    checkWhereToGo();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight,
            child: Image.asset("assets/images/image_five.png",
              fit: BoxFit.fill,),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: SizeConfig.screenHeight*.07),
              child: Opacity(
                  opacity: 0.95,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.fill, height: 80, width: 80,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  checkWhereToGo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if((prefs.getString('id') == null || (prefs.getString('caste') == null)
        || (prefs.getString('id') == '') || (prefs.getString('caste') == ''))){
      Timer(
          Duration(seconds: 3),
              () => Get.toNamed(Routes.LOGIN_SCREEN));
    }else{
      Timer(
          Duration(seconds: 3),
              () => Get.toNamed(Routes.MAIN_SCREEN));
    }
  }
  void saveTokenInLocal(String? value)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "${value}");
    print('TOKEN STORED '+ "${value}");
  }
}
