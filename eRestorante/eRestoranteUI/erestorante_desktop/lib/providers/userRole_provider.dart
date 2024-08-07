import 'dart:convert';
import 'package:erestorante_desktop/models/search_result.dart';
import 'package:erestorante_desktop/models/user.dart';
import 'package:erestorante_desktop/models/userRole.dart';
import 'package:erestorante_desktop/providers/base_provider.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UserRoleProvider extends BaseProvider<UserRole>{
  UserRoleProvider(): super("UserRole");

  @override
  UserRole fromJson(data) {
    return UserRole.fromJson(data);
  }
}