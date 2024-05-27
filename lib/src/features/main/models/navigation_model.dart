import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NavigationModel extends Equatable {
  final String title;
  final IconData icon;

  final String path;

  const NavigationModel({
    required this.title,
    required this.icon,
    required this.path,
  });

  @override
  List<Object?> get props => [title, icon, path];

  NavigationModel copyWith({
    String? title,
    IconData? icon,
    String? path,
  }) {
    return NavigationModel(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      path: path ?? this.path,
    );
  }
}
