// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cat_breed_bloc.dart';

enum CatStatus { unknown, progress, success, failure }

class CatBreedState extends Equatable {
  final CatStatus status;
  final List<CatBreed> breeds;
  final List<CatModel> singleCat;
  final List<CatTopImage> cattopimage;

  const CatBreedState({
    this.status = CatStatus.unknown,
    this.breeds = const <CatBreed>[],
    this.singleCat = const <CatModel>[],
    this.cattopimage = const <CatTopImage>[],
  });

  @override
  List<Object> get props => [status, breeds, cattopimage, singleCat];

  CatBreedState copyWith({
    CatStatus? status,
    List<CatBreed>? breeds,
    List<CatModel>? singleCat,
    List<CatTopImage>? cattopimage,
  }) {
    return CatBreedState(
      status: status ?? this.status,
      breeds: breeds ?? this.breeds,
      singleCat: singleCat ?? this.singleCat,
      cattopimage: cattopimage ?? this.cattopimage,
    );
  }
}

// class CatBreedInitial extends CatBreedState {}

// class CatBreedLoading extends CatBreedState {}

// class CatBreedLoaded extends CatBreedState {
//   List<CatBreed> breeds;
//   CatBreedLoaded({
//     required this.breeds,
//   });
// }

// class CatBreedError extends CatBreedState {
//   String errorMessage;
//   CatBreedError({
//     required this.errorMessage,
//   });
// }
