import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/auth/auth_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/login_page.dart';

class EmailVerifyUserPage extends StatefulWidget {
  const EmailVerifyUserPage({super.key});

  @override
  State<EmailVerifyUserPage> createState() => _EmailVerifyUserPageState();
}

class _EmailVerifyUserPageState extends State<EmailVerifyUserPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
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
                decoration: BoxDecoration(
                  color: const Color.fromARGB(195, 42, 34, 117),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // desplazamiento hacia abajo
                    ),
                  ],
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
                        'Verifica tu correo electrónico',
                        style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Hemos enviado un correo de verificación al correo que registraste, por favor revisa tu bandeja para confirmar tu cuenta.',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Si ya confirmaste tu cuenta mediante el correo que te enviamos, ya puedes iniciar sesión',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Revisa tu bandeja de ',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                          children: [
                            TextSpan(
                              text: 'correos no deseados',
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'No te ha llegado el correo?',
                          style: const TextStyle(color: Colors.white),
                          children: [
                            const WidgetSpan(
                              child: SizedBox(
                                  width: 5), // Espacio en blanco como widget
                            ),
                            TextSpan(
                              text: 'Enviar de nuevo',
                              style: TextStyle(
                                  color: Colors.purple[100],
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  User? userV =
                                      FirebaseAuth.instance.currentUser;
                                  BlocProvider.of<AuthCubit>(context)
                                      .sendVefEmail(userV!.email);
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
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).loggedOut();
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const LoginPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = const Offset(-1.0, 0.0);
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
                  },
                  child: Transform.translate(
                    offset: const Offset(0, 20),
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).loggedOut();
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const LoginPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(-1.0, 0.0);
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
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.purple[100]!,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      child: const Icon(
                        Icons.logout,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SizedBox(
              width: 250,
              height: 250,
              child: Center(
                child: Lottie.asset(
                  'assets/animations/email.json',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
