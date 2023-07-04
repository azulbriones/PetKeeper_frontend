import 'package:flutter/material.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/login_page.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/register_page.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/reset_password_page.dart';
import 'package:pet_keeper_front/global/const/page_const.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case PageConst.loginPage:
        {
          return materialPageBuilder(widget: const LoginPage());
        }
      case PageConst.forgotPage:
        {
          return materialPageBuilder(widget: const ResetPasswordPage());
        }
      case PageConst.registrationPage:
        {
          return materialPageBuilder(widget: const RegisterPage());
        }
      default:
        return materialPageBuilder(widget: const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("error"),
      ),
      body: const Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialPageBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
