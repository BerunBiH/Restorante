import 'dart:convert';
import 'package:erestorante_desktop/models/search_result.dart';
import 'package:erestorante_desktop/models/user.dart';
import 'package:erestorante_desktop/providers/base_provider.dart';
import 'package:erestorante_desktop/utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UserProvider extends BaseProvider<User>{
  UserProvider(): super("User");

  @override
  User fromJson(data) {
    return User.fromJson(data);
  }
}