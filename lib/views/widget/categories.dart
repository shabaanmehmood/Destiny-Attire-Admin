import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import '../../utils/global_widgets.dart';
import '../../utils/size_config.dart';
class MainPageAllCategories extends StatelessWidget {
  final List<DocumentSnapshot>? documents;
  MainPageAllCategories({this.documents});
  GlobalWidgets globalWidgets = GlobalWidgets();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * .35,
      width: SizeConfig.screenWidth * .45,
      child: ListView.builder(
          itemCount: documents?.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){
                GlobalVariables.categoryChosen = "${documents?[index].get('name')}";
                debugPrint("${documents?[index].get('name')}");
                Get.toNamed(Routes.PRODUCTS_OF_CATEGORY);
              },
              child: Padding(
                padding: EdgeInsets.only(left: index == 0 ? 8 : 2, right: index == documents!.length-1 ? 8 : 0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  elevation: 5,
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: (){
                      GlobalVariables.categoryChosen = "${documents?[index].get('name')}";
                      debugPrint("${documents?[index].get('name')}");
                      Get.toNamed(Routes.PRODUCTS_OF_CATEGORY);
                    },
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        showImageOfItem(documents,index, context),
                        Container(
                          constraints: BoxConstraints(
                              minHeight: 0, minWidth: 11, maxWidth: SizeConfig.screenWidth * .44),
                          // width: SizeConfig.screenWidth * .44,
                          child: globalWidgets.myTextCustom(context, "${documents?[index].get('name')}", ColorsX.black, 0, 10, 5, 0, FontWeight.w600, 15),
                        ),
                        Container(
                          constraints: BoxConstraints(
                              minHeight: 0, minWidth: 11, maxWidth: SizeConfig.screenWidth * .45),
                          child: globalWidgets.myTextCustom(context, "${documents?[index].get('any_text')}", ColorsX.black.withOpacity(0.4), 0, 10, 5, 0, FontWeight.w600, 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );

          }
      ),
    );
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

}
