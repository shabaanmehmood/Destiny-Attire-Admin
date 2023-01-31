
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as _storage;
import 'package:path/path.dart';
import '../../routes/app_pages.dart';
import '../../utils/colors.dart';
import '../../utils/global_widgets.dart';
import '../utils/size_config.dart';

class NewProduct extends StatefulWidget {
  NewProduct({Key? key}) : super(key: key);

  @override
  NewProductState createState() => NewProductState();
}

class NewProductState extends State<NewProduct> {

  TextEditingController productNameCtl = new TextEditingController();
  TextEditingController shortDescriptionCtl = new TextEditingController();
  TextEditingController longDescriptionCtl = new TextEditingController();
  TextEditingController cutPriceCtl = new TextEditingController();
  TextEditingController salePriceCtl = new TextEditingController();
  String discount = "0";
  List<String> urlsOfImages = [];
  String? selectedCategoryName;
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  List<DocumentSnapshot> allCategories = [];
  _storage.FirebaseStorage storage =
      _storage.FirebaseStorage.instance;

  File? _photo;

  String? urlOfImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if(pickedfiles != null){
        imagefiles = pickedfiles;
        setState(() {
        });
      }else{
        print("No image is selected.");
      }
    }catch (e) {
      print("error while picking file.");
    }
  }

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
    if(imagefiles == null)
      return;
    int length = imagefiles!.length;
    Map<String, dynamic> productInfo = Map();

    for(int index = 0; index < length; index++){
      _photo = File(imagefiles![index].path);
      final fileName = basename(_photo!.path+'_'+productNameCtl.text+index.toString());
      final destination = 'products/$fileName';
      try{
        GlobalWidgets.showProgressLoader('Please Wait');
        final ref = _storage.FirebaseStorage.instance
            .ref(destination)
            .child('products/');
        await ref.putFile(_photo!);
        urlOfImage = await ref.getDownloadURL();
        urlsOfImages.add('${urlOfImage}');

        debugPrint('added');
        debugPrint(urlOfImage);
      }catch(e){
        print('error occured');
      }
    }

    productInfo['cut_price'] = cutPriceCtl.text.trim().toString();
    productInfo['discount'] = discount;
    productInfo['images'] = urlsOfImages;
    productInfo['is_available'] = '1';
    productInfo['is_featured'] = '0';
    productInfo['long_description'] = longDescriptionCtl.text.trim().toString();
    productInfo['product_name'] = productNameCtl.text.trim().toString();
    productInfo['sale_price'] = salePriceCtl.text.trim().toString();
    productInfo['short_description'] = shortDescriptionCtl.text.trim().toString();
    productInfo['category'] = selectedCategoryName;
    var collection = FirebaseFirestore.instance.collection('products');
    var docRef = await collection.add(productInfo);
    var documentId = docRef.id;
    GlobalWidgets.hideProgressLoader();
    successDialog(documentId,context);


    //
    // if (_photo == null) return;
    // final fileName = basename(_photo!.path);
    // final destination = 'files/$fileName';



    // try {
    //   Map<String, dynamic> categoryInfo = Map();
    //
    //   GlobalWidgets.showProgressLoader('Please Wait');
    //   final ref = firebase_storage.FirebaseStorage.instance
    //       .ref(destination)
    //       .child('file/');
    //   await ref.putFile(_photo!);
    //   urlOfImage = await ref.getDownloadURL();
    //
    //   debugPrint('added');
    //   debugPrint(urlOfImage);
    //
    //   categoryInfo['name'] = categoryNameCtl.text.trim().toString();
    //   categoryInfo['any_text'] = descriptionCtl.text.trim().toString();
    //   categoryInfo['cat_image'] = urlOfImage;
    //   var collection = FirebaseFirestore.instance.collection('categories');
    //   var docRef = await collection.add(categoryInfo);
    //   var documentId = docRef.id;
    //   GlobalWidgets.hideProgressLoader();
    //   successDialog(documentId,context);
    // } catch (e) {
    //   print('error occured');
    // }
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
        title: '${signUpResponse} \n Product ID',
        desc:
        'Product Added successfully',// \n Save or remember ID to Log In' ,
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
                      openImages();
                      // _showPicker(context);
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
                imagefiles != null?Center(
                  child: Wrap(
                    children: imagefiles!.map((imageone){
                      return Container(
                          child:Card(
                            child: Container(
                              height: 100, width:100,
                              child: Image.file(File(imageone.path),fit: BoxFit.contain,),
                            ),
                          )
                      );
                    }).toList(),
                  ),
                ):Container(),
                myText(context, 'Product Name', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
                myText(context, 'For Example: Mint the Flavor of Summer', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
                myTextField(TextInputType.text, productNameCtl, false, "Category Name Here" ),
                myText(context, 'Short Description', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
                myText(context, 'This mint colour dress made in premium doriya lawn.', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
                myTextFieldMultiLine(TextInputType.text, shortDescriptionCtl, false, "Short Description" ),
                myText(context, 'Long Description', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
                myText(context, 'Briefly describe your product with features and details', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
                myTextFieldMultiLine(TextInputType.text, longDescriptionCtl, false, "Long Description" ),
                myText(context, 'Cut Price', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
                myText(context, 'Price before discount. This will be shown as cut price', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
                myTextFieldMultiLine(TextInputType.number, cutPriceCtl, false, "Cut Price" ),
                myText(context, 'Sale Price', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
                myText(context, 'Price after discount. Actual price to sale.', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
                myTextFieldMultiLine(TextInputType.number, salePriceCtl, false, "Sale Price" ),
                SizedBox(height: 40,),
                myText(context, 'Category', ColorsX.white, 20, 10, 0, 0, FontWeight.w700, 20),
                myText(context, 'Select Category for your product.', ColorsX.white, 0, 10, 0, 0, FontWeight.w400, 13),
                allCategories.isEmpty ? Container() : showAndSelectCategories(context),
                showDiscountButton(context),
                addProductButton(context),
          ],
        ),
      ),
    );
  }

  showAndSelectCategories(BuildContext context){

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: allCategories.length,
        itemBuilder: (BuildContext context, int index) => Center(child: itemBuild(context, index)),
      ),
    );
    // int length = allCategories.length;
    // debugPrint(length.toString());
    // for(int index = 0; index < length; index++)
    //   return Container(
    //     height: 70,
    //     child: ListView(
    //       scrollDirection: Axis.horizontal,
    //       children: [
    //         GestureDetector(
    //           onTap: (){
    //             selectedCategoryName = allCategories[index].get('name');
    //             debugPrint(selectedCategoryName);
    //           },
    //           child: myText(context, allCategories[index].get('name'),
    //               selectedCategoryName == allCategories[index].get('name') ? ColorsX.greenish : ColorsX.white,
    //               20, 20, 20, 10, FontWeight.w700, 15),
    //         ),
    //       ],
    //     ),
    //   );
  }
itemBuild(BuildContext context, int index){
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedCategoryName = allCategories[index].get('name');
        });
        debugPrint(selectedCategoryName);
      },
      child: myText(context, allCategories[index].get('name'),
          selectedCategoryName == allCategories[index].get('name') ? ColorsX.greenish : ColorsX.white,
          0, 10, 10, 0, FontWeight.w700, 15),
    );
}
  getAllCategories() async {

    GlobalWidgets.showProgressLoader("Fetching Categories");

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .get();

    final List<DocumentSnapshot> documents = querySnapshot.docs;
    GlobalWidgets.hideProgressLoader();
    if(documents.isEmpty) {
      debugPrint('No categories found');
    }else{
      setState(() {
        allCategories = documents;
      });
    }
  }

  showDiscountButton(BuildContext context,){
    return GestureDetector(
      onTap: (){
        if(cutPriceCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(
              context, "Cut Price required", 'Please provide price before discount to show as cut prive');
        }
        else if(salePriceCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(
              context, "Sale price required", 'Please provide price to sale after discount');
        }
        else if(int.parse(salePriceCtl.text) > int.parse(cutPriceCtl.text)){
          GlobalWidgets.showErrorToast(
              context, "Price Error", 'Cut price must be less than sale price');
        }
        else{
          GlobalWidgets.hideKeyboard(context);
          calculateDiscount();
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
            child: myText(context, "Show Discount", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
        ),
      ),
    );
  }

  calculateDiscount(){

    int priceBeforeDiscount = int.parse(cutPriceCtl.text);
    int priceAfterDiscount = int.parse(salePriceCtl.text);
    double remainder = 0.0;
    int priceDifference = 0;
    priceDifference = priceAfterDiscount - priceBeforeDiscount;
    remainder = priceDifference / priceBeforeDiscount;
    double myDiscount = remainder * 100;
    discount = myDiscount.toStringAsFixed(2);
    if(discount.contains('-')){
      discount = discount.replaceAll("-", '');
    }
    GlobalWidgets.showToast(
        "discount is ${discount}");
  }

  addProductButton(BuildContext context,){
    return GestureDetector(
      onTap: (){
        calculateDiscount();
        if(imagefiles == null){
          GlobalWidgets.showErrorToast(
              context, "No Image Selected", 'Please select images for your product');
        }
        else if(selectedCategoryName == null){
          GlobalWidgets.showErrorToast(
              context, "Category Name required", 'Please select category for your product');
        }
        else if(cutPriceCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(
              context, "Cut Price required", 'Please provide price before discount to show as cut prive');
        }
        else if(salePriceCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(
              context, "Sale price required", 'Please provide price to sale after discount');
        }
        else if(shortDescriptionCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(
              context, "Short Description required", 'Please provide short description');
        }
        else if(longDescriptionCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(
              context, "Long Description required", 'Please provide long description');
        }
        else if(productNameCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(
              context, "Product name required", 'Please provide product name');
        }
        else{
          GlobalWidgets.hideKeyboard(context);
          uploadFile(context);
        }
      },
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: ColorsX.light_orange,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: myText(context, "Add New Product", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
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