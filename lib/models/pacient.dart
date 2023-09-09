import 'package:flutter/material.dart';

class Pacient{
    final String id;
    final String name;
    final int age;
    final String sex;
    final String occupation;
    // final String religiao;
    // final String estado_civil;
    // final String residencia;
    // final String naturalidade;

    const Pacient({
      required this.id,
      required this.name,
      required this.age,
      required this.sex,
      required this.occupation,
    });
}