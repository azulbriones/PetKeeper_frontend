import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:network_image/network_image.dart';

import 'package:pet_keeper_front/features/adopt_pet/presentation/bloc/adopt_pet_bloc.dart';
import 'package:pet_keeper_front/features/adopt_pet/presentation/pages/adopt_post_view.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';

import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';

import 'package:pet_keeper_front/features/stray_pet/presentation/bloc/stray_pet_bloc.dart';
import 'package:pet_keeper_front/features/stray_pet/presentation/pages/stray_post_view.dart';

class MyPostsPage extends StatefulWidget {
  final String? userId;
  const MyPostsPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<MyPostsPage> createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPostsPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late AdoptPetBloc _adoptPetBloc;
  late StrayPetBloc _strayPetBloc;

  late AnimationController _animationController;
  late AnimationController _animationController2;
  late bool _visible;
  late bool _visible2;
  late int? _selectedStatus;

  List<String> statusOptions = [
    'Tuxtla Gutiérrez',
  ];

  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    _adoptPetBloc = BlocProvider.of<AdoptPetBloc>(context);
    _strayPetBloc = BlocProvider.of<StrayPetBloc>(context);
    _visible = true;
    _visible2 = false;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController2 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    context.read<AdoptPetBloc>().add(GetAllUserPostsPet(userId: widget.userId));
    context
        .read<StrayPetBloc>()
        .add(GetAllUserPostsStrayPet(userId: widget.userId));
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        context
            .read<AdoptPetBloc>()
            .add(GetAllUserPostsPet(userId: widget.userId));
        context
            .read<StrayPetBloc>()
            .add(GetAllUserPostsStrayPet(userId: widget.userId));
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
    _animationController.dispose();
    _animationController2.dispose();
    subscription.cancel();
    super.dispose();
  }

  // Función que se ejecutará al realizar la acción de recarga
  Future<void> _onRefresh() async {
    // Simulamos una operación de carga de datos
    await Future.delayed(const Duration(seconds: 1));

    // Una vez finalizada la operación, actualizamos la lista de elementos
    setState(() {
      context
          .read<AdoptPetBloc>()
          .add(GetAllUserPostsPet(userId: widget.userId));
      context
          .read<StrayPetBloc>()
          .add(GetAllUserPostsStrayPet(userId: widget.userId));
    });
  }

  void _onUpdatedAdoptPost() {
    setState(() {
      context
          .read<AdoptPetBloc>()
          .add(GetAllUserPostsPet(userId: widget.userId));
    });
  }

  void _onUpdatedStrayPost() {
    setState(() {
      context
          .read<StrayPetBloc>()
          .add(GetAllUserPostsStrayPet(userId: widget.userId));
    });
  }

  void _toggleVisibility() {
    setState(() {
      _visible = !_visible;
      if (_visible) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    });
  }

  void _toggleVisibility2() {
    setState(() {
      _visible2 = !_visible2;
      if (_visible2) {
        _animationController2.forward();
      } else {
        _animationController2.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('PetKeeper'),
      ),
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
      body: Center(
        child: Column(
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
                    'Mis publicaciones',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: GestureDetector(
                          onTap: _toggleVisibility,
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 8,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/lost_pet.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Mascotas extravíadas',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 28,
                                                      shadows: [
                                                        Shadow(
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          offset: const Offset(
                                                              0, 3),
                                                          blurRadius: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: RotationTransition(
                                          turns: Tween(begin: 0.75, end: 0.25)
                                              .animate(_animationController),
                                          child: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        height: _visible ? 300 : 0,
                        child: _buildStrayPets(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: GestureDetector(
                          onTap: _toggleVisibility2,
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 8,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/adopt_pet.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Mascotas en adopción',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 28,
                                                      shadows: [
                                                        Shadow(
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          offset: const Offset(
                                                              0, 3),
                                                          blurRadius: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: RotationTransition(
                                          turns: Tween(begin: 0.25, end: 0.75)
                                              .animate(_animationController2),
                                          child: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          height: _visible2 ? 300 : 0,
                          child: _buildAdoptPets(),
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

  Widget _buildStrayPets() {
    return BlocBuilder<StrayPetBloc, StrayPetState>(
      builder: (context, state) {
        if (state is LoadingAllUserPostsStrayPet) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedAllUserPostsStrayPet) {
          return state.allUserPostsStrayPets.isNotEmpty
              ? ListView(
                  children: state.allUserPostsStrayPets.map((pets) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
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
                        _onUpdatedStrayPost();
                      },
                      child: Dismissible(
                        key: Key(pets.id),
                        direction: DismissDirection.horizontal,
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            if (pets.status == 'lost') {
                              setState(() {
                                _selectedStatus = 1;
                              });
                            } else if (pets.status == 'found') {
                              setState(() {
                                _selectedStatus = 2;
                              });
                            }
                            await showDialog(
                              context: context,
                              builder: (context) => StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return AlertDialog(
                                  title: const Text(
                                      'Cambiar estatus de publicación'),
                                  scrollable: true,
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Seleccione un nuevo estatus'),
                                      Column(
                                        children: [
                                          RadioListTile<int>(
                                            title: const Text('Extraviado'),
                                            value: 1,
                                            groupValue: _selectedStatus,
                                            onChanged: (int? value) {
                                              setState(() {
                                                _selectedStatus = value;
                                              });
                                            },
                                          ),
                                          RadioListTile<int>(
                                            title: const Text('Encontrado'),
                                            value: 2,
                                            groupValue: _selectedStatus,
                                            onChanged: (int? value) {
                                              setState(() {
                                                _selectedStatus = value;
                                              });
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(
                                            false); // Cancelar el deslizamiento
                                      },
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        late String status;
                                        if (_selectedStatus == 1) {
                                          status = 'lost';
                                        } else if (_selectedStatus == 2) {
                                          status = 'found';
                                        }
                                        _updateStrayPost(pets.id, status);

                                        Navigator.of(context).pop(true);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Estatus actualizado'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        ); // Aceptar el deslizamiento
                                      },
                                      child: const Text('Actualizar'),
                                    ),
                                  ],
                                );
                              }),
                            );
                            return false;
                          } else if (direction == DismissDirection.startToEnd) {
                            bool shouldDismiss = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Eliminar publicación'),
                                content: const Text(
                                    '¿Estás seguro de eliminar esta publicación?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(
                                          false); // Cancelar el deslizamiento
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _deleteStrayPost(pets.id);

                                      Navigator.of(context).pop(true);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Post eliminado'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      ); // Aceptar el deslizamiento
                                    },
                                    child: const Text('Eliminar'),
                                  ),
                                ],
                              ),
                            );
                            return shouldDismiss; // Devuelve true o false según la decisión del usuario
                          }
                          return false;
                        },
                        background: Container(
                          height: 100,
                          margin: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.red,
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
                          alignment: Alignment.centerLeft,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        secondaryBackground: Container(
                          height: 100,
                          margin: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
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
                          alignment: Alignment.centerRight,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
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
                          margin: const EdgeInsets.all(5.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 85,
                                  width: 85,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: NetworkImageWidget(
                                      borderRadiusImageFile: 50,
                                      imageFileBoxFit: BoxFit.cover,
                                      placeHolderBoxFit: BoxFit.cover,
                                      networkImageBoxFit: BoxFit.cover,
                                      imageUrl: pets.petImage,
                                      progressIndicatorBuilder: const Center(
                                        child: CircularProgressIndicator(),
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
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  pets.petName.toString(),
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
                                                  '\$${pets.reward}',
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
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  pets.location.toString(),
                                                  style: TextStyle(
                                                    color:
                                                        Colors.indigo.shade400,
                                                    fontSize: 12,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  pets.ownerName.toString(),
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
                                                    color:
                                                        Colors.indigo.shade400,
                                                    fontSize: 12,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
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
                }).toList())
              : const Center(
                  child: Text(
                    'Nada por aqui aún',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
        } else if (state is StrayError) {
          return Center(
            child: Text(state.error, style: const TextStyle(color: Colors.red)),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildAdoptPets() {
    return BlocBuilder<AdoptPetBloc, AdoptPetState>(
      builder: (context, state) {
        if (state is LoadingAllUserPostsPet) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedAllUserPostsPet) {
          return state.allUserPostsPets.isNotEmpty
              ? ListView(
                  children: state.allUserPostsPets.map((pets) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    AdoptPostView(id: pets.id),
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
                        _onUpdatedAdoptPost();
                      },
                      child: Dismissible(
                        key: Key(pets.id),
                        direction: DismissDirection.horizontal,
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            if (pets.status == 'to adopt') {
                              setState(() {
                                _selectedStatus = 1;
                              });
                            } else if (pets.status == 'adopted') {
                              setState(() {
                                _selectedStatus = 2;
                              });
                            }
                            await showDialog(
                              context: context,
                              builder: (context) => StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return AlertDialog(
                                  title: const Text(
                                      'Cambiar estatus de publicación'),
                                  scrollable: true,
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Seleccione un nuevo estatus'),
                                      Column(
                                        children: [
                                          RadioListTile<int>(
                                            title: const Text('En adopción'),
                                            value: 1,
                                            groupValue: _selectedStatus,
                                            onChanged: (int? value) {
                                              setState(() {
                                                _selectedStatus = value;
                                              });
                                            },
                                          ),
                                          RadioListTile<int>(
                                            title: const Text('Adoptado'),
                                            value: 2,
                                            groupValue: _selectedStatus,
                                            onChanged: (int? value) {
                                              setState(() {
                                                _selectedStatus = value;
                                              });
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(
                                            false); // Cancelar el deslizamiento
                                      },
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        late String status;
                                        if (_selectedStatus == 1) {
                                          status = 'to adopt';
                                        } else if (_selectedStatus == 2) {
                                          status = 'adopted';
                                        }
                                        _updatePost(pets.id, status);

                                        Navigator.of(context).pop(true);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Estatus actualizado'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        ); // Aceptar el deslizamiento
                                      },
                                      child: const Text('Actualizar'),
                                    ),
                                  ],
                                );
                              }),
                            );
                            return false;
                          } else if (direction == DismissDirection.startToEnd) {
                            bool shouldDismiss = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Eliminar publicación'),
                                content: const Text(
                                    '¿Estás seguro de eliminar esta publicación?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(
                                          false); // Cancelar el deslizamiento
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _deletePost(pets.id);

                                      Navigator.of(context).pop(true);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Post eliminado'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      ); // Aceptar el deslizamiento
                                    },
                                    child: const Text('Eliminar'),
                                  ),
                                ],
                              ),
                            );
                            return shouldDismiss; // Devuelve true o false según la decisión del usuario
                          }
                          return false;
                        },
                        background: Container(
                          height: 100,
                          margin: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.red,
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
                          alignment: Alignment.centerLeft,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        secondaryBackground: Container(
                          height: 100,
                          margin: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
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
                          alignment: Alignment.centerRight,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
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
                          margin: const EdgeInsets.all(5.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 85,
                                  width: 85,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: NetworkImageWidget(
                                      borderRadiusImageFile: 50,
                                      imageFileBoxFit: BoxFit.cover,
                                      placeHolderBoxFit: BoxFit.cover,
                                      networkImageBoxFit: BoxFit.cover,
                                      imageUrl: pets.petImage,
                                      progressIndicatorBuilder: const Center(
                                        child: CircularProgressIndicator(),
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
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  pets.petName.toString(),
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
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  pets.location.toString(),
                                                  style: TextStyle(
                                                    color:
                                                        Colors.indigo.shade400,
                                                    fontSize: 12,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  pets.ownerName.toString(),
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
                                                    color:
                                                        Colors.indigo.shade400,
                                                    fontSize: 12,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
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
                }).toList())
              : const Center(
                  child: Text(
                    'Nada por aqui aún',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
        } else if (state is AdoptError) {
          return Center(
            child: Text(state.error, style: const TextStyle(color: Colors.red)),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _updatePost(String adoptPetId, String status) {
    _adoptPetBloc.add(UpdateStatusPet(adoptPetId: adoptPetId, status: status));
    Future.delayed(const Duration(seconds: 1))
        .then((value) => {_onUpdatedAdoptPost()});
  }

  void _updateStrayPost(String strayPetId, String status) {
    _strayPetBloc.add(UpdateStrayPet(strayPetId: strayPetId, status: status));
    Future.delayed(const Duration(seconds: 1))
        .then((value) => {_onUpdatedStrayPost()});
  }

  void _deletePost(String adoptPetId) {
    _adoptPetBloc.add(DeletePet(petId: adoptPetId));
    Future.delayed(const Duration(seconds: 1))
        .then((value) => {_onUpdatedAdoptPost()});
  }

  void _deleteStrayPost(String adoptPetId) {
    _strayPetBloc.add(DeleteStrayPet(strayPetId: adoptPetId));
    Future.delayed(const Duration(seconds: 1))
        .then((value) => {_onUpdatedStrayPost()});
  }
}
