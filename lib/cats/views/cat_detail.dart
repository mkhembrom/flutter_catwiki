import 'package:easy_image_viewer/easy_image_viewer.dart';

import 'package:cat/cats/bloc/cat_breed_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CatDetail extends StatefulWidget {
  final String value;
  final String id;
  final int idx;
  const CatDetail({
    super.key,
    required this.value,
    required this.id,
    required this.idx,
  });

  @override
  State<CatDetail> createState() => _CatDetailState();
}

class _CatDetailState extends State<CatDetail> {
  final ScrollController _scrollController = ScrollController();
  bool isExpanded = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        isExpanded = _scrollController.offset < 60;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      body: BlocBuilder<CatBreedBloc, CatBreedState>(
        builder: (context, state) {
          return BlocBuilder<CatBreedBloc, CatBreedState>(
            builder: (context, state) {
              if (state.status == CatStatus.success) {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    SliverAppBar(
                      expandedHeight: 350.0,
                      floating: true,
                      pinned: true,
                      leading: Container(
                        margin: const EdgeInsets.all(5),
                        width: 50,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      backgroundColor: Colors.red[100],
                      flexibleSpace: FlexibleSpaceBar(
                        title: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              widget.value,
                              style: GoogleFonts.poppins(
                                color: Colors.red[200],
                              ),
                            ),
                          ),
                        ),
                        background: state.singleCat.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            : Image.network(
                                state.singleCat[0].image.toString(),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                child: Text(
                                  state.breeds[widget.idx].origin,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.notoSansOlChiki(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              state.breeds[widget.idx].description,
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<CatBreedBloc, CatBreedState>(
                      builder: (context, state) {
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns
                              mainAxisSpacing: 10.0, // Spacing between rows
                              crossAxisSpacing: 10.0, // Spacing between columns
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                if (state.status == CatStatus.success) {
                                  return Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        showImageViewer(
                                            context,
                                            Image.network(
                                              state.singleCat[index].image
                                                  .toString(),
                                            ).image,
                                            swipeDismissible: true,
                                            doubleTapZoomable: true);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          // catbreedlists[index].image ?? '',
                                          state.singleCat[index].image
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return null;
                              },
                              childCount: 5, // Number of items
                            ),
                          ),
                        );
                      },
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 50,
                      ),
                    )
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
