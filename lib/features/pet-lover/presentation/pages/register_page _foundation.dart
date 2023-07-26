import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/global/common/common.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/credential/credential_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/auth/auth_cubit.dart';
import 'package:pet_keeper_front/global/pages/main_layout.dart';

class RegisterPageFoundation extends StatefulWidget {
  const RegisterPageFoundation({super.key});

  @override
  State<RegisterPageFoundation> createState() => _RegisterPageFoundationState();
}

class _RegisterPageFoundationState extends State<RegisterPageFoundation> {
  bool isPasswordVisible = false;
  bool isPassword2Visible = false;
  bool isLoading = false;
  late TextEditingController _passwordController;
  late TextEditingController _password2Controller;
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _infoController;
  late TextEditingController _payInfoController;
  late TextEditingController _addressController;
  String? _locationController;
  String? _cityController;
  late File _certFile;

  List<String> countries = [
    'Chiapas',
  ];

  List<String> cities = [
    'Tuxtla Gutiérrez',
  ];

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _password2Controller = TextEditingController();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _infoController = TextEditingController();
    _payInfoController = TextEditingController();
    _addressController = TextEditingController();
    _certFile = File('');
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _password2Controller.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _infoController.dispose();
    _payInfoController.dispose();
    _addressController.dispose();
    _certFile = File('');
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

