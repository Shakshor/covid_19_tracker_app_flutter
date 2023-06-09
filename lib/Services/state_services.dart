
import 'dart:convert';

import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:flutter/material.dart';
import 'package:covid_tracker/Model/WorldStatesModel.dart';

// http package
import 'package:http/http.dart' as http;


class StateServices {

 // get world states data
  Future<WorldStatesModel> fetchWorldStatesRecord () async {

    // http response
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));

    // response result
    if(response.statusCode == 200){

      var data = jsonDecode(response.body);
      // print(data);

      return WorldStatesModel.fromJson(data);

    }else{
      throw Exception('Error');
    }


  }


  // get all countries states data
  Future<List<dynamic>> countriesListApi () async {

    var data;
    // http response
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    // response result
    if(response.statusCode == 200){

      data = jsonDecode(response.body);

      // print(data);
      return data;

    }else{
      throw Exception('Error');
    }


  }





}
