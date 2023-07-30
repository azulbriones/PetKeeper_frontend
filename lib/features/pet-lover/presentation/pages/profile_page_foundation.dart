import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:network_image/network_image.dart';
import 'package:pet_keeper_front/features/adopt_pet/presentation/bloc/adopt_pet_bloc.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/auth/auth_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/user/user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/my_posts_page.dart';
import 'package:pet_keeper_front/features/stray_pet/presentation/bloc/stray_pet_bloc.dart';
import 'package:pet_keeper_front/global/common/common.dart';
import 'package:pet_keeper_front/global/widgets/container/container_button.dart';
import 'package:pet_keeper_front/global/widgets/container/container_button_danger.dart';
import 'package:pet_keeper_front/global/widgets/container/container_button_secondary.dart';
import 'package:pet_keeper_front/global/widgets/custom_text_field/text_field_container.dart';
import 'package:pet_keeper_front/features/storage/domain/usecases/upload_profile_image_usecase.dart';
import 'package:pet_keeper_front/features/injection_container.dart' as di;
import 'package:pet_keeper_front/global/theme/style.dart';

class ProfilePageFoundation extends StatefulWidget {
  const ProfilePageFoundation({Key? key}) : super(key: key);

  @override
  State<ProfilePageFoundation> createState() => _ProfilePageFoundationState();
}

class _ProfilePageFoundationState extends State<ProfilePageFoundation> {
  File? _image;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _payInfoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _infoController.dispose();
    _payInfoController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _onReturnFromOtherPage() {
    context.read<StrayPetBloc>().add(GetAllStrayPets());
    context.read<AdoptPetBloc>().add(GetAllPets());
  }

  @override
  Widget build(BuildContext context) {
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

  Future getImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
      );

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          toast('No se seleccionó ninguna imagen');
        }
      });
    } catch (e) {
      toast("error $e");
    }
  }

  Widget _bodyWidget(PetLoverEntity currentUser) {
    _nameController.value = TextEditingValue(text: "${currentUser.name}");
    _emailController.value = TextEditingValue(text: "${currentUser.email}");
    _infoController.value = TextEditingValue(text: "${currentUser.info}");
    _payInfoController.value = TextEditingValue(text: "${currentUser.payInfo}");
    _addressController.value = TextEditingValue(text: "${currentUser.address}");

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      getImage();
                    },
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: ClipOval(
                        child: NetworkImageWidget(
                          imageFile: _image,
                          borderRadiusImageFile: 50,
                          imageFileBoxFit: BoxFit.cover,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: PopupMenuButton(
                    onSelected: (result) async {
                      bool isDelete = await showDialog(
                        context: context,
                        builder: (context) {
                          BuildContext popupContext = context;
                          return AlertDialog(
                            title: const Text('Eliminar cuenta'),
                            content: const Text(
                                '¿Está seguro de eliminar su cuenta?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(false); // Cancelar el deslizamiento
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(popupContext).pop(true);
                                },
                                child: const Text(
                                  'Eliminar',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      if (isDelete == true) {
                        // ignore: use_build_context_synchronously
                        BlocProvider.of<SingleUserCubit>(context)
                            .singleUserDeleted();

                        // ignore: use_build_context_synchronously
                        BlocProvider.of<AuthCubit>(context).deleteAccount();
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      const PopupMenuItem(
                        value: 1,
                        child: Text('Eliminar cuenta'),
                      ),
                    ],
                    child: const Icon(
                      Icons.settings,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            const Text(
              'Remove profile photo',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 28,
            ),
            TextFieldContainer(
              hintText: "username",
              prefixIcon: Icons.person,
              controller: _nameController,
            ),
            const SizedBox(
              height: 14,
            ),
            AbsorbPointer(
              child: TextFieldContainer(
                hintText: "email",
                prefixIcon: Icons.alternate_email,
                controller: _emailController,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                controller: _infoController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: color747480.withOpacity(.2),
                  prefixIcon: const Icon(Icons.info),
                  hintText: 'info',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                controller: _payInfoController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: color747480.withOpacity(.2),
                  prefixIcon: const Icon(Icons.payment),
                  hintText: 'pay info',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                controller: _addressController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: color747480.withOpacity(.2),
                  prefixIcon: const Icon(Icons.home),
                  hintText: 'address',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            ContainerButton(
              title: "Update Profile",
              icon: Icons.update,
              onTap: () {
                _updateProfile(currentUser.id!);
              },
            ),
            const SizedBox(
              height: 14,
            ),
            ContainerButtonSecondary(
              title: "My posts",
              icon: Icons.post_add,
              onTap: () async {
                await Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        MyPostsPage(userId: currentUser.id),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
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
            ),
            const SizedBox(
              height: 14,
            ),
            ContainerButtonDanger(
              title: "Logout",
              icon: Icons.logout,
              onTap: () {
                BlocProvider.of<AuthCubit>(context).loggedOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateProfile(String uid) {
    if (_image != null) {
      di.sl<UploadProfileImageUseCase>().call(file: _image!).then((imageUrl) {
        BlocProvider.of<UserCubit>(context)
            .getUpdateUser(
          user: PetLoverEntity(
            id: uid,
            name: _nameController.text,
            info: _infoController.text,
            profileUrl: imageUrl,
          ),
        )
            .then((value) {
          toastOk("Profile Updated Successfully");
        });
      });
    } else {
      BlocProvider.of<UserCubit>(context)
          .getUpdateUser(
        user: PetLoverEntity(
          id: uid,
          name: _nameController.text,
          info: _infoController.text,
        ),
      )
          .then((value) {
        toastOk("Profile Updated Successfully");
      });
    }
  }
}
