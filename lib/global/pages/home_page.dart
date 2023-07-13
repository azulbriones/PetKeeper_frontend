import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_image/network_image.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/auth/auth_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/user/user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            Container(
              width: 375 * fem,
              height: 50 * fem,
              color: Colors.indigo[400],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0 * fem),
                  child: const Text(
                    'Inicio',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Padding(
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
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage(
                                    'assets/images/profile_default.png'),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Mascotas extravíadas',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Padding(
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
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage(
                                    'assets/images/profile_default.png'),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Mascotas en adopción',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
