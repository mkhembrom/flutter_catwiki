import 'package:cat/cats/bloc/cat_breed_bloc.dart';
import 'package:cat/cats/views/cat_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatBreedView extends StatelessWidget {
  const CatBreedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: BlocProvider(
          create: (context) => CatBreedBloc()..add(CatBreedLoadEvent()),
          child: CatAutoComplete(),
        ),
      ),
    );
  }
}
