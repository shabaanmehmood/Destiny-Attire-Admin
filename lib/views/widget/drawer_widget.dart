import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_pages.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import '../../utils/global_widgets.dart';
import '../../utils/size_config.dart';

class DrawerWidget extends StatelessWidget {
  GlobalWidgets globalWidgets = GlobalWidgets();

  DrawerWidget(BuildContext context);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth*.75,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: ColorsX.black.withOpacity(0.8),
        ),
        child: Drawer(
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: <Widget>[
              // _createHeader(),
              // SizedBox(height: SizeConfig.screenHeight*.13,),
              Container(
                child: Image.asset('assets/images/logo.png', width:
                  SizeConfig.screenWidth * .70, height: SizeConfig.screenHeight*.25,
                  fit: BoxFit.cover,),
              ),
              _createDrawerItem(Icons.production_quantity_limits, 'All Products', context),
              _createDrawerItem(Icons.category_outlined, 'All Categories', context),
              _createDrawerItem(Icons.history, 'My Orders', context),
              Divider(
                color: ColorsX.white,
              ),
              // _createDrawerItem(Icons.star_outline_sharp, 'Favourites', context),
              // _createDrawerItem(Icons.filter_list_alt, 'Filter', context),
              // Divider(
              //   color: ColorsX.white,
              // ),
              _createDrawerItem(Icons.privacy_tip_outlined, 'Privacy Policy', context),
              _createDrawerItem(Icons.photo_size_select_large_rounded, 'Terms & Conditions', context),
              Divider(
                color: ColorsX.white,
              ),
              // _createDrawerItem(Icons.edit, 'Edit Profile', context),
              // Divider(
              //   color: ColorsX.white,
              // ),
              // _createDrawerItem(Icons.edit, 'My Profile', context),
              // Divider(
              //   color: ColorsX.white,
              // ),
              _createDrawerItem(Icons.share_rounded, 'Share with Friends', context),
              _createDrawerItem(Icons.bug_report, 'Report an issue', context),
              Divider(
                color: ColorsX.white,
              ),
              _createDrawerItem(Icons.logout, 'Logout', context),
              Divider(
                color: ColorsX.white,
              ),
              // ListTile(
              //   title: Text('Powered by Epopiah', style: TextStyle(color: ColorsX.white),),
              //   onTap: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }

  _createDrawerItem(IconData icon, String text, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // if(text=='Filter'){
        //
        //   Get.toNamed(Routes.FILTER_SCREEN);
        //   Get.back();
        //   // Get.toNamed(Routes.FAMILY_INFORMATION);
        // }
        if(text=='All Products'){

          GlobalVariables.viewAll = 'Products';
          Get.toNamed(Routes.ALL_FEATURED);
          Get.back();
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        if(text== "All Categories"){
          Get.back();
          GlobalVariables.viewAll = 'Categories';
          Get.toNamed(Routes.ALL_CATEGORIES);
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        if(text== "My Orders"){
          Get.back();
          Get.toNamed(Routes.MY_ORDERS);
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        if(text== "Privacy Policy"){
          Get.back();
          GlobalVariables.webView_url = "http://rishtaaasan.000webhostapp.com/privacy_policy.html";
          Get.toNamed(Routes.PRIVACY_POLICY);
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        // if(text=='Request for Featured'){
        //
        //   Get.toNamed(Routes.EDIT_PROFILE);
        //   Get.back();
        //   // Get.toNamed(Routes.FAMILY_INFORMATION);
        // }
        if(text=='Report an issue'){

          Get.toNamed(Routes.EDIT_PROFILE);
          Get.back();
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        // if(text=='My Profile'){
        //   GlobalVariables.isMyProfile = true;
        //   Get.toNamed(Routes.PROPOSALS_DETAIL);
        //   Get.back();
        //   // Get.toNamed(Routes.FAMILY_INFORMATION);
        // }
        if(text=='Share with Friends'){
          Get.back();
          Share.share('This is an amazing app to find best clothes and dresses. You should at least try once . https://play.google.com/store/apps/details?id=com.epopiah.destiny_attire');
        }
        // if(text=='Logout'){
        //
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   prefs.setString('id', '');
        //   prefs.setString('caste', '');
        //   prefs.setString('subcaste', '');
        //   prefs.setString('religion', '');
        //   prefs.setString('sect', '');
        //   prefs.setString('account_created_at', '');
        //   prefs.setString('mother_tongue', '');
        //   prefs.setString('phone', '');
        //   prefs.setString('gender', '');
        //   Get.back();
        //   Get.toNamed(Routes.LOGIN_SCREEN);
        // }

      },
      child: Container(
         child: ListTile(
           dense: true,
           leading: Icon(icon, color: ColorsX.white,),
           title: globalWidgets.myText(context, text, ColorsX.white, 0, 2, 0, 0, FontWeight.w600, 16),
           onTap: () async {
             if(text == "All Products"){
               Get.back();
               GlobalVariables.viewAll = 'Products';
               Get.toNamed(Routes.ALL_FEATURED);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text == "All Categories"){
               Get.back();
               GlobalVariables.viewAll = 'Categories';
               Get.toNamed(Routes.ALL_CATEGORIES);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text == "My Orders"){
               Get.back();
               Get.toNamed(Routes.MY_ORDERS);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text== "Privacy Policy"){
               Get.back();
               GlobalVariables.webView_url =("http://rishtaaasan.000webhostapp.com/privacy_policy.html");
               Get.toNamed(Routes.PRIVACY_POLICY);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text== "Terms & Conditions"){
               Get.back();
               GlobalVariables.webView_url = ("http://rishtaaasan.000webhostapp.com/terms.html");
               Get.toNamed(Routes.TERMS_CONDITIONS);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             // if(text== "Edit Profile"){
             //   Get.back();
             //   Get.toNamed(Routes.EDIT_PROFILE);
             //   // Get.toNamed(Routes.FAMILY_INFORMATION);
             // }
             // if(text== "Request for Featured"){
             //   Get.back();
             //   Get.toNamed(Routes.EDIT_PROFILE);
             //   // Get.toNamed(Routes.FAMILY_INFORMATION);
             // }
             if(text== "Report an issue"){
               Get.back();
               Get.toNamed(Routes.EDIT_PROFILE);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             // if(text== "My Profile"){
             //   Get.back();
             //   GlobalVariables.isMyProfile = true;
             //   getId(context);
             //   Get.toNamed(Routes.PROPOSALS_DETAIL);
             //   // Get.toNamed(Routes.FAMILY_INFORMATION);
             // }
             if(text== "Share with Friends"){
               Get.back();
               Share.share('This is an amazing app to find best match for your marriage. You should at least try once by creating your profile. https://play.google.com/store/apps/details?id=com.epopiah.destiny_attire');
             }
             // if(text== "Logout"){
             //
             //   SharedPreferences prefs = await SharedPreferences.getInstance();
             //   prefs.setString('id', '');
             //   prefs.setString('caste', '');
             //   prefs.setString('subcaste', '');
             //   prefs.setString('religion', '');
             //   prefs.setString('sect', '');
             //   prefs.setString('account_created_at', '');
             //   prefs.setString('mother_tongue', '');
             //   prefs.setString('phone', '');
             //   prefs.setString('gender', '');
             //   Get.back();
             //   Get.toNamed(Routes.LOGIN_SCREEN);
             // }
           },
         ),
      ),
    );
  }

  _createHeader() {
    return Container(
      height: SizeConfig.screenHeight*.25,
      child: Stack(
        children: [
          Container(
            color: ColorsX.black.withOpacity(0.8),
          ),
        ],
      ),
    );
  }

  void getId(BuildContext context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    GlobalVariables.idOfProduct = "${preferences.getString("id")}";
  }
}