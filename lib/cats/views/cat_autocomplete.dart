import 'package:cat/cats/bloc/cat_breed_bloc.dart';
import 'package:cat/cats/components/catbrands.dart';
import 'package:cat/cats/models/breeds.dart';
import 'package:cat/cats/views/cat_detail.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CatAutoComplete extends StatelessWidget {
  // final List<CatBreed> catbreedlist;
  // final List<CatTopImage> cattoplist;
  late String catId = "";
  late int catIdx = 0;
  late String namecat = "";
  CatAutoComplete({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final catBreedBloc = BlocProvider.of<CatBreedBloc>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Catwiki",
              style: GoogleFonts.akayaTelivigala(
                  fontSize: 36, fontWeight: FontWeight.w700),
            ),
            Text(
              "Get to know more about \ncat breed",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: BlocBuilder<CatBreedBloc, CatBreedState>(
                builder: (context, state) {
                  return EasyAutocomplete(
                    decoration: InputDecoration(
                      labelText: "Cat Breeds",
                      labelStyle:
                          GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Select Breeds",
                      fillColor: Colors.white70,
                    ),
                    debounceDuration: const Duration(milliseconds: 500),
                    suggestions: state.breeds.map((e) => e.name).toList(),
                    onChanged: (value) => {},
                    onSubmitted: (value) {
                      catId = getCatIdFromBreeds(state.breeds, value);
                      catIdx = getCatIdxFromBreeds(state.breeds, value);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => BlocProvider.value(
                            value: catBreedBloc
                              ..add(CatBreedLoadEvent())
                              ..add(CatSingleBreedLoadEvent(id: catId)),
                            child:
                                CatDetail(value: value, id: catId, idx: catIdx),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CatBrands(),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Most Search breeds",
                  style: GoogleFonts.poppins(fontSize: 20),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black,
                      ),
                      width: 100,
                      height: 5,
                    ),
                  ),
                ),
                Text(
                  "66+ Breeds \nFor you to discover",
                  style: GoogleFonts.murecho(fontSize: 30),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CatRow(
                      images: [
                        'https://cdn2.thecatapi.com/images/hBXicehMA.jpg',
                        'https://cdn2.thecatapi.com/images/xnsqonbjW.jpg'
                      ],
                      names: [
                        'American Bobtail',
                        'American Curl',
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CatRow(
                      images: [
                        'https://cdn2.thecatapi.com/images/ozEvzdVM-.jpg',
                        'https://cdn2.thecatapi.com/images/kg7nc0poR.jpg'
                      ],
                      names: [
                        'Aegean',
                        'Himalayan',
                      ],
                    ),
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Daily 10 Cat window",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: BlocBuilder<CatBreedBloc, CatBreedState>(
                  builder: (context, state) {
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          showImageViewer(
                              context,
                              Image.network(
                                state.cattopimage[index].image.toString(),
                              ).image,
                              swipeDismissible: true,
                              doubleTapZoomable: true);
                        },
                        child: Container(
                          height: 100,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black45,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  state.cattopimage[index].image.toString()),
                            ),
                          ),
                        ),
                      ),
                      itemCount: state.cattopimage.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 20,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  getIdFromBreeds(List<CatBreed> catbreedlist, String value) {
    for (CatBreed catBreed in catbreedlist) {
      if (catBreed.name == value) {
        return catBreed.id;
      }
    }
  }

  getCatInfo(List<CatBreed> catbreedlist, String value) {
    for (CatBreed catBreed in catbreedlist) {
      if (catBreed.name == value) {
        return catBreed;
      }
    }
  }

  String getCatIdFromBreeds(List<CatBreed> breeds, String value) {
    for (CatBreed catBreed in breeds) {
      if (catBreed.name == value) {
        return catBreed.id;
      }
    }
    return '';
  }

  getCatIdxFromBreeds(List<CatBreed> breeds, String value) {
    for (int i = 0; i < breeds.length; i++) {
      if (breeds[i].name == value) {
        return i;
      }
    }
    return -1; // Return -1 if the object is not found in the list
  }
}

class CatRow extends StatelessWidget {
  final List<String> images;
  final List<String> names;
  const CatRow({
    super.key,
    required this.images,
    required this.names,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CatCard(
          image: images[0],
          name: names[0],
        ),
        const SizedBox(
          width: 25,
        ),
        CatCard(
          image: images[1],
          name: names[1],
        ),
      ],
    );
  }
}

class CatCard extends StatelessWidget {
  late String catId = "";
  late int catIdx = 0;
  late String name;
  late String image;
  CatCard({
    super.key,
    required this.image,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    final catBreedBloc = BlocProvider.of<CatBreedBloc>(context);

    return BlocBuilder<CatBreedBloc, CatBreedState>(
      builder: (context, state) {
        if (state.status == CatStatus.success) {
          return GestureDetector(
            onTap: () {
              catId = getCatIdFromBreeds(state.breeds, name);
              catIdx = getCatIdxFromBreeds(state.breeds, name);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => BlocProvider.value(
                    value: catBreedBloc
                      ..add(CatBreedLoadEvent())
                      ..add(CatSingleBreedLoadEvent(id: catId)),
                    child: CatDetail(value: name, id: catId, idx: catIdx),
                  ),
                ),
              );
            },
            child: SizedBox(
              height: 180,
              width: 160,
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Text(
                    name,
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  String getCatIdFromBreeds(List<CatBreed> breeds, String value) {
    for (CatBreed catBreed in breeds) {
      if (catBreed.name == value) {
        return catBreed.id;
      }
    }
    return '';
  }

  getCatIdxFromBreeds(List<CatBreed> breeds, String value) {
    for (int i = 0; i < breeds.length; i++) {
      if (breeds[i].name == value) {
        return i;
      }
    }
    return -1; // Return -1 if the object is not found in the list
  }
}
