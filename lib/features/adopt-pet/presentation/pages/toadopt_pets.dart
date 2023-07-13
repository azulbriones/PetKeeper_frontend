import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_image/network_image.dart';
import 'package:pet_keeper_front/features/adopt-pet/presentation/pages/adopt_post.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/profile_page.dart';

class ToAdoptPets extends StatefulWidget {
  const ToAdoptPets({super.key});

  @override
  State<ToAdoptPets> createState() => _ToAdoptPetsState();
}

class Post {
  String nombre;
  String raza;
  String owner;
  String info;
  String fotoUrl;
  String postDate;
  String postPlace;

  Post({
    required this.nombre,
    required this.raza,
    required this.owner,
    required this.info,
    required this.fotoUrl,
    required this.postDate,
    required this.postPlace,
  });
}

class _ToAdoptPetsState extends State<ToAdoptPets> {
  List<Post> mascotas = [
    Post(
      nombre: 'Max',
      raza: 'Labrador',
      owner: 'Emilio',
      info:
          'Hola, esta es mi mascota, la extravié en aaaaaaaaaaaaaaaaaaaaaaaaaaaaafffffffffgggggggg',
      fotoUrl: 'assets/images/dog1.png',
      postDate: '14/12/2020',
      postPlace: 'Tuxtla Gutierrez',
    ),
    Post(
      nombre: 'Luna',
      raza: 'Golden Retriever',
      owner: 'Emilio 2',
      info: 'Hola, esta es mi mascota, la extravié en',
      fotoUrl: 'assets/images/dog2.png',
      postDate: '23/06/2021',
      postPlace: 'Suchiapa',
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
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('PetKeeper'),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipOval(
                      child: NetworkImageWidget(
                        borderRadiusImageFile: 50,
                        placeHolderBoxFit: BoxFit.cover,
                        networkImageBoxFit: BoxFit.cover,
                        imageUrl: currentUser.profileUrl,
                        progressIndicatorBuilder: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        placeHolder: "assets/images/profile_default.png",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
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
                  'Mascotas en adopción',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                mascota.postDate,
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
                                                mascota.postPlace,
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
                            MaterialPageRoute(
                              builder: (context) => const AdoptPost(),
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
