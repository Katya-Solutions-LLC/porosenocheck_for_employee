import 'package:flutter/material.dart';

abstract class BaseLanguage {
  static BaseLanguage of(BuildContext context) => Localizations.of<BaseLanguage>(context, BaseLanguage)!;

  String get myUnits;

  String get myTags;

  String get addedByAdmin;

  String get myBrands;

  String get hello;

  String get searchHere;

  String get somethingWentWrong;

  String get reload;

  String get file;

  String get taxIncluded;

  String get bookNow;

  String get gallery;

  String get camera;

  String get cancel;

  String get accept;

  String get wouldYouLikeToSetProfilePhotoAsEmployee;

  String get profileUpdatedSuccessfully;

  String get yourOldPasswordDoesnT;

  String get yourNewPasswordDoesnT;

  String get logout;

  String get pressBackAgainToExitApp;

  String get home;

  String get profile;

  String get settings;

  String get language;

  String get changePassword;

  String get deleteAccount;

  String get delete;

  String get deleteAccountConfirmation;

  String get noBookingsFound;

  String get thereAreCurrentlyNo;

  String get customerInformation;

  String get petName;

  String get reason;

  String get paymentStatus;

  String get bookingFor;

  String get appointmentStatus;

  String get dateAndTime;

  String get duration;

  String get location;

  String get cancelBooking;

  String get doYouCancelThisBooking;

  String get confirm;

  String get about;

  String get yourNewPasswordMust;

  String get password;

  String get eG;

  String get newPassword;

  String get confirmNewPassword;

  String get submit;

  String get editProfile;

  String get firstName;

  String get lastName;

  String get email;

  String get contactNumber;

  String get thisFieldIsRequired;

  String get update;

  String get yourInternetIsNotWorking;

  String get forgetPassword;

  String get toResetYourNew;

  String get stayTunedNoNew;

  String get noNewNotificationsAt;

  String get rateApp;

  String get aboutApp;

  String get welcomeBackToThe;

  String get care;

  String get welcomeToThe;

  String get rememberMe;

  String get forgotPassword;

  String get signIn;

  String get yourPasswordHasBeen;

  String get youCanNowLog;

  String get done;

  String get invalidUrl;

  String get demoUserCannotBeGrantedForThis;

  String get viewAll;

  String get doYouWantToLogout;

  String get noDataFound;

  String get employeeInformation;

  String get employeeName;

  String get appointmentInformation;

  String get appLanguages;

  String get appTheme;

  String get doe;

  String get merry;

  String get customerName;

  String get yes;

  String get tokenExpired;

  String get badRequest;

  String get forbidden;

  String get pageNotFound;

  String get tooManyRequests;

  String get internalServerError;

  String get badGateway;

  String get serviceUnavailable;

  String get gatewayTimeout;

  String get myReviews;

  String get thereAreNoRevivew;

  String get bookingStatus;

  String get call;

  String get bookingsList;

  String get bookings;

  String get notifications;

  String get sorryUserCannotSignin;

  String get chooseLanguage;

  String get dayCareTaker;

  String get veterinarian;

  String get date;

  String get time;

  String get address;

  String get aboutSelf;

  String get passionateAndAttentivePet;

  String get expert;

  String get firstAidKnowledgeForPets;

  String get mainStreet;

  String get gender;

  String get zoomVideoCall;

  String get facebookLink;

  String get instagramLink;

  String get twitterLink;

  String get dribbbleLink;

  String get arrivalDate;

  String get arrivalTime;

  String get leaveDate;

  String get leaveTime;

  String get boarder;

  String get groomer;

  String get walker;

  String get trainer;

  String get daycareTaker;

  String get demoAccounts;

  String get daycare;

  String get taker;

  String get bookingInformation;

  String get service;

  String get confirmCashPayment;

  String get paymentConfirmation;

  String get areYouSureWantConfirmPayment;

  String get areYouSureWant;

  String get ohNoAreYouLeaving;

  String get pet;

  String get totalAmount;

  String get favoriteFood;

  String get favoriteActivity;

  String get paymentDetails;

  String get price;

  String get rejected;

  String get reject;

  String get areYouSureWantToRejectBooking;

  String get loading;

  String get areYouSureWantToConfirm;

  String get guest;

  String get newUpdate;

  String get anUpdateTo;

  String get isAvailableGo;

  String get later;

  String get closeApp;

  String get updateNow;

  String get start;

  String get complete;

  String get ohNoYouAreLeaving;

  String get oldPassword;

  String get personalizeYourProfile;

  String get appLanguage;

  String get theme;

  String get deleteAccounts;

  String get showSomeLoveShare;

  String get privacyPolicy;

  String get termsConditions;

  String get securelyLogOutOfAccount;

  String get thereAreNoReview;

  String get pending;

  String get completed;

  String get confirmed;

  String get cancelled;

  String get inProgress;

  String get paid;

  String get addServices;

  String get serviceName;

  String get serviceDuration;

  String get mins;

  String get defaultPrice;

  String get description;

  String get category;

  String get chooseCategory;

  String get searchForCategory;

