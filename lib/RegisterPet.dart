import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterPet extends StatefulWidget {
  const RegisterPet({super.key});

  @override
  State<RegisterPet> createState() => _RegisterPetState();
}

class _RegisterPetState extends State<RegisterPet> {
  bool isLoading = false;
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _raceController;
  late TextEditingController _specialFeaturesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _raceController = TextEditingController();
    _specialFeaturesController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _raceController.dispose();
    _specialFeaturesController.dispose();
    super.dispose();
  }

  void toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/banner.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 375 * fem,
                height: 500 * fem,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(195, 42, 34, 117),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.only(right: 45.0 * fem),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                iconSize: 40,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                    width: 140 * fem,
                                    height: 140 * fem,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Text(
                        'Regístra a tu mascota',
                        style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Rellena el formulario con sus datos',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.pets,
                            color: Colors.white,
                          ),
                          contentPadding: const EdgeInsets.all(12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(132, 255, 255, 255),
                              width: 0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(132, 255, 255, 255),
                              width: 0,
                            ),
                          ),
                          hintText: 'Nombre',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(161, 255, 255, 255)),
                          filled: true,
                          fillColor: const Color.fromARGB(132, 255, 255, 255),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _ageController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.numbers,
                            color: Colors.white,
                          ),
                          contentPadding: const EdgeInsets.all(12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(132, 255, 255, 255),
                              width: 0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(132, 255, 255, 255),
                              width: 0,
                            ),
                          ),
                          hintText: 'Edad',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(161, 255, 255, 255)),
                          filled: true,
                          fillColor: const Color.fromARGB(132, 255, 255, 255),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _raceController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.type_specimen,
                            color: Colors.white,
                          ),
                          contentPadding: const EdgeInsets.all(12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(132, 255, 255, 255),
                              width: 0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(132, 255, 255, 255),
                              width: 0,
                            ),
                          ),
                          hintText: 'Raza',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(161, 255, 255, 255)),
                          filled: true,
                          fillColor: const Color.fromARGB(132, 255, 255, 255),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _specialFeaturesController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                          contentPadding: const EdgeInsets.all(12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(132, 255, 255, 255),
                              width: 0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(132, 255, 255, 255),
                              width: 0,
                            ),
                          ),
                          hintText: 'Características especiales',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(161, 255, 255, 255)),
                          filled: true,
                          fillColor: const Color.fromARGB(132, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Transform.translate(
                  offset: const Offset(0, 20),
                  child: ElevatedButton(
                    onPressed: () {
                      toggleLoading();
                      print('iniciar sesion');
                      Future.delayed(const Duration(seconds: 2), () {
                        toggleLoading();
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.purple[100]!,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(8),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero),
                      minimumSize:
                          MaterialStateProperty.all(const Size(100, 50)),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Visibility(
                          visible: !isLoading,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 30,
                          ),
                        ),
                        Visibility(
                          visible: isLoading,
                          child: Container(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: SizedBox(
              width: 210,
              height: 210,
              child: Center(
                child: Lottie.asset(
                  'assets/animations/pets.json',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
