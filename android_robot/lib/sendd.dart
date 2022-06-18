import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class send{
  static final _client = http.Client();

  static sendReview(url) async {
    http.Response response = await _client.post(url);
    print(response);

  }
}