  String get categoryListIsEmpty;

  String get thereAreNoCategory;

  String get featureImage;

  String get chooseFile;

  String get save;

  String get clearAll;

  String get areYouSureWantToRemoveNotification;

  String get notificationDeleted;

  String get successfully;

  String get areYouSureWantToClearAllNotification;

  String get nutrition;

  String get consultation;

  String get flea;

  String get and;

  String get tick;

  String get bath;

  String get leashTraining;

  String get min;

  String get healthyDogFeedingGuide;

  String get targetedTreatmentToEliminate;

  String get ticks;

  String get teachingPetsToWalk;

  String get videoConsultancy;

  String get bathingAndShampooing;

  String get categoryType;

  String get serviceFiles;

  String get addFiles;

  String get addParticularServices;

  String get newBooking;

  String get completeBooking;

  String get rejectBooking;

  String get acceptBooking;

  String get forgetEmailPassword;

  String get orderPlaced;

  String get orderPending;

  String get orderProcessing;

  String get orderDelivered;

  String get orderCancelled;

  String get noBookingDetailsFound;

  String get thereAreCurrentlyNoDetails;

  String get bookingId;

  String get tryReloadOrCheckingLater;

  String get doYouWantToRemoveNotification;

  String get doYouWantToClearAllNotification;

  String get doYouWantToConfirmPayment;

  String get doYouWantToConfirmBooking;

  String get doYouWantToRejectBooking;

  String get statusListIsEmpty;

  String get thereAreNoStatus;

  String get filters;

  String get clearFilter;

  String get bookingTime;

  String get apply;

  String get searchBookings;

  String get filterBy;

  String get searchForStatus;

  String get chooseFromMap;

  String get useCurrentLocation;

  String get chooseYourLocation;

  String get setAddress;

  String get lblPickAddress;

  String get locationPermissionDenied;

  String get lbl;

  String get enableLocation;

  String get permissionDeniedPermanently;

  String get pleaseAcceptTermsAnd;

  String get notAMember;

  String get registerNow;

  String get createYourAccount;

  String get createYourAccountFor;

  String get signUp;

  String get alreadyHaveAnAccount;

  String get termsOfService;

  String get notRegistered;

  String get signInWithGoogle;

  String get signInWithApple;

  String get orSignInWith;

  String get signInFailed;

  String get userCancelled;

  String get appleSigninIsNot;

  String get breed;

  String get birthday;

  String get weight;

  String get height;

  String get notesFor;

  String get addNote;

  String get noNewNotes;

  String get thereAreCurrentlyNoNotes;

  String get areYouSureWantDeleteNote;

  String get sNotes;

  String get groomingFor;

  String get title;

  String get noteFor;

  String get writeHere;

  String get serviceImage;

  String get chooseImage;

  String get noteYouCanUpload;

  String get editService;

  String get addService;

  String get noteYouCanUploadOne;

  String get pleaseSelectAServiceImage;

  String get oppsLooksLikeYou;

  String get addNewService;

  String get areYouSureYou;

  String get serviceDeleteSuccessfully;

  String get setAsPrivateNote;

  String get sPets;

  String get currentlyThereAreNo;

  String get myServices;

  String get manageYourServices;

  String get petOwners;

  String get manageNotesForPets;

  String get shop;

  String get brands;

  String get addAndShowTheBrandList;

  String get units;

  String get addAndShowTheShopUnitS;

  String get tags;

  String get addAndShowTheShopTagS;

  String get products;

  String get addAndShowTheProductList;

  String get orders;

  String get addAndShowTheOrderList;

  String get shipping;

  String get logisticList;

  String get addAndShowTheLogisticS;

  String get logisticZoneList;

  String get addAndShowTheLogisticZones;

  String get others;

  String get selectUserType;

  String get iAgreeToThe;

  String get petInformation;

  String get petNotes;

  String get seePetProfile;

  String get doYouWantToAcceptBooking;

  String get doYouWantToStartBooking;

  String get doYouWantToCompleteBooking;

  String get pleaseSelectAnItem;

  String get bookingRequest;

  String get totalBooking;

  String get employeeEarning;

  String get totalRevenue;

  String get noRatingsYet;

  String get upcomingBooking;

  String get noUpcomingBookingsYet;

  String get thereAreCurrentlyNoOrders;

  String get totalOrders;

  String get totalProducts;

  String get totalBrands;

  String get totalUnits;

  String get totalTags;

  String get updateBrand;

  String get addBrand;

  String get brandName;

  String get status;

  String get selectTheBrandImage;

  String get enterTheBrandName;

  String get brandList;

  String get noBrandFound;

  String get thereAreCurrentlyNoBrand;

  String get areYouSureYouDeleteBrand;

  String get aboutProducts;

  String get qty;

  String get off;

  String get deliveryStatus;

  String get payment;

  String get priceDetails;

  String get subTotal;

  String get tax;

  String get deliveryCharge;

  String get total;

  String get shippingDetail;

  String get alternativeContactNumber;

  String get orderDetails;

  String get orderDate;

  String get deliveredOn;

