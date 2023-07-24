import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_image/network_image.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/profile_page.dart';
import 'package:pet_keeper_front/features/stray_pet/presentation/bloc/stray_pet_bloc.dart';
import 'package:pet_keeper_front/global/theme/style.dart';
import 'package:pet_keeper_front/global/widgets/container/container_button.dart';

class StrayPostView extends StatefulWidget {
  final String? id;
  const StrayPostView({Key? key, required this.id}) : super(key: key);

  @override
  State<StrayPostView> createState() => _StrayPostViewState();
}

class _StrayPostViewState extends State<StrayPostView> {
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    print('ID DEL POST RECIBIDO: ${widget.id}');
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        context
            .read<StrayPetBloc>()
            .add(GetDetailStrayPet(strayPetId: widget.id));
        ScaffoldMessenger.of(context).clearSnackBars();
      } else {
        const snackBar = SnackBar(
          content: Text(
            'Se perdió la conectividad Wi-Fi',
            style: TextStyle(),
          ),
          duration: Duration(days: 365),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: BlocBuilder<StrayPetBloc, StrayPetState>(
                    builder: (context, state) {
                  if (state is LoadingDetailStrayPet) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedDetailStrayPet) {
                    return ListView(
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
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image(
                              image: NetworkImage(
                                state.strayPet.petImage.toString(),
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
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          state.strayPet.petName.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          '(${state.strayPet.petBreed})',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '\$${state.strayPet.reward}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                        color: Colors.green,
                                      ),
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
                                      state.strayPet.ownerName.toString(),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  state.strayPet.description.toString(),
                                  style: const TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      state.strayPet.address.toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                      state.strayPet.lostDate.toString(),
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
                        SizedBox(
                          height: 15.0,
                        ),
                        InkWell(
                          onTap: () {
                            print('enviar mensaje');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 44,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: greenColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Enviar mensaje',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Icon(
                                  Icons.chat,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is Error) {
                    return Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return Text(state.toString());
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
