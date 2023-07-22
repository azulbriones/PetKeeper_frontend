import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_image/network_image.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/profile_page.dart';
import 'package:pet_keeper_front/features/stray_pet/presentation/pages/stray_post.dart';
import 'package:pet_keeper_front/features/stray_pet/presentation/pages/stray_post_view.dart';

class StrayPets extends StatefulWidget {
  const StrayPets({super.key});

  @override
  State<StrayPets> createState() => _StrayPetsState();
}

class Post {
  String nombre;
  String raza;
  String owner;
  String info;
  String fotoUrl;
  String strayDate;
  String strayPlace;
  String bounty;

  Post({
    required this.nombre,
    required this.raza,
    required this.owner,
    required this.info,
    required this.fotoUrl,
    required this.strayDate,
    required this.strayPlace,
    required this.bounty,
  });
}

class _StrayPetsState extends State<StrayPets> {
  String? selectedCountry;
  String? selectedCity;

  List<String> countries = [
    'Chiapas',
  ];

  List<String> cities = [
    'Tuxtla Gutiérrez',
  ];

  List<Post> mascotas = [
    Post(
      nombre: 'Max',
      raza: 'Labrador',
      owner: 'Emilio',
      info:
          'Hola, esta es mi mascota, la extravié en aaaaaaaaaaaaaaaaaaaaaaaaaaaaafffffffffgggggggg',
      fotoUrl: 'assets/images/dog1.png',
      strayDate: '14/12/2020',
      strayPlace: 'Tuxtla Gutierrez',
      bounty: '3,000',
    ),
    Post(
      nombre: 'Luna',
      raza: 'Golden Retriever',
      owner: 'Emilio 2',
      info: 'Hola, esta es mi mascota, la extravié en',
      fotoUrl: 'assets/images/dog2.png',
      strayDate: '23/06/2021',
      strayPlace: 'Suchiapa',
      bounty: '2,000',
    ),
    // Agrega más objetos de mascota con diferentes datos
  ];

  @override
  Widget build(BuildContext context) {
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
                      iconEnabledColor: Colors.black87,
                      style: const TextStyle(color: Colors.black87),
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
                            style: const TextStyle(color: Colors.black87),
                          ),
                        );
                      }).toList(),
                      hint: const Text(
                        'Seleccione un estado',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    selectedCountry != null
                        ? DropdownButton<String>(
                            value: selectedCity,
                            iconEnabledColor: Colors.black87,
                            style: const TextStyle(color: Colors.black87),
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
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              );
                            }).toList(),
                            hint: const Text(
                              'Seleccione un municipio',
                              style: TextStyle(color: Colors.black87),
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
                ListView.builder(
                  itemCount: mascotas.length,
                  itemBuilder: (BuildContext context, int index) {
                    Post mascota = mascotas[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const StrayPostView(),
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
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        AssetImage(mascota.fotoUrl),
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
                                                    mascota.nombre,
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
                                                    '\$${mascota.bounty}',
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
                                                    mascota.strayDate,
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
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    mascota.owner,
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
                                                    mascota.strayPlace,
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
                                              mascota.info,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                              overflow: TextOverflow.ellipsis,
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
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: FloatingActionButton(
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
