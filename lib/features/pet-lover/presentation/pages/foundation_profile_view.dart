import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_image/network_image.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/foundation/foundation_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/profile_page.dart';
import 'package:pet_keeper_front/global/common/common.dart';
import 'package:pet_keeper_front/global/theme/style.dart';

class FoundationProfileView extends StatefulWidget {
  final String? id;
  const FoundationProfileView({Key? key, required this.id}) : super(key: key);

  @override
  State<FoundationProfileView> createState() => _FoundationProfileViewState();
}

class _FoundationProfileViewState extends State<FoundationProfileView> {
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    BlocProvider.of<FoundationCubit>(context)
        .getSingleFoundation(foundationId: widget.id.toString());
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print('La conexion es: $result');
      if (result == ConnectivityResult.wifi) {
        BlocProvider.of<FoundationCubit>(context)
            .getSingleFoundation(foundationId: widget.id.toString());
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
    super.initState();
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
                child: BlocBuilder<FoundationCubit, FoundationState>(
                    builder: (context, state) {
                  if (state is SingleFoundationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SingleFoundationLoaded) {
                    return ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          width: double.infinity,
                          height: 250,
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
                          child: NetworkImageWidget(
                            borderRadiusImageFile: 12.0,
                            borderRadiusNetworkImage: 12.0,
                            borderRadiusPlaceHolder: 12.0,
                            imageFileBoxFit: BoxFit.cover,
                            placeHolderBoxFit: BoxFit.cover,
                            networkImageBoxFit: BoxFit.cover,
                            imageUrl: state.foundation.profileUrl,
                            progressIndicatorBuilder: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            placeHolder: "assets/images/pet_default2.jpg",
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  state.foundation.name.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  state.foundation.info.toString(),
                                  style: const TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.place,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${state.foundation.location} ${state.foundation.address}',
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.grey),
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
                                      Icons.mail,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      state.foundation.email.toString(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
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
                                      Icons.payment,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      state.foundation.payInfo.toString(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            scrollable: true,
                                            title: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.dangerous),
                                                SizedBox(width: 5.0),
                                                Text('Reportar fundación'),
                                              ],
                                            ),
                                            content: const Column(
                                              children: [
                                                Text(
                                                    'Escriba el motivo de su reporte'),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                                  child: SizedBox(
                                                    width: 220,
                                                    child: TextField(
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  // Aquí puedes agregar la lógica que deseas realizar al presionar el botón "Cancelar"
                                                  Navigator.of(context)
                                                      .pop(); // Cerrar el AlertDialog
                                                },
                                                child: const Text('Cancelar'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  //enviar correo a petkeeper del reporte
                                                  toastOk(
                                                      'Foundation report sent');
                                                  Navigator.of(context)
                                                      .pop(); // Cerrar el AlertDialog
                                                },
                                                child: const Text('Enviar'),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.report,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          'Reportar fundación',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        if (currentUser.id != state.foundation.id)
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    CupertinoIcons.chat_bubble_fill,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    );
                  } else if (state is FoundationError) {
                    return Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return Container();
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
