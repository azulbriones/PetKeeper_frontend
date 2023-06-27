import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isPasswordVisible = false;
  bool isPassword2Visible = false;
  bool isLoading = false;
  late TextEditingController _passwordController;
  late TextEditingController _password2Controller;
  late TextEditingController _emailController;
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _password2Controller = TextEditingController();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _password2Controller.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void togglePassword2Visibility() {
    setState(() {
      isPassword2Visible = !isPassword2Visible;
    });
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
                      Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 140 * fem,
                          height: 140 * fem,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Text(
                        'Regístrate',
                        style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Rellena el formulario con tus datos',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _usernameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person,
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
                          hintText: 'Nombre de usuario',
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
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email,
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
                          hintText: 'Correo electrónico',
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
                        controller: _passwordController,
                        obscureText: !isPasswordVisible,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: togglePasswordVisibility,
                            child: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
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
                          hintText: 'Contraseña',
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
                        controller: _password2Controller,
                        obscureText: !isPassword2Visible,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: togglePasswordVisibility,
                            child: Icon(
                              isPassword2Visible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
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
                          hintText: 'Confirmar contraseña',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(161, 255, 255, 255)),
                          filled: true,
                          fillColor: const Color.fromARGB(132, 255, 255, 255),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Ya tienes una cuenta?',
                          style: const TextStyle(color: Colors.white),
                          children: [
                            const WidgetSpan(
                              child: SizedBox(
                                  width: 5), // Espacio en blanco como widget
                            ),
                            TextSpan(
                              text: 'Iniciar sesión',
                              style: TextStyle(
                                  color: Colors.purple[100],
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                },
                            ),
                          ],
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
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'O continúa con',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        'assets/images/fb.png',
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Al continúar, estás de acuerdo con nuestros',
                      style: const TextStyle(color: Colors.black),
                      children: [
                        const WidgetSpan(
                          child: SizedBox(
                              width: 5), // Espacio en blanco como widget
                        ),
                        TextSpan(
                          text: 'Términos y condiciones',
                          style: TextStyle(
                              color: Colors.purple[100],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
