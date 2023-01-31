import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ndialog/ndialog.dart';

import 'colors.dart';
import 'size_config.dart';


class GlobalWidgets {
  static late ProgressDialog progressDialog;

  static String? day = "";
  static String? month = "";
  static String? year = "";
  static String? chosenDateTimeFromSetAppointment = "";

  static void showProgressDialog(
      BuildContext context, String title, String message) {
    progressDialog =
        ProgressDialog(context, message: Text(message), title: Text(title));
  }

  myText(BuildContext context, String text, Color colorsX, double top, double left, double right, double bottom,
      FontWeight fontWeight, double fontSize){
    return Container(
      margin: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      child: Text(text, style: GoogleFonts.mukta(textStyle: TextStyle( color: colorsX, fontWeight: fontWeight,
          fontSize: fontSize)),),
    );
  }
  cutText(BuildContext context, String text, Color colorsX, double top, double left, double right, double bottom,
      FontWeight fontWeight, double fontSize){
    return Container(
      margin: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      child: Text(text, style: GoogleFonts.mukta(textStyle: TextStyle( color: colorsX, fontWeight: fontWeight,
          fontSize: fontSize), decoration: TextDecoration.lineThrough),),
    );
  }
  myTextCustom(BuildContext context, String text, Color colorsX, double top, double left, double right, double bottom,
      FontWeight fontWeight, double fontSize){
    return Container(
      margin: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      child: Text(text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: GoogleFonts.mukta(textStyle: TextStyle( color: colorsX, fontWeight: fontWeight,
          fontSize: fontSize)),),
    );
  }
  myTextCustomWithTwoLines(BuildContext context, String text, Color colorsX, double top, double left, double right, double bottom,
      FontWeight fontWeight, double fontSize){
    return Container(
      margin: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      child: Text(text,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: GoogleFonts.mukta(textStyle: TextStyle( color: colorsX, fontWeight: fontWeight,
          fontSize: fontSize)),),
    );
  }
  detailText(BuildContext context, String text,String detail, Color colorsX, double top, double left, double right, double bottom,
      FontWeight fontWeight, double fontSize){
    return Container(
      margin: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      child: Text(text, style: GoogleFonts.mukta(textStyle: TextStyle( color: colorsX, fontWeight: fontWeight,
          fontSize: fontSize)),),
    );
  }
  myTextField(TextInputType inputType, TextEditingController ctl, bool obscureText, String hint){
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(color: ColorsX.black.withOpacity(0.4), width: 1.25)
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
  static bool validateEmail(String email) {
    bool emailValid = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
    return emailValid;
  }

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: ColorsX.blue_button_color,
        textColor: ColorsX.white,
        fontSize: 16.0);
  }
  //
  static showErrorToast(
      BuildContext context, String title, String description) {
    MotionToast.error(
        title: title,
        animationDuration: Duration(microseconds: 100),
        toastDuration: Duration(milliseconds: 1700),
        titleStyle: TextStyle(fontWeight: FontWeight.bold),
        description: description)
        .show(context);
  }
  //
  static showSuccessToast(
      BuildContext context, String title, String description) {
    MotionToast.success(
        title: title,
        animationDuration: Duration(microseconds: 100),
        toastDuration: Duration(milliseconds: 1700),
        titleStyle: TextStyle(fontWeight: FontWeight.bold),
        description: description)
        .show(context);
  }

  static hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static showProgressLoader(String msg) {
    EasyLoading.show(status: msg);
  }

  static hideProgressLoader() {
    EasyLoading.dismiss();
  }

  static void initializeLoader() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 60
      ..radius = 20
      ..backgroundColor = Colors.black
      ..indicatorColor = ColorsX.white
      ..textColor = Colors.white
      ..userInteractions = true
      ..dismissOnTap = false
      ..indicatorType = EasyLoadingIndicatorType.cubeGrid;
  }

