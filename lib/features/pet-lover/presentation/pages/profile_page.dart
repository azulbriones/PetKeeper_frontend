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

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  File? _image;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  void _onReturnFromOtherPage() {
    context.read<StrayPetBloc>().add(GetAllStrayPets());
    context.read<AdoptPetBloc>().add(GetAllPets());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
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

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                getImage();
              },
              child: Container(
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
            SizedBox(
              height: 14,
            ),
            const Text(
              'Remove profile photo',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 28,
            ),
            TextFieldContainer(
              hintText: "username",
              prefixIcon: Icons.person,
              controller: _nameController,
            ),
            SizedBox(
              height: 14,
            ),
            AbsorbPointer(
              child: TextFieldContainer(
                hintText: "email",
                prefixIcon: Icons.alternate_email,
                controller: _emailController,
              ),
            ),
            SizedBox(
              height: 28,
            ),
            ContainerButton(
              title: "Update Profile",
              icon: Icons.update,
              onTap: () {
                _updateProfile(currentUser.id!);
              },
            ),
            SizedBox(
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
            SizedBox(
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
        ),
      )
          .then((value) {
        toastOk("Profile Updated Successfully");
      });
    }
  }
}