  Future<void> _pickFile() async {
    print('FILE PATH BEFORE ${_certFile.path}');
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        _certFile = File(result.files.single.path!);
        print('FILE PATH: $_certFile');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        builder: (context, credentialState) {
          if (credentialState is CredentialLoading) {
            return const Center(
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
                height: 550 * fem,
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
                      Container(
                        height: 240 * fem,
                        child: ListView(
                          children: [
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
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(132, 255, 255, 255),
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
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
                                fillColor:
                                    const Color.fromARGB(132, 255, 255, 255),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _infoController,
                              maxLines:
                                  null, // Permite que el campo de entrada se expanda automáticamente
                              keyboardType: TextInputType
                                  .multiline, // Permite varias líneas de texto
                              textInputAction: TextInputAction.newline,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.info,
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
                                  borderRadius: BorderRadius.circular(12.0),
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
                                hintText: 'Descripción de perfil',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(161, 255, 255, 255)),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(132, 255, 255, 255),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _payInfoController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.payment,
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
                                  borderRadius: BorderRadius.circular(12.0),
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
                                hintText: 'Información de pago',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(161, 255, 255, 255)),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(132, 255, 255, 255),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: const Color.fromARGB(132, 255, 255, 255),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.place,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 13.0,
                                    ),
                                    Expanded(
                                      child: DropdownButton<String>(
                                        dropdownColor: Colors.indigo,
                                        value: _locationController,
                                        iconEnabledColor: Colors.white,
                                        isExpanded: true,
                                        style: const TextStyle(
                                            color: Colors.black87),
                                        underline:
                                            Container(), // Para ocultar el underline del DropdownButton
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _locationController = newValue;
                                          });
                                        },
                                        items: countries
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        hint: const Text(
                                          'Seleccione un estado',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                176, 255, 255, 255),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _locationController != null
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: const Color.fromARGB(
                                              132, 255, 255, 255),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.location_city,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 13.0,
                                              ),
                                              Expanded(
                                                child: DropdownButton<String>(
                                                  dropdownColor: Colors.indigo,
                                                  value: _cityController,
                                                  iconEnabledColor:
                                                      Colors.white,
                                                  isExpanded: true,
                                                  style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 16,
                                                  ),
                                                  underline:
                                                      Container(), // Para ocultar el underline del DropdownButton
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      _cityController =
                                                          newValue;
                                                    });
                                                  },
                                                  items: cities.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  hint: const Text(
                                                    'Seleccione un estado',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          176, 255, 255, 255),
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _addressController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.home,
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
                                  borderRadius: BorderRadius.circular(12.0),
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
                                hintText: 'Dirección física',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(161, 255, 255, 255)),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(132, 255, 255, 255),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InputDecorator(
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 13),
                                prefixIcon: const Icon(
                                  Icons.attach_file,
                                  color: Colors.white,
                                ),
                                hintText: 'Adjuntar archivo',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(132, 255, 255, 255),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
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
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _pickFile();
                                    },
                                    // ignore: unrelated_type_equality_checks
                                    child: _certFile.path != ''
                                        ? SizedBox(
                                            width: 250,
                                            child: Text(
                                              _certFile.path,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        : const Text(
                                            'Seleccionar archivo',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  176, 255, 255, 255),
                                              fontSize: 16,
                                            ),
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Certificado de fundación'),
                                              content: const Text(
                                                  'En este apartado usted debe cargar el documento que certifica que es una fundación.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Cerrar el modal
                                                  },
                                                  child: const Text('Cerrar'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
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
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(132, 255, 255, 255),
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
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
                                fillColor:
                                    const Color.fromARGB(132, 255, 255, 255),
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
                                  borderRadius: BorderRadius.circular(12.0),
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
                                hintText: 'Contraseña',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(161, 255, 255, 255)),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(132, 255, 255, 255),
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
                                  onTap: togglePassword2Visibility,
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
                                  borderRadius: BorderRadius.circular(12.0),
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
                                hintText: 'Confirmar contraseña',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(161, 255, 255, 255)),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(132, 255, 255, 255),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Ya tienes una cuenta?',
                              style: const TextStyle(color: Colors.white),
                              children: [
                                const WidgetSpan(
                                  child: SizedBox(
                                      width:
                                          5), // Espacio en blanco como widget
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
                          SizedBox(
                            height: 15.0,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Eres un usuario?',
                              style: const TextStyle(color: Colors.white),
                              children: [
                                const WidgetSpan(
                                  child: SizedBox(
                                      width:
                                          5), // Espacio en blanco como widget
                                ),
                                TextSpan(
                                  text: 'Registrarse como usuario',
                                  style: TextStyle(
                                      color: Colors.purple[100],
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPageFoundation(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
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
                      _submitSignUp();
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 50.0),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 70.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         const Text(
          //           'O continúa con',
          //           style: TextStyle(fontSize: 18),
          //         ),
          //         SizedBox(
          //           height: 20,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Image.asset(
          //               'assets/images/google.png',
          //               width: 50,
          //               height: 50,
          //             ),
          //             SizedBox(
          //               width: 20,
          //             ),
          //             Image.asset(
          //               'assets/images/fb.png',
          //               width: 50,
          //               height: 50,
          //             ),
          //           ],
          //         ),
          //         SizedBox(
          //           height: 30,
          //         ),
          //         RichText(
          //           textAlign: TextAlign.center,
          //           text: TextSpan(
          //             text: 'Al continúar, estás de acuerdo con nuestros',
          //             style: const TextStyle(color: Colors.black),
          //             children: [
          //               const WidgetSpan(
          //                 child: SizedBox(
          //                     width: 5), // Espacio en blanco como widget
          //               ),
          //               TextSpan(
          //                 text: 'Términos y condiciones',
          //                 style: TextStyle(
          //                     color: Colors.purple[100],
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void _submitSignUp() async {
    if (_usernameController.text.isEmpty) {
      toast("Enter username");
      toggleLoading();
      return;
    }

    if (_infoController.text.isEmpty) {
      toast("Enter description");
      toggleLoading();
      return;
    }

    if (_payInfoController.text.isEmpty) {
      toast("Enter pay info");
      toggleLoading();
      return;
    }

    if (_locationController == '' || _locationController == null) {
      toast("Enter location");
      toggleLoading();
      return;
    }

    if (_addressController.text.isEmpty) {
      toast("Enter address");
      toggleLoading();
      return;
    }

    if (_certFile.path == '' ||
        _certFile.path.isEmpty ||
        !_certFile.path.contains('.pdf')) {
      toast("Enter cert document");
      toggleLoading();
      return;
    }

    if (_emailController.text.isEmpty) {
      toast("Enter email");
      toggleLoading();
      return;
    }

    if (_passwordController.text.isEmpty) {
      toast("Enter password");
      toggleLoading();
      return;
    }

    if (_password2Controller.text.isEmpty) {
      toast("Enter again password");
      toggleLoading();
      return;
    }

    if (_passwordController.text != _password2Controller.text) {
      toast("both password must be same");
      toggleLoading();
      return;
    }

    BlocProvider.of<CredentialCubit>(context).signUpSubmit(
        user: PetLoverEntity(
            name: _usernameController.text,
            profileUrl: "",
            email: _emailController.text,
            password: _passwordController.text,
            type: 'foundation',
            certFile: _certFile,
            info: _infoController.text,
            payInfo: _payInfoController.text,
            address: _addressController.text,
            location: ('$_locationController, $_cityController,')));
    toggleLoading();
  }
}
