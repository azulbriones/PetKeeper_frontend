import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/adopt-pet/presentation/pages/toadopt_pets.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/user/user_cubit.dart';
import 'package:pet_keeper_front/features/stray-pet/presentation/pages/stray_pets.dart';
import 'package:pet_keeper_front/global/pages/home_page.dart';

class MainLayout extends StatefulWidget {
  final String uid;

  const MainLayout({Key? key, required this.uid}) : super(key: key);
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
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
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Stray Pets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'To Adopt',
          ),
        ],
      ),
    );
  }

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
        ],
      ),
    );
  }
}
