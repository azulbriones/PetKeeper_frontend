import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_image/network_image.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/stray_pet/presentation/bloc/stray_pet_bloc.dart';
import 'package:pet_keeper_front/features/stray_pet/presentation/pages/stray_post.dart';
import 'package:pet_keeper_front/features/stray_pet/presentation/pages/stray_post_view.dart';

class StrayPets extends StatefulWidget {
  const StrayPets({super.key});

  @override
  State<StrayPets> createState() => _StrayPetsState();
}

class _StrayPetsState extends State<StrayPets>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String? selectedCountry;
  String? selectedCity;

  List<String> countries = [
    'Chiapas',
    'Todos',
  ];

  List<String> cities = [
    'Tuxtla Gutiérrez',
  ];

  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    context.read<StrayPetBloc>().add(GetAllStrayPets());
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        context.read<StrayPetBloc>().add(GetAllStrayPets());
        ScaffoldMessenger.of(context).clearSnackBars();
      } else {
        const snackBar = SnackBar(
          content: Text(
            'No hay internet',
            style: TextStyle(),
          ),
          duration: Duration(days: 365),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  // Función que se ejecutará al realizar la acción de recarga
  Future<void> _onRefresh() async {
    // Simulamos una operación de carga de datos
    await Future.delayed(Duration(seconds: 1));

    // Una vez finalizada la operación, actualizamos la lista de elementos
    setState(() {
      context.read<StrayPetBloc>().add(GetAllStrayPets());
    });
  }

  void _onReturnFromOtherPage() {
    context.read<StrayPetBloc>().add(GetAllStrayPets());
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
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0 * fem),
                child: const Text(
                  'Mascotas extraviadas',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            width: 375 * fem,
            height: 40 * fem,
            color: Colors.grey.shade400,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0 * fem),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      value: selectedCountry,
                      dropdownColor: Colors.grey.shade400,
                      iconEnabledColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCountry = newValue;
                        });
                      },
                      items: countries
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      hint: const Text(
                        'Seleccione un estado',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    selectedCountry != null && selectedCountry != 'Todos'
                        ? DropdownButton<String>(
                            value: selectedCity,
                            dropdownColor: Colors.grey.shade400,
                            iconEnabledColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCity = newValue;
                              });
                            },
                            items: cities
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                            hint: const Text(
                              'Seleccione un municipio',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                BlocBuilder<StrayPetBloc, StrayPetState>(
                    builder: (context, state) {
                  if (state is LoadingAllStrayPets) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedAllStrayPets) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView(
                          children: state.allStrayPets.map((pets) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        StrayPostView(id: pets.id),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = const Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.easeInOut;

                                      var tween = Tween(begin: begin, end: end)
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
                                margin: EdgeInsets.all(8),
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
                                            imageFileBoxFit: BoxFit.cover,
                                            placeHolderBoxFit: BoxFit.cover,
                                            networkImageBoxFit: BoxFit.cover,
                                            imageUrl: pets.petImage,
                                            progressIndicatorBuilder:
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            placeHolder:
                                                "assets/images/pet_default2.jpg",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        pets.petName.toString(),
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        // '\$${pets.reward}',
                                                        pets.reward.toString(),
                                                        style: const TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        pets.lostDate
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors
                                                              .indigo.shade400,
                                                          fontSize: 12,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        pets.ownerName
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        pets.address.toString(),
                                                        style: TextStyle(
                                                          color: Colors
                                                              .indigo.shade400,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  pets.description.toString(),
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
                      }).toList()),
                    );
                  } else if (state is StrayError) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: Center(
                        child: Text(state.error,
                            style: const TextStyle(color: Colors.red)),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: FloatingActionButton(
                        heroTag: 'strayPetsButton',
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const StrayPost(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.easeInOut;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
