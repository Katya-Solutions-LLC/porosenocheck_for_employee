import 'dart:convert';
import 'dart:io';

import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/main.dart';
import 'package:porosenocheckemployee/utils/app_common.dart';
import 'package:porosenocheckemployee/utils/colors.dart';

import '../../../../utils/common_base.dart';
import '../../../../utils/constants.dart';
import '../../brand/model/brand_list_response.dart';
import '../../brand/services/brand_api.dart';
import '../../units_tags/model/unit_tag_list_response.dart';
import '../../units_tags/services/unit_tag_api.dart';
import '../../variation/model/variation_list_response.dart';
import '../../variation/services/variation_api.dart';
import '../model/product_discount_data_response.dart';
import '../model/product_list_response.dart';
import '../model/shop_category_model.dart';
import '../model/variation_combination_model.dart';
import '../product_detail/model/product_item_data_response.dart';
import '../shop_product_list/services/shop_product_api.dart';

class AddShopProductController extends RxController {
  RxList<ShopCategory> shopCategoryList = RxList();
  RxList<BrandData> brandsList = RxList();
  RxList<UnitTagData> tagsList = RxList();
  RxList<UnitTagData> unitsList = RxList();
  RxList<VariationData> variationList = RxList();
  List<String> selectedTagName = [];
  RxList<String> selectedCategoryName = RxList();
  RxList<VariationData> addVariationsList = RxList();
  RxList<ProductVariationData> addProductVariationDataList = RxList();
  RxList<VariationCombinationData> variationCombinationList = RxList();

  XFile? pickedFile;
  Rx<File> imageFile = File("").obs;

  RxString errorMessage = "".obs;
  RxString productImage = "".obs;

  RxBool isLoading = false.obs;
  RxBool isHasVariation = false.obs;
  RxBool isFeature = false.obs;
  RxBool isLastPage = false.obs;
  RxBool isStatus = true.obs;
  RxBool hasError = false.obs;
  RxBool isEdit = false.obs;
  RxBool isVariationType = false.obs;
  RxBool isVariationValue = false.obs;
  RxBool isSelectedDateRange = false.obs;

  RxBool isFirstTime = true.obs;
  RxBool isDiscountAmount = false.obs;

  RxInt categoryPage = 1.obs;
  RxInt brandPage = 1.obs;
  RxInt tagPage = 1.obs;
  RxInt unitPage = 1.obs;
  RxInt variationPage = 1.obs;
  // RxInt variationCount = 0.obs;

  DateTime? startDate = DateTime.now();
  DateTime? endDate;

  RxList<ShopCategory> selectedCategory = RxList();
  Rx<BrandData> selectedBrand = BrandData(id: -1).obs;
  Rx<UnitTagData> selectedUnit = UnitTagData(id: -1).obs;
  Rx<ProductDiscountData> selectedDiscountType = productDiscountTypes.first.obs;
  RxList<UnitTagData> selectedTag = RxList();

  Rx<VariationData> selectedVariationType = VariationData().obs;

  Rx<ProductItemDataResponse> productItemData = ProductItemDataResponse(id: (-1).obs, inWishlist: false.obs).obs;

  TextEditingController productNameCont = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();

  TextEditingController shortDescriptionCont = TextEditingController();
  TextEditingController categoryCont = TextEditingController();
  TextEditingController brandCont = TextEditingController();
  TextEditingController tagsCont = TextEditingController();
  TextEditingController unitCont = TextEditingController();
  TextEditingController dateRangeCont = TextEditingController();
  TextEditingController discountAmountCont = TextEditingController();

  // If product isn't any variation
  TextEditingController priceCont = TextEditingController();
  TextEditingController stockCont = TextEditingController();
  TextEditingController skuCont = TextEditingController();
  TextEditingController codeCont = TextEditingController();

