
import 'dart:io';

import 'package:Rishta_Nagar/app/utils/size_config.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import '../../routes/app_pages.dart';
import '../../utils/colors.dart';
import '../../utils/global_widgets.dart';

class NewCategory extends StatefulWidget {
  NewCategory({Key? key}) : super(key: key);

  @override
  NewCategoryState createState() => NewCategoryState();
}

class NewCategoryState extends State<NewCategory> {

  TextEditingController categoryNameCtl = new TextEditingController();
  TextEditingController descriptionCtl = new TextEditingController();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;

  String? urlOfImage;

  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile(BuildContext context) async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      Map<String, dynamic> categoryInfo = Map();

      GlobalWidgets.showProgressLoader('Please Wait');
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
      urlOfImage = await ref.getDownloadURL();

      debugPrint('added');
      debugPrint(urlOfImage);

      categoryInfo['name'] = categoryNameCtl.text.trim().toString();
      categoryInfo['any_text'] = descriptionCtl.text.trim().toString();
      categoryInfo['cat_image'] = urlOfImage;
      var collection = FirebaseFirestore.instance.collection('categories');
      var docRef = await collection.add(categoryInfo);
      var documentId = docRef.id;
      GlobalWidgets.hideProgressLoader();
      successDialog(documentId,context);
    } catch (e) {
      print('error occured');
    }
  }
  successDialog(String signUpResponse, BuildContext context) {
    // String id = '';
    // if(signUpResponse.toString().contains('Data Submitted')){
    //   id = signUpResponse.toString().split(".")[1];
    //   // saveIdInLocal(id);
    // }
    // else{
    //   print('no id found');
    // }
    return AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        closeIcon: Container(),
        // closeIcon: IconButton(icon : Icon(Icons.close, color: ColorsX.light_orange,),onPressed: () {
        //   Get.back();
        //   // Get.toNamed(Routes.LOGIN_SCREEN);
        // },),
        showCloseIcon: true,
        title: '${signUpResponse} \n Category ID',
        desc:
        'Category Created successfully',// \n Save or remember ID to Log In' ,
        btnOkOnPress: () {
          debugPrint('OnClcik');
          Get.back();
          // Get.toNamed(Routes.ALL_CASTES_MAIN_PAGE);
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {
          debugPrint('Dialog Dismiss from callback $type');
        })
      ..show();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color:  const Color(0xff000000).withOpacity(0.8),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Color(0xffFDCF09),
                  child: _photo != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      _photo!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                      : Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50)),
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
            ),
            myText(context, 'Category Name', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
            myText(context, 'For Example: Kids Collection', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
            myTextField(TextInputType.text, categoryNameCtl, false, "Category Name Here" ),
            myText(context, 'Description', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
            myText(context, 'Description about category', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
            myTextFieldMultiLine(TextInputType.text, descriptionCtl, false, "Description" ),
            SizedBox(
              height: 40,
            ),
            addCategoryButton(context),
          ],
        ),
      ),
    );
  }
  addCategoryButton(BuildContext context,){
    return GestureDetector(
      onTap: (){
        if(_photo == null){
          GlobalWidgets.showErrorToast(
              context, "No Image Selected", 'Please select an image for your category');
        }
        else if(categoryNameCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(
              context, "Category Name required", 'Please provide category name');
        }
        else if(descriptionCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(
              context, "Description required", 'Please provide category description');
        }
        else{
          GlobalWidgets.hideKeyboard(context);
          uploadFile(context);
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
            child: myText(context, "Add New Category", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
            hintText: hint, hintStyle: TextStyle(color: ColorsX.greenish)
        ),
      ),
    );
  }

  myTextFieldMultiLine(TextInputType inputType, TextEditingController ctl, bool obscureText, String hint){
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
        minLines: 1,
        maxLines: 5,
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
            hintText: hint, hintStyle: TextStyle(color: ColorsX.greenish)
        ),
      ),
    );
  }


}