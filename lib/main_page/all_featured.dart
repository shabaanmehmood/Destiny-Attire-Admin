import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../utils/cache_data.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import '../../utils/global_widgets.dart';
import '../../utils/size_config.dart';
import '../../views/widget/drawer_widget.dart';

class AllFeatured extends StatefulWidget {
  const AllFeatured({Key? key}) : super(key: key);

  @override
  _AllFeaturedState createState() => _AllFeaturedState();
}

class _AllFeaturedState extends State<AllFeatured> with SingleTickerProviderStateMixin {

  GlobalWidgets globalWidgets = GlobalWidgets();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CacheData cacheData = CacheData();
  List<DocumentSnapshot> allProducts = [];
  AnimationController? _animationController;
  Animation? animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(GlobalVariables.viewAll == 'Featured') {
      debugPrint(GlobalVariables.viewAll);
      loadFeaturedProducts();
    }
    if(GlobalVariables.viewAll == 'Products') {
      debugPrint(GlobalVariables.viewAll);
      loadAllProducts();
    }
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = ColorTween(begin: Colors.red, end: Colors.amber)
        .animate(_animationController!);
    _animationController?.repeat();
    _animationController?.addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose() {
    super.dispose();
    _animationController?.stop();
    _animationController?.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        _animationController?.stop();
        Get.back();
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: body(context),
        drawer: DrawerWidget(context),
        appBar: AppBar(
          backgroundColor: const Color(0xffEEEEEE).withOpacity(0.8),
          centerTitle: true,
          title: Image.asset('assets/images/logo.png', height: 40, width: 50,),
          leading: IconButton(
            icon: Icon(Icons.menu_rounded, color: ColorsX.black,),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(), //Scaffold.of(context).openDrawer(),
          ),
        ),
        // floatingActionButton: new FloatingActionButton(
        //   backgroundColor: GlobalVariables.cartList.isEmpty ? ColorsX.black : animation?.value,
        //   onPressed: () => cartOpen(context),
        //   tooltip: 'Cart',
        //   child: FaIcon(FontAwesomeIcons.shoppingCart, color: ColorsX.white,),
        // ),
      ),
    );
  }

  cartOpen(BuildContext context) {
    Get.toNamed(Routes.CART);
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
              color:  const Color(0xffEEEEEE).withOpacity(0.8),
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
      child: Container(
        // height: SizeConfig.screenHeight,
        // width: SizeConfig.screenWidth,
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: EdgeInsets.only(top: SizeConfig.screenHeight * .02),
                      child: Image.asset('assets/images/logo.png', height: 80, width: 80,)),
                ),
                SizedBox(height: 15,),
                allProducts.isEmpty ? Container() :
                showGridView(context),
                allProducts.isEmpty ? Container() :ourLinks(context),
                Container(
                  margin: EdgeInsets.only(bottom: SizeConfig.screenHeight * .02),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  ourLinks(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(),
          GestureDetector(
            onTap: (){},
            child: CircleAvatar(
              child: FaIcon(FontAwesomeIcons.facebookF, color: Colors.white,), // Icon widget changed with FaIcon
              radius: 20.0,
              // backgroundColor: Colors.cyan
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: CircleAvatar(
              child: FaIcon(FontAwesomeIcons.instagram, color: Colors.white,), // Icon widget changed with FaIcon
              radius: 20.0,
              // backgroundColor: Colors.cyan
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: CircleAvatar(
              child: FaIcon(FontAwesomeIcons.twitter, color: Colors.white,), // Icon widget changed with FaIcon
              radius: 20.0,
              // backgroundColor: Colors.cyan
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: CircleAvatar(
              child: FaIcon(FontAwesomeIcons.linkedin, color: Colors.white,), // Icon widget changed with FaIcon
              radius: 20.0,
              // backgroundColor: Colors.cyan
            ),
          ),
          Container(),
        ],
      ),
    );
  }
  void loadFeaturedProducts() async {

    GlobalWidgets.showProgressLoader("Please wait");

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('is_featured', isEqualTo: '1')
        .where('is_available', isEqualTo: '1')
        .get();
    final List<DocumentSnapshot> firestoreResponseList = querySnapshot.docs;

    if (firestoreResponseList.isEmpty) {
      debugPrint('no featured and not available');
    }
    else {
      setState(() {
        allProducts = querySnapshot.docs;
        // GlobalVariables.featuredModelLength = documentsByCastes.length ?? 0;
        // GlobalVariables.featuredModelLength = featuredModel?.serverResponse.length ?? 0;
        print('featured length' + allProducts.length.toString());
      });
    }
      GlobalWidgets.hideProgressLoader();
  }

  void loadAllProducts() async {

    GlobalWidgets.showProgressLoader("Please wait");

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .get();
    final List<DocumentSnapshot> firestoreResponseList = querySnapshot.docs;

    if (firestoreResponseList.isEmpty) {
      debugPrint('no products available');
    }
    else {
      setState(() {
        allProducts = querySnapshot.docs;
        // GlobalVariables.featuredModelLength = documentsByCastes.length ?? 0;
        // GlobalVariables.featuredModelLength = featuredModel?.serverResponse.length ?? 0;
        print('products length' + allProducts.length.toString());
      });
    }
      GlobalWidgets.hideProgressLoader();
  }


  errorDialog(BuildContext context) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: "No Product Found",
        desc:
        'Please try again',
        btnOkOnPress: () {
          Get.back();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }


  showImageOfItem(List<DocumentSnapshot<Object?>>? documents, int index, BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 3, right: 3, bottom: 3),
      child: GestureDetector(
        onTap: (){
          debugPrint(documents?[index].get('product_name'));
          GlobalVariables.imagesListOfSpecificProduct = documents?[index].get('images');
          GlobalVariables.idOfProduct = "${documents?[index].reference.id}";
          Get.toNamed(Routes.PRODUCTS_DETAIL);
        },
        child: Center(
          child: Container(
            height: SizeConfig.screenHeight * .25,
            width: SizeConfig.screenWidth * .36,
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: documents?[index].get('images')[0],
              placeholder: (context,url) => Container(
                child: Image.asset('assets/images/logo.png', height: 100, width: 100,),
              ),
              // progressIndicatorBuilder: (context, url, downloadProgress) =>
              //     CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }


  outOfStock(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: globalWidgets.myText(context, "Out of Stock", ColorsX.red_danger, 0, 5, 5, 0, FontWeight.w700, 20),
      ),
    );
  }

  showGridView(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: SizeConfig.screenHeight * .43, // Set as you want or you can remove it also.
        maxHeight: double.infinity,
      ),
      child: Container(
        // height: SizeConfig.screenHeight,
        // width: SizeConfig.screenWidth,
        child: GridView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          // shrinkWrap: true,
          // physics: ScrollPhysics(),
          itemCount: allProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            // crossAxisSpacing: SizeConfig.marginVerticalXsmall,
            // mainAxisSpacing: SizeConfig.marginVerticalXsmall,
            crossAxisCount: 2,
            childAspectRatio: 0.5,
          ),
          itemBuilder: (contxt, index) {
            return  buildItem(index, context);
          },
        ),
      ),
    );
  }

  buildItem(int index, BuildContext context) {
    return Container(

        height: SizeConfig.screenHeight * .43,
        width: SizeConfig.screenWidth * .38,
        child: Padding(
          padding: EdgeInsets.only(left: 8 , right:  8),
          child: GestureDetector(
            onTap: (){
              debugPrint(allProducts?[index].get('product_name'));
            },
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              elevation: 5,
              color: Colors.white,
              child: GestureDetector(
                onTap: (){},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    showImageOfItem(allProducts,index, context),
                    GestureDetector(
                      onTap: (){
                        debugPrint(allProducts?[index].get('product_name'));
                        GlobalVariables.imagesListOfSpecificProduct = allProducts?[index].get('images');
                        GlobalVariables.idOfProduct = "${allProducts?[index].reference.id}";
                        Get.toNamed(Routes.PRODUCTS_DETAIL);
                      },
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: 0, minWidth: 11, maxWidth: SizeConfig.screenWidth * .38),
                        child: globalWidgets.myTextCustom(context, "${allProducts?[index].get('product_name')}", ColorsX.black, 0, 10, 5, 0, FontWeight.w600, 15),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        debugPrint(allProducts?[index].get('product_name'));
                        GlobalVariables.imagesListOfSpecificProduct = allProducts?[index].get('images');
                        GlobalVariables.idOfProduct = "${allProducts?[index].reference.id}";
                        Get.toNamed(Routes.PRODUCTS_DETAIL);
                      },
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: 0, minWidth: 11, maxWidth: SizeConfig.screenWidth * .38),
                        child: globalWidgets.myTextCustom(context, "${allProducts?[index].get('short_description')}", ColorsX.black.withOpacity(0.4), 0, 10, 5, 0, FontWeight.w600, 12),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            debugPrint(allProducts?[index].get('product_name'));
                            GlobalVariables.imagesListOfSpecificProduct = allProducts?[index].get('images');
                            GlobalVariables.idOfProduct = "${allProducts?[index].reference.id}";
                            Get.toNamed(Routes.PRODUCTS_DETAIL);
                          },
                          child: globalWidgets.cutText(context, "PKR ${allProducts?[index].get('cut_price')}", ColorsX.red_danger, 0, 10, 5, 0, FontWeight.w300, 15),
                        ),
                        SizedBox(width: 5,),
                        allProducts?[index].get('discount') == '0' ? Container() :
                        GestureDetector(
                          onTap: (){
                            debugPrint(allProducts?[index].get('product_name'));
                            GlobalVariables.imagesListOfSpecificProduct = allProducts?[index].get('images');
                            GlobalVariables.idOfProduct = "${allProducts?[index].reference.id}";
                            Get.toNamed(Routes.PRODUCTS_DETAIL);
                          },
                          child: globalWidgets.myText(context, "-${allProducts?[index].get('discount')}%", ColorsX.greenish, 0, 10, 5, 0, FontWeight.w700, 15),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        debugPrint(allProducts?[index].get('product_name'));
                        GlobalVariables.imagesListOfSpecificProduct = allProducts?[index].get('images');
                        GlobalVariables.idOfProduct = "${allProducts?[index].reference.id}";
                        Get.toNamed(Routes.PRODUCTS_DETAIL);
                      },
                      child: globalWidgets.myText(context, "PKR ${allProducts?[index].get('sale_price')}", ColorsX.black, 0, 10, 5, 0, FontWeight.w600, 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}