//   static showErrorDialog({
//     required String title,
//     required String msg,
//     required bool isSuccess,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         onCancel: () {
//           // Get.back();
//         },
//         onConfirm: () {
//           Get.back();
//           if(isSuccess) {
//             Get.toNamed(Routes.WELCOME_CUSTOMER_SCREEN);
//           }
//         },
//         titleStyle: TextStyle(color: ColorsX.red_dashboard),
//         confirmTextColor: ColorsX.white);
//   }
//
//
//   static showAdminErrorDialog({
//     required String title,
//     required String msg,
//     required bool isSuccess,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         onCancel: () {
//           // Get.back();
//         },
//         onConfirm: () {
//           Get.back();
//           if(isSuccess) {
//             Get.toNamed(Routes.LOGIN_SCREEN_ADMIN);
//           }
//         },
//         titleStyle: TextStyle(color: ColorsX.red_dashboard),
//         confirmTextColor: ColorsX.white);
//   }
//
//   static showSimpleDialog({
//     required String title,
//     required String msg,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         onCancel: () {
//           // Get.back();
//           // Get.toNamed(Routes.WELCOME_CUSTOMER_SCREEN);
//         },
//         onConfirm: () {
//           Get.back();
//           // Get.toNamed(Routes.WELCOME_CUSTOMER_SCREEN);
//         },
//         titleStyle: TextStyle(color: ColorsX.red_dashboard),
//         confirmTextColor: ColorsX.white);
//   }
//
//   static showClearCartDialog({
//     required String title,
//     required String msg,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         onCancel: () {
//           // Get.back();
//           // Get.toNamed(Routes.WELCOME_CUSTOMER_SCREEN);
//         },
//         onConfirm: () {
//           Get.back();
//
//           SaloonController controller = Get.find();
//           if(controller.selectedAddOnsIDSList.isNotEmpty)
//             controller.selectedAddOnsIDSList.clear();
//           if(controller.selectedAddOnsList.isNotEmpty){
//             controller.selectedAddOnsList.clear();
//           }
//           if(controller.selectedAddOnsPriceList.isNotEmpty){
//             controller.selectedAddOnsPriceList.clear();
//           }
//           if(controller.selectedProductsNamePriceList.isNotEmpty){
//             controller.selectedProductsNamePriceList.clear();
//           }
//           if(controller.selectedProductsQuantityList.isNotEmpty){
//             controller.selectedProductsQuantityList.clear();
//           }
//           if(controller.selectedServicesIDSList.isNotEmpty){
//             controller.selectedServicesIDSList.clear();
//           }
//           if(controller.selectedServicesList.isNotEmpty){
//             controller.selectedServicesList.clear();
//           }
//           if(controller.selectedServicesPriceList.isNotEmpty){
//             controller.selectedServicesPriceList.clear();
//           }
//           if(controller.selectedSlot.value.isNotEmpty){
//             controller.selectedSlot.value="";
//           }
//           if(controller.serviceCount.value.isGreaterThan(0)){
//             controller.serviceCount.value=0;
//           }
//           if(controller.addOnCount.value.isGreaterThan(0)){
//             controller.addOnCount.value=0;
//           }
//           // Get.toNamed(Routes.WELCOME_CUSTOMER_SCREEN);
//         },
//         titleStyle: TextStyle(color: ColorsX.red_dashboard),
//         confirmTextColor: ColorsX.white);
//   }
//
//   static serviceAddedDialog({
//     required String title,
//     required String msg,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         onCancel: () {
//           // Get.back();
//           // Get.toNamed(Routes.WELCOME_CUSTOMER_SCREEN);
//
//           ServicesAdminListAddCTL servicesAdminListAddCTL = Get.find();
//           servicesAdminListAddCTL.isAllServiceLoaded.toggle();
//           // dealsListCTL.getSaloonAllDeals(1, 10);
//           servicesAdminListAddCTL.getAdminAllServices();
//           // servicesAdminListAddCTL.pagingController.refresh();
//
//           // Get.toNamed(DealsNavigation.dealsNofferList,
//           //     id: DealsNavigation.id);
//           Get.toNamed(AdminServiceNavigation.servicesList,
//               id: AdminServiceNavigation.id) ;
//         },
//         onConfirm: () {
//           // Get.back();
//           Get.back();
//
//           ServicesAdminListAddCTL servicesAdminListAddCTL = Get.find();
//           servicesAdminListAddCTL.isAllServiceLoaded.toggle();
//           // dealsListCTL.getSaloonAllDeals(1, 10);
//           servicesAdminListAddCTL.getAdminAllServices();
//           // servicesAdminListAddCTL.pagingController.refresh();
//
//           // Get.toNamed(DealsNavigation.dealsNofferList,
//           //     id: DealsNavigation.id);
//           Get.toNamed(AdminServiceNavigation.servicesList,
//               id: AdminServiceNavigation.id) ;
//           // Get.toNamed(AdminServiceNavigation.servicesList);
//           // Get.toNamed(Routes.WELCOME_CUSTOMER_SCREEN);
//         },
//         titleStyle: TextStyle(color: ColorsX.red_dashboard),
//         confirmTextColor: ColorsX.white);
//   }
//   static dealAddedDialog({
//     required String title,
//     required String msg,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         onCancel: () async {
//           // Get.back();
//           // Get.toNamed(Routes.WELCOME_CUSTOMER_SCREEN);
//
//           DealsListCTL dealsListCTL = Get.find();
//           dealsListCTL.isDataLoaded.toggle();
//           // dealsListCTL.getSaloonAllDeals(1, 10);
//           dealsListCTL.getSaloonAllDeals(1, 10);
//           dealsListCTL.pagingController.refresh();
//
//           Get.toNamed(DealsNavigation.dealsNofferList,
//               id: DealsNavigation.id);
//         },
//         onConfirm: () {
//           // Get.back();
//           Get.back();
//           // Get.toNamed(AdminServiceNavigation.servicesList);
//           // Get.toNamed(Routes.WELCOME_CUSTOMER_SCREEN);
//
//           DealsListCTL dealsListCTL = Get.find();
//           dealsListCTL.isDataLoaded.toggle();
//           // dealsListCTL.getSaloonAllDeals(1, 10);
//           dealsListCTL.getSaloonAllDeals(1, 10);
//           dealsListCTL.pagingController.refresh();
//
//           Get.toNamed(DealsNavigation.dealsNofferList,
//               id: DealsNavigation.id);
//         },
//         titleStyle: TextStyle(color: ColorsX.red_dashboard),
//         confirmTextColor: ColorsX.white);
//   }
//   static dealUpdateDialog({
//     required String title,
//     required String msg,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         onCancel: () async {
//           // Get.back();
//           // Get.toNamed(Routes.WELCOME_CUSTOMER_SCREEN);
//
//           DealsListCTL dealsListCTL = Get.find();
//           dealsListCTL.isDataLoaded.toggle();
//           // dealsListCTL.getSaloonAllDeals(1, 10);
//           dealsListCTL.getSaloonAllDeals(1, 10);
//           dealsListCTL.pagingController.refresh();
//
//           Get.toNamed(DealsNavigation.dealsNofferList,
//               id: DealsNavigation.id);
//         },
//         onConfirm: () async {
//           // Get.back();
//           Get.back();
//           // Get.toNamed(AdminServiceNavigation.servicesList);
//           // Get.toNamed(Routes.WELCOME_CUSTOMER_SCREEN);
//
//           DealsListCTL dealsListCTL = Get.find();
//           dealsListCTL.isDataLoaded.toggle();
//           // dealsListCTL.getSaloonAllDeals(1, 10);
//
//           dealsListCTL.getSaloonAllDeals(1, 10);
//           dealsListCTL.pagingController.refresh();
//
//           Get.toNamed(DealsNavigation.dealsNofferList,
//               id: DealsNavigation.id);
//         },
//         titleStyle: TextStyle(color: ColorsX.red_dashboard),
//         confirmTextColor: ColorsX.white);
//   }
//
//   static showAddedBookingDialog({
//     required String title,
//     required String msg,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         textConfirm: "      See Appointments      ",
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(
//               height: 15,
//             ),
//             Image.asset("assets/images/big-tick.png"),
//             SizedBox(
//               height: 15,
//             ),
//             Align(
//               alignment: Alignment.topCenter,
//               child: Text(
//                 "Your appointment booking is in process",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xff70b4ff)),
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             RichText(
//               textAlign: TextAlign.center,
//               text: TextSpan(
//                 text: 'You can view the Appointment booking into the "',
//                 style: TextStyle(
//                   color: Color(0xff707070),
//                 ),
//                 children: const <TextSpan>[
//                   TextSpan(
//                       text: 'Appointment"',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff70b4ff))),
//                   TextSpan(
//                       text: ' Section',
//                       style: TextStyle(color: Color(0xff707070))),
//                 ],
//               ),
//             )
//           ],
//         ),
//         // onCancel: () {
//         //   // Get.back();
//         //   Get.toNamed(Routes.WELCOME_CUSTOMER_SCREEN);
//         // },
//         onConfirm: () {
//           Get.back();
//           Get.toNamed(Routes.WELCOME_CUSTOMER_SCREEN);
//
//           SaloonController controller = Get.find();
//           if(controller.selectedAddOnsIDSList.isNotEmpty)
//             controller.selectedAddOnsIDSList.clear();
//           if(controller.selectedAddOnsList.isNotEmpty){
//             controller.selectedAddOnsList.clear();
//           }
//           if(controller.selectedAddOnsPriceList.isNotEmpty){
//             controller.selectedAddOnsPriceList.clear();
//           }
//           if(controller.selectedProductsNamePriceList.isNotEmpty){
//             controller.selectedProductsNamePriceList.clear();
//           }
//           if(controller.selectedProductsQuantityList.isNotEmpty){
//             controller.selectedProductsQuantityList.clear();
//           }
//           if(controller.selectedServicesIDSList.isNotEmpty){
//             controller.selectedServicesIDSList.clear();
//           }
//           if(controller.selectedServicesList.isNotEmpty){
//             controller.selectedServicesList.clear();
//           }
//           if(controller.selectedServicesPriceList.isNotEmpty){
//             controller.selectedServicesPriceList.clear();
//           }
//           if(controller.selectedSlot.value.isNotEmpty){
//             controller.selectedSlot.value="";
//           }
//           if(controller.serviceCount.value.isGreaterThan(0)){
//             controller.serviceCount.value=0;
//           }
//           if(controller.addOnCount.value.isGreaterThan(0)){
//             controller.addOnCount.value=0;
//           }
//         },
//         titleStyle: TextStyle(color: ColorsX.red_dashboard),
//         confirmTextColor: ColorsX.white);
//   }
//
//   static showErrorDialogForOtp({
//     required String title,
//     required String msg,
//     required String number,
//     required BuildContext context,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         onCancel: () {
//           // Get.back();
//         },
//         onConfirm: () {
//           Get.off(OTPCode(
//             phone: number,
//           ));
//           // Get.toNamed("/verify");
//         },
//         titleStyle: TextStyle(color: ColorsX.red_dashboard),
//         confirmTextColor: ColorsX.white);
//   }
//   static showErrorDialogForOtpAdmin({
//     required String title,
//     required String msg,
//     required String number,
//     required BuildContext context,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         onCancel: () {
//           // Get.back();
//         },
//         onConfirm: () {
//           Get.off(OTPCodeAdmin(
//             phone: number,
//           ));
//           // Get.toNamed("/verify");
//         },
//         titleStyle: TextStyle(color: ColorsX.red_dashboard),
//         confirmTextColor: ColorsX.white);
//   }
//
//   static transitToDialog(
//       {required String title, required String msg, required String page}) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         textConfirm: 'OK',
//         onConfirm: () {
//           print("Page .....$page");
//           Get.toNamed('/otp-screen');
//         },
//         titleStyle: TextStyle(color: ColorsX.black),
//         confirmTextColor: ColorsX.white);
//   }
//
//   static openPopUpForStaffDetail({
//     required StaffDetailModel? data,
//     required String title,
//     required String msg,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         textCancel: "    Cancel    ",
//         textConfirm: "  Book Now  ",
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             pictureAndName(data?.data.saloon.profilePic, data?.data.name,
//                 data?.data.designation.title),
//             SizedBox(
//               height: 5,
//             ),
//             hisImages(data?.data.photos),
//             SizedBox(
//               height: 5,
//             ),
//             _rowItemForHeaderText(
//                 "Work Schedule", 14, FontWeight.w700, 0xff000000, 10, 10, 0),
//             SizedBox(
//               height: 5,
//             ),
//             for (int index = 0; index < data!.data.timeSlots.length; index++)
//               hisSchedule(
//                   data.data.timeSlots[index].day,
//                   data.data.timeSlots[index].startTime,
//                   data.data.timeSlots[index].endTime),
//             // SizedBox(
//             //   height: 5,
//             // ),
//             // reviewsSet(),
//             // SizedBox(
//             //   height: 5,
//             // ),
//             // reviewsData(),
//             // Divider(),
//             // reviewsData(),
//           ],
//         ),
//         onCancel: () {
//           AppStrings.fromStaff="";
//           // Get.back();
//         },
//         onConfirm: () {
//           print("OK clicked");
//           AppStrings.fromStaff="yes";
//           Get.toNamed(Routes.SELECT_SERVICES);
//           // Get.toNamed(Routes.appointment_content_two);
//         },
//         titleStyle: TextStyle(color: ColorsX.blue_button_color),
//         confirmTextColor: ColorsX.white);
//   }
//
//   static showZoomImage({required String imageName}){
//     Get.defaultDialog(
//         textCancel: "    Cancel    ",
//         title: "",
//         textConfirm: "       OK       ",
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               height: 300,
//               width: SizeConfig.screenWidth,
//               margin: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                   border: Border.all(color: ColorsX.blue_button_color),
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(15.0),
//                 child: CachedNetworkImage(
//                   imageUrl: AppUrls.BASE_URL_IMAGE + '${imageName}',
//                   errorWidget: (context, url, error) => Icon(Icons.error),
//                   fit: BoxFit.fill,
//                   height: 280,
//                   width: SizeConfig.screenWidth * .75,
//                   placeholder: (context, url) => Container(
//                       height: 280,
//                       width: SizeConfig.screenWidth * .75,
//                       child: Center(child: CircularProgressIndicator())),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//           ],
//         ),
//         onCancel: () {
//           // Get.back();
//         },
//         onConfirm: () async {
//           Get.back();
//         },
//         titleStyle: TextStyle(color: ColorsX.blue_button_color),
//         confirmTextColor: ColorsX.white);
//   }
//
//   static showDealDetail({required int index}){
//     DashboardItemController dashboardItemController = Get.find();
//     Get.defaultDialog(
//         textCancel: "    Cancel    ",
//         title: dashboardItemController.saloonItemsModel?.deals?[index].couponName,
//         textConfirm: "       OK       ",
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//                 width: SizeConfig.screenWidth,
//                 margin: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                     border: Border.all(color: ColorsX.blue_button_color),
//                     color: ColorsX.greydashboard,
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 child: Center(
//                   child: Align(
//                     alignment: Alignment.topCenter,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         _rowItemForHeaderText("Coupon Name: "+dashboardItemController.saloonItemsModel?.deals?[index].couponName, 15, FontWeight.w600, 0xff000000, 15, 15, 0),
//                         _rowItemForHeaderText("Coupon Code: "+dashboardItemController.saloonItemsModel?.deals?[index].couponCode, 15, FontWeight.w600, 0xffD26839, 15, 15, 0),
//                         _rowItemForHeaderText("Service Name: "+dashboardItemController.saloonItemsModel?.deals?[index].service.name, 15, FontWeight.w600, 0xff000000, 15, 15, 0),
//                         _rowItemForHeaderText("Valid Only: "+"${dashboardItemController.saloonItemsModel?.deals?[index].endDate.toString().split(' ')[0]??''}", 15,
//                             FontWeight.w600, 0xff000000, 15, 15, 0),
//                         "${dashboardItemController.saloonItemsModel?.deals?[index].percentage}".isNotEmpty?
//                         _rowItemForHeaderText("${dashboardItemController.saloonItemsModel?.deals?[index].percentage}% OFF", 15, FontWeight.w600, 0xffD26839, 15, 15, 0):Container(),
//                         Container(
//                           margin: EdgeInsets.only(left: 15,top: 10),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: SizeConfig.blockSizeHorizontal * 4,
//                               vertical: SizeConfig.blockSizeVertical * 0.5),
//                           decoration: BoxDecoration(
//                               color: ColorsX.active_green,
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(10))),
//                           child: _rowItemForHeaderText("${dashboardItemController.saloonItemsModel?.deals?[index].status}", 15, FontWeight.w600,
//                               0xffffffff, 0, 0, 0),
//                         ),
//                         _rowItemForHeaderText("Description: "+"${dashboardItemController.saloonItemsModel?.deals?[index].description}", 12, FontWeight.w600, 0xff000000, 15, 15, 15),
//                         SizedBox(height: 15,)
//                       ],
//                     ),
//                   ),
//                 )
//             ),
//             SizedBox(
//               height: 5,
//             ),
//           ],
//         ),
//         onCancel: () {
//           // Get.back();
//         },
//         onConfirm: () async {
//           Get.back();
//         },
//         titleStyle: TextStyle(color: ColorsX.blue_button_color),
//         confirmTextColor: ColorsX.white);
//   }
//
//   static openPopUpForDateSelectForAppointment({
//     required String title,
//     required String msg,
//     required String date,
//     required BuildContext context,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         textCancel: "    Cancel    ",
//         textConfirm: "       OK       ",
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               height: 150,
//               width: SizeConfig.screenWidth,
//               margin: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                   border: Border.all(color: ColorsX.blue_button_color),
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               child: CupertinoDatePicker(
//                 mode: CupertinoDatePickerMode.date,
//                 initialDateTime: DateTime(
//                     int.parse(DateTime.now().year.toString()),
//                     int.parse(DateTime.now().month.toString()),
//                     int.parse(DateTime.now().day.toString())),
//                 onDateTimeChanged: (DateTime newDateTime) {
//                   // Do something
//
//                   SaloonController saloonController = Get.find();
//
//                   int dayEndDate = newDateTime.day;
//                   int monthEndDate = newDateTime.month;
//                   int yearEndDate = newDateTime.year;
//                   String dayString ="";
//                   String monthString ="";
//                   dynamic newDay = newDateTime.day;
//                   if (newDay < 10) {
//                     newDay = '0$newDay';
//                   }
//                   else if(dayEndDate<10){
//                     dayString = "0$dayEndDate";
//                   }
//                   else if(monthEndDate<10){
//                     monthString="0$monthEndDate";
//                   }
//                   else{
//                     dayString = dayEndDate.toString();
//                     monthString = monthEndDate.toString();
//                   }
//                   String newDob = dayString +
//                       "/" +
//                       monthString +
//                       "/" +
//                       newDateTime.year.toString();
//
//                   saloonController
//                       .chosenDateTimeFromSetAppointmentWithDashes.value =
//                       newDateTime.year.toString() +
//                           "-" +
//                           newDateTime.month.toString() +
//                           "-" +
//                           newDay.toString();
//                   chosenDateTimeFromSetAppointment = newDob;
//                   print('chosen Date ${saloonController
//                       .chosenDateTimeFromSetAppointmentWithDashes.value}');
//                   saloonController.chosenDateTimeForEndDateWithDashes.value =
//                   "${saloonController
//                       .chosenDateTimeFromSetAppointmentWithDashes.value}";
//                   // yearEndDate.toString() +
//                   //     "-" +
//                   //     monthString +
//                   //     "-" +
//                   //     dayString;
//                   // saloonController.chosenDateTimeForEndDateWithDashes.value = "";
//                   // dobCtl.text = newDob;
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//           ],
//         ),
//         onCancel: () {
//           // Get.back();
//         },
//         onConfirm: () async {
//           print("OK clicked");
//           String choosenDayWithoutSlashes =
//           chosenDateTimeFromSetAppointment.toString().split("/")[0];
//           String choosenMonthWithoutSlashes =
//           chosenDateTimeFromSetAppointment.toString().split("/")[1];
//           String choosenYearWithoutSlashes =
//           chosenDateTimeFromSetAppointment.toString().split("/")[2];
//           print(choosenDayWithoutSlashes);
//           print(choosenMonthWithoutSlashes);
//           print(choosenYearWithoutSlashes);
//
//           String todaysDayWithoutSlashes =
//           getTodaysDate().toString().split("-")[0];
//           String todaysMonthWithoutSlashes =
//           getTodaysDate().toString().split("-")[1];
//           String todaysYearWithoutSlashes =
//           getTodaysDate().toString().split("-")[2];
//
//           print(todaysDayWithoutSlashes);
//           print(todaysMonthWithoutSlashes);
//           print(todaysYearWithoutSlashes);
//           String concatinatedChoosenDate = choosenDayWithoutSlashes +
//               choosenMonthWithoutSlashes +
//               choosenYearWithoutSlashes;
//           String concatinatedTodaysDate = todaysDayWithoutSlashes +
//               todaysMonthWithoutSlashes +
//               todaysYearWithoutSlashes;
//           print("${concatinatedChoosenDate} concatinatedChoosenDate");
//           print("${concatinatedTodaysDate} concatinatedTodaysDate");
//           // if (int.parse(concatinatedChoosenDate) <
//           //     int.parse(concatinatedTodaysDate)) {
//           //   Functions.showErrorToast(
//           //       context, "Error", "Cannot book in previous dates");
//           // }
//           if(compareDatesNowForAppointment()=="false"){
//
//             Functions.showErrorToast(
//                 context, "Error", "Cannot book in previous dates");
//           }
//           else {
//             SaloonController saloonController = Get.find();
//             saloonController.isDataLoadedForDateChange.toggle();
//             await saloonController
//                 .getSpecificStaffDetailsForSpecificDates(saloonController
//                 .chosenDateTimeFromSetAppointmentWithDashes.value)
//                 .then((value) =>{
//               saloonController.isDataLoadedForDateChange.toggle(),
//               Get.back()
//             });
//             // Get.back();
//           }
//           // Get.toNamed(Routes.SELECT_SERVICES);
//           // Get.toNamed(Routes.appointment_content_two);
//         },
//         titleStyle: TextStyle(color: ColorsX.blue_button_color),
//         confirmTextColor: ColorsX.white);
//   }
//
//
//
//   static openPopUpForDateSelectForAppointmentForAdmin({
//     required String title,
//     required String msg,
//     required String date,
//     required BuildContext context,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         textCancel: "    Cancel    ",
//         textConfirm: "       OK       ",
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               height: 150,
//               width: SizeConfig.screenWidth,
//               margin: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                   border: Border.all(color: ColorsX.blue_button_color),
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               child: CupertinoDatePicker(
//                 mode: CupertinoDatePickerMode.date,
//                 initialDateTime: DateTime(
//                     int.parse(DateTime.now().year.toString()),
//                     int.parse(DateTime.now().month.toString()),
//                     int.parse(DateTime.now().day.toString())),
//                 onDateTimeChanged: (DateTime newDateTime) {
//                   // Do something
//
//                   AdminSaloonController adminSaloonController = Get.find();
//
//                   int dayEndDate = newDateTime.day;
//                   int monthEndDate = newDateTime.month;
//                   int yearEndDate = newDateTime.year;
//                   String dayString ="";
//                   String monthString ="";
//                   dynamic newDay = newDateTime.day;
//                   if (newDay < 10) {
//                     newDay = '0$newDay';
//                   }
//                   else if(dayEndDate<10){
//                     dayString = "0$dayEndDate";
//                   }
//                   else if(monthEndDate<10){
//                     monthString="0$monthEndDate";
//                   }
//                   else{
//                     dayString = dayEndDate.toString();
//                     monthString = monthEndDate.toString();
//                   }
//                   String newDob = dayString +
//                       "/" +
//                       monthString +
//                       "/" +
//                       newDateTime.year.toString();
//
//                   adminSaloonController
//                       .chosenDateTimeFromSetAppointmentWithDashes.value =
//                       newDateTime.year.toString() +
//                           "-" +
//                           newDateTime.month.toString() +
//                           "-" +
//                           newDay.toString();
//                   chosenDateTimeFromSetAppointment = newDob;
//                   print('chosen Date ${adminSaloonController
//                       .chosenDateTimeFromSetAppointmentWithDashes.value}');
//                   adminSaloonController.chosenDateTimeForEndDateWithDashes.value =
//                   "${adminSaloonController
//                       .chosenDateTimeFromSetAppointmentWithDashes.value}";
//                   // yearEndDate.toString() +
//                   //     "-" +
//                   //     monthString +
//                   //     "-" +
//                   //     dayString;
//                   // saloonController.chosenDateTimeForEndDateWithDashes.value = "";
//                   // dobCtl.text = newDob;
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//           ],
//         ),
//         onCancel: () {
//           // Get.back();
//         },
//         onConfirm: () async {
//           print("OK clicked");
//           // String choosenDayWithoutSlashes =
//           //     chosenDateTimeFromSetAppointment.toString().split("/")[0];
//           // String choosenMonthWithoutSlashes =
//           //     chosenDateTimeFromSetAppointment.toString().split("/")[1];
//           // String choosenYearWithoutSlashes =
//           //     chosenDateTimeFromSetAppointment.toString().split("/")[2];
//           // print(choosenDayWithoutSlashes);
//           // print(choosenMonthWithoutSlashes);
//           // print(choosenYearWithoutSlashes);
//           //
//           // String todaysDayWithoutSlashes =
//           //     getTodaysDate().toString().split("-")[0];
//           // String todaysMonthWithoutSlashes =
//           //     getTodaysDate().toString().split("-")[1];
//           // String todaysYearWithoutSlashes =
//           //     getTodaysDate().toString().split("-")[2];
//           //
//           // print(todaysDayWithoutSlashes);
//           // print(todaysMonthWithoutSlashes);
//           // print(todaysYearWithoutSlashes);
//           // String concatinatedChoosenDate = choosenDayWithoutSlashes +
//           //     choosenMonthWithoutSlashes +
//           //     choosenYearWithoutSlashes;
//           // String concatinatedTodaysDate = todaysDayWithoutSlashes +
//           //     todaysMonthWithoutSlashes +
//           //     todaysYearWithoutSlashes;
//           // print("${concatinatedChoosenDate} concatinatedChoosenDate");
//           // print("${concatinatedTodaysDate} concatinatedTodaysDate");
//
//
//           // if (int.parse(concatinatedChoosenDate) <
//           //     int.parse(concatinatedTodaysDate)) {
//           //   Functions.showErrorToast(
//           //       context, "Error", "Cannot book in previous dates");
//           // }
//           if(compareDatesNowForAppointmentAdmin()=="false"){
//
//             Functions.showErrorToast(
//                 context, "Error", "Cannot book in previous dates");
//           }
//           else {
//             AdminSaloonController adminSaloonController = Get.find();
//             if(MiddleContainer.staffId.isEmpty){
//               Functions.showErrorToast(
//                   context, "Error", "Select Staff Member");
//             }else{
//               adminSaloonController.selectedSlot.value="";
//               adminSaloonController.isDataLoadedForDateChange.toggle();
//               await adminSaloonController
//                   .getSpecificStaffDetailsForSpecificDates(adminSaloonController
//                   .chosenDateTimeFromSetAppointmentWithDashes.value)
//                   .then((value) =>{
//                 adminSaloonController.isDataLoadedForDateChange.toggle(),
//                 Get.back()
//               });
//             }
//             // Get.back();
//           }
//           // Get.toNamed(Routes.SELECT_SERVICES);
//           // Get.toNamed(Routes.appointment_content_two);
//         },
//         titleStyle: TextStyle(color: ColorsX.blue_button_color),
//         confirmTextColor: ColorsX.white);
//   }
//
//
//   static compareDatesNowForAppointment(){
//     String status="";
//     /**
//         comparing dates now
//      */
//     SaloonController saloonController = Get.find();
//     print("${saloonController.chosenDateTimeFromSetAppointmentWithDashes.value} startDateDay");
//     String startDateDay = getTodaysDate().split("-")[2];
//     String startDateMonth = getTodaysDate().split("-")[1];
//     String startDateYear = getTodaysDate().split("-")[0];
//
//
//     print("${saloonController.chosenDateTimeForEndDateWithDashes.value} endDateDay");
//     String endDateDay = saloonController.chosenDateTimeForEndDateWithDashes.value.split("-")[2];
//     String endDateMonth = saloonController.chosenDateTimeForEndDateWithDashes.value.split("-")[1];
//     String endDateYear = saloonController.chosenDateTimeForEndDateWithDashes.value.split("-")[0];
//     var endDateCompareValue = new DateTime.utc(int.parse(endDateYear), int.parse(endDateMonth), int.parse(endDateDay));
//     var startDateCompareValue = new DateTime.utc(int.parse(startDateYear), int.parse(startDateMonth), int.parse(startDateDay));
// // 0 denotes being equal positive value greater and negative value being less
//     if(endDateCompareValue.compareTo(startDateCompareValue)==0)
//     {
//       print("equal");
//       status = "true";
//     }
//     else if(endDateCompareValue.compareTo(startDateCompareValue)>0)
//     {
//       print("true");
//       status = "true";
//     }
//     else{
//       print("false");
//       status = "false";
//     }
//     return status;
//   }
//
//
//   static compareDatesNowForAppointmentAdmin(){
//     String status="";
//     /**
//         comparing dates now
//      */
//     AdminSaloonController adminSaloonController = Get.find();
//     print("${adminSaloonController.chosenDateTimeFromSetAppointmentWithDashes.value} startDateDay");
//     String startDateDay = getTodaysDate().split("-")[2];
//     String startDateMonth = getTodaysDate().split("-")[1];
//     String startDateYear = getTodaysDate().split("-")[0];
//
//
//     print("${adminSaloonController.chosenDateTimeForEndDateWithDashes.value} endDateDay");
//     if(adminSaloonController.chosenDateTimeForEndDateWithDashes.value.isEmpty){
//       adminSaloonController.chosenDateTimeForEndDateWithDashes.value=getTodaysDate();
//     }else{
//
//       String endDateDay = adminSaloonController.chosenDateTimeForEndDateWithDashes.value.split("-")[2];
//       String endDateMonth = adminSaloonController.chosenDateTimeForEndDateWithDashes.value.split("-")[1];
//       String endDateYear = adminSaloonController.chosenDateTimeForEndDateWithDashes.value.split("-")[0];
//       var endDateCompareValue = new DateTime.utc(int.parse(endDateYear), int.parse(endDateMonth), int.parse(endDateDay));
//       var startDateCompareValue = new DateTime.utc(int.parse(startDateYear), int.parse(startDateMonth), int.parse(startDateDay));
//
//
//
// // 0 denotes being equal positive value greater and negative value being less
//       if(endDateCompareValue.compareTo(startDateCompareValue)==0)
//       {
//         print("equal");
//         status = "true";
//       }
//       else if(endDateCompareValue.compareTo(startDateCompareValue)>0)
//       {
//         print("true");
//         status = "true";
//       }
//       else{
//         print("false");
//         status = "false";
//       }
//     }
//     return status;
//   }
//
//
//
//
//   static openPopUpForDateSelectForAppointmentAdmin({
//     required String title,
//     required String msg,
//     required String date,
//     required BuildContext context,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         textCancel: "    Cancel    ",
//         textConfirm: "       OK       ",
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               height: 150,
//               width: SizeConfig.screenWidth,
//               margin: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                   border: Border.all(color: ColorsX.blue_button_color),
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               child: CupertinoDatePicker(
//                 mode: CupertinoDatePickerMode.date,
//                 initialDateTime: DateTime(
//                     int.parse(DateTime.now().year.toString()),
//                     int.parse(DateTime.now().month.toString()),
//                     int.parse(DateTime.now().day.toString())),
//                 onDateTimeChanged: (DateTime newDateTime) {
//                   // Do something
//
//                   AdminSaloonController adminSaloonController = Get.find();
//
//                   int dayEndDate = newDateTime.day;
//                   int monthEndDate = newDateTime.month;
//                   int yearEndDate = newDateTime.year;
//                   String dayString ="";
//                   String monthString ="";
//                   dynamic newDay = newDateTime.day;
//                   if (newDay < 10) {
//                     newDay = '0$newDay';
//                   }
//                   else if(dayEndDate<10){
//                     dayString = "0$dayEndDate";
//                   }
//                   else if(monthEndDate<10){
//                     monthString="0$monthEndDate";
//                   }
//                   else{
//                     dayString = dayEndDate.toString();
//                     monthString = monthEndDate.toString();
//                   }
//                   String newDob = dayString +
//                       "/" +
//                       monthString +
//                       "/" +
//                       newDateTime.year.toString();
//
//                   adminSaloonController
//                       .chosenDateTimeFromSetAppointmentWithDashes.value =
//                       newDateTime.year.toString() +
//                           "-" +
//                           newDateTime.month.toString() +
//                           "-" +
//                           newDay.toString();
//                   chosenDateTimeFromSetAppointment = newDob;
//                   print('chosen Date ${adminSaloonController
//                       .chosenDateTimeFromSetAppointmentWithDashes.value}');
//                   adminSaloonController.chosenDateTimeForEndDateWithDashes.value =
//                   "${adminSaloonController
//                       .chosenDateTimeFromSetAppointmentWithDashes.value}";
//                   // yearEndDate.toString() +
//                   //     "-" +
//                   //     monthString +
//                   //     "-" +
//                   //     dayString;
//                   // saloonController.chosenDateTimeForEndDateWithDashes.value = "";
//                   // dobCtl.text = newDob;
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//           ],
//         ),
//         onCancel: () {
//           // Get.back();
//         },
//         onConfirm: () async {
//           print("OK clicked");
//           // String choosenDayWithoutSlashes =
//           // chosenDateTimeFromSetAppointment.toString().split("/")[0];
//           // String choosenMonthWithoutSlashes =
//           // chosenDateTimeFromSetAppointment.toString().split("/")[1];
//           // String choosenYearWithoutSlashes =
//           // chosenDateTimeFromSetAppointment.toString().split("/")[2];
//           // print(choosenDayWithoutSlashes);
//           // print(choosenMonthWithoutSlashes);
//           // print(choosenYearWithoutSlashes);
//           //
//           // String todaysDayWithoutSlashes =
//           // getTodaysDate().toString().split("-")[0];
//           // String todaysMonthWithoutSlashes =
//           // getTodaysDate().toString().split("-")[1];
//           // String todaysYearWithoutSlashes =
//           // getTodaysDate().toString().split("-")[2];
//           //
//           // print(todaysDayWithoutSlashes);
//           // print(todaysMonthWithoutSlashes);
//           // print(todaysYearWithoutSlashes);
//           // String concatinatedChoosenDate = choosenDayWithoutSlashes +
//           //     choosenMonthWithoutSlashes +
//           //     choosenYearWithoutSlashes;
//           // String concatinatedTodaysDate = todaysDayWithoutSlashes +
//           //     todaysMonthWithoutSlashes +
//           //     todaysYearWithoutSlashes;
//           // print("${concatinatedChoosenDate} concatinatedChoosenDate");
//           // print("${concatinatedTodaysDate} concatinatedTodaysDate");
//           // if (int.parse(concatinatedChoosenDate) <
//           //     int.parse(concatinatedTodaysDate)) {
//           //   Functions.showErrorToast(
//           //       context, "Error", "Cannot book in previous dates");
//           // }
//           if(compareDatesNowForAppointmentAdmin()=="false"){
//
//             Functions.showErrorToast(
//                 context, "Error", "Cannot book in previous dates");
//           }
//           else {
//             AdminSaloonController adminSaloonController = Get.find();
//             adminSaloonController.isDataLoadedForDateChange.toggle();
//             await adminSaloonController
//                 .getSpecificStaffDetailsForSpecificDates(adminSaloonController
//                 .chosenDateTimeFromSetAppointmentWithDashes.value)
//                 .then((value) =>{
//               adminSaloonController.isDataLoadedForDateChange.toggle(),
//               Get.back()
//             });
//             // Get.back();
//           }
//           // Get.toNamed(Routes.SELECT_SERVICES);
//           // Get.toNamed(Routes.appointment_content_two);
//         },
//         titleStyle: TextStyle(color: ColorsX.blue_button_color),
//         confirmTextColor: ColorsX.white);
//   }
//
//
//
//
//   static getStartDateEndDateForCreateDeal({
//     required String title,
//     required String msg,
//     required String date,
//     required BuildContext context,
//   })
//   {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         textCancel: "    Cancel    ",
//         textConfirm: "       OK       ",
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               height: 150,
//               width: SizeConfig.screenWidth,
//               margin: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                   border: Border.all(color: ColorsX.blue_button_color),
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               child: CupertinoDatePicker(
//                 mode: CupertinoDatePickerMode.date,
//                 initialDateTime: DateTime(
//                     int.parse(DateTime.now().year.toString()),
//                     int.parse(DateTime.now().month.toString()),
//                     int.parse(DateTime.now().day.toString())),
//                 onDateTimeChanged: (DateTime newDateTime) {
//                   // Do something
//                   int dayEndDate = newDateTime.day;
//                   int monthEndDate = newDateTime.month;
//                   int yearEndDate = newDateTime.year;
//                   String dayString ="";
//                   String monthString ="";
//                   if(dayEndDate<10){
//                     dayString = "0"+dayEndDate.toString();
//                   }else {
//                     dayString = dayEndDate.toString();
//                   }
//                   if(monthEndDate<10){
//                     monthString = "0"+monthEndDate.toString();
//                   }else {
//                     monthString = monthEndDate.toString();
//                   }
//                   AdminDealsCTL adminDealsCtl = Get.find();
//                   String newDob = newDateTime.day.toString() +
//                       "/" +
//                       newDateTime.month.toString() +
//                       "/" +
//                       newDateTime.year.toString();
//                   adminDealsCtl
//                       .chosenDateTimeFromSetAppointmentWithDashes.value =
//                       newDateTime.year.toString() +
//                           "-" +
//                           monthString +
//                           "-" +
//                           dayString;
//                   // adminDealsCtl
//                   //         .chosenDateTimeForEndDateWithDashes.value =
//                   //     yearEndDate.toString() +
//                   //         "-" +
//                   //         monthString +
//                   //         "-" +
//                   //         dayString;
//                   print(newDob);
//                   print(adminDealsCtl.chosenDateTimeFromSetAppointmentWithDashes.value);
//                   print("${adminDealsCtl.chosenDateTimeFromSetAppointmentWithDashes.value} start date" );
//                   print("${adminDealsCtl.chosenDateTimeForEndDateWithDashes.value} end date" );
//                   print("${dayEndDate} end date day" );
//                   print("${monthEndDate} end date month" );
//                   print("${yearEndDate} end date year" );
//
//
//                   // chosenDateTimeFromSetAppointment = newDob;
//                   // print(chosenDateTimeFromSetAppointment);
//                   // dobCtl.text = newDob;
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//           ],
//         ),
//         onCancel: () {
//           // Get.back();
//         },
//         onConfirm: () async {
//           print("OK clicked");
//           AdminDealsCTL adminDealsCtl = Get.find();
//           if(adminDealsCtl.chosenDateTimeFromSetAppointmentWithDashes.value.isNotEmpty) {
//             print(adminDealsCtl.chosenDateTimeFromSetAppointmentWithDashes.value);
//             Get.back();
//           }else{
//             print(getTodaysDate());
//             Get.back();
//           }
//
//           // if(chosenDateTimeFromSetAppointment!.isNotEmpty) {
//           //   String choosenDayWithoutSlashes =
//           //   chosenDateTimeFromSetAppointment.toString().split("/")[0];
//           //   String choosenMonthWithoutSlashes =
//           //   chosenDateTimeFromSetAppointment.toString().split("/")[1];
//           //   String choosenYearWithoutSlashes =
//           //   chosenDateTimeFromSetAppointment.toString().split("/")[2];
//           //   print(choosenDayWithoutSlashes);
//           //   print(choosenMonthWithoutSlashes);
//           //   print(choosenYearWithoutSlashes);
//           //   AdminDealsCTL adminDealsCTL = Get.find();
//           //   adminDealsCTL.chosenDateTimeFromSetAppointmentWithDashes.value = choosenDayWithoutSlashes+"-"+
//           // choosenMonthWithoutSlashes+"-"+choosenYearWithoutSlashes;
//           //   print("${adminDealsCTL.chosenDateTimeFromSetAppointmentWithDashes.value} chosen date");
//           // }
//           // else {
//           // String todaysDayWithoutSlashes =
//           // getTodaysDate().toString().split("-")[0];
//           // String todaysMonthWithoutSlashes =
//           // getTodaysDate().toString().split("-")[1];
//           // String todaysYearWithoutSlashes =
//           // getTodaysDate().toString().split("-")[2];
//           //
//           // print(todaysDayWithoutSlashes);
//           // print(todaysMonthWithoutSlashes);
//           // print(todaysYearWithoutSlashes);
//           //
//           //
//           // String choosenDayWithoutSlashes = "";
//           // String choosenMonthWithoutSlashes = "";
//           // String choosenYearWithoutSlashes = "";
//           //
//           // String concatinatedChoosenDate = choosenDayWithoutSlashes +
//           //     choosenMonthWithoutSlashes +
//           //     choosenYearWithoutSlashes;
//           // String concatinatedTodaysDate = todaysDayWithoutSlashes +
//           //     todaysMonthWithoutSlashes +
//           //     todaysYearWithoutSlashes;
//           // print("${concatinatedChoosenDate} concatinatedChoosenDate");
//           // print("${concatinatedTodaysDate} concatinatedTodaysDate");
//           // if(concatinatedChoosenDate.isNotEmpty) {
//           //   if (int.parse(concatinatedChoosenDate) <
//           //       int.parse(concatinatedTodaysDate)) {
//           //     Functions.showErrorToast(
//           //         context, "Error", "Cannot book in previous dates");
//           //   } else {
//           //     // SaloonController saloonController = Get.find();
//           //     // saloonController.isDataLoadedForDateChange.toggle();
//           //     // await saloonController
//           //     //     .getSpecificStaffDetailsForSpecificDates(saloonController
//           //     //         .chosenDateTimeFromSetAppointmentWithDashes.value)
//           //     //     .then((value) => Get.back());
//           //     Get.back();
//           //   }
//           // }
//           // else{
//           //   Get.back();
//           // }
//           // }
//           // Get.toNamed(Routes.SELECT_SERVICES);
//           // Get.toNamed(Routes.appointment_content_two);
//         },
//         titleStyle: TextStyle(color: ColorsX.blue_button_color),
//         confirmTextColor: ColorsX.white);
//   }
//
//
//
//
//   static getStartDateEndDateForEditDeal({
//     required String title,
//     required String msg,
//     required String date,
//     required BuildContext context,
//   })
//   {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         textCancel: "    Cancel    ",
//         textConfirm: "       OK       ",
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               height: 150,
//               width: SizeConfig.screenWidth,
//               margin: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                   border: Border.all(color: ColorsX.blue_button_color),
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               child: CupertinoDatePicker(
//                 mode: CupertinoDatePickerMode.date,
//                 initialDateTime: DateTime(
//                     int.parse(DateTime.now().year.toString()),
//                     int.parse(DateTime.now().month.toString()),
//                     int.parse(DateTime.now().day.toString())),
//                 onDateTimeChanged: (DateTime newDateTime) {
//                   // Do something
//                   int dayEndDate = newDateTime.day;
//                   int monthEndDate = newDateTime.month;
//                   int yearEndDate = newDateTime.year;
//                   String dayString ="";
//                   String monthString ="";
//                   if(dayEndDate<10){
//                     dayString = "0"+dayEndDate.toString();
//                   }else {
//                     dayString = dayEndDate.toString();
//                   }
//                   if(monthEndDate<10){
//                     monthString = "0"+monthEndDate.toString();
//                   }else {
//                     monthString = monthEndDate.toString();
//                   }
//                   DealsListCTL adminDealsCtl = Get.find();
//                   String newDob = newDateTime.day.toString() +
//                       "/" +
//                       newDateTime.month.toString() +
//                       "/" +
//                       newDateTime.year.toString();
//                   adminDealsCtl
//                       .chosenDateTimeFromSetAppointmentWithDashes.value =
//                       newDateTime.year.toString() +
//                           "-" +
//                           monthString +
//                           "-" +
//                           dayString;
//                   // adminDealsCtl
//                   //         .chosenDateTimeForEndDateWithDashes.value =
//                   //     yearEndDate.toString() +
//                   //         "-" +
//                   //         monthString +
//                   //         "-" +
//                   //         dayString;
//                   print(newDob);
//                   print(adminDealsCtl.chosenDateTimeFromSetAppointmentWithDashes.value);
//                   print("${adminDealsCtl.chosenDateTimeFromSetAppointmentWithDashes.value} start date" );
//                   print("${adminDealsCtl.chosenDateTimeForEndDateWithDashes.value} end date" );
//                   print("${dayEndDate} end date day" );
//                   print("${monthEndDate} end date month" );
//                   print("${yearEndDate} end date year" );
//
//
//                   // chosenDateTimeFromSetAppointment = newDob;
//                   // print(chosenDateTimeFromSetAppointment);
//                   // dobCtl.text = newDob;
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//           ],
//         ),
//         onCancel: () {
//           // Get.back();
//         },
//         onConfirm: () async {
//           print("OK clicked");
//           AdminDealsCTL adminDealsCtl = Get.find();
//           if(adminDealsCtl.chosenDateTimeFromSetAppointmentWithDashes.value.isNotEmpty) {
//             print(adminDealsCtl.chosenDateTimeFromSetAppointmentWithDashes.value);
//             Get.back();
//           }else{
//             print(getTodaysDate());
//             Get.back();
//           }
//
//           // if(chosenDateTimeFromSetAppointment!.isNotEmpty) {
//           //   String choosenDayWithoutSlashes =
//           //   chosenDateTimeFromSetAppointment.toString().split("/")[0];
//           //   String choosenMonthWithoutSlashes =
//           //   chosenDateTimeFromSetAppointment.toString().split("/")[1];
//           //   String choosenYearWithoutSlashes =
//           //   chosenDateTimeFromSetAppointment.toString().split("/")[2];
//           //   print(choosenDayWithoutSlashes);
//           //   print(choosenMonthWithoutSlashes);
//           //   print(choosenYearWithoutSlashes);
//           //   AdminDealsCTL adminDealsCTL = Get.find();
//           //   adminDealsCTL.chosenDateTimeFromSetAppointmentWithDashes.value = choosenDayWithoutSlashes+"-"+
//           // choosenMonthWithoutSlashes+"-"+choosenYearWithoutSlashes;
//           //   print("${adminDealsCTL.chosenDateTimeFromSetAppointmentWithDashes.value} chosen date");
//           // }
//           // else {
//           // String todaysDayWithoutSlashes =
//           // getTodaysDate().toString().split("-")[0];
//           // String todaysMonthWithoutSlashes =
//           // getTodaysDate().toString().split("-")[1];
//           // String todaysYearWithoutSlashes =
//           // getTodaysDate().toString().split("-")[2];
//           //
//           // print(todaysDayWithoutSlashes);
//           // print(todaysMonthWithoutSlashes);
//           // print(todaysYearWithoutSlashes);
//           //
//           //
//           // String choosenDayWithoutSlashes = "";
//           // String choosenMonthWithoutSlashes = "";
//           // String choosenYearWithoutSlashes = "";
//           //
//           // String concatinatedChoosenDate = choosenDayWithoutSlashes +
//           //     choosenMonthWithoutSlashes +
//           //     choosenYearWithoutSlashes;
//           // String concatinatedTodaysDate = todaysDayWithoutSlashes +
//           //     todaysMonthWithoutSlashes +
//           //     todaysYearWithoutSlashes;
//           // print("${concatinatedChoosenDate} concatinatedChoosenDate");
//           // print("${concatinatedTodaysDate} concatinatedTodaysDate");
//           // if(concatinatedChoosenDate.isNotEmpty) {
//           //   if (int.parse(concatinatedChoosenDate) <
//           //       int.parse(concatinatedTodaysDate)) {
//           //     Functions.showErrorToast(
//           //         context, "Error", "Cannot book in previous dates");
//           //   } else {
//           //     // SaloonController saloonController = Get.find();
//           //     // saloonController.isDataLoadedForDateChange.toggle();
//           //     // await saloonController
//           //     //     .getSpecificStaffDetailsForSpecificDates(saloonController
//           //     //         .chosenDateTimeFromSetAppointmentWithDashes.value)
//           //     //     .then((value) => Get.back());
//           //     Get.back();
//           //   }
//           // }
//           // else{
//           //   Get.back();
//           // }
//           // }
//           // Get.toNamed(Routes.SELECT_SERVICES);
//           // Get.toNamed(Routes.appointment_content_two);
//         },
//         titleStyle: TextStyle(color: ColorsX.blue_button_color),
//         confirmTextColor: ColorsX.white);
//   }
//
//   static compareDatesNow(){
//     String status="";
//     /**
//         comparing dates now
//      */
//     AdminDealsCTL adminDealsCTL = Get.find();
//     String startDateDay = adminDealsCTL.chosenDateTimeFromSetAppointmentWithDashes.value.split("-")[2];
//     String startDateMonth = adminDealsCTL.chosenDateTimeFromSetAppointmentWithDashes.value.split("-")[1];
//     String startDateYear = adminDealsCTL.chosenDateTimeFromSetAppointmentWithDashes.value.split("-")[0];
//
//
//     String endDateDay = adminDealsCTL.chosenDateTimeForEndDateWithDashes.value.split("-")[2];
//     String endDateMonth = adminDealsCTL.chosenDateTimeForEndDateWithDashes.value.split("-")[1];
//     String endDateYear = adminDealsCTL.chosenDateTimeForEndDateWithDashes.value.split("-")[0];
//     var endDateCompareValue = new DateTime.utc(int.parse(endDateYear), int.parse(endDateMonth), int.parse(endDateDay));
//     var startDateCompareValue = new DateTime.utc(int.parse(startDateYear), int.parse(startDateMonth), int.parse(startDateDay));
// // 0 denotes being equal positive value greater and negative value being less
//     if(endDateCompareValue.compareTo(startDateCompareValue)==0)
//     {
//       print("equal");
//       status = "true";
//     }
//     else if(endDateCompareValue.compareTo(startDateCompareValue)>0)
//     {
//       print("true");
//       status = "true";
//     }
//     else{
//       print("false");
//       status = "false";
//     }
//     return status;
//   }
//
//   static compareDatesEditDealNow(){
//     String status="";
//     /**
//         comparing dates now
//      */
//     DealsListCTL adminDealsCTL = Get.find();
//     String startDateDay = adminDealsCTL.chosenDateTimeFromSetAppointmentWithDashes.value.split("-")[2];
//     String startDateMonth = adminDealsCTL.chosenDateTimeFromSetAppointmentWithDashes.value.split("-")[1];
//     String startDateYear = adminDealsCTL.chosenDateTimeFromSetAppointmentWithDashes.value.split("-")[0];
//
//
//     String endDateDay = adminDealsCTL.chosenDateTimeForEndDateWithDashes.value.split("-")[2];
//     String endDateMonth = adminDealsCTL.chosenDateTimeForEndDateWithDashes.value.split("-")[1];
//     String endDateYear = adminDealsCTL.chosenDateTimeForEndDateWithDashes.value.split("-")[0];
//     var endDateCompareValue = new DateTime.utc(int.parse(endDateYear), int.parse(endDateMonth), int.parse(endDateDay));
//     var startDateCompareValue = new DateTime.utc(int.parse(startDateYear), int.parse(startDateMonth), int.parse(startDateDay));
// // 0 denotes being equal positive value greater and negative value being less
//     if(endDateCompareValue.compareTo(startDateCompareValue)==0)
//     {
//       print("equal");
//       status = "true";
//     }
//     else if(endDateCompareValue.compareTo(startDateCompareValue)>0)
//     {
//       print("true");
//       status = "true";
//     }
//     else{
//       print("false");
//       status = "false";
//     }
//     return status;
//   }
//
//
//   static getEndDateEndDateForCreateDeal({
//     required String title,
//     required String msg,
//     required String date,
//     required BuildContext context,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         textCancel: "    Cancel    ",
//         textConfirm: "       OK       ",
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               height: 150,
//               width: SizeConfig.screenWidth,
//               margin: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                   border: Border.all(color: ColorsX.blue_button_color),
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               child: CupertinoDatePicker(
//                 mode: CupertinoDatePickerMode.date,
//                 initialDateTime: DateTime(
//
//                     int.parse(DateTime.now().year.toString()),
//                     int.parse(DateTime.now().month.toString()),
//                     int.parse(DateTime.now().day.toString())),
//                 onDateTimeChanged: (DateTime newDateTime) {
//                   // Do something
//                   int dayEndDate = newDateTime.day;
//                   int monthEndDate = newDateTime.month;
//                   int yearEndDate = newDateTime.year;
//                   String dayString ="";
//                   String monthString ="";
//                   if(dayEndDate<10){
//                     dayString = "0"+dayEndDate.toString();
//                   }else {
//                     dayString = dayEndDate.toString();
//                   }
//                   if(monthEndDate<10){
//                     monthString = "0"+monthEndDate.toString();
//                   }else {
//                     monthString = monthEndDate.toString();
//                   }
//                   AdminDealsCTL adminDealsCtl = Get.find();
//                   // String newDob = newDateTime.day.toString() +
//                   //     "/" +
//                   //     newDateTime.month.toString() +
//                   //     "/" +
//                   //     newDateTime.year.toString();
//                   // adminDealsCtl
//                   //         .chosenDateTimeFromSetAppointmentWithDashes.value =
//                   //     newDateTime.year.toString() +
//                   //         "-" +
//                   //         newDateTime.month.toString() +
//                   //         "-" +
//                   //         newDateTime.day.toString();
//                   adminDealsCtl
//                       .chosenDateTimeForEndDateWithDashes.value =
//                       yearEndDate.toString() +
//                           "-" +
//                           monthString +
//                           "-" +
//                           dayString;
//                   print("${adminDealsCtl.chosenDateTimeForEndDateWithDashes.value} end date" );
//                   print("${dayEndDate} end date day" );
//                   print("${monthEndDate} end date month" );
//                   print("${yearEndDate} end date year" );
//                   // chosenDateTimeFromSetAppointment = newDob;
//                   // print(chosenDateTimeFromSetAppointment);
//                   // dobCtl.text = newDob;
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//           ],
//         ),
//         onCancel: () {
//           // Get.back();
//         },
//         onConfirm: () async {
//           print("OK clicked");
//           AdminDealsCTL adminDealsCtl = Get.find();
//           if(adminDealsCtl.chosenDateTimeFromSetAppointmentWithDashes.value.isNotEmpty) {
//             print(adminDealsCtl.chosenDateTimeFromSetAppointmentWithDashes.value);
//             Get.back();
//           }else{
//             print(getTodaysDate());
//             Get.back();
//           }
//
//           // if(chosenDateTimeFromSetAppointment!.isNotEmpty) {
//           //   String choosenDayWithoutSlashes =
//           //   chosenDateTimeFromSetAppointment.toString().split("/")[0];
//           //   String choosenMonthWithoutSlashes =
//           //   chosenDateTimeFromSetAppointment.toString().split("/")[1];
//           //   String choosenYearWithoutSlashes =
//           //   chosenDateTimeFromSetAppointment.toString().split("/")[2];
//           //   print(choosenDayWithoutSlashes);
//           //   print(choosenMonthWithoutSlashes);
//           //   print(choosenYearWithoutSlashes);
//           //   AdminDealsCTL adminDealsCTL = Get.find();
//           //   adminDealsCTL.chosenDateTimeFromSetAppointmentWithDashes.value = choosenDayWithoutSlashes+"-"+
//           // choosenMonthWithoutSlashes+"-"+choosenYearWithoutSlashes;
//           //   print("${adminDealsCTL.chosenDateTimeFromSetAppointmentWithDashes.value} chosen date");
//           // }
//           // else {
//           // String todaysDayWithoutSlashes =
//           // getTodaysDate().toString().split("-")[0];
//           // String todaysMonthWithoutSlashes =
//           // getTodaysDate().toString().split("-")[1];
//           // String todaysYearWithoutSlashes =
//           // getTodaysDate().toString().split("-")[2];
//           //
//           // print(todaysDayWithoutSlashes);
//           // print(todaysMonthWithoutSlashes);
//           // print(todaysYearWithoutSlashes);
//           //
//           //
//           // String choosenDayWithoutSlashes = "";
//           // String choosenMonthWithoutSlashes = "";
//           // String choosenYearWithoutSlashes = "";
//           //
//           // String concatinatedChoosenDate = choosenDayWithoutSlashes +
//           //     choosenMonthWithoutSlashes +
//           //     choosenYearWithoutSlashes;
//           // String concatinatedTodaysDate = todaysDayWithoutSlashes +
//           //     todaysMonthWithoutSlashes +
//           //     todaysYearWithoutSlashes;
//           // print("${concatinatedChoosenDate} concatinatedChoosenDate");
//           // print("${concatinatedTodaysDate} concatinatedTodaysDate");
//           // if(concatinatedChoosenDate.isNotEmpty) {
//           //   if (int.parse(concatinatedChoosenDate) <
//           //       int.parse(concatinatedTodaysDate)) {
//           //     Functions.showErrorToast(
//           //         context, "Error", "Cannot book in previous dates");
//           //   } else {
//           //     // SaloonController saloonController = Get.find();
//           //     // saloonController.isDataLoadedForDateChange.toggle();
//           //     // await saloonController
//           //     //     .getSpecificStaffDetailsForSpecificDates(saloonController
//           //     //         .chosenDateTimeFromSetAppointmentWithDashes.value)
//           //     //     .then((value) => Get.back());
//           //     Get.back();
//           //   }
//           // }
//           // else{
//           //   Get.back();
//           // }
//           // }
//           // Get.toNamed(Routes.SELECT_SERVICES);
//           // Get.toNamed(Routes.appointment_content_two);
//         },
//         titleStyle: TextStyle(color: ColorsX.blue_button_color),
//         confirmTextColor: ColorsX.white);
//   }
//
//
//   static getEndDateEndDateForEditDeal({
//     required String title,
//     required String msg,
//     required String date,
//     required BuildContext context,
//   }) {
//     Get.defaultDialog(
//         title: title,
//         middleText: msg,
//         textCancel: "    Cancel    ",
//         textConfirm: "       OK       ",
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               height: 150,
//               width: SizeConfig.screenWidth,
//               margin: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                   border: Border.all(color: ColorsX.blue_button_color),
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               child: CupertinoDatePicker(
//                 mode: CupertinoDatePickerMode.date,
//                 initialDateTime: DateTime(
//
//                     int.parse(DateTime.now().year.toString()),
//                     int.parse(DateTime.now().month.toString()),
//                     int.parse(DateTime.now().day.toString())),
//                 onDateTimeChanged: (DateTime newDateTime) {
//                   // Do something
//                   int dayEndDate = newDateTime.day;
//                   int monthEndDate = newDateTime.month;
//                   int yearEndDate = newDateTime.year;
//                   String dayString ="";
//                   String monthString ="";
//                   if(dayEndDate<10){
//                     dayString = "0"+dayEndDate.toString();
//                   }else {
//                     dayString = dayEndDate.toString();
//                   }
//                   if(monthEndDate<10){
//                     monthString = "0"+monthEndDate.toString();
//                   }else {
//                     monthString = monthEndDate.toString();
//                   }
//                   DealsListCTL adminDealsCtl = Get.find();
//                   // String newDob = newDateTime.day.toString() +
//                   //     "/" +
//                   //     newDateTime.month.toString() +
//                   //     "/" +
//                   //     newDateTime.year.toString();
//                   // adminDealsCtl
//                   //         .chosenDateTimeFromSetAppointmentWithDashes.value =
//                   //     newDateTime.year.toString() +
//                   //         "-" +
//                   //         newDateTime.month.toString() +
//                   //         "-" +
//                   //         newDateTime.day.toString();
//                   adminDealsCtl
//                       .chosenDateTimeForEndDateWithDashes.value =
//                       yearEndDate.toString() +
//                           "-" +
//                           monthString +
//                           "-" +
//                           dayString;
//                   print("${adminDealsCtl.chosenDateTimeForEndDateWithDashes.value} end date" );
//                   print("${dayEndDate} end date day" );
//                   print("${monthEndDate} end date month" );
//                   print("${yearEndDate} end date year" );
//                   // chosenDateTimeFromSetAppointment = newDob;
//                   // print(chosenDateTimeFromSetAppointment);
//                   // dobCtl.text = newDob;
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//           ],
//         ),
//         onCancel: () {
//           // Get.back();
//         },
//         onConfirm: () async {
//           print("OK clicked");
//           AdminDealsCTL adminDealsCtl = Get.find();
//           if(adminDealsCtl.chosenDateTimeFromSetAppointmentWithDashes.value.isNotEmpty) {
//             print(adminDealsCtl.chosenDateTimeFromSetAppointmentWithDashes.value);
//             Get.back();
//           }else{
//             print(getTodaysDate());
//             Get.back();
//           }
//
//           // if(chosenDateTimeFromSetAppointment!.isNotEmpty) {
//           //   String choosenDayWithoutSlashes =
//           //   chosenDateTimeFromSetAppointment.toString().split("/")[0];
//           //   String choosenMonthWithoutSlashes =
//           //   chosenDateTimeFromSetAppointment.toString().split("/")[1];
//           //   String choosenYearWithoutSlashes =
//           //   chosenDateTimeFromSetAppointment.toString().split("/")[2];
//           //   print(choosenDayWithoutSlashes);
//           //   print(choosenMonthWithoutSlashes);
//           //   print(choosenYearWithoutSlashes);
//           //   AdminDealsCTL adminDealsCTL = Get.find();
//           //   adminDealsCTL.chosenDateTimeFromSetAppointmentWithDashes.value = choosenDayWithoutSlashes+"-"+
//           // choosenMonthWithoutSlashes+"-"+choosenYearWithoutSlashes;
//           //   print("${adminDealsCTL.chosenDateTimeFromSetAppointmentWithDashes.value} chosen date");
//           // }
//           // else {
//           // String todaysDayWithoutSlashes =
//           // getTodaysDate().toString().split("-")[0];
//           // String todaysMonthWithoutSlashes =
//           // getTodaysDate().toString().split("-")[1];
//           // String todaysYearWithoutSlashes =
//           // getTodaysDate().toString().split("-")[2];
//           //
//           // print(todaysDayWithoutSlashes);
//           // print(todaysMonthWithoutSlashes);
//           // print(todaysYearWithoutSlashes);
//           //
//           //
//           // String choosenDayWithoutSlashes = "";
//           // String choosenMonthWithoutSlashes = "";
//           // String choosenYearWithoutSlashes = "";
//           //
//           // String concatinatedChoosenDate = choosenDayWithoutSlashes +
//           //     choosenMonthWithoutSlashes +
//           //     choosenYearWithoutSlashes;
//           // String concatinatedTodaysDate = todaysDayWithoutSlashes +
//           //     todaysMonthWithoutSlashes +
//           //     todaysYearWithoutSlashes;
//           // print("${concatinatedChoosenDate} concatinatedChoosenDate");
//           // print("${concatinatedTodaysDate} concatinatedTodaysDate");
//           // if(concatinatedChoosenDate.isNotEmpty) {
//           //   if (int.parse(concatinatedChoosenDate) <
//           //       int.parse(concatinatedTodaysDate)) {
//           //     Functions.showErrorToast(
//           //         context, "Error", "Cannot book in previous dates");
//           //   } else {
//           //     // SaloonController saloonController = Get.find();
//           //     // saloonController.isDataLoadedForDateChange.toggle();
//           //     // await saloonController
//           //     //     .getSpecificStaffDetailsForSpecificDates(saloonController
//           //     //         .chosenDateTimeFromSetAppointmentWithDashes.value)
//           //     //     .then((value) => Get.back());
//           //     Get.back();
//           //   }
//           // }
//           // else{
//           //   Get.back();
//           // }
//           // }
//           // Get.toNamed(Routes.SELECT_SERVICES);
//           // Get.toNamed(Routes.appointment_content_two);
//         },
//         titleStyle: TextStyle(color: ColorsX.blue_button_color),
//         confirmTextColor: ColorsX.white);
//   }
//
//   static String getTodaysDate() {
//     final DateTime now = DateTime.now();
//     print("now wali date" + "${now}");
//     final DateFormat formatter = DateFormat('yyyy-MM-dd');
//     final String formatted = formatter.format(now);
//     print(formatted);
//     return formatted;
//   }
//
//   static Widget pictureAndName(
//       String? profilePic, String? name, String? designation) {
//     return Container(
//       margin: EdgeInsets.only(left: 10, right: 10, top: 0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           ClipRRect(
//             borderRadius: BorderRadius.all(Radius.circular(25)),
//             child: CachedNetworkImage(
//               imageUrl: AppUrls.BASE_URL_IMAGE + '${profilePic}',
//               errorWidget: (context, url, error) => Icon(Icons.error),
//               fit: BoxFit.cover,
//               width: 50,
//               height: 50,
//               placeholder: (context, url) => Container(
//                   height: 30,
//                   width: 30,
//                   child: Center(child: CircularProgressIndicator())),
//             ),
//           ),
//           SizedBox(
//             width: 20,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               _rowItemForHeaderText(
//                   '${name}', 14, FontWeight.w700, 0xff000000, 0, 0, 0),
//               _rowItemForHeaderText(
//                   '${designation}', 14, FontWeight.w400, 0xff8890a6, 0, 0, 0),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   static Widget hisImages(List<dynamic>? photos) {
//     return Container(
//       margin: EdgeInsets.only(left: 10, right: 10),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: [
//             for (int index = 0; index < photos!.length; index++)
//               ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 child: CachedNetworkImage(
//                   imageUrl: AppUrls.BASE_URL_IMAGE + '${photos[index]}',
//                   errorWidget: (context, url, error) => Icon(Icons.error),
//                   fit: BoxFit.cover,
//                   width: 40,
//                   height: 40,
//                   placeholder: (context, url) => Container(
//                       height: 30,
//                       width: 30,
//                       child: Center(child: CircularProgressIndicator())),
//                 ),
//               ),
//             SizedBox(
//               width: 5,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   static Widget reviewsSet() {
//     return Container(
//       margin: EdgeInsets.only(left: 10, right: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _rowItemForHeaderText(
//               "Reviews", 12, FontWeight.w700, 0xff000000, 0, 0, 0),
//           // Expanded(child: Container()),
//           // Container(
//           //     width: SizeConfig.blockSizeHorizontal * 32,
//           //     height: SizeConfig.blockSizeVertical * 3,
//           //     padding: EdgeInsets.only(
//           //         left: SizeConfig.blockSizeHorizontal * 3,
//           //         right: SizeConfig.blockSizeHorizontal * 3),
//           //     margin: EdgeInsets.only(top: 0, left: 10, bottom: 5),
//           //     decoration: BoxDecoration(
//           //         border: Border.all(color: ColorsX.blue_button_color),
//           //         borderRadius: BorderRadius.circular(5)),
//           //     child: DropdownButton(
//           //       underline: SizedBox(),
//           //       hint: Text(
//           //         '$dropDownValue',
//           //         style:
//           //             TextStyle(color: ColorsX.blue_button_color, fontSize: 10),
//           //       ),
//           //       isExpanded: true,
//           //       iconSize: 30.0,
//           //       icon: Image.asset(AppImages.dropdown_field_ic,
//           //           color: ColorsX.blue_button_color),
//           //       style: TextStyle(
//           //           color: Color(0xff8890A6),
//           //           fontSize: 10,
//           //           fontWeight: FontWeight.w600),
//           //       items: dropDownList.map(
//           //         (val) {
//           //           return DropdownMenuItem<String>(
//           //             value: val,
//           //             child: Text(val),
//           //           );
//           //         },
//           //       ).toList(),
//           //       onChanged: (val) {
//           //         // setState(
//           //         //   () {
//           //         //     _dropDownValue = val as String;
//           //         //   },
//           //         // );
//           //       },
//           //     )),
//         ],
//       ),
//     );
//   }
//
//   Widget _DropDownWithoutBorder(List<String> values, String text) {
//     return Container(
//         width: SizeConfig.seventyFivePercentWidth,
//         margin: EdgeInsets.only(top: 0, left: 10, bottom: 5),
//         child: DropdownButton(
//           underline: SizedBox(),
//           hint: Text(
//             '$text',
//             style: TextStyle(color: Color(0xff515C6F)),
//           ),
//           isExpanded: true,
//           iconSize: 30.0,
//           // icon: Image.asset(AppImages.dropdown_field_ic),
//           style: TextStyle(
//               color: Color(0xff8890A6),
//               fontSize: 14,
//               fontWeight: FontWeight.w600),
//           items: values.map(
//                 (val) {
//               return DropdownMenuItem<String>(
//                 value: val,
//                 child: Text(val),
//               );
//             },
//           ).toList(),
//           onChanged: (val) {
//             // setState(
//             //   () {
//             //     _dropDownValue = val as String;
//             //   },
//             // );
//           },
//         ));
//   }
//
//   static Widget reviewsData() {
//     return Container(
//       margin: EdgeInsets.only(left: 10, right: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 child: Image.asset(
//                   AppImages.jim,
//                   height: 40,
//                   width: 40,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               SizedBox(
//                 width: 15,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   _rowItemForHeaderText("Jim Fernandez", 13, FontWeight.w600,
//                       0xff707070, 0, 0, 0),
//                   RatingBar.builder(
//                     itemSize: 11,
//                     initialRating: 4,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     tapOnlyMode: false,
//                     ignoreGestures: true,
//                     itemCount: 5,
//                     itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
//                     itemBuilder: (context, _) => Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: (rating) {
//                       print(rating);
//                     },
//                   ),
//                 ],
//               ),
//               Expanded(child: Container()),
//               _rowItemForHeaderText(
//                   "2 hours ago", 10, FontWeight.w600, 0xff707070, 0, 0, 0)
//             ],
//           ),
//           _rowItemForHeaderText(
//               "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla ",
//               12,
//               FontWeight.w400,
//               0xff707070,
//               5,
//               0,
//               0)
//         ],
//       ),
//       // child: Row(
//       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //   children: [
//       //     _rowItemForHeaderText("Reviews", 12, FontWeight.w700, 0xff000000, 0, 0, 0),
//       //     _rowItemForHeaderText("Lowest to Highest", 12, FontWeight.w400, 0xff70b4FF, 0, 0, 0),
//       //   ],
//       // ),
//     );
//   }
//
//   static Widget hisSchedule(String? day, String from, String to) {
//     return Container(
//       margin: EdgeInsets.only(left: 10, right: 10),
//       child: Row(
//         children: [
//           Container(
//             width: SizeConfig.screenWidth * .20,
//             child: _rowItemForHeaderText(
//                 "${day}", 12, FontWeight.w400, 0xff000000, 0, 0, 0),
//           ),
//           Expanded(child: Container()),
//           Expanded(
//               child: _rowItemForHeaderText(
//                   from, 12, FontWeight.w400, 0xff000000, 0, 0, 0)),
//           Expanded(child: Container()),
//           _rowItemForHeaderText(to, 12, FontWeight.w400, 0xff000000, 0, 0, 0),
//         ],
//       ),
//     );
//   }
//
//   static void navigateTo(double lat, double lng) async {
//     print(lat);
//     print(lng);
//     var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
//     if (await canLaunch(uri.toString())) {
//       await launch(uri.toString());
//     } else {
//       throw 'Could not launch ${uri.toString()}';
//     }
//     // var uri = Uri.parse("https://google.navigation:q=$lat,$lng&mode=d");
//     // if (await canLaunch(uri.toString())) {
//     //   await launch(uri.toString());
//     // } else {
//     //   throw 'Could not launch ${uri.toString()}';
//     // }
//   }
//   static launchURL (double latitude, double longitude) async {
//
//     final String googleMapslocationUrl = "https://www.google.com/maps/dir/?api=1&parameters=$latitude,$longitude";
//     // final String googleMapslocationUrl = "https%3A%2F%2Fwww.google.com%2Fmaps%2Fdir%2F%3Fapi%3D1%26parameters%3D$latitude%2C$longitude";
//     // if (await MapLauncher.isMapAvailable(MapType.google)) {
//     if(latitude.isGreaterThan(0)){
//
//       try{
//         await MapLauncher.showMarker(
//           mapType: MapType.google,
//           coords: Coords(latitude, longitude),
//           title: "title",
//           description: "description",
//         );
//       }
//       catch(e){
//         print(e);
//       }
//     }
//     else{
//       Functions.showToast("Location not provided");
//     }
//   }
//
//   static openwhatsapp(BuildContext context, String number, String text) async{
//     if (Platform.isAndroid) {
//       // add the [https]
//       await launch("https://wa.me/?text=${Uri.parse(text)}");
//       // return "https://wa.me/$number/?text=${Uri.parse(text)}"; // new line
//     } else {
//       // add the [https]
//       await launch("https://api.whatsapp.com/send?phone=$number=${Uri.parse(text)}");
//       // return "https://api.whatsapp.com/send?phone=$number=${Uri.parse(text)}"; // new line
//     }
//     //
//     //
//     // var whatsapp =number;
//     // var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=$text";
//     // var whatappURL_ios ="https://wa.me/$whatsapp?text=$text";
//     // if(Platform.isIOS){
//     //   // for iOS phone only
//     //   if( await canLaunch(whatappURL_ios)){
//     //     await launch(whatappURL_ios, forceSafariVC: false);
//     //   }else{
//     //     showToast("WhatsApp not installed");
//     //   }
//     // }else{
//     //   // android , web
//     //   if( await canLaunch(whatsappURl_android)){
//     //     await launch(whatsappURl_android);
//     //   }else{
//     //     showToast("WhatsApp not installed");
//     //   }
//     // }
//   }
//
//
//   static Widget _rowItemForHeaderText(
//       String value,
//       double fontSize,
//       FontWeight fontWeight,
//       int colorCode,
//       double top,
//       double left,
//       double right) {
//     return Container(
//       margin: EdgeInsets.only(top: top, left: left, right: right),
//       child: Text(
//         value,
//         style: TextStyle(
//             color: Color(colorCode),
//             fontWeight: fontWeight,
//             fontSize: fontSize),
//       ),
//     );
//   }
}
