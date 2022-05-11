import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/loginModel.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api.dart';
import '../../../utils/colors.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/global_widgets.dart';
import '../../../utils/size_config.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailCtl = new TextEditingController();
  TextEditingController passwordCtl = new TextEditingController();
  GlobalWidgets globalWidgets = GlobalWidgets();
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  <Widget>[
          Align(
            alignment: Alignment.center,
            child: myText(context, "Already have an account ? Continue to Login", ColorsX.white, SizeConfig.screenHeight*.20, 10, 0, 10, FontWeight.w400, 18.0,),
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
        Get.toNamed(Routes.BASIC_INFORMATION);
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
          loginNow(emailCtl.text.toString(),passwordCtl.text.toString(), context);
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
        Get.toNamed(Routes.BASIC_INFORMATION);
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

   loginNow(String email, String password, BuildContext context) async{

     var _apiService = ApiService();
     SharedPreferences prefs = await SharedPreferences.getInstance();
     GlobalVariables.email = email;
     GlobalVariables.password = password;

     Map<String, dynamic> userInfo = Map();

     userInfo['email'] = GlobalVariables.email;
     userInfo['password'] = GlobalVariables.password;

     GlobalWidgets.showProgressLoader("Please Wait");
     GlobalWidgets.hideKeyboard(context);
     final res = await _apiService.userLogin(apiParams: userInfo);
     GlobalWidgets.hideProgressLoader();
     if (res is LoginModel) {
       prefs.setString('id', "${res.serverResponse.basicDetails.id}");
       prefs.setString('caste', "${res.serverResponse.basicDetails.caste}");
       prefs.setString('subcaste', "${res.serverResponse.basicDetails.subcaste}");
       prefs.setString('religion', "${res.serverResponse.basicDetails.religion}");
       prefs.setString('sect', "${res.serverResponse.basicDetails.sect}");
       prefs.setString('account_created_at', "${res.serverResponse.others.accountCreatedAt}");
       prefs.setString('mother_tongue', "${res.serverResponse.basicDetails.motherTongue}");
       prefs.setString('phone', "${res.serverResponse.basicDetails.primaryPhone}");
       prefs.setString('gender', "${res.serverResponse.basicDetails.gender}");

       print(prefs.getString('id'));
       print(prefs.getString('caste'));
       print(prefs.getString('subcaste'));
       print(prefs.getString('religion'));
       print(prefs.getString('sect'));
       print(prefs.getString('account_created_at'));
       print(prefs.getString('mother_tongue'));
       print(prefs.getString('gender'));
       Get.toNamed(Routes.ALL_CASTES_MAIN_PAGE);
//show success dialog
//        successDialog(GlobalVariables.signUpResponse);
     }
     else {
       errorDialog(context);
     }
   }

  errorDialog(BuildContext context) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Error',
        desc:
        'Please try again',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }

}
