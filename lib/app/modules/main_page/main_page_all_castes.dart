import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/featured.dart';
import '../../routes/app_pages.dart';
import '../../services/api.dart';
import '../../utils/cache_data.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import '../../utils/global_widgets.dart';
import '../../utils/size_config.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/featured_proposals.dart';


class AllCastesMainPage extends StatefulWidget {
  const AllCastesMainPage({Key? key}) : super(key: key);

  @override
  _AllCastesMainPageState createState() => _AllCastesMainPageState();
}

class _AllCastesMainPageState extends State<AllCastesMainPage> {
  GlobalWidgets globalWidgets = GlobalWidgets();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CacheData cacheData = CacheData();
  String selectedCasteType = '';
  FeaturedModel? featuredModel;
  String? gender = '';
  SharedPreferences? prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValues();
    getFeaturedProposals();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: body(context),
        drawer: DrawerWidget(context),
        appBar: AppBar(
          backgroundColor: ColorsX.black,
          centerTitle: true,
          title: globalWidgets.myText(context, "Proposals", ColorsX.white, 0, 0,0,0, FontWeight.w400, 16),
          leading: IconButton(
            icon: Icon(Icons.menu_rounded, color: ColorsX.white,),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(), //Scaffold.of(context).openDrawer(),
          ),
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
  listViewContent(BuildContext context){
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: ListView(
        children: [
          // profession(context),
          featuredModel == null ? Container() : FeaturedProposals(featuredModel: featuredModel),
          globalWidgets.myText(context, 'Professions', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'Matches available for theses professions', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          // castes(context,),
          peofessions(context,),
          globalWidgets.myText(context, 'Castes', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'Matches available for theses castes', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
          castes(context,),
        ],
      ),
    );
  }

  peofessions(BuildContext context) {

    return ListView.separated(
      itemCount: GlobalWidgets.professionsList.length,
        separatorBuilder: (context, index) =>Divider(height: 1, color: ColorsX.light_orange),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              GlobalVariables.isCaste = false;
              print(GlobalWidgets.professionsList[index]);
              GlobalVariables.valueChosen = GlobalWidgets.professionsList[index];
              Get.toNamed(Routes.PROPOSALS_LIST);
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: ColorsX.yellowColor,
                child: globalWidgets.myText(context, (index+1).toString(), ColorsX.black, 0, 0, 0, 0, FontWeight.w400, 12),
              ),
              title: globalWidgets.myText(context, GlobalWidgets.professionsList[index], ColorsX.white, 0, 0, 0, 0, FontWeight.w700, 15),
              subtitle: globalWidgets.myText(context, "Find best matches", ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 13),
              trailing: GestureDetector(
                onTap: (){
                  GlobalVariables.isCaste = false;
                  print(GlobalWidgets.professionsList[index]);
                  GlobalVariables.valueChosen = GlobalWidgets.professionsList[index];
                  Get.toNamed(Routes.PROPOSALS_LIST);
                },
                child: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset(gender == 'Male' ? 'assets/images/woman.png' : 'assets/images/man.png', fit: BoxFit.contain, ),
                ),
              ),
            ),
          );
        });

  }

  castes(BuildContext context){
    return ListView.separated(
      itemCount: GlobalWidgets.casteList.length,
        separatorBuilder: (context, index) =>Divider(height: 1, color: ColorsX.light_orange),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              GlobalVariables.isCaste = true;
              print(GlobalWidgets.casteList[index]);
              GlobalVariables.valueChosen = GlobalWidgets.casteList[index];
              Get.toNamed(Routes.PROPOSALS_LIST);
            },
            child: index == 0 ? Container():ListTile(
              leading: CircleAvatar(
                backgroundColor: ColorsX.yellowColor,
                child: globalWidgets.myText(context, (index+1).toString(), ColorsX.black, 0, 0, 0, 0, FontWeight.w400, 12),
              ),
              title: globalWidgets.myText(context, GlobalWidgets.casteList[index], ColorsX.white, 0, 0, 0, 0, FontWeight.w700, 15),
              subtitle: globalWidgets.myText(context, "Find best matches", ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 13),
              trailing: GestureDetector(
                onTap: (){
                  GlobalVariables.isCaste = true;
                  print(GlobalWidgets.casteList[index]);
                  GlobalVariables.valueChosen = GlobalWidgets.casteList[index];
                  Get.toNamed(Routes.PROPOSALS_LIST);
                },
                child: Container(
                  height: 25,
                  width: 25,
                  child: Image.asset(gender == 'Male' ? 'assets/images/woman.png' : 'assets/images/man.png', fit: BoxFit.contain, ),
                ),
              ),
            ),
          );
        });

  }

  Widget categoryType(BuildContext context, String type) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: GestureDetector(
            onTap: (){
              setState(() {
                selectedCasteType = type;
              });
            },
            child: Container(
              height: 120,
              width: SizeConfig.screenWidth * .30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 2,color: ColorsX.white),
                color: selectedCasteType == type ? ColorsX.light_orange : Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      child: FaIcon(gender == "Male" ? FontAwesomeIcons.female : FontAwesomeIcons.male, color: ColorsX.black,),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Container(
                        child: globalWidgets.myText(context, type, ColorsX.black, 10, 5, 5, 0, FontWeight.w400, 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void getValues() async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      gender = prefs?.getString('gender');
      print(gender);
    });
  }

  void getFeaturedProposals() async{

    var _apiService = ApiService();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> userInfo = Map();

    userInfo['is_featured'] = '1';
    userInfo['gender'] = prefs.getString('gender');

    GlobalWidgets.showProgressLoader("Please Wait");
    GlobalWidgets.hideKeyboard(context);
    final res = await _apiService.getFeaturedProposals(apiParams: userInfo);
    GlobalWidgets.hideProgressLoader();
    if (res is FeaturedModel) {
      setState(() {
        featuredModel = res;
        GlobalVariables.featuredModelLength = featuredModel?.serverResponse.length ?? 0;
        print('featured length' + GlobalVariables.featuredModelLength.toString());
      });
    }
    else {
      print("No featured Proposals");
      // errorDialog(context);
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
