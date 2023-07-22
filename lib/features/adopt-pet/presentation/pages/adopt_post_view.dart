import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_image/network_image.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/profile_page.dart';

class AdoptPostView extends StatefulWidget {
  const AdoptPostView({super.key});

  @override
  State<AdoptPostView> createState() => _AdoptPostViewState();
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

class _AdoptPostViewState extends State<AdoptPostView> {
  var mascotas = Post(
    nombre: 'Max',
    raza: 'Labrador',
    owner: 'Emilio',
    info:
        'Hola, esta es mi mascota, la quiero dar en aaaaaaaaaaaaaaaaaaaaaaaaaaaaafffffffffgggggggg',
    fotoUrl: 'assets/images/adopt_pet.jpg',
    postDate: '14/12/2020',
    postPlace: 'Tuxtla Gutierrez',
  );

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
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image(
                          image: AssetImage(
                            mascotas.fotoUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  mascotas.nombre,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  '(${mascotas.raza})',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  mascotas.owner,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              mascotas.info,
                              style: const TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  mascotas.postPlace,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  mascotas.postDate,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
    );
  }
}
