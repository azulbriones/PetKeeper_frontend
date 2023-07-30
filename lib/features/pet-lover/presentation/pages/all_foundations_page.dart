import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_image/network_image.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/foundation/foundation_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/foundation_profile_view.dart';

class AllFoundationsPage extends StatefulWidget {
  const AllFoundationsPage({Key? key}) : super(key: key);

  @override
  State<AllFoundationsPage> createState() => _AllFoundationsPageState();
}

class _AllFoundationsPageState extends State<AllFoundationsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    BlocProvider.of<FoundationCubit>(context)
        .getFoundations(foundation: const PetLoverEntity());
    super.initState();
  }

  void _onReturnFromOtherPage() {
    BlocProvider.of<FoundationCubit>(context)
        .getFoundations(foundation: const PetLoverEntity());
  }

  // Función que se ejecutará al realizar la acción de recarga
  Future<void> _onRefresh() async {
    // Simulamos una operación de carga de datos
    await Future.delayed(const Duration(seconds: 1));

    // Una vez finalizada la operación, actualizamos la lista de elementos
    setState(() {
      BlocProvider.of<FoundationCubit>(context)
          .getFoundations(foundation: const PetLoverEntity());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocBuilder<SingleUserCubit, SingleUserState>(
        builder: (context, singleUserState) {
          if (singleUserState is SingleUserLoaded) {
            return _bodyWidget(singleUserState.currentUser);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _bodyWidget(PetLoverEntity currentUser) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: 375 * fem,
            height: 50 * fem,
            color: Colors.indigo[400],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0 * fem),
                child: const Text(
                  'Fundaciones',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<FoundationCubit, FoundationState>(
              builder: (context, state) {
                if (state is FoundationLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FoundationLoaded) {
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: state.foundations.isNotEmpty
                        ? ListView(
                            children: state.foundations.map((foundations) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            FoundationProfileView(
                                                id: foundations.id),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.easeInOut;

                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));

                                          return SlideTransition(
                                            position: animation.drive(tween),
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                    _onReturnFromOtherPage();
                                  },
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 8,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    margin: const EdgeInsets.all(8),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 85,
                                            width: 85,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: NetworkImageWidget(
                                                borderRadiusImageFile: 50,
                                                borderRadiusPlaceHolder: 50.0,
                                                imageFileBoxFit: BoxFit.cover,
                                                placeHolderBoxFit: BoxFit.cover,
                                                networkImageBoxFit:
                                                    BoxFit.cover,
                                                imageUrl:
                                                    foundations.profileUrl,
                                                progressIndicatorBuilder:
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                placeHolder:
                                                    "assets/images/profile_default.png",
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      foundations.name
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      foundations.location
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      foundations.info
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList())
                        : const Center(
                            child: Text('No hay fundaciones en este momento'),
                          ),
                  );
                } else if (state is FoundationError) {
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(state.error,
                                    style: const TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
