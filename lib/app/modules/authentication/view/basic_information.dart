
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/cache_data.dart';
import '../../../utils/colors.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/global_widgets.dart';
import '../../../utils/size_config.dart';

class BasicInformation extends StatefulWidget {
  const BasicInformation({Key? key}) : super(key: key);

  @override
  _BasicInformationState createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CacheData cacheData = CacheData();
  String selectedTypeOfProfileCreator = '';
  String selectedTypeOSingleWidow = '';
  String reasonOfSecondMarriage = '';
  String selectedGender = '';
  bool isSingle = false;
  var listOfProfessions = [];
  String formattedDateWithZeros = '';
  DateTime selectedDate = DateTime.now();
  String date = "";
  TextEditingController nameCtl = new TextEditingController();
  TextEditingController kidsCtl = new TextEditingController();
  TextEditingController separationYearsCtl = new TextEditingController();
  TextEditingController marriageYearsCtl = new TextEditingController();
  TextEditingController kidsOwnershipCtl = new TextEditingController();
  TextEditingController dobCtl = new TextEditingController();
  TextEditingController cityCtl = new TextEditingController();
  TextEditingController areaCtl = new TextEditingController();
  TextEditingController addressCtl = new TextEditingController();
  TextEditingController emailCtl = new TextEditingController();
  TextEditingController passwordCtl = new TextEditingController();
  TextEditingController primaryPhoneCtl = new TextEditingController();
  TextEditingController secondaryPhoneCtl = new TextEditingController();
  TextEditingController subCasteCtl = new TextEditingController();
  TextEditingController qualificationCtl = new TextEditingController();
  TextEditingController occupationCtl = new TextEditingController();
  TextEditingController monthlyIncomeCtl = new TextEditingController();
  TextEditingController feetCtl = new TextEditingController();
  TextEditingController inchesCtl = new TextEditingController();

