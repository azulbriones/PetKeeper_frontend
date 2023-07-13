import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/auth/auth_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/credential/credential_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/email_verify_user_page.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/register_page.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/reset_password_page.dart';
import 'package:pet_keeper_front/global/common/common.dart';
import 'package:pet_keeper_front/global/pages/home_page.dart';
import 'package:pet_keeper_front/global/pages/main_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;
  bool isLoading = false;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit, CredentialState>(
        builder: (context, credentialState) {
          if (credentialState is CredentialLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainLayout(
                    uid: authState.uid,
                  );
                } else {
                  return _bodyWidget();
                }
              },
            );
          }

          return _bodyWidget();
        },
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }

          if (credentialState is CredentialFailure) {
            toast("wrong email please check");
            //toast
            //alertDialog
            ///SnackBar
          }
        },
      ),
    );
  }

  Widget _bodyWidget() {
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
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 140 * fem,
                            height: 140 * fem,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Text(
                        'Bienvenido de nuevo!',
                        style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Inicia sesión con tu correo electrónico y contraseña',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'No tienes una cuenta?',
                          style: const TextStyle(color: Colors.white),
                          children: [
                            const WidgetSpan(
                              child: SizedBox(
                                  width: 5), // Espacio en blanco como widget
                            ),
                            TextSpan(
                              text: 'Crear una cuenta',
                              style: TextStyle(
                                  color: Colors.purple[100],
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                        height: 20,
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
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Olvidaste tu contraseña?',
                          style: const TextStyle(color: Colors.white),
                          children: [
                            const WidgetSpan(
                              child: SizedBox(
                                  width: 5), // Espacio en blanco como widget
                            ),
                            TextSpan(
                              text: 'Restablecer contraseña',
                              style: TextStyle(
                                  color: Colors.purple[100],
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResetPasswordPage(),
                                    ),
                                  );
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
                      _submitLogin();
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

  void _submitLogin() {
    if (_emailController.text.isEmpty) {
      toast("Enter Your Email");
      return;
    }

    if (_passwordController.text.isEmpty) {
      toast("Enter Your Password");
      return;
    }

    BlocProvider.of<CredentialCubit>(context).signInSubmit(
        email: _emailController.text, password: _passwordController.text);
    toggleLoading();
  }
}
