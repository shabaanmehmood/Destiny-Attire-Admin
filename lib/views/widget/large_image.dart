import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/size_config.dart';

class LargeImage extends StatelessWidget {
  final String image_url;
  LargeImage(this.image_url);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: image_url,
        placeholder: (context,url) => Container(
          child: Image.asset('assets/images/logo.png', height: 100, width: 100,),
        ),
        // progressIndicatorBuilder: (context, url, downloadProgress) =>
        //     CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
