import 'package:flutter/material.dart';

class Restaurant {
  final String name;
  final String category;
  final String deliveryTaxe;
  final String distance;
  final double rate;
  final List<int> time;
  final bool favorite;
  final String photoUrl;

  Restaurant({
    required this.name,
    required this.category,
    required this.deliveryTaxe,
    required this.distance,
    required this.rate,
    required this.time,
    required this.favorite,
    required this.photoUrl,
  });

  Restaurant changeFav({
    bool? favorite,
  }) {
    return Restaurant(
      name: name,
      category: category,
      deliveryTaxe: deliveryTaxe,
      distance: distance,
      rate: rate,
      time: time,
      photoUrl: photoUrl,
      favorite: favorite ?? this.favorite,
    );
  }
}
