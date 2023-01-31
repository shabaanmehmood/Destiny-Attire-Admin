import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:online_clothing_admin/categories/update_product.dart';

import '../../routes/app_pages.dart';
import '../../utils/cache_data.dart';
import '../../utils/colors.dart';
import '../../utils/global_widgets.dart';
import '../../utils/size_config.dart';
import '../../views/widget/drawer_widget.dart';
import '../utils/global_variables.dart';
import '../views/widget/large_image.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> with SingleTickerProviderStateMixin{

  GlobalWidgets globalWidgets = GlobalWidgets();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CacheData cacheData = CacheData();
  DocumentSnapshot? documentSnapshot;
  Map<String, dynamic>? fetchDoc;
  bool alreadyAdded = false;
  AnimationController? _animationController;
  Animation? animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductDetails();
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
  Widget build(BuildContext context) {
    // checkIfProductAlreadyAddedInTheCart();
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

  @override
  void dispose() {
    super.dispose();
    _animationController?.stop();
    _animationController?.dispose();
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
      child: ListView(
        children: [
          // profession(context),
          // featuredModel == null ? Container() : FeaturedProposals(featuredModel: featuredModel),
          // documents.isEmpty ? Container() : FeaturedProposals(documents: documents,),
          Align(
            alignment: Alignment.center,
            child: Container(
                margin: EdgeInsets.only(top: SizeConfig.screenHeight * .02),
                child: Image.asset('assets/images/logo.png', height: 80, width: 80,)),
          ),
          documentSnapshot == null ? Container() :
          showImageOfItem(context),
          documentSnapshot == null ? Container() :Container(
            child: globalWidgets.myText(context, "${fetchDoc?['product_name']}", ColorsX.black, 10, 20, 10, 0, FontWeight.w700, 24),
          ),

          documentSnapshot == null ? Container() : Container(
            child: globalWidgets.myText(context, "${fetchDoc?['category']}", ColorsX.black.withOpacity(0.6), 0, 20, 5, 0, FontWeight.w700, 15),
          ),
          fetchDoc?['is_available'] == '0' ? outOfStock(context) : Container(),
          documentSnapshot == null ? Container() : savePrice(context),

          documentSnapshot == null ? Container() : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: globalWidgets.cutText(context, "PKR${fetchDoc?['cut_price']}", ColorsX.red_danger, 10, 20, 5, 0, FontWeight.w700, 18),
              ),
              Container(
                child: globalWidgets.myText(context, "PKR${fetchDoc?['sale_price']}", ColorsX.greenish, 10, 20, 5, 0, FontWeight.w700, 18),
              ),
              Expanded(child: Container()),
              fetchDoc?['discount'] == '0' ? Container() :
              Container(
                margin: EdgeInsets.only(top: 10),
                  child: Icon(Icons.done, color: ColorsX.black,)
              ),
              fetchDoc?['discount'] == '0' ? Container() :
              globalWidgets.myText(context, "-${fetchDoc?['discount']}% off", ColorsX.greenish, 10, 5, 15, 0, FontWeight.w700, 18),

            ],
          ),
          documentSnapshot == null ? Container() : Container(
            child: globalWidgets.myText(context, "${fetchDoc?['short_description']}", ColorsX.black.withOpacity(0.6), 10, 20, 5, 0, FontWeight.w400, 16),
          ),
          documentSnapshot == null ? Container() : Container(
            child: globalWidgets.myText(context, "${fetchDoc?['long_description']}", ColorsX.black.withOpacity(0.8), 10, 20, 5, 0, FontWeight.w700, 16),
          ),
          // GlobalVariables.cartListContainsItem.contains(fetchDoc?['product_name']) ?
          SizedBox(height: 20,),
          documentSnapshot == null ? Container() : addToCartButton(context),
          SizedBox(height: 20,),
          documentSnapshot == null ? Container() : deleteButton(context),
          SizedBox(height: 20,),
          documentSnapshot == null ? Container() :
          // GlobalVariables.cartListContainsItem.contains(fetchDoc?['product_name']) ?
          // Container(
          //   child: globalWidgets.myText(context, "This item is already added to your cart", ColorsX.greenish.withOpacity(0.8), 0, 20, 5, 0, FontWeight.w400, 16),
          // ) : Container(),
          documentSnapshot == null ? Container() :ourLinks(context),
          Container(
            margin: EdgeInsets.only(bottom: SizeConfig.screenHeight * .02),
          ),
        ],
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

  void getProductDetails() async {
    GlobalWidgets.showProgressLoader("Please wait");

    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('products')
        .doc(GlobalVariables.idOfProduct)
        .get();
    if(snapshot.exists){
      fetchDoc = snapshot.data() as Map<String, dynamic>?;
      // imageList = fetchDoc?['images'];
      setState(() {
        documentSnapshot = snapshot;
      });
      GlobalWidgets.hideProgressLoader();
    }
    else{
      GlobalWidgets.hideProgressLoader();
      errorDialog(context);
    }
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


  showImageOfItem(BuildContext context) {

    return Container(
      height: SizeConfig.screenHeight * .40,
      width: SizeConfig.screenWidth * .38,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 3, right: 3, bottom: 3),
        child: ListView.builder(
            itemCount: fetchDoc?['images'].length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index){
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 8 : 2, right: index == fetchDoc?['images']!.length-1 ? 8 : 0),
                child: GestureDetector(
                  onTap: (){
                    debugPrint(fetchDoc?['images']);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    elevation: 5,
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: (){
                        // debugPrint(fetchDoc?['images']);
                        Navigator.of(context).push(MaterialPageRoute(builder:(context)=>LargeImage("${fetchDoc?['images'][index]}")));
                      },
                      child: Container(
                        height: SizeConfig.screenHeight * .40,
                        width: SizeConfig.screenWidth * .38,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: fetchDoc?['images'][index],
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
                ),
              );
            }
        ),
      ),
    );
  }

  savePrice(BuildContext context) {
    String _cutPrice = "${fetchDoc?['cut_price']}";
    String _salePrice = "${fetchDoc?['sale_price']}";
    int salePrice = int.parse(_salePrice);
    int cutPrice = int.parse(_cutPrice);
    int? newValue = cutPrice - salePrice;
    return Container(
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: ColorsX.greenish,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: globalWidgets.myText(context, "Discount for PKR $newValue", ColorsX.white, 0, 5, 5, 0, FontWeight.w700, 15),
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

  // checkIfProductAlreadyAddedInTheCart(){
  //   if(GlobalVariables.cartList.isNotEmpty){
  //     for(int index = 0; index < GlobalVariables.cartList.length; index++){
  //       Map <String, dynamic> myMap = GlobalVariables.cartList[index];
  //       if (myMap["product_name"] == fetchDoc?["product_name"]){
  //         setState(() {
  //           alreadyAdded = true;
  //           GlobalVariables.cartListContainsItem.add(fetchDoc?["product_name"]);
  //         });
  //       }
  //       //value not exists
  //       else{
  //         alreadyAdded = false;
  //       }
  //     }
  //   }else{
  //     setState(() {
  //       alreadyAdded = false;
  //     });
  //   }
  // }
  cartOpen(BuildContext context) {
    Get.toNamed(Routes.CART);
  }
  deleteButton(BuildContext context) {
    // return GlobalVariables.cartListContainsItem.contains(fetchDoc?['product_name']) ? Container() : GestureDetector(
    return GestureDetector(
      onTap: (){
        Map<String,dynamic> cartMap = new Map();
        cartMap["product_name"]= fetchDoc?['product_name'];
        cartMap["image_url"] = fetchDoc?["images"][0];
        cartMap["cut_price"] = int.parse(fetchDoc?["cut_price"]);
        cartMap["sale_price"] = int.parse(fetchDoc?["sale_price"]);
        cartMap["amount_payable"] = int.parse(fetchDoc?["sale_price"]);
        cartMap["quantity"] = 1;
        cartMap["category"] = fetchDoc?['category'];
        setState(() {
          GlobalVariables.cartList.add(cartMap);
        });
        debugPrint(GlobalVariables.cartList.toString());
        _animationController?.stop();
        Get.back();
      },
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: ColorsX.black,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: globalWidgets.myText(context, "Delete Item", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
        ),
      ),
    );
  }
  addToCartButton(BuildContext context) {
    // return GlobalVariables.cartListContainsItem.contains(fetchDoc?['product_name']) ? Container() : GestureDetector(
    return GestureDetector(
      onTap: (){
        Map<String,dynamic> cartMap = new Map();
        cartMap["product_name"]= fetchDoc?['product_name'];
        cartMap["image_url"] = fetchDoc?["images"][0];
        cartMap["cut_price"] = int.parse(fetchDoc?["cut_price"]);
        cartMap["sale_price"] = int.parse(fetchDoc?["sale_price"]);
        cartMap["amount_payable"] = int.parse(fetchDoc?["sale_price"]);
        cartMap["quantity"] = 1;
        cartMap["category"] = fetchDoc?['category'];
        cartMap["short_description"] = fetchDoc?['short_description'];
        cartMap["is_available"] = fetchDoc?['is_available'];
        cartMap["is_featured"] = fetchDoc?['is_featured'];
        cartMap["long_description"] = fetchDoc?['long_description'];
        // setState(() {
        //   GlobalVariables.cartList.add(cartMap);
        // });
        // debugPrint(GlobalVariables.cartList.toString());
        // _animationController?.stop();
        // Get.toNamed(Routes.UPDATE);
        Navigator.of(context).push(MaterialPageRoute(builder:(context)=>UpdateProduct(cartMap)));

        // Get.back();
      },
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: ColorsX.black,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: globalWidgets.myText(context, "Update Item", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
        ),
      ),
    );
  }
}