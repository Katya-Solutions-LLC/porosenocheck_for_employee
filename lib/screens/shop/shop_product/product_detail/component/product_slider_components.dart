import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/cached_image_widget.dart';
import 'package:porosenocheck_employee/screens/shop/shop_product/product_detail/product_detail_controller.dart';

class ProductSlider extends StatelessWidget {
  final List<String> productGalleryData;

  ProductSlider({super.key, required this.productGalleryData});

  final ProductDetailController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Stack(
        children: [
          PageView.builder(
            controller: productController.pageController,
            reverse: false,
            itemCount: productGalleryData.length,
            itemBuilder: (_, i) {
              return CachedImageWidget(url: productGalleryData[i].toString(), height: 330, width: Get.width, fit: BoxFit.cover).onTap(() {
                //
              });
            },
          ),
          Positioned(
            bottom: 8,
            right: 0,
            left: 0,
            child: DotIndicator(
              pageController: productController.pageController,
              pages: productGalleryData,
              indicatorColor: grey,
              unselectedIndicatorColor: lightGray,
              currentBoxShape: BoxShape.rectangle,
              boxShape: BoxShape.rectangle,
              currentBorderRadius: radius(8),
              borderRadius: radius(8),
              currentDotSize: 26,
              currentDotWidth: 6,
              dotSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
