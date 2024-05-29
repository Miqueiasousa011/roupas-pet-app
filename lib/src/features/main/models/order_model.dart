import 'package:flutter/material.dart';

class OrderModel {
  final int id;
  final String paymentMethod;
  final double shippingCost;
  final double total;
  final String status;

  OrderModel({
    required this.id,
    required this.paymentMethod,
    required this.shippingCost,
    required this.total,
    required this.status,
  });

  IconData get getPaymentIcon {
    switch (paymentMethod) {
      case 'PIX':
        return Icons.pix;
      case 'CREDIT_CARD':
        return Icons.credit_card;
      case 'BANK_SLIP':
        return Icons.credit_card;
      default:
        return Icons.credit_card;
    }
  }

  String get getStatus {
    switch (status) {
      case 'PENDING':
        return 'Pendente';
      case 'DELIVERED':
        return 'Entregue';
      case 'CANCELED':
        return 'Rejeitado';
      default:
        return 'Desconhecido';
    }
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      paymentMethod: json['paymentMethod'],
      shippingCost: json['shippingCost'],
      total: json['total'],
      status: json['status'],
    );
  }
}
