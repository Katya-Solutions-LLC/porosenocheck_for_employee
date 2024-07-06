import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/screens/shop/shop_product/shop_product_list/services/shop_product_api.dart';
import 'package:porosenocheck_employee/utils/app_common.dart';
import 'package:porosenocheck_employee/utils/constants.dart';
import 'package:stream_transform/stream_transform.dart';

import '../product_detail/model/product_item_data_response.dart';

class ShopProductListController extends RxController {
  Rx<Future<RxList<ProductItemDataResponse>>> getProducts = Future(() => RxList<ProductItemDataResponse>()).obs;
  List<ProductItemDataResponse> productList = RxList();

  RxInt page = 1.obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  RxBool isSearchProductText = false.obs;

  TextEditingController searchProductCont = TextEditingController();

  StreamController<String> searchProductStream = StreamController<String>();
  final _scrollController = ScrollController();

  @override
  void onReady() {
    _scrollController.addListener(() => Get.context != null ? hideKeyboard(Get.context) : null);
    searchProductStream.stream.debounce(const Duration(seconds: 1)).listen((s) {
      getProductList();
    });
    getProductList();
    super.onReady();
  }

  getProductList({bool showLoader = true, String search = ""}) {
    if (showLoader) {
      isLoading(true);
    }
    getProducts(
      ShopProductAPI.getProduct(
        employeeId: loginUserData.value.id,
        list: productList,
        page: page.value,
        perPage: Constants.perPageItem,
        search: searchProductCont.text.trim(),
        lastPageCallBack: (p0) {
          isLastPage(p0);
        },
      ),
    ).then((value) {}).catchError((e) {
      isLoading(false);
      log('shopProductListController Error: $e');
    }).whenComplete(() => isLoading(false));
  }

  @override
  void onClose() {
    searchProductStream.close();
    if (Get.context != null) {
      _scrollController.removeListener(() => hideKeyboard(Get.context));
    }
    super.onClose();
  }
}
