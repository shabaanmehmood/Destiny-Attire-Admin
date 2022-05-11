import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../utils/colors.dart';
import '../../utils/global_widgets.dart';
import '../../utils/size_config.dart';
import '../../widget/drawer_widget.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalWidgets globalWidgets = GlobalWidgets();
  var listOfProfessions = [];
  var listOfCastess = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: body(context),
      drawer: DrawerWidget(context),
      appBar: AppBar(
        backgroundColor: ColorsX.black,
        centerTitle: true,
        title: globalWidgets.myText(context, "Filters", ColorsX.white, 0, 0,0,0, FontWeight.w400, 16),
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

  listViewContent(BuildContext context) {
    return Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: ListView(
        children: <Widget>[
          globalWidgets.myText(context, 'Choose Castes', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          castes(context),
          globalWidgets.myText(context, 'Choose Professions', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
          profession(context),
          SizedBox(height: 30,),
          findButton(context),
          SizedBox(height: 30,),
        ]
      ),
    );
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
          child: globalWidgets.myText(context, type, listOfProfessions.contains(type) ? ColorsX.white : ColorsX.black, 0, 10, 10, 0, FontWeight.w600, 15),
        ),
      ),
    );
  }
  castes(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: <Widget>[
          for(int index = 0; index < GlobalWidgets.casteList.length; index++)
            castesType(context, GlobalWidgets.casteList[index],index),
        ],
      ),
    );
  }
  castesType(BuildContext context, String type, int index){

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
          child: globalWidgets.myText(context, type, listOfProfessions.contains(type) ? ColorsX.white : ColorsX.black, 0, 10, 10, 0, FontWeight.w600, 15),
        ),
      ),
    );
  }
  findButton(BuildContext context,){
    return GestureDetector(
      onTap: (){
        Get.toNamed(Routes.PROPOSALS_LIST);
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
            child: globalWidgets.myText(context, "Next", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
        ),
      ),
    );
  }

}
