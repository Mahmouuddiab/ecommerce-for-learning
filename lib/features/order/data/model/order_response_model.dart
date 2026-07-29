
import 'package:ecommerce/features/order/domain/entity/order_entity.dart';

class OrderResponseModel {
  final String? status;
  final OrderDataModel? data;

  OrderResponseModel({this.status, this.data});

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      status: json['status'],
      data: json['data'] != null ? OrderDataModel.fromJson(json['data']) : null,
    );
  }
}

class OrderDataModel {
  final String? id;
  final num? totalOrderPrice;
  final String? paymentMethodType;
  final bool? isPaid;
  final bool? isDelivered;

  OrderDataModel({
    this.id,
    this.totalOrderPrice,
    this.paymentMethodType,
    this.isPaid,
    this.isDelivered,
  });

  factory OrderDataModel.fromJson(Map<String, dynamic> json) {
    return OrderDataModel(
      id: json['_id'],
      totalOrderPrice: json['totalOrderPrice'],
      paymentMethodType: json['paymentMethodType'],
      isPaid: json['isPaid'],
      isDelivered: json['isDelivered'],
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id ?? '',
      totalOrderPrice: totalOrderPrice ?? 0,
      paymentMethodType: paymentMethodType ?? 'cash',
      isPaid: isPaid ?? false,
      isDelivered: isDelivered ?? false,
    );
  }
}