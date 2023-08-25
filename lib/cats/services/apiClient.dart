import 'dart:convert';
import 'package:cat/cats/models/breedImage.dart';
import 'package:cat/cats/models/catModel.dart';
import 'package:http/http.dart' as http;

import 'package:cat/cats/models/breeds.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final dio = Dio();
  final String url = "https://api.thecatapi.com/v1";

  Future<List<CatBreed>> fetchCatBreeds() async {
    final response =
        await http.get(Uri.parse('https://api.thecatapi.com/v1/breeds'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => CatBreed.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cat breeds');
    }
  }

  Future<List<CatTopImage>> fetchCatTopImage() async {
    final response = await http
        .get(Uri.parse('https://api.thecatapi.com/v1/images/search?limit=10'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => CatTopImage.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cat breeds');
    }
  }

  List<CatModel> catbreedlists = <CatModel>[];

  Future<List<CatModel>> fetchSingleCat(String id) async {
    final response = await http.get(Uri.parse(
        'https://api.thecatapi.com/v1/images/search?breed_ids=${id}&limit=10'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<CatModel> catbreed =
          jsonData.map((e) => CatModel.fromJson(e)).toList();

      return catbreed;
    } else {
      throw Exception('Failed to load cat breeds');
    }
  }

  // void getBreeds() async {
  //   final response = await http.get(Uri.parse(
  //       'https://api.thecatapi.com/v1/images/${widget.catinfo.referenceImageId.toString()}'));

  //   if (response.statusCode == 200) {
  //     final dynamic jsonData = json.decode(response.body);
  //     CatModel cat = CatModel.fromJson(jsonData);
  //     setState(() {
  //       catImage = cat.image ?? '';
  //     });
  //   } else {
  //     throw Exception('Failed to load cat breeds');
  //   }
  // }
}
