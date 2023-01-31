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

class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories>  with SingleTickerProviderStateMixin{

  GlobalWidgets globalWidgets = GlobalWidgets();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CacheData cacheData = CacheData();
  List<DocumentSnapshot> allCategories = [];
  AnimationController? _animationController;
  Animation? animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCategories();
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

  cartOpen(BuildContext context) {
    Get.toNamed(Routes.CART);
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
                allCategories.isEmpty ? Container() :
                showGridView(context),
                allCategories.isEmpty ? Container() :ourLinks(context),
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
  void loadCategories() async {

    GlobalWidgets.showProgressLoader("Please wait");

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .get();
    final List<DocumentSnapshot> firestoreResponseList = querySnapshot.docs;

    if (firestoreResponseList.isEmpty) {
      debugPrint('no featured and not available');
    }
    else {
      setState(() {
        allCategories = querySnapshot.docs;
        // GlobalVariables.featuredModelLength = documentsByCastes.length ?? 0;
        // GlobalVariables.featuredModelLength = featuredModel?.serverResponse.length ?? 0;
        print('categories length' + allCategories.length.toString());
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
      child: Container(
        height: SizeConfig.screenHeight * .25,
        width: SizeConfig.screenWidth * .37,
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: documents?[index].get('cat_image'),
          placeholder: (context,url) => Container(
            child: Image.asset('assets/images/logo.png', height: 100, width: 100,),
          ),
          // progressIndicatorBuilder: (context, url, downloadProgress) =>
          //     CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
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
          itemCount: allCategories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            // crossAxisSpacing: SizeConfig.marginVerticalXsmall,
            // mainAxisSpacing: SizeConfig.marginVerticalXsmall,
            crossAxisCount: 2,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (contxt, index) {
            return  buildItem(index, context);
          },
        ),
      ),
    );
    // return Container(
    //   height: SizeConfig.screenHeight,
    //   width: SizeConfig.screenWidth,
    //   child: GridView.custom(
    //     shrinkWrap: true,
    //     physics: ScrollPhysics(),
    //     gridDelegate: SliverWovenGridDelegate.count(
    //       crossAxisCount: 2,
    //       mainAxisSpacing: 2,
    //       crossAxisSpacing: 2,
    //       pattern: [
    //         WovenGridTile(0.6),
    //         WovenGridTile(
    //           5 / 9,
    //           crossAxisRatio: 0.9,
    //           alignment: AlignmentDirectional.centerEnd,
    //         ),
    //       ],
    //     ),
    //     childrenDelegate: SliverChildBuilderDelegate(
    //           (context, index) {
    //             return ClipRRect(
    //               borderRadius: BorderRadius.circular(8),
    //               child: buildItem(index, context)
    //             );
    //           },
    //       childCount: allCategories.length,
    //     ),
    //   ),
    // );
  }

  buildItem(int index, BuildContext context) {
    return Container(

        height: SizeConfig.screenHeight * .20,
        width: SizeConfig.screenWidth * .38,
        child: GestureDetector(
          onTap: (){
            GlobalVariables.categoryChosen = "${allCategories?[index].get('name')}";
            debugPrint("${allCategories?[index].get('name')}");
            Get.toNamed(Routes.PRODUCTS_OF_CATEGORY);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 8 , right: 8 ),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              elevation: 5,
              color: Colors.white,
              child: GestureDetector(
                onTap: (){
                  GlobalVariables.categoryChosen = "${allCategories?[index].get('name')}";
                  debugPrint("${allCategories?[index].get('name')}");
                  Get.toNamed(Routes.PRODUCTS_OF_CATEGORY);
                },
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showImageOfItem(allCategories,index, context),
                    Container(
                      constraints: BoxConstraints(
                          minHeight: 0, minWidth: 11, maxWidth: SizeConfig.screenWidth * .44),
                      // width: SizeConfig.screenWidth * .44,
                      child: globalWidgets.myTextCustom(context, "${allCategories?[index].get('name')}", ColorsX.black, 0, 10, 5, 0, FontWeight.w600, 15),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          minHeight: 0, minWidth: 11, maxWidth: SizeConfig.screenWidth * .45),
                      child: globalWidgets.myTextCustom(context, "${allCategories?[index].get('any_text')}", ColorsX.black.withOpacity(0.4), 0, 10, 5, 0, FontWeight.w600, 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
