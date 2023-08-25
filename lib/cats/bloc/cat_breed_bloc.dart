import 'package:bloc/bloc.dart';
import 'package:cat/cats/models/breedImage.dart';
import 'package:cat/cats/models/breeds.dart';
import 'package:cat/cats/models/catModel.dart';
import 'package:cat/cats/repositories/breedRepository.dart';
import 'package:equatable/equatable.dart';

part 'cat_breed_event.dart';
part 'cat_breed_state.dart';

class CatBreedBloc extends Bloc<CatBreedEvent, CatBreedState> {
  final breedRepository = BreedRepository();
  CatBreedBloc() : super(const CatBreedState()) {
    on<CatBreedLoadEvent>(
      (event, emit) async {
        try {
          emit(state.copyWith(status: CatStatus.progress));
          final data = await breedRepository.getBreeds();
          final topCat = await breedRepository.getTopImage();
          emit(state.copyWith(
              status: CatStatus.success, breeds: data, cattopimage: topCat));
        } catch (e) {
          emit(state.copyWith(status: CatStatus.failure));
        }
      },
    );

    on<CatSingleBreedLoadEvent>(
      (event, emit) async {
        try {
          emit(state.copyWith(status: CatStatus.progress));
          final data = await breedRepository.fetchSingleCat(event.id);
          emit(state.copyWith(status: CatStatus.success, singleCat: data));
        } catch (e) {
          emit(state.copyWith(status: CatStatus.failure));
        }
      },
    );
  }
}
