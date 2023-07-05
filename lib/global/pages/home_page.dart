import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/auth/auth_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/user/user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/profile_page.dart';
import 'package:pet_keeper_front/global/widgets/custom_tab_bar/custom_tab_bar.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Widget> get pages =>
  //     [GroupPage(uid: widget.uid), AllUsersPage(), ProfilePage()];

  PageController _pageController = PageController();

  @override
  void initState() {
    BlocProvider.of<SingleUserCubit>(context)
        .getSingleUserProfile(user: PetLoverEntity(id: widget.uid));
    BlocProvider.of<UserCubit>(context)
        .getUsers(user: PetLoverEntity(id: widget.uid));
    //BlocProvider.of<GroupCubit>(context).getGroups();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).loggedOut();
            },
            child: Text('Log Out'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
            child: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
