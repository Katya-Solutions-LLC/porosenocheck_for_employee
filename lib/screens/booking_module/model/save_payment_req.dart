import 'dart:convert';

class SavePaymentReq {
  int bookingId;
  int paymentID;
  String externalTransactionId;
  String transactionType;
  num discountPercentage;
  num discountAmount;
  List<TaxPercentage> taxPercentage;
  int paymentStatus;
  num totalAmount;

  SavePaymentReq({
    this.bookingId = -1,
    this.paymentID = -1,
    this.externalTransactionId = "",
    this.transactionType = "",
    this.discountPercentage = -1,
    this.discountAmount = -1,
    this.taxPercentage = const <TaxPercentage>[],
    this.paymentStatus = -1,
    this.totalAmount = -1,
  });

  factory SavePaymentReq.fromJson(Map<String, dynamic> json) {
    return SavePaymentReq(
      bookingId: json['booking_id'] is int ? json['booking_id'] : -1,
      paymentID: json['id'] is int ? json['id'] : -1,
      externalTransactionId: json['external_transaction_id'] is String ? json['external_transaction_id'] : "",
      transactionType: json['transaction_type'] is String ? json['transaction_type'] : "",
      discountPercentage: json['discount_percentage'] is num ? json['discount_percentage'] : -1,
      discountAmount: json['discount_amount'] is num ? json['discount_amount'] : -1,
      taxPercentage: json['tax_percentage'] is List ? List<TaxPercentage>.from(json['tax_percentage'].map((x) => TaxPercentage.fromJson(x))) : [],
      paymentStatus: json['payment_status'] is int ? json['payment_status'] : -1,
      totalAmount: json['total_amount'] is num ? json['total_amount'] : -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": paymentID.isNegative ? "" : paymentID,
      'booking_id': bookingId,
      if (externalTransactionId.trim().isNotEmpty) 'external_transaction_id': externalTransactionId,
      'transaction_type': transactionType,
      if (!discountPercentage.isNegative) 'discount_percentage': discountPercentage,
      if (!discountAmount.isNegative) 'discount_amount': discountAmount,
      if (taxPercentage.isNotEmpty) 'tax_percentage': jsonEncode(taxPercentage.map((e) => e.toJson()).toList()),
      'payment_status': paymentStatus,
      'total_amount': totalAmount,
    };
  }
}

class TaxPercentage {
  int id;
  String name;
  String type;
  num value;

  TaxPercentage({
    this.id = -1,
    this.name = "",
    this.type = "",
    this.value = -1,
  });

  factory TaxPercentage.fromJson(Map<String, dynamic> json) {
    return TaxPercentage(
      id: json['id'] is int ? json['id'] : -1,
      name: json['title'] is String ? json['title'] : "",
      type: json['type'] is String ? json['type'] : "",
      value: json['value'] is num ? json['value'] : -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'type': type,
      'value': value,
    };
  }
}
