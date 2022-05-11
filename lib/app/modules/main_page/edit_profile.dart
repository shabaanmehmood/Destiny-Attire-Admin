import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors.dart';
import '../../utils/global_widgets.dart';
import '../../utils/size_config.dart';
import '../../widget/drawer_widget.dart';

class EditProfile extends StatelessWidget {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalWidgets globalWidgets = GlobalWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: body(context),
      drawer: DrawerWidget(context),
      appBar: AppBar(
        backgroundColor: ColorsX.black,
        centerTitle: true,
        title: globalWidgets.myText(context, "Edit Profile", ColorsX.white, 0, 0,0,0, FontWeight.w400, 16),
        leading: IconButton(
          icon: Icon(Icons.menu_rounded, color: ColorsX.white,),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(), //Scaffold.of(context).openDrawer(),
        ),
      ),
    );
  }
  body(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: Stack(
        children: <Widget>[
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              // color:  const Color(0xff70b4ff).withOpacity(0.8),
              color:  const Color(0xff000000).withOpacity(0.8),
            ),
          ),
          listViewContent(context),
        ],
      ),
    );
  }
  button(BuildContext context, String text, FaIcon faIcon, Color fillColor,){
    return GestureDetector(
      onTap: (){
        if(text == 'WhatsApp'){
          openWhatsapp(context,"Write your message here.");
        }
        else if(text == "Email"){
          sendMail(context, "Kindly explain your purpose");
        }
      },
      child: Container(
        width: SizeConfig.screenWidth*.45,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: faIcon,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: globalWidgets.myText(context, text, ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 15),
              )
            ),
          ],
        ),
      ),
    );
  }
  directCall(BuildContext context, String text, FaIcon faIcon, Color fillColor,){
    return GestureDetector(
      onTap: (){
        dialNumber(context, "+923230474685");
      },
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: faIcon,
            ),
            Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: globalWidgets.myText(context, text, ColorsX.black, 0, 0, 0, 0, FontWeight.w600, 15),
                )
            ),
          ],
        ),
      ),
    );
  }
  dialNumber(BuildContext context, String number) async {
    var url = "tel:$number";
    try{
      await launch(url);
    }
    catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("Problem Occured. Please Try Again")));
      throw 'Could not launch $url';
    }
  }

  featured(BuildContext context, String text, FaIcon faIcon, Color fillColor,){
    return GestureDetector(
      onTap: (){
        openWhatsapp(context,"I want to make my proposal featured. My Proposal ID is ");
      },
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: faIcon,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: globalWidgets.myText(context, text, ColorsX.black, 0, 0, 0, 0, FontWeight.w600, 15),
              )
            ),
          ],
        ),
      ),
    );
  }
  listViewContent(BuildContext context){
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          globalWidgets.myText(context, 'Profile Editing Information', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'Whatever you want to update in your profile, we strongly recommend you to contact our support team through email or Whatsapp. We do this to keep our client\u0027s information more secure and safe.  ',
              ColorsX.white, 10, 10, 0, 0, FontWeight.w400, 15),
          SizedBox(height: SizeConfig.screenHeight*.05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              button(context, "WhatsApp", FaIcon(FontAwesomeIcons.whatsapp, color: ColorsX.white,),ColorsX.whatsappGreen),
              button(context, "Email", FaIcon(FontAwesomeIcons.google, color: ColorsX.white,),ColorsX.red_dashboard),
            ],
          ),
          SizedBox(height: 20,),
          globalWidgets.myText(context, 'Featured proposals is a paid service.\nTerms & Conditions apply',
              ColorsX.white, 10, 10, 0, 0, FontWeight.w400, 15),
          SizedBox(height: 20,),
          Center(
            child:
            featured(context, "Request For Featured Proposal", FaIcon(FontAwesomeIcons.adversal, color: ColorsX.black,),ColorsX.greyBackground
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child:
            directCall(context, "Direct Call", FaIcon(FontAwesomeIcons.phone, color: ColorsX.black,),ColorsX.greyBackground
            ),
          ),
        ],
      ),
    );
  }
  openWhatsapp(BuildContext context, String text) async{
    var whatsapp ="+923230474685";
    var whatsappURl_android = '';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString("id");
    String? newText = "${text} ${id}";
      // whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=${text}${id}";
      whatsappURl_android = "https://wa.me/923230474685?text= My Id is ${id}";
    // var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("${text}")}";
    if(Platform.isAndroid){
      try{
        await launch(whatsappURl_android);
      }
      catch (e){
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("Problem Occured. Please Use Direct Call Method")));
      }
      // if( await canLaunch(whatsappURl_android)){
      //   await launch(whatsappURl_android);
      // }else{
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: new Text("whatsapp not installed")));
      // }
    }
    // if(Platform.isIOS){
    //   // for iOS phone only
    //   if( await canLaunch(whatappURL_ios)){
    //     await launch(whatappURL_ios, forceSafariVC: false);
    //   }else{
    //     ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: new Text("whatsapp no installed")));
    //   }
    // }
  }


  sendMail(BuildContext context, String? body) async {
    // Android and iOS
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? id = sharedPreferences.getString("id");
    String? phone = sharedPreferences.getString("phone");
    String? subject = "My ID is $id"+" and Phone Number is $phone";
    // const uri =
    //     'mailto:rishtaaasan@gmail.com?subject=Greetings&body=Hello%20World';
    var uri =
        "mailto:rishtaaasan@gmail.com?subject=${subject}&body=${body}";
    try{
        await launch(uri);
    }
    catch (e){
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("Problem Occured. Please Use Direct Call Method")));
      throw 'Could not launch $uri';

    }
  }
}
