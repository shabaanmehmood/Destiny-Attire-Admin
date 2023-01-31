import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/colors.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/global_widgets.dart';
import '../../../utils/size_config.dart';


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailCtl = new TextEditingController();
  TextEditingController passwordCtl = new TextEditingController();
  GlobalWidgets globalWidgets = GlobalWidgets();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: body(context),
      ),
    );
  }

  body(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      color:  const Color(0xff000000).withOpacity(0.8),
      // decoration: const BoxDecoration(
      //   color:  const Color(0xff969B9B).withOpacity(0.5),
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: SizeConfig.screenHeight * .12),
                child: Image.asset('assets/images/logo.png', height: 80, width: 80,)),
          ),
          Align(
            alignment: Alignment.center,
            child: myText(context, "Already have an account ? Continue to Login", ColorsX.white, SizeConfig.screenHeight*.05, 10, 0, 10, FontWeight.w400, 18.0,),
          ),
          globalWidgets.myTextField(TextInputType.emailAddress, emailCtl, false, "Email ID" ),
          SizedBox(height: 15,),
          globalWidgets.myTextField(TextInputType.text, passwordCtl, true, "Password" ),
          SizedBox(height: 15,),
          Align(
            alignment: Alignment.centerRight,
            child: myText(context, "Forgot Password?", ColorsX.white, 0, 0, 10, 10, FontWeight.w400, 16,),
          ),
          loginButton(context),
          Align(
            alignment: Alignment.center,
            child: myText(context, "Don't have an account ? Click to Register", ColorsX.white, 30, 10, 0, 10, FontWeight.w400, 18.0,),
          ),
          signUpButton(context),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: registerNowText(context,20,10,10,0),
          // ),
        ],
      ),
    );
  }
  registerNowText(BuildContext context, double top, double right, double left, double bottom){
    return GestureDetector(
      onTap: (){
        Get.toNamed(Routes.REGISTER_NOW);
      },
      child: Container(
        margin: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Don't have an account? ", style: TextStyle(color: ColorsX.white, fontSize: 16),
              ),
              TextSpan(
                text: "Register Now !", style: TextStyle(color: ColorsX.yellowColor, fontSize: 16, fontWeight: FontWeight.w700),
              )
            ]
          ),
        ),
      ),
    );
  }
  loginButton(BuildContext context,){
    return GestureDetector(
      onTap: (){

        if (emailCtl.text.trim().isEmpty) {
          GlobalWidgets.showErrorToast(
              context, "Email required", 'Please provide your email id');
        }
        else if (passwordCtl.text.trim().isEmpty) {
          GlobalWidgets.showErrorToast(
              context, "Password", 'Please Provide your Password');
        }
        else if(!GlobalWidgets.validateEmail(emailCtl.text)){
          GlobalWidgets.showErrorToast(context, "Email not valid", 'Please provide valid email');
        }
        else{
          // loginNow(emailCtl.text.toString(),passwordCtl.text.toString(), context);
          checkIfEmailExists(emailCtl.text.toString(),passwordCtl.text.toString(), context);
        }
      },
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: ColorsX.light_orange,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: myText(context, "Login Now", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
        ),
      ),
    );
  }
  signUpButton(BuildContext context,){
    return GestureDetector(
      onTap: (){
        Get.toNamed(Routes.REGISTER_NOW);
      },
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: ColorsX.light_orange,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: myText(context, "Register Now", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
        ),
      ),
    );
  }
  myTextField(TextInputType inputType, TextEditingController ctl, bool obscureText, String hint){
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        border: Border.all(color: ColorsX.white, width: 1.25)
      ),
      child: TextFormField(
        keyboardType: inputType,
        controller: ctl,
        obscureText: obscureText,
        decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: hint, hintStyle: TextStyle(color: ColorsX.white)
        ),
      ),
    );
  }
  myText(BuildContext context, String text, Color colorsX, double top, double left, double right, double bottom,
      FontWeight fontWeight, double fontSize){
    return Container(
      margin: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      child: Text(text, style: GoogleFonts.mukta(textStyle: TextStyle( color: colorsX, fontWeight: fontWeight,
          fontSize: fontSize)),),
    );
  }
  // Future<void> getData(String email) async {
  //   // Get docs from collection reference
  //
  //   GlobalWidgets.showProgressLoader("Validating Data");
  //
  //
  //   // return documents.length == 1;
  //
  //
  //   CollectionReference _collectionRef =
  //   FirebaseFirestore.instance.collection('candidates');
  //   QuerySnapshot querySnapshot = await _collectionRef.get();
  //
  //   // Get data from docs and convert map to List
  //   final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //
  //   print(allData);
  //   GlobalWidgets.hideProgressLoader();
  // }

  Future<String> checkIfEmailExists(String email, String password, BuildContext context) async {
    // Get docs from collection reference
    String response = '';
    GlobalWidgets.hideKeyboard(context);
    GlobalWidgets.showProgressLoader("Validating Data");

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('admins')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .limit(1)
        .get();

    final List<DocumentSnapshot> documents = querySnapshot.docs;
    GlobalWidgets.hideProgressLoader();
    if(documents.isEmpty) {
      errorDialog(context);
    }
    else {
      print(documents.first);

      String id = querySnapshot.docs[0].reference.id;
      //parsing of data to save in shared preferences
      for (var doc in querySnapshot.docs) {
        // Getting data directly
        String token = doc.get('token');
        saveDataInLocal(context,  token, id);
        // Get.toNamed(Routes.MAIN_SCREEN);

        // String religion = doc.get('religion');
        // String caste = doc.get('caste');
        // String subcaste = doc.get('subcaste');
        // String sect = doc.get('sect');
        // String account_created_at = doc.get('account_created_at');
        // String mother_tongue = doc.get('mother_tongue');
        // String phone = doc.get('primary_phone');
        // String gender = doc.get('gender');
        // saveDataInLocal(id,caste,religion,subcaste,sect,account_created_at,mother_tongue,phone,gender);
        // debugPrint(id);
        // Getting data from map
        // Map<String, dynamic> data = doc.data();
        // int age = data['age'];
      }
    }

    return response;
  }

  errorDialog(BuildContext context) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Invalid Credentials',
        desc:
        'Please try again with valid email and password',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }

  Future<void> saveDataInLocal(BuildContext context, String tokenSavedOnServer, String id) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('email', "${email}");
    String? tokenGeneratedByApp = prefs.getString('token');
    if(tokenGeneratedByApp == tokenSavedOnServer){
      prefs.setString('token', "${tokenSavedOnServer}");
      // print(prefs.getString('full_name'));
      // print(prefs.getString('email'));
      Get.toNamed(Routes.MAIN_SCREEN);
    }
    else{
      debugPrint(id);
      prefs.setString('token', "${tokenGeneratedByApp}");
      updateToken(tokenGeneratedByApp, context, id);

      // print(prefs.getString('full_name'));
      // print(prefs.getString('email'));
      Get.toNamed(Routes.MAIN_SCREEN);
    }
  }

  Future<void> updateToken(String? tokenGeneratedByApp, BuildContext context, String id) async {

    GlobalWidgets.showProgressLoader("Please wait");

    var collection = await FirebaseFirestore.instance.collection('admins');
    await collection
        .doc(id)
        .update({'token' : tokenGeneratedByApp}) // <-- Updated data
        .then((_) => print('Success'))
        .catchError((error) => print('Failed: $error'));
    GlobalWidgets.hideProgressLoader();
  }
}
