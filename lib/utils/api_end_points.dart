class APIEndPoints {
  static const String appConfiguration = 'app-configuration';
  static const String aboutPages = 'page-list';

  //Auth & User
  static const String register = 'register';
  static const String socialLogin = 'social-login';
  static const String login = 'login';
  static const String logout = 'logout';
  static const String changePassword = 'change-password';
  static const String forgotPassword = 'forgot-password';
  static const String userDetail = 'user-detail';
  static const String updateProfile = 'update-profile';
  static const String deleteUserAccount = 'delete-account';

  //Pet
  static const String getPetTypeList = 'pet-types';
  static const String getPetList = 'pet-list';
  static const String getPetOwnerList = 'owner-pet-list';
  static const String deletePet = 'delete-pet';
  static const String addPet = 'pet';
  static const String getNote = 'get-notes';
  static const String addNote = 'save-note';
  static const String deleteNote = 'delete-note';

  //Pet Service
  static const String getFacility = 'facility-list';
  static const String getTraining = 'training-list';
  static const String getDuration = 'duration-list';
  static const String saveBooking = 'save-booking';
  static const String savePayment = 'save-payment';
  static const String getBreed = 'breed-list';
  static const String getService = 'service-list';
  static const String getCategory = 'category-list';
  static const String getEmployeeList = 'employee-list';
  static const String petCenterDetail = 'pet-center-detail';

  //home choose service api
  static const String getEmployeeDashboard = 'employee-dashboard';
  static const String getNotification = 'notification-list';
  static const String getBlogs = 'blog-list';
  static const String getEvents = 'event-list';

  //booking api-list
  static const String getBooking = 'booking-list';
  static const String bookingUpdate = 'booking-update';
  static const String acceptBooking = 'accept-booking';
  static const String bookingStatus = 'booking-status';

  //booking detail-api
  static const String getBookingDetail = 'booking-detail';

  //Review
  static const String saveRating = 'save-rating';
  static const String getRating = 'get-rating';
  static const String deleteRating = 'delete-rating';
  static const String addService = 'service';
  static const String updateService = 'update-service';
  static const String addServiceTraining = 'service-training';
  static const String serviceList = 'service-list';
  static const String deleteService = 'delete-service';

  static const String removeNotification = 'notification-remove';
  static const String clearAllNotification = 'notification-deleteall';

  // Product Category
  static const String getShopCategory = 'get-product-category';

  // Get Variation
  static const String getVariation = 'product-variation';
  static const String deleteVariation = 'delete-variation';
  static const String createCombination = 'create-combination';

  // Country List
  static const String getCountry = 'country-list';

  // State List
  static const String getStates = 'state-list';

  // City List
  static const String getCity = 'city-list';

  // Logistic Zone
  static const String saveLogisticZone = "save-logisticzone";
  static const String updateLogisticZone = "update-logisticzone";
  static const String deleteLogisticZone = "delete-logisticzone";
  static const String getLogisticZone = "get-logisticzone-list";

  // Logistic
  static const String saveLogistic = "save-logistics";
  static const String updateLogistic = "update-logistics";
  static const String deleteLogistic = "delete-logistics";
  static const String getLogistic = "logistics-list";

  // Brands
  static const String getBrand = 'product-brand';
  static const String saveBrand = 'save-brand';
  static const String updateBrand = 'update-brand';
  static const String deleteBrand = 'delete-brand';

  // Product
  static const String saveProduct = 'save-product';
  static const String updateProduct = 'update-product';
  static const String deleteProduct = 'delete-product';
  static const String getProduct = 'get-product-list';
  static const String getProductDetails = 'product_detail';

  //Order
  static const String getOrderDetails = 'get-order-details';
  static const String getOrderList = 'get-order-list';
  static const String getOrderStatusList = 'get-order-status-list';
  static const String updateDeliveryStatus = 'update-delivery-status';
  static const String updatePaymentStatus = 'update-payment-status';

  // Units & Tags
  static const String getUnit = 'product-unit';
  static const String saveUnit = "save-unit";
  static const String updateUnit = "update-unit";
  static const String deleteUnit = "delete-unit";
  static const String getTag = 'product-tag';
  static const String saveTags = "save-tag";
  static const String updateTags = "update-tag";
  static const String deleteTags = "delete-tag";
}