  @override
  void onInit() {
    getCategoryList();
    getBrandList();
    getUnitTagList();
    getUnitTagList(isFromTag: true);
    getVariationList();

    if (Get.arguments is ProductItemDataResponse) {
      productItemData(Get.arguments as ProductItemDataResponse);
      isEdit(true);
      productNameCont.text = productItemData.value.name;
      descriptionCont.text = productItemData.value.description;
      shortDescriptionCont.text = productItemData.value.shortDescription;
      isHasVariation = productItemData.value.hasVariation == 1 ? true.obs : false.obs;
      priceCont.text = productItemData.value.variationData.first.taxIncludeProductPrice.toString();
      stockCont.text = productItemData.value.stockQty.toString();
      skuCont.text = productItemData.value.variationData.first.sku;
      codeCont.text = productItemData.value.variationData.first.code;
      discountAmountCont.text = productItemData.value.discountValue.toString();
      isFeature = productItemData.value.isFeatured == 1 ? true.obs : false.obs;
      isStatus = productItemData.value.status == 1 ? true.obs : false.obs;
      productImage(productItemData.value.productImage);
      dateRangeCont.text = productItemData.value.dateRange;
      productDiscountTypes.forEach((e1) {
        if (e1.productDiscountType == productItemData.value.discountType) {
          selectedDiscountType(e1);
        }
      });
    }

    super.onInit();
  }

  //region get category
  getCategoryList({bool showLoader = true, String search = ""}) {
    if (showLoader) {
      isLoading(true);
    }

    ShopProductAPI.getShopCategory(
      page: categoryPage.value,
      perPage: Constants.perPageItem,
      list: shopCategoryList,
      search: search.trim(),
      lastPageCallBack: (p) {
        isLastPage(p);
      },
    ).then((value) {
      selectedCategory.clear();

      if (isEdit.value) {
        shopCategoryList.forEach((e1) {
          productItemData.value.category.forEach((e2) {
            if (e1.id == e2.id) {
              e1.isSelected = true;
              selectedCategory.add(e1);
            }
          });
        });

        selectedCategoryName.clear();
        selectedCategory.forEach((element) {
          selectedCategoryName.add(element.name);
        });

        categoryCont.text = selectedCategoryName.join(',');
      }
    }).onError((error, stackTrace) {
      hasError(true);
      errorMessage(error.toString());
    }).whenComplete(() => isLoading(false));
  }

  //endregion

  //region Get Variation Type
  getVariationList({bool showLoader = true}) async {
    if (showLoader) {
      isLoading(true);
    }

    VariationAPI.getVariations(
      filterByServiceStatus: ServiceFilterStatusConst.all,
      employeeId: loginUserData.value.id,
      page: variationPage.value,
      list: variationList,
      lastPageCallBack: (p) {
        isLastPage(p);
      },
    ).then((value) {
      isLoading(true);
      if (isEdit.value) {
        variationList.forEach((e1) {
          // Find the combination for the current variation type
          List<Combination> combinationForVariationType = [];
          productItemData.value.variationData.forEach((e2) {
            e2.combination.forEach((combination) {
              if (combination.productVariationType == e1.name) {
                combinationForVariationType.add(combination);
              }
            });
          });

          if (combinationForVariationType.isNotEmpty) {
            // Store variation values in a set to remove duplicates
            Set<String> variationValuesSet = {};
            combinationForVariationType.forEach((combination) {
              variationValuesSet.add(combination.productVariationName);
            });

            // Concatenate unique variation values into a single string for the current variation type
            String variationValues = variationValuesSet.join(', ');

            // Create a new VariationData object for the current variation type
            VariationData variationData = VariationData(
              index: addVariationsList.length,
              addVariationCount: addVariationsList.length + 1,
              variationTypeCont: TextEditingController(text: e1.name),
              variationTypeFocus: FocusNode(),
              variationValueCont: TextEditingController(text: variationValues),
              variationValueFocus: FocusNode(),
            );

            // Add the variation type to addVariationsList
            addVariationsList.add(variationData);

            // Check if the variation value names are not empty
            if (variationValues.isNotEmpty) {
              isVariationValue(true);
            } else {
              isVariationValue(false);
            }

            // Check if the variation type is not empty
            if (variationData.variationTypeCont!.text.isNotEmpty) {
              isVariationType(true);
            } else {
              isVariationType(false);
            }

            // If the variation is selected, set isSelected to true and update variationValue
            combinationForVariationType.forEach((combination) {
              e1.productVariationData.forEach((e) {
                if (e.name == combination.productVariationName) {
                  e.isSelected(true);
                  variationData.variation = e.variationId;
                  variationData.variationValue = e1.productVariationData.where((element) => element.isSelected.value).map((e) => e.id).toList();
                }
              });
            });
          }
        });

        if (isHasVariation.value) {
          if (isVariationType.value && isVariationValue.value) {
            createCombinationList();
          } else {
            toast(locale.value.pleaseSelectAtleastOne);
          }
        }
      }
    }).onError((error, stackTrace) {
      hasError(true);
      errorMessage(error.toString());
    }).whenComplete(() => isLoading(false));
  }

