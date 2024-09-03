import 'dart:convert';
import 'package:erestorante_mobile/models/role.dart';
import 'package:erestorante_mobile/models/search_result.dart';
import 'package:erestorante_mobile/models/user.dart';
import 'package:erestorante_mobile/models/userRole.dart';
import 'package:erestorante_mobile/providers/base_provider.dart';
import 'package:erestorante_mobile/utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RoleProvider extends BaseProvider<Role>{
RoleProvider(): super("Role");

  @override
  Role fromJson(data) {
    return Role.fromJson(data);
  }
}