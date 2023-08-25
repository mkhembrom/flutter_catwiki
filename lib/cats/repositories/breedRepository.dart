// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cat/cats/models/breedImage.dart';
import 'package:cat/cats/models/breeds.dart';
import 'package:cat/cats/models/catModel.dart';
import 'package:cat/cats/services/apiClient.dart';

class BreedRepository {
  final ApiClient apiClient = ApiClient();

  Future<List<CatBreed>> getBreeds() async {
    List<CatBreed> response = await apiClient.fetchCatBreeds();
    return response;
  }

  Future<List<CatTopImage>> getTopImage() async {
    List<CatTopImage> response = await apiClient.fetchCatTopImage();
    return response;
  }

  Future<List<CatModel>> fetchSingleCat(String id) async {
    List<CatModel> response = await apiClient.fetchSingleCat(id);
    return response;
  }
}