  Future<void> createCombinationList() async {
    isLoading(true);

    Map<String, dynamic> req = {"variations": addVariationsList.map((e) => e.toJsonRequest()).toList()};

    log('Variation Req: $req');

    await VariationAPI.getVariationCombination(request: req).then((value) {
      isLoading(false);
      variationCombinationList(value.data);

      if (productItemData.value.variationData.length == value.data.length) {
        if (isEdit.value) {
          productItemData.value.variationData.forEachIndexed((e2, index) {
            variationCombinationList.forEach((element) {
              if (element.sku == e2.sku) {
                variationCombinationList[index].variationsCont.text = e2.sku;
                variationCombinationList[index].priceCont.text = e2.taxIncludeProductPrice.toString();
                variationCombinationList[index].stockCont.text = e2.productStockQty.toString();
                variationCombinationList[index].skuCont.text = e2.sku;
                variationCombinationList[index].codeCont.text = e2.code;
              }
            });
          });
        }
      } else {
        variationCombinationList.forEach((element) {
          element.variationsCont.text = element.variation;
          // Check if the combination exists in the productItemData.variationData

          final foundIndex = productItemData.value.variationData.indexWhere((e) => e.sku == element.sku);
          if (foundIndex != -1) {
            // Combination exists, set price and stock from productItemData
            element.priceCont.text = productItemData.value.variationData[foundIndex].taxIncludeProductPrice.toString();
            element.stockCont.text = productItemData.value.variationData[foundIndex].productStockQty.toString();
          } else {
            // Combination does not exist, set price and stock to zero
            element.priceCont.text = element.price.toString();
            element.stockCont.text = element.stock.toString();
          }
          element.skuCont.text = element.sku;
          element.codeCont.text = element.code;
        });
      }
    }).catchError((error) {
      isLoading(false);
      toast(error.toString(), print: true);
    });
  }

  //endregion

  //region get Brand
  getBrandList({bool showLoader = true}) {
    if (showLoader) {
      isLoading(true);
    }

    BrandAPI.getBrand(
      employeeId: loginUserData.value.id,
      status: 1,
      page: brandPage.value,
      brand: brandsList,
      lastPageCallBack: (p) {
        isLastPage(p);
      },
    ).then((value) {
      isLoading(false);
      brandsList(value);
      if (isEdit.value) {
        selectedBrand(brandsList.firstWhere((p0) => p0.name == productItemData.value.brandName, orElse: () => BrandData()));
        brandCont.text = selectedBrand.value.name;
      }
    }).onError((error, stackTrace) {
      hasError(true);
      errorMessage(error.toString());
      isLoading(false);
    });
  }

  //endregion

  //region get Unit
  getUnitTagList({bool showLoader = true, bool isFromTag = false}) {
    if (showLoader) {
      isLoading(true);
    }

    if (isFromTag) {
      UnitTagsAPI.getTags(
        filterByServiceStatus: ServiceFilterStatusConst.all,
        employeeId: loginUserData.value.id,
        list: tagsList,
        page: tagPage.value,
        lastPageCallBack: (p) {
          isLastPage(p);
        },
      ).then((value) {
        selectedTag.clear();

        if (isEdit.value) {
          tagsList.forEach((e1) {
            productItemData.value.productTags.forEach((e2) {
              if (e1.name == e2) {
                e1.isSelected = true;
                selectedTag.add(e1);
              }
            });
          });

          selectedTagName.clear();
          selectedTag.forEach((element) {
            selectedTagName.add(element.name);
          });

          tagsCont.text = selectedTagName.join(',');
        }
      }).onError((error, stackTrace) {
        hasError(true);
        errorMessage(error.toString());
      }).whenComplete(() => isLoading(false));
    } else {
      UnitTagsAPI.getUnits(
        filterByServiceStatus: ServiceFilterStatusConst.all,
        employeeId: loginUserData.value.id,
        list: unitsList,
        page: unitPage.value,
        lastPageCallBack: (p) {
          isLastPage(p);
        },
      ).then((value) {
        unitsList(value);
        if (isEdit.value) {
          selectedUnit(unitsList.firstWhere((p0) => p0.name == productItemData.value.unitName, orElse: () => UnitTagData()));
          unitCont.text = selectedUnit.value.name;
        }
      }).onError((error, stackTrace) {
        hasError(true);
        errorMessage(error.toString());
      }).whenComplete(() => isLoading(false));
    }
  }

