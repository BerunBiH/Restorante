import 'dart:convert';
import 'package:erestorante_desktop/models/categoryC.dart';
import 'package:erestorante_desktop/models/role.dart';
import 'package:erestorante_desktop/models/search_result.dart';
import 'package:erestorante_desktop/models/user.dart';
import 'package:erestorante_desktop/models/userRole.dart';
import 'package:erestorante_desktop/providers/base_provider.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CategoryProvider extends BaseProvider<CategoryC>{
CategoryProvider(): super("Category");

  @override
  CategoryC fromJson(data) {
    return CategoryC.fromJson(data);
  }
}