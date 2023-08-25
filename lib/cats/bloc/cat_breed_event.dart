// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cat_breed_bloc.dart';

abstract class CatBreedEvent extends Equatable {
  const CatBreedEvent();

  @override
  List<Object> get props => [];
}

class CatBreedLoadEvent extends CatBreedEvent {}

class CatSingleBreedLoadEvent extends CatBreedEvent {
  final String id;
  const CatSingleBreedLoadEvent({
    required this.id,
  });
}
