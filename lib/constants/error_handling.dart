import 'dart:convert';

import 'package:amazon_clone/constants/utilis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSucess,
}) {
  switch (response.statusCode) {
    case 200:
      onSucess();
      break;
    case 400:
      showSnackBarMessage(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBarError(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBarMessage(context, response.body);
  }
  ;
}
