import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pet_keeper_front/email_verify_user.dart';
import 'package:pet_keeper_front/register.dart';
import 'package:pet_keeper_front/reset_password.dart';

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
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: 375 * fem,
            height: 100 * fem,
            decoration: BoxDecoration(
              color: Colors.indigo[900],
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'PetKepper',
                                style: TextStyle(
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage('assets/images/pp.png'),
                              ),
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
          Container(
            width: 375 * fem,
            height: 50 * fem,
            color: Colors.indigo[400],
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Mascotas extraviadas',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mascotas.length,
              itemBuilder: (BuildContext context, int index) {
                Post mascota = mascotas[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.indigo.shade400),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 5),
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
                            backgroundImage: AssetImage(mascota.fotoUrl),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            mascota.nombre,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '\$${mascota.bounty}',
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            mascota.strayDate,
                                            style: TextStyle(
                                              color: Colors.indigo.shade400,
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
                                          alignment: Alignment.centerLeft,
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
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            mascota.strayPlace,
                                            style: TextStyle(
                                              color: Colors.indigo.shade400,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