  //endregion

  //region Select Start Date & end Date.

  void selectDate(BuildContext context) {
    showCustomDateRangePicker(
      context,
      dismissible: true,
      minimumDate: DateTime.now(),
      maximumDate: DateTime.now().add(const Duration(days: 30)),
      endDate: endDate,
      startDate: startDate,
      backgroundColor: context.cardColor,
      primaryColor: primaryColor,
      onApplyClick: (start, end) {
        startDate = start;
        endDate = end;

        dateRangeCont.text = '${formatDate(startDate.toString(), format: DateFormatConst.yyyy_MM_dd)} to ${formatDate(endDate.toString(), format: DateFormatConst.yyyy_MM_dd)}';
        isSelectedDateRange(true);
      },
      onCancelClick: () {
        //
      },
    );
  }

  //endregion

  //region Select Images for product
  Future<void> _handleGalleryClick() async {
    Get.back();
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      productImage('');
      imageFile(File(pickedFile!.path));
    }
  }

  Future<void> _handleCameraClick() async {
    Get.back();
    pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      productImage('');
      imageFile(File(pickedFile!.path));
    }
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: context.cardColor,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SettingItemWidget(
              title: locale.value.gallery,
              leading: const Icon(Icons.image, color: primaryColor),
              onTap: () async {
                _handleGalleryClick();
              },
            ),
            SettingItemWidget(
              title: locale.value.camera,
              leading: const Icon(Icons.camera, color: primaryColor),
              onTap: () {
                _handleCameraClick();
              },
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ],
        ).paddingAll(16.0);
      },
    );
  }

//endregion

  //region Save Product
  void saveProduct() {
    String id = '';
    isLoading(true);
    hideKeyBoardWithoutContext();

    List<String> selectedTagNames = [];
    List<int> selectedCategoryIds = [];

    if (isEdit.value) {
      id = productItemData.value.id.value.toString();
    }

    selectedTag.forEach((element) {
      selectedTagNames.add('"${element.name}"');
    });

    selectedCategory.forEach((element) {
      selectedCategoryIds.add(element.id);
    });

    Map<String, dynamic> req = {
      "name": productNameCont.text.validate(),
      "category_ids": selectedCategoryIds,
      "brand_id": selectedBrand.value.id,
      "unit_id": selectedUnit.value.id,
      "tags": selectedTagNames,
      "discount_value": discountAmountCont.text.validate(),
      "discount_type": selectedDiscountType.value.productDiscountType.validate(),
      "status": isStatus.value ? "1" : "0",
      "is_featured": isFeature.value ? "1" : "0",
      "has_variation": isHasVariation.value ? "1" : "0",
      "description": descriptionCont.text.validate(),
      "short_description": shortDescriptionCont.text.validate(),
      "date_range": dateRangeCont.text,
    };

    if (!isHasVariation.value) {
      req.putIfAbsent("price", () => priceCont.text.validate());
      req.putIfAbsent("stock", () => stockCont.text.validate());
      req.putIfAbsent("sku", () => skuCont.text.validate());
      req.putIfAbsent("code", () => codeCont.text.validate());
    } else {
      req.putIfAbsent('variations', () => jsonEncode(addVariationsList.map((e) => e.toJsonRequest()).toList()));
      req.putIfAbsent('combinations', () => jsonEncode(variationCombinationList.map((e) => e.toCombinationRequest()).toList()));
    }

    isLoading(true);
    ShopProductAPI.addProductMultipart(
      isEdit: isEdit.value,
      productId: id,
      request: req,
      imageFile: imageFile.value.path.isNotEmpty ? imageFile.value : null,
    ).then((value) {
      Get.back(result: true);
      isLoading(false);
    }).catchError((e) {
      isLoading(false);
      toast(e.toString());
    });
  }

//endregion
}