  String get noDetailFound;

  String get noOrdersFound;

  String get pleaseSelectAtleastOne;

  String get selectCategory;

  String get categoryNotFound;

  String get thereAreCurrentlyNoCategory;

  String get selectYourProductCategory;

  String get selectBrand;

  String get chooseBrand;

  String get brandNotFound;

  String get thereAreCurrentlyNoBrandAvailable;

  String get selectYourProductBrand;

  String get selectTag;

  String get selectTagS;

  String get tagSNotFound;

  String get thereAreCurrentlyNoTags;

  String get selectYourProductTagS;

  String get selectUnit;

  String get unitNotFound;

  String get thereAreCurrentlyNoUnit;

  String get selectYourProductUnit;

  String get variationType;

  String get selectYourProductVariation;

  String get chooseVariationType;

  String get variationTypeNotFound;

  String get thereAreCurrentlyNoVariation;

  String get variationValue;

  String get selectVariations;

  String get variationsNotFound;

  String get thereCurrentlyNo;

  String get available;

  String get hasVariation;

  String get addMoreVariation;

  String get saveVariation;

  String get variation;

  String get variations;

  String get enterPrice;

  String get stock;

  String get enterStock;

  String get sku;

  String get enterProductSku;

  String get code;

  String get enterProductCode;

  String get enterYourPrice;

  String get enterYourStock;

  String get enterYourProductSku;

  String get enterYourProductCode;

  String get dateRange;

  String get selectStartDateEndDate;

  String get discountAmount;

  String get thisIsAFeaturedProduct;

  String get editProduct;

  String get addProduct;

  String get basicInformation;

  String get productName;

  String get enterYourProductName;

  String get shortDescription;

  String get productDescription;

  String get pleaseSelectProductImage;

  String get enterShortProductDescription;

  String get enterProductDescription;

  String get delivered;

  String get processing;

  String get failed;

  String get createdByAdmin;

  String get all;

  String get assignedByAdmin;

  String get addedByMe;

  String get areYouSureYouWantToDeleteThisUnit;

  String get thereAreCurrentlyNoUnitsAvailable;

  String get noUnitsFound;

  String get unitsList;

  String get tagList;

  String get enterTheTagName;

  String get enterTheUnitName;

  String get tagName;

  String get unitName;

  String get updateTag;

  String get addTag;

  String get updateUnit;

  String get addUnits;

  String get logisticHasBeenUpdatedSuccessfully;

  String get logisticHasBeenCreatedSuccessfully;

  String get thereAreCurrentlyNoLogisticAvailable;

  String get noLogisticFound;

  String get areYouSureYouWantToDeleteThisBrand;

  String get selectTheLogisticImage;

  String get enterTheLogisticName;

  String get logisticName;

  String get noteYouCanUploadImageWithJpgPngJpegExtensions;

  String get addLogistic;

  String get thereAreCurrentlyNoLogisticzoneAvailable;

  String get thereAreCurrentlyNoLogisticZoneAvailable;

  String get noLogisticZoneFound;

  String get cities;

  String get zoneName;

  String get areYouSureYouWantToDeleteThisLogisticzone;

  String get enterTheStandardDeliveryTime;

  String get standardDeliveryTime;

  String get enterTheStandardDeliveryCharge;

  String get standardDeliveryCharge;

  String get thereAreCurrentlyNoCityAvailable;

  String get cityNotFound;

  String get chooseCity;

  String get selectCity;

  String get city;

  String get thereAreCurrentlyNoStateAvailable;

  String get stateNotFound;

  String get chooseState;

  String get selectState;

  String get state;

  String get thereAreCurrentlyNoCountryAvailable;

  String get countryNotFound;

  String get chooseCountry;

  String get selectCountry;

  String get country;

  String get logisticNotFound;

  String get selectLogistic;

  String get logistic;

  String get enterTheLogisticZoneName;

  String get logisticZoneName;

  String get editLogisticZone;

  String get addLogisticZone;

  String get youCantSetTheStandardDeliveryCharge0;

  String get productDeleteSuccessfully;

  String get areYouSureYouWantToDeleteThisProduct;

  String get addNewProduct;

  String get oppsLooksLikeYouHaveNotAddedAnyProductYet;

  String get ratings;

  String get inclusiveOfAllTaxes;

  String get brand;

  String get readLess;

  String get readMore;

  String get productDetails;

  String get updateLogistic;

  String get chooseLogistic;

  String get priceSkuStock;

  String get productDiscount;

  String get editVariations;

  String get createVariations;

  String get variationName;

  String get productVariations;

  String get addAndShowTheProductVariations;

  String get noVariationsFound;

  String get thereAreCurrentlyNoVariationsAvailable;

  String get theInputtedPriceIsInvalid;

  String get brandAddedSuccessfully;

  String get theInputtedStockIsInvalid;

  String get theInputtedDiscountIsInvalid;

  String get pendingPayout;

  String get enableShop;

  String get pendingOrderPayout;

  String get pendingServicePayout;

  String get addUnit;

  String get pendingBookingPayout;
}
