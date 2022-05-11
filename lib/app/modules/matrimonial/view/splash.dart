import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/size_config.dart';

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
      child: Opacity(
        opacity: 0.65,
          child: Image.asset(
        "assets/images/sunnat.png",
        fit: BoxFit.fill,
      )),
    );
  }

  checkWhereToGo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if((prefs.getString('id') == null || (prefs.getString('caste') == null))){
      Timer(
          Duration(seconds: 3),
              () => Get.toNamed(Routes.LOGIN_SCREEN));
    }else{
      Timer(
          Duration(seconds: 3),
              () => Get.toNamed(Routes.ALL_CASTES_MAIN_PAGE));
    }
  }
  void saveTokenInLocal(String? value)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "${value}");
    print('TOKEN STORED '+ "${value}");
  }
}
