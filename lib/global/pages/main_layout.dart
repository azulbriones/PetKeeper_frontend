import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/adopt-pet/presentation/pages/toadopt_pets.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/user/user_cubit.dart';
import 'package:pet_keeper_front/features/stray_pet/presentation/pages/stray_pets.dart';
import 'package:pet_keeper_front/global/pages/home_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainLayout extends StatefulWidget {
  final String uid;

  const MainLayout({Key? key, required this.uid}) : super(key: key);
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

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

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SingleUserCubit, SingleUserState>(
        builder: (context, singleUserState) {
          if (singleUserState is SingleUserLoaded) {
            return _bodyLayout(singleUserState.currentUser);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: GNav(
        tabs: tabItems,
        selectedIndex: _currentIndex,
        onTabChange: _onTabTapped,
        gap: 5,
        activeColor: Colors.indigo,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        color: Colors.grey,
        iconSize: 30,
        backgroundColor: Colors.white,
      ),
    );
  }

  final List<GButton> tabItems = const [
    GButton(
      icon: Icons.home,
      text: 'Home',
    ),
    GButton(
      icon: Icons.search,
      text: 'Stray Pets',
    ),
    GButton(
      icon: Icons.pets,
      text: 'To Adopt',
    ),
    GButton(
      icon: Icons.foundation,
      text: 'Foundations',
    ),
  ];

  Widget _bodyLayout(PetLoverEntity currentUser) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          HomePage(),
          StrayPets(),
          ToAdoptPets(),
          HomePage(),
        ],
      ),
    );
  }
}
