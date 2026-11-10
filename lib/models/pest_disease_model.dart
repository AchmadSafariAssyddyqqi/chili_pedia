import 'package:flutter/material.dart';

enum CategoryType {
  penyakit,
  hama,
}

class PestDiseaseModel {
  final String id;
  final String name;
  final String alias;
  final CategoryType category;
  final String attackedPart; // Bagian yang Diserang
  final String symptoms; // Ciri-ciri / Gejala
  final String cause; // Penyebab
  final String controlMethod; // Cara Pengendalian
  final IconData icon;
  final Color primaryColor;
  final Color accentColor;
  final String tag;
  final String imageAsset;

  const PestDiseaseModel({
    required this.id,
    required this.name,
    required this.alias,
    required this.category,
    required this.attackedPart,
    required this.symptoms,
    required this.cause,
    required this.controlMethod,
    required this.icon,
    required this.primaryColor,
    required this.accentColor,
    required this.tag,
    required this.imageAsset,
  });

  String get categoryLabel =>
      category == CategoryType.penyakit ? 'Penyakit' : 'Hama';
}