  static String motherTongueValue = "Mother Tongue";
  static String religionValue = "Religion";
  static String cityValue = "Select City";
  static String maslakValue = "Maslak";
  static String casteValue = "Caste";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: body(context),
      appBar: AppBar(
        backgroundColor: ColorsX.black,
        centerTitle: true,
        leading: Container(),
        title: myText(context, "Basic Information", ColorsX.white, 0, 0,0,0, FontWeight.w400, 16),
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
  listViewContent(BuildContext context){
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: ListView(
        children: <Widget>[
          myText(context, 'Find Your Perfect Match', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Profile Created By', ColorsX.white, 0, 10, 0, 0, FontWeight.w700, 16),
          myText(context, 'Select who is creating profile', ColorsX.white, 3, 10, 0, 0, FontWeight.w400, 13),
          profileCreator(context),
          myText(context, 'Marital Status', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'What explains you best', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          singleWidowDivorced(context),
          Visibility(
            visible: isSingle,
              child: myText(context, 'Reason for second marriage', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          ),
          Visibility(
            visible: isSingle,
              child: myText(context, 'Choose any option according to your case', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          ),
          Visibility(
            visible: isSingle,
              child: secondMarriageType(context)
          ),
          Visibility(
            visible: isSingle,
            child: myText(context, 'Marriage Period', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          ),
          Visibility(
            visible: isSingle,
            child: myText(context, 'How many years did marriage last', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          ),
          Visibility(
            visible: isSingle,
            child: myTextField(TextInputType.phone, marriageYearsCtl, false, "Years" ),
          ),
          Visibility(
            visible: isSingle,
              child: myText(context, 'Separation Period', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          ),
          Visibility(
            visible: isSingle,
              child: myText(context, 'How many years of separation', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          ),
          Visibility(
            visible: isSingle,
              child: myTextField(TextInputType.phone, separationYearsCtl, false, "Years" ),
          ),

          Visibility(
            visible: isSingle,
            child: myText(context, 'Kids Details', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          ),
          Visibility(
            visible: isSingle,
            child: myText(context, 'How many kids do you have?', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          ),
          Visibility(
            visible: isSingle,
            child: myTextField(TextInputType.phone, kidsCtl, false, "Kids" ),
          ),
          Visibility(
            visible: isSingle,
            child: myText(context, 'Kids Ownership', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          ),
          Visibility(
            visible: isSingle,
            child: myText(context, 'Who has the kids?', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          ),
          Visibility(
            visible: isSingle,
            child: myTextField(TextInputType.text, kidsOwnershipCtl, false, "Mother / Father" ),
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 15),
          //   child: Divider(
          //     height: 1,
          //     thickness: 1,
          //     color: ColorsX.greytext,
          //   ),
          // ),
          myText(context, 'Personal Details', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Gender', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Gender of the candidate', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          gender(context, "Male", "Female"),
          myText(context, 'Name', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Name of the candidate or Any concerned person (Other proposals may reach you by this name)', ColorsX.white, 0, 10, 10, 0, FontWeight.w400, 13),
          myTextField(TextInputType.name, nameCtl, false, "Name" ),
          myText(context, 'Date of Birth', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Date of birth of the candidate', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          dateOfBirth(context, TextInputType.number, dobCtl, false, "Date of Birth"),
          myText(context, 'City', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'City to find easily', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          // myTextField(TextInputType.name, cityCtl, false, "City" ),
          cityDropdown(),
          myText(context, 'Area', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Town (Allama Iqbal Town)', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          myTextField(TextInputType.text, areaCtl, false, "Allama Iqbal Town" ),
          myText(context, 'Address', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Complete house Address', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          myTextField(TextInputType.text, addressCtl, false, "Address" ),
          myText(context, 'Height', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Height of candidate (feet & inches)', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          getHeight(context, feetCtl, inchesCtl, false),

          // Container(
          //   margin: EdgeInsets.only(top: 15),
          //   child: Divider(
          //     height: 1,
          //     thickness: 1,
          //     color: ColorsX.greytext,
          //   ),
          // ),
          myText(context, 'Contact & Caste Details', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Email', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Email for communication', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          myTextField(TextInputType.emailAddress, emailCtl, false, "Email" ),
          myText(context, 'Password', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Password to secure information', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          myTextField(TextInputType.text, passwordCtl, true, "Password" ),
          myText(context, 'Phone', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Interested profiles will contact you on this number', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          phoneNumberLayout(context, TextInputType.phone, primaryPhoneCtl, false, "Phone"),
          myText(context, 'Phone', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'In case of first number is not reachable (optional)', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          phoneNumberLayout(context, TextInputType.phone, secondaryPhoneCtl, false, "Phone"),
          myText(context, 'Mother Tongue', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Native language to find perfect match', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          motherTongeDropdown(),
          myText(context, 'Religion', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Chosose Religion', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          religionDropdown(),
          religionValue == "Islam" ? myText(context, 'Sect', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20) : Container(),
          religionValue == "Islam" ? myText(context, 'Maslak / Sect', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13) : Container(),
          religionValue == "Islam" ? maslakDropdown(): Container(),
          myText(context, 'Caste', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Your caste will help others and you to find each other', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          casteDropdown(),
          myText(context, 'Sub Caste', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Your sub caste will help others and you to find each other', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          myTextField(TextInputType.text, subCasteCtl, false, "Sub caste" ),

          myText(context, 'Profession & Education Details', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Profession', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Which profession explains you best', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          profession(context),
          myText(context, 'Qualification', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Last qualification of candidate', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          myTextField(TextInputType.text, qualificationCtl, false, "BS Computer Science" ),
          myText(context, 'Occupation', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Job holder ? (nature of job)', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          myTextField(TextInputType.text, occupationCtl, false, "Designation" ),
          myText(context, 'Monthly Income', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
          myText(context, 'Monthly salary of candidate', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          myTextField(TextInputType.text, monthlyIncomeCtl, false, "Salary" ),
          SizedBox(height: 30,),
          createProfileButton(context),
          Align(
            alignment: Alignment.topCenter,
            child: termsText(context, 25, 20, 20, 20),
          ),
          SizedBox(height: 50,),
        ],
      ),
    );
  }
  gender(BuildContext context, String male, String female){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              genderType(context, male),
              genderType(context, female),
            ],
          ),
        ],
      ),
    );
  }

  getHeight(BuildContext context, TextEditingController feetCtl, TextEditingController inchCtl, bool obscureText){
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(child: myTextField(TextInputType.phone, feetCtl, false, 'Feet')),
          Expanded(child: myTextField(TextInputType.phone, inchCtl, false, 'Inch')),
        ],
      ),
    );
  }
  phoneNumberLayout(BuildContext context, TextInputType inputType, TextEditingController ctl, bool obscureText, String hint){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 0, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: ColorsX.white),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child:  myText(context, "+92", ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 15),
              ),
            )
          ),
          Expanded(child: myTextField(inputType, ctl, obscureText, hint)),
        ],
      ),
    );
  }
  selectDateOfBirth(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1980),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      formattedDateWithZeros = DateFormat('dd-MM-yyyy').format(selected);
      setState(() {
        selectedDate = selected;
      });
    }
  }

  termsText(BuildContext context, double top, double right, double left, double bottom){
    return GestureDetector(
      onTap: (){
        // Get.toNamed(Routes.CREATE_ACCOUNT);
      },
      child: Container(
        margin: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: RichText(
          text: TextSpan(
              children: [
                TextSpan(
                  text: "By clicking the button, you agree to our ", style: TextStyle(color: ColorsX.white, fontSize: 16),
                ),
                TextSpan(
                  text: "Terms & Conditions", style: TextStyle(color: ColorsX.yellowColor, fontSize: 16, fontWeight: FontWeight.w700),
                  recognizer: TapGestureRecognizer()..onTap = () {

                    GlobalVariables.webView_url = ("http://rishtaaasan.000webhostapp.com/terms.html");
                    Get.toNamed(Routes.TERMS_CONDITIONS);
                  },
                ),
                TextSpan(
                  text: " and ", style: TextStyle(color: ColorsX.white, fontSize: 16),
                ),
                TextSpan(
                  text: "Privacy Policy", style: TextStyle(color: ColorsX.yellowColor, fontSize: 16, fontWeight: FontWeight.w700),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    GlobalVariables.webView_url =("http://rishtaaasan.000webhostapp.com/privacy_policy.html");
                    Get.toNamed(Routes.PRIVACY_POLICY);
                  },
                ),
              ]
          ),
        ),
      ),
    );
  }
  cityDropdown(){
    return Container(
      width: SizeConfig.screenWidth,
      height: 50,
      margin: EdgeInsets.only(top: 5, right: 10, left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsX.white),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(cityValue),
        underline: SizedBox(),
        value: cityValue,
        //elevation: 5,
        style: TextStyle(
            color: Colors.black,
            fontSize: 14),
        icon: Container(
          margin: EdgeInsets.only(right: 10),
          child: Icon(Icons.arrow_drop_down, color: ColorsX.white,),
        ),
        items: GlobalWidgets.citiesList.map<DropdownMenuItem<String>>(
                (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.only(
                      right:
                      SizeConfig.marginVerticalXXsmall),
                  child: myText(context, value, ColorsX.light_orange, 0, 10, 0, 0, FontWeight.w400, 15),
                ),
              );
            }).toList(),
        onChanged: (value) {
          setState(() {
            cityValue = value!;
            print(cityValue);
          });
        },
      ),
    );
  }
  motherTongeDropdown(){
    return Container(
      width: SizeConfig.screenWidth,
      height: 50,
      margin: EdgeInsets.only(top: 5, right: 10, left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsX.white),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(motherTongueValue),
        underline: SizedBox(),
        value: motherTongueValue,
        //elevation: 5,
        style: TextStyle(
            color: Colors.black,
            fontSize: 14),
        icon: Container(
          margin: EdgeInsets.only(right: 10),
          child: Icon(Icons.arrow_drop_down, color: ColorsX.white,),
        ),
        items: GlobalWidgets.motherTongueList.map<DropdownMenuItem<String>>(
                (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.only(
                      right:
                      SizeConfig.marginVerticalXXsmall),
                  child: myText(context, value, ColorsX.light_orange, 0, 10, 0, 0, FontWeight.w400, 15),
                ),
              );
            }).toList(),
        onChanged: (value) {
          setState(() {
            motherTongueValue = value!;
            print(motherTongueValue);
          });
        },
      ),
    );
  }
  religionDropdown(){
    return Container(
      width: SizeConfig.screenWidth,
      height: 50,
      margin: EdgeInsets.only(top: 5, right: 10, left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsX.white),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(religionValue),
        underline: SizedBox(),
        value: religionValue,
        //elevation: 5,
        style: TextStyle(
            color: Colors.black,
            fontSize: 14),
        icon: Container(
          margin: EdgeInsets.only(right: 10),
          child: Icon(Icons.arrow_drop_down, color: ColorsX.white,),
        ),
        items: GlobalWidgets.religionList.map<DropdownMenuItem<String>>(
                (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.only(
                      right:
                      SizeConfig.marginVerticalXXsmall),
                  child: myText(context, value, ColorsX.light_orange, 0, 10, 0, 0, FontWeight.w400, 15),
                ),
              );
            }).toList(),
        onChanged: (value) {
          setState(() {
            religionValue = value!;
            print(religionValue);
          });
        },
      ),
    );
  }

  maslakDropdown(){
    return Container(
      width: SizeConfig.screenWidth,
      height: 50,
      margin: EdgeInsets.only(top: 5, right: 10, left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsX.white),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(maslakValue),
        underline: SizedBox(),
        value: maslakValue,
        //elevation: 5,
        style: TextStyle(
            color: Colors.black,
            fontSize: 14),
        icon: Container(
          margin: EdgeInsets.only(right: 10),
          child: Icon(Icons.arrow_drop_down, color: ColorsX.white,),
        ),
        items: GlobalWidgets.maslakList.map<DropdownMenuItem<String>>(
                (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.only(
                      right:
                      SizeConfig.marginVerticalXXsmall),
                  child: myText(context, value, ColorsX.light_orange, 0, 10, 0, 0, FontWeight.w400, 15),
                ),
              );
            }).toList(),
        onChanged: (value) {
          setState(() {
            maslakValue = value!;
            print(maslakValue);
          });
        },
      ),
    );
  }
  casteDropdown(){
    return Container(
      width: SizeConfig.screenWidth,
      height: 50,
      margin: EdgeInsets.only(top: 5, right: 10, left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsX.white),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(casteValue),
        underline: SizedBox(),
        value: casteValue,
        //elevation: 5,
        style: TextStyle(
            color: Colors.black,
            fontSize: 14),
        icon: Container(
          margin: EdgeInsets.only(right: 10),
          child: Icon(Icons.arrow_drop_down, color: ColorsX.white,),
        ),
        items: GlobalWidgets.casteList.map<DropdownMenuItem<String>>(
                (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.only(
                      right:
                      SizeConfig.marginVerticalXXsmall),
                  child: myText(context, value, ColorsX.light_orange, 0, 10, 0, 0, FontWeight.w400, 15),
                ),
              );
            }).toList(),
        onChanged: (value) {
          setState(() {
            casteValue = value!;
            print(casteValue);
          });
        },
      ),
    );
  }

  dateOfBirth(BuildContext context, TextInputType inputType, TextEditingController ctl, bool obscureText, String hint) {
    return GestureDetector(
      onTap: (){
        return selectDateOfBirth(context);
      },
      child: GestureDetector(
        onTap: (){
          return selectDateOfBirth(context);
        },
        child: Container(
          width: SizeConfig.screenWidth,
          height: 50,
          margin: EdgeInsets.only(left: 10, right: 10, top: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(color: ColorsX.white, width: 1.25)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              myText(context, selectedDate == DateTime.now() || formattedDateWithZeros == null || formattedDateWithZeros.isEmpty ? 'Date of Birth' :
              formattedDateWithZeros, ColorsX.white, 0, 15, 0, 0,
                  FontWeight.w400, 15),
              Expanded(child: Container()),
              Icon(Icons.date_range, color: ColorsX.white,),
              SizedBox(width: 15,),
            ],
          ),
        ),
      ),
    );
  }
  bool isAdult(String birthDayYear) {
    // String datePattern = "dd-MM-yyyy";
    int birthYear = int.parse(birthDayYear);
    // DateTime birthDate = DateTime.parse(datePattern);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthYear;
    // int monthDiff = today.month - birthDate.month;
    // int dayDiff = today.day - birthDate.day;

    // return yearDiff > 17 || yearDiff == 17 && monthDiff >= 0 && dayDiff >= 0;
    return yearDiff > 17 || yearDiff == 17;
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
            hintText: hint, hintStyle: TextStyle(color: ColorsX.white)
        ),
      ),
    );
  }

  profileCreator(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: <Widget>[
          profileCreatorType(context, 'Self'),
          profileCreatorType(context, 'Parent'),
          profileCreatorType(context, 'Sibling'),
          profileCreatorType(context, 'Relative'),
          profileCreatorType(context, 'Friend'),
        ],
      ),
    );
  }
  singleWidowDivorced(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: <Widget>[
          singleWidowerType(context, 'Bachelor'),
          singleWidowerType(context, 'Second Marriage'),
        ],
      ),
    );
  }
  secondMarriageType(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: <Widget>[
          secondMarriageReasonType(context, 'Widow'),
          secondMarriageReasonType(context, 'Divorced'),
          secondMarriageReasonType(context, 'Widower'),
          secondMarriageReasonType(context, 'Khulla'),
        ],
      ),
    );
  }
  genderType(BuildContext context, String type){
    return GestureDetector(
        onTap: (){
          setState(() {
            selectedGender = type;
            cacheData.genderOfThePerson = selectedGender;
          });
        },
        child: Container(
          height: 100,
          width: SizeConfig.screenWidth * .25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(width: 2,color: ColorsX.white),
            color: selectedGender == type ? ColorsX.light_orange : Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  child: FaIcon(type == "Male" ? FontAwesomeIcons.male : FontAwesomeIcons.female, size: 30, color: ColorsX.white,),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: myText(context, type, ColorsX.white, 10, 0, 0, 0, FontWeight.w400, 15),
                ),
              ),
            ],
          ),
        ),
      );
    //   GestureDetector(
    //   onTap: (){
    //     setState(() {
    //       selectedGender = type;
    //     });
    //   },
    //   child: Container(
    //     decoration: BoxDecoration(
    //       color: selectedGender == type ? ColorsX.light_orange : ColorsX.lightColorServiceRow,
    //       borderRadius: BorderRadius.all(Radius.circular(20)),
    //     ),
    //     child: Padding(
    //       padding: EdgeInsets.symmetric(
    //         horizontal: 15, vertical: 5
    //       ),
    //       child: myText(context, type, selectedGender == type ? ColorsX.white : ColorsX.black, 0, 10, 10, 0, FontWeight.w600, 15),
    //     ),
    //   ),
    // );
  }

  profileCreatorType(BuildContext context, String type){
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedTypeOfProfileCreator = type;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedTypeOfProfileCreator == type ? ColorsX.light_orange : ColorsX.lightColorServiceRow,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15, vertical: 8
          ),
          child: myText(context, type, selectedTypeOfProfileCreator == type ? ColorsX.white : ColorsX.black, 0, 10, 10, 0, FontWeight.w600, 15),
        ),
      ),
    );
  }
  singleWidowerType(BuildContext context, String type){
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedTypeOSingleWidow = type;
          if(type == "Bachelor"){
            isSingle = false;
          }
          else {
            isSingle = true;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedTypeOSingleWidow == type ? ColorsX.light_orange : ColorsX.lightColorServiceRow,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15, vertical: 8
          ),
          child: myText(context, type, selectedTypeOSingleWidow == type ? ColorsX.white : ColorsX.black, 0, 10, 10, 0, FontWeight.w600, 15),
        ),
      ),
    );
  }
  secondMarriageReasonType(BuildContext context, String type){
    return GestureDetector(
      onTap: (){
        setState(() {
          reasonOfSecondMarriage = type;
          if(type == "Bachelor"){
            isSingle = false;
          }
          else {
            isSingle = true;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: reasonOfSecondMarriage == type ? ColorsX.light_orange : ColorsX.lightColorServiceRow,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15, vertical: 8
          ),
          child: myText(context, type, reasonOfSecondMarriage == type ? ColorsX.white : ColorsX.black, 0, 10, 10, 0, FontWeight.w600, 15),
        ),
      ),
    );
  }
  createProfileButton(BuildContext context,){
    return GestureDetector(
      onTap: (){
        if(selectedTypeOfProfileCreator==''){
          GlobalWidgets.showErrorToast(context, "Who's Creating Profile ?", 'Choose your relaton with candidate');
        }
        else if(selectedTypeOSingleWidow.trim().toString().toLowerCase() != 'bachelor' && selectedTypeOSingleWidow.trim().toString().toLowerCase()!="second marriage"){
          GlobalWidgets.showErrorToast(context, "Marital Status Of Candidate", 'Choose marital status');
        }
        else if(isSingle && reasonOfSecondMarriage == ''){
          GlobalWidgets.showErrorToast(context, "Second Marriage Reason", 'Choose Reason for second marriage');
        }
        else if(isSingle && marriageYearsCtl.text.trim().toString().isEmpty){
          GlobalWidgets.showErrorToast(context, "Married Life Years", 'Add marriage years');
        }
        else if(isSingle && separationYearsCtl.text.trim().toString().isEmpty){
          GlobalWidgets.showErrorToast(context, "Years of Separation", 'Add separation years');
        }
        else if(isSingle && kidsCtl.text.trim().toString().isEmpty){
          GlobalWidgets.showErrorToast(context, "Number of Kids", 'Add number of kids');
        }
        else if(isSingle && kidsOwnershipCtl.text.trim().toString().isEmpty){
          GlobalWidgets.showErrorToast(context, "Who Has The Kids", 'Add kids details (who has the kids?)');
        }
        else if(selectedGender == ''){
          GlobalWidgets.showErrorToast(context, "Gender Required", 'Choose Gender');
        }
        else if(nameCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Name", 'Please provide name of the candidate');
        }
        else if(!isAdult(selectedDate.year.toString())){
          GlobalWidgets.showErrorToast(context, "Date of Birth", 'Date of Birth must be 17+');
        }
        else if(cityValue == "Select City"){
          GlobalWidgets.showErrorToast(context, "City", 'Please provide city');
        }
        else if(areaCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Area", 'Please provide area');
        }
        else if(addressCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Address", 'Please provide address');
        }
        else if(feetCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Height", 'Please provide height in feet');
        }
        else if(inchesCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Height", 'Please provide height in inches');
        }
        else if(emailCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Email", 'Please provide email');
        }
        else if(passwordCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Password", 'Please provide password');
        }
        else if(primaryPhoneCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Phone", 'Please provide primary phone number');
        }
        else if(emailCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Height", 'Please provide height in feet');
        }
        else if(motherTongueValue == 'Mother Tongue'){
          GlobalWidgets.showErrorToast(context, "Mother Tongue", 'Please provide mother tongue');
        }
        else if(religionValue == 'Religion'){
          GlobalWidgets.showErrorToast(context, "Religion", 'Please provide religion');
        }
        else if(religionValue == 'Islam' && maslakValue == 'Maslak'){
          GlobalWidgets.showErrorToast(context, "Maslak", 'Please provide maslak');
        }
        else if(casteValue == 'Caste'){
          GlobalWidgets.showErrorToast(context, "Caste", 'Please provide Caste');
        }
        else if(subCasteCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Subcaste", 'Please provide Subcaste');
        }
        else if(qualificationCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Qualification", 'Please provide qualification of candidate');
        }
        else if(!GlobalWidgets.validateEmail(emailCtl.text)){
          GlobalWidgets.showErrorToast(context, "Email not valid", 'Please provide valid email');
        }
        else {
          GlobalVariables.profileCreatedBy = selectedTypeOfProfileCreator;
          GlobalVariables.maritalStatus = isSingle ? "Second Marriage" : "Single";
          GlobalVariables.reason_for_second_marriage = isSingle ? selectedTypeOSingleWidow : "Nil";
          GlobalVariables.marriage_period = isSingle ? marriageYearsCtl.text : "Nil";
          GlobalVariables.separation_period = isSingle ? separationYearsCtl.text : "Nil";
          GlobalVariables.kids = isSingle ? kidsCtl.text : "Nil";
          GlobalVariables.kids_ownership = isSingle ? kidsOwnershipCtl.text : "Nil";
          GlobalVariables.gender = selectedGender;
          GlobalVariables.name = nameCtl.text.trim().toString();
          GlobalVariables.dob = formattedDate(selectedDate.day.toString() , selectedDate.month.toString() , selectedDate.year.toString());
          // GlobalVariables.dob = formattedDateWithZeros;
          GlobalVariables.city = cityValue;
          GlobalVariables.area = areaCtl.text.trim().toString();
          GlobalVariables.address = addressCtl.text.trim().toString();
          GlobalVariables.height = feetCtl.text.trim().toString()+'\u0027'+inchesCtl.text.trim().toString();
          GlobalVariables.email = emailCtl.text.trim().toString();
          GlobalVariables.password = passwordCtl.text.trim().toString();
          GlobalVariables.primary_phone = primaryPhoneCtl.text.trim().toString();
          GlobalVariables.secondary_phone = secondaryPhoneCtl.text.trim().toString().isEmpty ? 'Nil' : secondaryPhoneCtl.text.trim().toString();
          GlobalVariables.mother_tongue = motherTongueValue;
          GlobalVariables.caste = casteValue;
          GlobalVariables.subcaste = subCasteCtl.text.trim().toString();
          GlobalVariables.profession = listOfProfessions.isEmpty ? 'Nil' : listOfProfessions.toString();
          GlobalVariables.religion = religionValue;
          GlobalVariables.sect = religionValue == 'Islam' ? maslakValue : 'Nil' ;
          GlobalVariables.qualificatiion = qualificationCtl.text.trim().toString();
          GlobalVariables.occupation = occupationCtl.text.trim().toString();
          GlobalVariables.monthly_income = monthlyIncomeCtl.text.trim().toString();
          Get.toNamed(Routes.FAMILY_INFORMATION);
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
            child: myText(context, "Next", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
        ),
      ),
    );
  }
  formattedDate(String day, String month, String year){
    String newDay = '';
    String newMonth = '';
    int oldDay = int.parse(day);
    int oldMonth = int.parse(month);
    if(oldDay<10 && oldDay>0){
      newDay = '0'+day;
    }else{
      newDay = day;
    }
    if(oldMonth<10 && oldMonth>0){
      newMonth = '0'+month;
    }else{
      newMonth = month;
    }
    return newDay + "/"+ newMonth + "/"+ year;
  }

  profession(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: <Widget>[
          professionType(context, 'Doctor',0),
          professionType(context, 'Engineer',1),
          professionType(context, 'Lecturer',2),
          professionType(context, 'M.B.A',3),
          professionType(context, 'M.A',4),
          professionType(context, 'Foreign Nationality',5),
          professionType(context, 'B.Sc',6),
          professionType(context, 'B.A',7),
          professionType(context, 'F.A',8),
          professionType(context, 'Business',9),
          professionType(context, 'Government Job',10),
          professionType(context, 'Army / Military',11),
          professionType(context, 'Lawyer',12),
          professionType(context, 'Banker',13),
        ],
      ),
    );
  }
  professionType(BuildContext context, String type, int index){

    return GestureDetector(
      onTap: (){
        setState(() {
          if(listOfProfessions.isEmpty){
            listOfProfessions.add(type);
          }
          else if(listOfProfessions.contains(type)){
            listOfProfessions.remove(type);
          }
          else{
            listOfProfessions.add(type);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: listOfProfessions.contains(type) ? ColorsX.light_orange : ColorsX.lightColorServiceRow,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 15, vertical: 8
          ),
          child: myText(context, type, listOfProfessions.contains(type) ? ColorsX.white : ColorsX.black, 0, 10, 10, 0, FontWeight.w600, 15),
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

}
