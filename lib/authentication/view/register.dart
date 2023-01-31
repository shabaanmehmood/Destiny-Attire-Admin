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

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController fullNameCtl = new TextEditingController();
  // TextEditingController cityCtl = new TextEditingController();
  // TextEditingController addressCtl = new TextEditingController();
  // TextEditingController mobileCtl = new TextEditingController();
  TextEditingController emailCtl = new TextEditingController();
  TextEditingController passwordCtl = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: body(context),
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
      child: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
                margin: EdgeInsets.only(top: SizeConfig.screenHeight * .10),
                child: Image.asset('assets/images/logo.png', height: 80, width: 80,)),
          ),
          myText(context, 'Full Name', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myTextField(TextInputType.text, fullNameCtl, false, "Full Name" ),
          // myText(context, 'City', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          // myTextField(TextInputType.text, cityCtl, false, "Your City" ),
          // myText(context, 'Address', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          // myTextField(TextInputType.text, addressCtl, false, "Your Address" ),
          // myText(context, 'Mobile Number', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          // myTextField(TextInputType.number, mobileCtl, false, "Your Mobile Number" ),
          myText(context, 'Email', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myTextField(TextInputType.emailAddress, emailCtl, false, "Your Email" ),
          myText(context, 'Password', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myTextField(TextInputType.text, passwordCtl, true, "Your Password" ),
          SizedBox(height: 40,),
          addUserButton(context),
          SizedBox(
            height: 40,
          ),
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

  addUserButton(BuildContext context,){
    return GestureDetector(
      onTap: () async {
        // if(mobileCtl.text.trim().isEmpty){
        //   GlobalWidgets.showErrorToast(
        //       context, "Mobile Number required", 'Please provide mobile number');
        // }
        // else if(mobileCtl.text.length<11){
        //   GlobalWidgets.showErrorToast(
        //       context, "Mobile Number Not valid", 'Please provide valid mobile number');
        // }
        if(emailCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(
              context, "Email required", 'Please provide your email address');
        }
        // else if(cityCtl.text.trim().isEmpty){
        //   GlobalWidgets.showErrorToast(
        //       context, "City required", 'Please provide your city');
        // }
        // else if(addressCtl.text.trim().isEmpty){
        //   GlobalWidgets.showErrorToast(
        //       context, "Address required", 'Please provide address');
        // }
        else if(fullNameCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(
              context, "Full name required", 'Please provide full name');
        }
        else if(passwordCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(
              context, "Password required", 'Please provide password');
        }
        else{
          GlobalWidgets.hideKeyboard(context);
          SharedPreferences prefs = await SharedPreferences.getInstance();

          Map<String, dynamic> userInfo = Map();
          userInfo['token'] = prefs.getString('token');
          // userInfo['address'] = addressCtl.text.trim().toString();
          // userInfo['city'] = cityCtl.text.trim().toString();
          userInfo['email'] = emailCtl.text.trim().toString();
          userInfo['password'] = passwordCtl.text.trim().toString();
          userInfo['name'] = fullNameCtl.text.trim().toString();
          userInfo['role'] = 'Super Admin';
          // userInfo['mobile'] = mobileCtl.text.trim().toString();
          print(userInfo);
          checkIfEmailExists(emailCtl.text.trim().toString(), userInfo, context);
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
            child: myText(context, "Register Now", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
        ),
      ),
    );
  }

  Future<String> checkIfEmailExists(String email, Map<String, dynamic> userInfo, BuildContext context) async {
    // Get docs from collection reference
    String response = '';
    GlobalWidgets.showProgressLoader("Validating Data");

    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('admins')
        .where('email', isEqualTo: email)
    // .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if(documents.isEmpty) {
      response = 'ok';

      // final res = await _apiService.userSignUp(apiParams: userInfo);
      var collection = FirebaseFirestore.instance.collection('admins');
      var docRef = await collection.add(userInfo);
      var documentId = docRef.id;
      GlobalWidgets.hideProgressLoader();
      print('created');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', userInfo["email"]);
      prefs.setString('full_name', userInfo["name"]);

      debugPrint(prefs.getString('full_name'));
      debugPrint(prefs.getString('email'));
      Get.toNamed(Routes.MAIN_SCREEN);
    }
    else {
      print(documents.first);
      response = 'no';
      GlobalWidgets.hideProgressLoader();
      errorDialog(context, 'Failed', 'Email already exists.');
    }
    return response;
  }
  myText(BuildContext context, String text, Color colorsX, double top, double left, double right, double bottom,
      FontWeight fontWeight, double fontSize){
    return Container(
      margin: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      child: Text(text, style: GoogleFonts.mukta(textStyle: TextStyle( color: colorsX, fontWeight: fontWeight,
          fontSize: fontSize)),),
    );
  }

  errorDialog(BuildContext context, String title, String msg) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: title,
        desc: msg,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }

  myTextField(TextInputType inputType, TextEditingController ctl, bool obscureText, String hint){
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(color: ColorsX.white, width: 1.25)
      ),
      child: TextFormField(
        keyboardType: inputType,
        controller: ctl,
        obscureText: obscureText,
        style: TextStyle(color: ColorsX.white),
        decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: hint, hintStyle: TextStyle(color: ColorsX.white.withOpacity(0.4))
        ),
      ),
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
