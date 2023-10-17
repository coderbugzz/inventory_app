import 'package:flutter/material.dart';

/// product.dart
/// Defines the Product class, the main entity for this application

@immutable
class Product {
  final String? id;

  final String name;

  final String brandName;

  final String category;

  final int quantity;

  final double price;

  const Product({
    required this.name,
    required this.brandName,
    required this.category,
    required this.quantity,
    required this.price,
    this.id,
  });

  // create an instance of the model
  // from json
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      brandName: json['brandName'],
      category: json['category'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brandName': brandName,
      'category': category,
      'quantity': quantity,
      'price': price,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? brandName,
    String? category,
    int? quantity,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      brandName: brandName ?? this.brandName,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}
