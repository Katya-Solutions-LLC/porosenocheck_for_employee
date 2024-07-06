import 'package:porosenocheck_employee/screens/shop/orders/model/order_detail_model.dart';

class OrderListModel {
  bool status;
  List<OrderListData> data;
  String message;

  OrderListModel({
    this.status = false,
    this.data = const <OrderListData>[],
    this.message = "",
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<OrderListData>.from(json['data'].map((x) => OrderListData.fromJson(x))) : [],
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}
