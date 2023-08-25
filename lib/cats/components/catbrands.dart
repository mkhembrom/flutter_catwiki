import 'dart:async';
import 'dart:convert';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:cat/cats/models/catModel.dart';
import 'package:flutter/material.dart';

class CatBrands extends StatefulWidget {
  const CatBrands({super.key});

  @override
  State<CatBrands> createState() => _CatBrandsState();
}

class _CatBrandsState extends State<CatBrands> {
  String catImage = "";
  void getBreeds() async {
    final response = await http
        .get(Uri.parse('https://api.thecatapi.com/v1/images/search/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<CatModel> cat =
          jsonData.map((e) => CatModel.fromJson(e)).toList();
      // CatModel cat = CatModel.fromJson(jsonData);
      setState(() {
        catImage = cat[0].image ?? '';
      });
    } else {
      throw Exception('Failed to load cat breeds');
    }
  }

  @override
  void initState() {
    getBreeds();
    startDelayedFunction();
    super.initState();
  }

  void startDelayedFunction() {
    Timer(Duration(seconds: 20), () {
      getBreeds();
      startDelayedFunction(); // Recursively call the function after the delay
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: () {
          showImageViewer(
              context,
              Image.network(
                catImage,
              ).image,
              swipeDismissible: true,
              doubleTapZoomable: true);
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(catImage, scale: 1.0),
                    fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: Text(
                    "Random Cats",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
