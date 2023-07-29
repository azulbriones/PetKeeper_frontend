import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_image/network_image.dart';
import 'package:pet_keeper_front/features/adopt_pet/presentation/pages/your_breeds.dart';
import 'package:pet_keeper_front/global/common/common.dart';
import 'package:pet_keeper_front/global/config/config.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/profile_page.dart';
import 'package:http/http.dart' as http;
import 'package:pet_keeper_front/global/widgets/container/container_button.dart';

String apiURL = serverURL;

class RecommendPet extends StatefulWidget {
  const RecommendPet({super.key});

  @override
  State<RecommendPet> createState() => _RecommendPetState();
}

class _RecommendPetState extends State<RecommendPet> {
  String? _selected1 = '';
  String? _selected2 = '';
  String? _selected3 = '';
  String? _selected4 = '';
  String? _selected5 = '';
  String? _selected6 = '';
  String? _selected7 = '';
  String? _selected8 = '';
  String? _selected9 = '';
  String? _selected10 = '';
  String? _selected11 = '';
  String? _selected12 = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  Widget _bodyWidget(PetLoverEntity currentUser) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('PetKeeper'),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipOval(
                      child: NetworkImageWidget(
                        borderRadiusImageFile: 50,
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
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: 375 * fem,
            height: 50 * fem,
            color: Colors.indigo[400],
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0 * fem),
                child: const Text(
                  'Encuentra tu mascota ideal',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tienes expereiencia cuidando perros?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Algo de experiencia'),
                            value:
                                'perro apto para dueño con algo de experiencia',
                            groupValue: _selected1,
                            onChanged: (value) {
                              setState(() {
                                _selected1 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Con experiencia'),
                            value: 'perro apto para dueño con experiencia',
                            groupValue: _selected1,
                            onChanged: (value) {
                              setState(() {
                                _selected1 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Sin experiencia'),
                            value: 'perro apto para dueño sin experiencia',
                            groupValue: _selected1,
                            onChanged: (value) {
                              setState(() {
                                _selected1 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Qué tipo de adiestramiento podra propocionarle a su perro ideal?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Algo de adiestramiento'),
                            value: 'se requiere algo de adiestramiento',
                            groupValue: _selected2,
                            onChanged: (value) {
                              setState(() {
                                _selected2 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Adiestramiento basico'),
                            value: 'se requiere adiestramiento basico',
                            groupValue: _selected2,
                            onChanged: (value) {
                              setState(() {
                                _selected2 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Adiestramiento extra'),
                            value: 'se requiere adiestramiento extra',
                            groupValue: _selected2,
                            onChanged: (value) {
                              setState(() {
                                _selected2 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Qué tipo de paseos realizaria su perro ideal?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Enérgicos'),
                            value: 'gustan los paseos enérgicos',
                            groupValue: _selected3,
                            onChanged: (value) {
                              setState(() {
                                _selected3 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Suaves'),
                            value: 'gustan los paseos suaves',
                            groupValue: _selected3,
                            onChanged: (value) {
                              setState(() {
                                _selected3 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Activos'),
                            value: 'gustan los paseos activos',
                            groupValue: _selected2,
                            onChanged: (value) {
                              setState(() {
                                _selected3 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cuánto tiempo durará el paseo?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Una o dos horas al día'),
                            value: 'le gusta pasear una o dos horas al dia',
                            groupValue: _selected4,
                            onChanged: (value) {
                              setState(() {
                                _selected4 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Mas de dos horas'),
                            value: 'le gusta pasear mas de dos horas',
                            groupValue: _selected4,
                            onChanged: (value) {
                              setState(() {
                                _selected4 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Media hora al dia'),
                            value: 'le gusta pasear media hora al dia',
                            groupValue: _selected4,
                            onChanged: (value) {
                              setState(() {
                                _selected4 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Una hora al dia'),
                            value: 'le gusta pasear una hora al dia',
                            groupValue: _selected4,
                            onChanged: (value) {
                              setState(() {
                                _selected4 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tamaño del perro ideal que podrá cuidar',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Mini tipo toy'),
                            value: 'perro mini tipo toy',
                            groupValue: _selected5,
                            onChanged: (value) {
                              setState(() {
                                _selected5 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Pequeño'),
                            value: 'perro pequeño',
                            groupValue: _selected5,
                            onChanged: (value) {
                              setState(() {
                                _selected5 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Mediano'),
                            value: 'perro mediano',
                            groupValue: _selected5,
                            onChanged: (value) {
                              setState(() {
                                _selected5 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Grande'),
                            value: 'perro grande',
                            groupValue: _selected5,
                            onChanged: (value) {
                              setState(() {
                                _selected5 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Gigante'),
                            value: 'perro gigante',
                            groupValue: _selected5,
                            onChanged: (value) {
                              setState(() {
                                _selected5 = value;
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dato: todos los perros babean, porfavor elija que tanto puede babear su perro ideal:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Babeo mínimo'),
                            value: 'babeo minimo',
                            groupValue: _selected6,
                            onChanged: (value) {
                              setState(() {
                                _selected6 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Babeo intenso'),
                            value: 'babeo intenso',
                            groupValue: _selected6,
                            onChanged: (value) {
                              setState(() {
                                _selected6 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Que tan seguido aseara a su perro ideal?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Diario'),
                            value: 'diario',
                            groupValue: _selected7,
                            onChanged: (value) {
                              setState(() {
                                _selected7 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Cada dos días'),
                            value: 'cada dos dias',
                            groupValue: _selected7,
                            onChanged: (value) {
                              setState(() {
                                _selected7 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Una vez por semana'),
                            value: 'una vez por semana',
                            groupValue: _selected7,
                            onChanged: (value) {
                              setState(() {
                                _selected7 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Necesita que su perro sea hipoalergeníco?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Si'),
                            value: 'perro hipolergeníco',
                            groupValue: _selected8,
                            onChanged: (value) {
                              setState(() {
                                _selected8 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('No'),
                            value: 'perro no hipoalergeníco',
                            groupValue: _selected8,
                            onChanged: (value) {
                              setState(() {
                                _selected8 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Que actitud debe tener su perro ideal?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Perro expresivo y ladrador'),
                            value: 'perro expresivo y ladrador',
                            groupValue: _selected9,
                            onChanged: (value) {
                              setState(() {
                                _selected9 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Perro tranquilo'),
                            value: 'perro tranquilo',
                            groupValue: _selected9,
                            onChanged: (value) {
                              setState(() {
                                _selected9 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Perro muy ladrador'),
                            value: 'perro muy ladrador',
                            groupValue: _selected9,
                            onChanged: (value) {
                              setState(() {
                                _selected9 = value;
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Necesita que su perro ideal sea uno guardián?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Si'),
                            value: 'perro guardian',
                            groupValue: _selected10,
                            onChanged: (value) {
                              setState(() {
                                _selected10 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('No'),
                            value: 'no es un perro guardian',
                            groupValue: _selected10,
                            onChanged: (value) {
                              setState(() {
                                _selected10 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Si su perro vivira con mascotas, porfavor seleccione que tipo de perro le gustaria tener?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Familiar'),
                            value: 'perro familiar',
                            groupValue: _selected11,
                            onChanged: (value) {
                              setState(() {
                                _selected11 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('No familiar'),
                            value:
                                'Puede necesitar entrenamiento para vivir con niños',
                            groupValue: _selected11,
                            onChanged: (value) {
                              setState(() {
                                _selected11 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Si su perro vivira con mascotas, porfavor seleccione que tipo de perro le gustaria tener?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Perro social'),
                            value:
                                'convive bien con otras mascotas" para social',
                            groupValue: _selected12,
                            onChanged: (value) {
                              setState(() {
                                _selected12 = value;
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Perro no social'),
                            value:
                                'Puede necesitar entrenamiento para vivir con otras mascotas',
                            groupValue: _selected12,
                            onChanged: (value) {
                              setState(() {
                                _selected12 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ContainerButton(
                    title: 'Enviar',
                    onTap: () async {
                      List<String> razas = await _sendFeatures();
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  YourBreeds(razas: razas),
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
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<List<String>> _sendFeatures() async {
    var data =
        '$_selected1, $_selected12, $_selected3, $_selected4, $_selected5, $_selected6, $_selected7, $_selected8, $_selected9, $_selected10, $_selected11, $_selected12';

    // Construir el cuerpo JSON con el campo "necesidades"
    var requestBody = jsonEncode({"necesidades": data});

    // Definir las cabeceras de la solicitud POST
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(
        Uri.http(apiURL, '/api/predecir_raza/'),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Decodificar la respuesta JSON y obtener la lista de strings
        var jsonResponse = jsonDecode(response.body);
        // Obtener el mapa que contiene las listas
        // Obtener la lista de mapas que contiene las claves 'raza'
        List<dynamic> resultList = jsonResponse['resultados_top3'];

        // Crear una lista de strings que contendrá todas las razas
        List<String> razasList = [];

        // Iterar sobre la lista de mapas
        for (var map in resultList) {
          // Obtener el valor asociado a la clave 'raza' en cada mapa
          var razaList = map['raza'];

          // Aquí es donde modificamos para obtener el string de la lista
          var raza = razaList[
              0]; // Obtenemos el primer elemento de la lista como un string

          // Agregar la raza a la lista final
          razasList.add(raza);
        }
        print(razasList);
        return razasList;
      } else {
        // Si la respuesta no es exitosa, lanzar una excepción con el mensaje de error
        throw Exception('Failed to load Adopt pets');
      }
    } catch (e) {
      // Si ocurre un error en la solicitud, lanzar una excepción con el mensaje de error
      throw Exception('Error: $e');
    }
  }
}
