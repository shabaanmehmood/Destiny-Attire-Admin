import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/proposalDetailModel.dart';
import '../../services/api.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import '../../utils/global_widgets.dart';
import '../../utils/size_config.dart';

class ProposalDetails extends StatefulWidget {
  const ProposalDetails({Key? key}) : super(key: key);

  @override
  _ProposalDetailsState createState() => _ProposalDetailsState();
}

class _ProposalDetailsState extends State<ProposalDetails> {
  GlobalWidgets globalWidgets = GlobalWidgets();
  ProposalDetailModel? proposalDetailModel;
  String addedToFavourite = '';
  String age = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
      appBar: AppBar(
        backgroundColor: ColorsX.black,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () { Get.back(); },),
        title: globalWidgets.myText(context, "Proposal Detail", ColorsX.white, 0, 0,0,0, FontWeight.w400, 16),
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

  listViewContent(BuildContext context) {
    String professiontemp = '${proposalDetailModel?.serverResponse.basicDetails.profession.replaceAll('[', '')}';
    String profession = professiontemp.replaceAll(']', '');
    String requiredprofessiontemp = '${proposalDetailModel?.serverResponse.demands.professionDemand.replaceAll('[', '')}';
    String professionRequired = requiredprofessiontemp.replaceAll(']', '');
    String requiredHousePossessiontemp = '${proposalDetailModel?.serverResponse.demands.housingDemandPossession.replaceAll('[', '')}';
    String housePossession = requiredHousePossessiontemp.replaceAll(']', '');
    String requiredHouseLocationtemp = '${proposalDetailModel?.serverResponse.demands.housingDemandLocation.replaceAll('[', '')}';
    String location = requiredHouseLocationtemp.replaceAll(']', '');
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: proposalDetailModel == null ? Container() : ListView(
        children: [
          // addToFavourites(context),
          globalWidgets.myText(context, 'Basic Details', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          heading(context, 'ID', '${proposalDetailModel?.serverResponse.basicDetails.id}' == "null" ? "" :
          '${proposalDetailModel?.serverResponse.basicDetails.id}'
              ,ColorsX.greytext, 20, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Profile Created By', '${proposalDetailModel?.serverResponse.basicDetails.profileCreatedBy}' == "null" ? "" :
          '${proposalDetailModel?.serverResponse.basicDetails.profileCreatedBy}'
              ,ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Name', '${proposalDetailModel?.serverResponse.others.name}' == "null" ? "" :
          '${proposalDetailModel?.serverResponse.others.name}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Caste', '${proposalDetailModel?.serverResponse.basicDetails.caste}' == "null" ? "" :
          '${proposalDetailModel?.serverResponse.basicDetails.caste}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Sub-caste', heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.subcaste}') == "null" ? "" :
          heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.subcaste}'),ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Mother Tongue', '${proposalDetailModel?.serverResponse.basicDetails.motherTongue}' == "null" ? "" :
          '${proposalDetailModel?.serverResponse.basicDetails.motherTongue} Speaking',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Age', ageCalculate('${proposalDetailModel?.serverResponse.basicDetails.dob}') == "null" ? "" :
          ageCalculate('${proposalDetailModel?.serverResponse.basicDetails.dob}'),ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Gender', '${proposalDetailModel?.serverResponse.basicDetails.gender}' == "null" ? "" :
          '${proposalDetailModel?.serverResponse.basicDetails.gender}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Height', heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.height}') == "null" ? "" :
          heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.height}'),ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Marital Status', '${proposalDetailModel?.serverResponse.basicDetails.maritalStatus}' == "null" ? "" :
          '${proposalDetailModel?.serverResponse.basicDetails.maritalStatus}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          Visibility(
            visible: '${proposalDetailModel?.serverResponse.basicDetails.maritalStatus}' == 'Single' ? false : true,
              child: heading(context, 'Reason for Second Marriage', '${proposalDetailModel?.serverResponse.basicDetails.reasonForSecondMarriage}' == "null" ? "" :
              '${proposalDetailModel?.serverResponse.basicDetails.reasonForSecondMarriage}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          ),
          Visibility(
            visible: '${proposalDetailModel?.serverResponse.basicDetails.maritalStatus}' == 'Single' ? false : true,
            child: heading(context, 'Marriage Period', '${proposalDetailModel?.serverResponse.basicDetails.marriagePeriod}' == "null" ? "" :
            '${proposalDetailModel?.serverResponse.basicDetails.marriagePeriod} yrs',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          ),
          Visibility(
            visible: '${proposalDetailModel?.serverResponse.basicDetails.maritalStatus}' == 'Single' ? false : true,
            child: heading(context, 'Separation Period', '${proposalDetailModel?.serverResponse.basicDetails.separationPeriod}' == "null" ? "" :
            '${proposalDetailModel?.serverResponse.basicDetails.separationPeriod} yrs',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          ),
          Visibility(
            visible: '${proposalDetailModel?.serverResponse.basicDetails.maritalStatus}' == 'Single' ? false : true,
            child: heading(context, 'Kids', '${proposalDetailModel?.serverResponse.basicDetails.kids}' == "null" ? "" :
            '${proposalDetailModel?.serverResponse.basicDetails.kids}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          ),
          Visibility(
            visible: '${proposalDetailModel?.serverResponse.basicDetails.maritalStatus}' == 'Single' ? false : true,
            child: heading(context, 'Kids Ownership', heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.kidsOwnership}') == "null" ? "" :
            heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.kidsOwnership}'),ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          ),
          globalWidgets.myText(context, 'Place of Living', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          heading(context, 'City', '${proposalDetailModel?.serverResponse.basicDetails.city}' == "null" ? "" :
          '${proposalDetailModel?.serverResponse.basicDetails.city}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Area', '${proposalDetailModel?.serverResponse.basicDetails.area}' == "null" ? "" :
          '${proposalDetailModel?.serverResponse.basicDetails.area}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          globalWidgets.myText(context, 'Qualification', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          heading(context, 'Latest Education', heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.qualification}') == "null" ? "" :
          heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.qualification}'),ColorsX.greytext, 20, 10, 0, 0, FontWeight.w400, 15),
          globalWidgets.myText(context, 'Professional Information', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          heading(context, 'Profession', '${proposalDetailModel?.serverResponse.basicDetails.profession}' == "null" ? "" :
          '${profession}',ColorsX.greytext, 20, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Occupation', heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.occupation}'),ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Salary', heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.monthlyIncome}'),ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          globalWidgets.myText(context, 'Family Details', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          heading(context, 'Mother Alive', '${proposalDetailModel?.serverResponse.familyDetails.motherAlive}' == '1' ? 'Yes' : "No",ColorsX.greytext, 20, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Father Alive', '${proposalDetailModel?.serverResponse.familyDetails.fatherAlive}' == '1' ? 'Yes' : "No",ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Father\u0027s Occupation', heightCalculate('${proposalDetailModel?.serverResponse.familyDetails.fathersOccupation}'),ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Mother\u0027s Occupation', '${proposalDetailModel?.serverResponse.basicDetails.mo}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Siblings', '${proposalDetailModel?.serverResponse.familyDetails.siblings}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Married Brothers', '${proposalDetailModel?.serverResponse.familyDetails.marriedBrothers}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Married Sisters', '${proposalDetailModel?.serverResponse.familyDetails.marriedSisters}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Unmarried Brothers', '${proposalDetailModel?.serverResponse.familyDetails.unmarriedBrothers}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Unmarried Sisters', '${proposalDetailModel?.serverResponse.familyDetails.unmarriedSisters}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          globalWidgets.myText(context, 'Religion Details', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          heading(context, 'Religion', '${proposalDetailModel?.serverResponse.basicDetails.religion}',ColorsX.greytext, 20, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Sect', '${proposalDetailModel?.serverResponse.basicDetails.sect}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          globalWidgets.myText(context, 'Housing Details', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          heading(context, 'House Area', '${proposalDetailModel?.serverResponse.familyDetails.houseArea} ${proposalDetailModel?.serverResponse.familyDetails.houseIn}',ColorsX.greytext, 20, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'House Possession', '${proposalDetailModel?.serverResponse.familyDetails.possession}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Location', '${proposalDetailModel?.serverResponse.basicDetails.area}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Area', "Lower Mall",ColorsX.greytext, 0, 10, 0, 0, FontWeight.w700, 15),
          globalWidgets.myText(context, 'Additional Information', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          heading(context, 'Additional Information', heightCalculate('${proposalDetailModel?.serverResponse.familyDetails.additionalInfo}'),ColorsX.greytext, 20, 10, 10, 0, FontWeight.w400, 15),

          globalWidgets.myText(context, 'Required Proposal', ColorsX.yellowColor, 25, 10, 0, 0, FontWeight.w900, 20),
          heading(context, 'Caste Specific', '${proposalDetailModel?.serverResponse.demands.casteDemand}' == "1" ? "Please Contact only if Caste Matches" :
          '${proposalDetailModel?.serverResponse.demands.casteDemand}' == "2" ? "Out of Caste can contact" : "No Caste Specific Demand",ColorsX.greytext, 20, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Caste Restriction', '${proposalDetailModel?.serverResponse.demands.casteDemand}' == "1" ? "Yes" : "No",ColorsX.greytext, 2, 10, 10, 0, FontWeight.w400, 15),
          heading(context, 'Profession', '${professionRequired}',ColorsX.greytext, 2, 10, 10, 0, FontWeight.w400, 15),
          heading(context, 'Age Limit', '${proposalDetailModel?.serverResponse.demands.ageLimit} yrs',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Min Height', heightCalculate('${proposalDetailModel?.serverResponse.demands.heightDemand}'),ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Min House Area', '${proposalDetailModel?.serverResponse.demands.housingDemandArea}'
              ' ${proposalDetailModel?.serverResponse.demands.housingDemandIn}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'House Possession', '${housePossession}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Location', '${location}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'City', '${proposalDetailModel?.serverResponse.demands.cityDemand}',ColorsX.greytext, 2, 10, 0, 0, FontWeight.w400, 15),
          globalWidgets.myText(context, 'Additional Information', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          heading(context, 'Additional Demands', heightCalculate('${proposalDetailModel?.serverResponse.demands.additionalDemand}'),ColorsX.greytext, 20, 10, 0, 0, FontWeight.w400, 15),
          SizedBox(height: 30,),
          buttonsLayout(context),
          SizedBox(height: 50,),
        ],
      ),
    );
  }

  ageCalculate(String birthDateString) {
    try {
      print(birthDateString);
      String year = birthDateString.split("/")[2];
      DateTime today = DateTime.now();
      int hisAgeValue = int.parse(year);
      int yrsOld = today.year - hisAgeValue;
      age = yrsOld.toString() + " yrs";
      return yrsOld.toString() + " yrs";
    }
    catch(e){
      age = '0 yrs';
      return age;
    }
  }

  heightCalculate(String height) {
    String newHeight = height;
    if(height.contains('@')){
      newHeight = height.replaceAll("@", "\u0027");
    }
    return newHeight;
  }

  accountCreated(String dateTime) {
    int days = 0;
    DateTime today = DateTime.now();
    DateTime incoming = DateTime.parse(dateTime);
    days = today.difference(incoming).inDays;
    if(days < 1){
      days = today.difference(incoming).inHours;
      return days.toString()+ ' hours ago';
    }else{
      return days.toString() + ' days ago';
    }
  }
  addToFavourites(BuildContext context){
    return GestureDetector(
      onTap: (){
        setState(() {
          addedToFavourite == "Yes" ? "No" : "Yes";
        });
      },
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 10, right: 10),
              child: IconButton(icon : Icon(Icons.star_outline_sharp, color:  addedToFavourite == "Yes" ? Colors.red : ColorsX.white,), onPressed: () { setState(() {
                addedToFavourite == "Yes" ? addedToFavourite = "No" : addedToFavourite = "Yes";
              }); },),
            ),
          ),
          globalWidgets.myText(context, addedToFavourite == "Yes" ?"Added to Favourites" : "Add to Favourites", ColorsX.white, 15, 0, 10, 0, FontWeight.w400, 14)
        ],
      ),
    );
  }
  buttonsLayout(BuildContext context, ){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Visibility(
            visible: false,
            child: GestureDetector(
              onTap: (){

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: new Text("This feature is not available yet")));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: ColorsX.light_orange)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: (FaIcon(FontAwesomeIcons.rocketchat, color: ColorsX.white,)),
                      ),
                      Container(
                        child: globalWidgets.myText(context, "Chat", ColorsX.white, 5, 0, 0, 0, FontWeight.w900, 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: GlobalVariables.isMyProfile == true ? false : true,
            child: GestureDetector(
              onTap: (){
                dialNumber(context, "${proposalDetailModel?.serverResponse.basicDetails.primaryPhone}");
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: ColorsX.light_orange)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: (FaIcon(FontAwesomeIcons.phone, color: ColorsX.white,)),
                      ),
                      Container(
                        child: globalWidgets.myText(context, "Call", ColorsX.white, 5, 0, 0, 0, FontWeight.w900, 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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

  heading(BuildContext context, String text,String detail, Color colorsX, double top, double left, double right, double bottom,
      FontWeight fontWeight, double fontSize){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: globalWidgets.myText(context, text, colorsX, top, left, right, bottom, fontWeight, fontSize)),
        Expanded(child: globalWidgets.myText(context, detail, ColorsX.white.withOpacity(0.8), top, left, right, bottom, fontWeight, fontSize),
        ),
      ],
    );
  }


  void loadDetails() async{

    var _apiService = ApiService();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> userInfo = Map();

    userInfo['id'] = GlobalVariables.idOfProposal;

    GlobalWidgets.showProgressLoader("Please Wait");
    GlobalWidgets.hideKeyboard(context);
    final res = await _apiService.proposalDetail(apiParams: userInfo);
    GlobalWidgets.hideProgressLoader();
    if (res is ProposalDetailModel) {
      setState(() {
        proposalDetailModel = res;
      });
      // ageCalculate("${proposalDetailModel?.serverResponse.basicDetails.dob}");
      print('hurrah');
      // Get.toNamed(Routes.ALL_CASTES_MAIN_PAGE);
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
        title: "No proposal Found",
        desc:
        'Please try again',
        btnOkOnPress: () {
          Get.back();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }

}
