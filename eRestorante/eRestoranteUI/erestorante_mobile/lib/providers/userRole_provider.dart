import 'dart:convert';
import 'package:erestorante_mobile/models/search_result.dart';
import 'package:erestorante_mobile/models/user.dart';
import 'package:erestorante_mobile/models/userRole.dart';
import 'package:erestorante_mobile/providers/base_provider.dart';
import 'package:erestorante_mobile/utils/util.dart';
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