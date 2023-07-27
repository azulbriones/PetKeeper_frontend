import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:network_image/network_image.dart';
import 'package:pet_keeper_front/features/adopt_pet/presentation/bloc/adopt_pet_bloc.dart';
import 'package:pet_keeper_front/features/pet-lover/domain/entities/pet_lover_entity.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/profile_page.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/profile_page_foundation.dart';
import 'package:pet_keeper_front/global/common/common.dart';
import 'package:pet_keeper_front/global/theme/style.dart';
import 'package:pet_keeper_front/global/widgets/container/container_button_secondary.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StrayPost extends StatefulWidget {
  const StrayPost({super.key});

  @override
  State<StrayPost> createState() => _StrayPostState();
}

class _StrayPostState extends State<StrayPost> {
  late TextEditingController _petName;
  late TextEditingController _petRace;
  late TextEditingController _petOwner;
  late TextEditingController _petStrayAddress;
  late TextEditingController _petDesc;
  late TextEditingController _petBounty;
  String? _locationController;
  String? _cityController;
  String buttonTitle = 'Seleccionar imagen';
  File? _image;
  DateTime? _selectedDate;
  final DateTime _maximumDate = DateTime.now();
  bool isLoading = false;
  bool _isColorChanged = false;

  List<String> countries = [
    'Chiapas',
  ];

  List<String> cities = [
    'Tuxtla Gutiérrez',
  ];

  @override
  void initState() {
    super.initState();
    _petName = TextEditingController();
    _petRace = TextEditingController();
    _petOwner = TextEditingController();
    _petDesc = TextEditingController();
    _petStrayAddress = TextEditingController();
    _petBounty = TextEditingController();
  }

  @override
  void dispose() {
    _petName.dispose();
    _petRace.dispose();
    _petOwner.dispose();
    _petDesc.dispose();
    _petStrayAddress.dispose();
    _petBounty.dispose();
    _image = null;
    super.dispose();
  }

  void toggleLoading() {
    setState(() {
      isLoading = !isLoading;
      _isColorChanged = !_isColorChanged;
    });
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
                    if (currentUser.type == 'foundation') {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const ProfilePageFoundation(),
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
                    } else {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const ProfilePage(),
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
                    }
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
      body: Center(
        child: Column(
          children: [
            Container(
              width: 375 * fem,
              height: 50 * fem,
              color: lightPrimaryColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0 * fem),
                  child: const Text(
                    'Crear publicación de extravío',
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
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    if (_image != null)
                      Stack(
                        children: [
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 12.0),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ContainerButtonSecondary(
                      title: buttonTitle,
                      onTap: () async {
                        final picker = ImagePicker();
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);

                        setState(() {
                          if (pickedFile != null) {
                            _image = File(pickedFile.path);
                            buttonTitle = 'Cambiar imagen';
                          } else {
                            toast('No se seleccionó ninguna imagen.');
                          }
                        });
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _petName,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.pets,
                          color: Colors.indigo,
                        ),
                        contentPadding: const EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        hintText: 'Nombre de la mascota',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(132, 255, 255, 255),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _petRace,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.type_specimen,
                          color: Colors.indigo,
                        ),
                        contentPadding: const EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        hintText: 'Raza de la mascota',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(132, 255, 255, 255),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _petOwner,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.indigo,
                        ),
                        contentPadding: const EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        hintText: 'Nombre del dueño',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(132, 255, 255, 255),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: const Color.fromARGB(132, 255, 255, 255),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.place,
                              color: Colors.indigo,
                            ),
                            SizedBox(
                              width: 13.0,
                            ),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  dropdownColor: Colors.indigo,
                                  value: _locationController,
                                  iconEnabledColor: Colors.indigo,
                                  isExpanded: true,
                                  style: const TextStyle(color: Colors.black87),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _locationController = newValue;
                                    });
                                  },
                                  items:
                                      countries.map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  hint: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text(
                                      'Seleccione un estado',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
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
                                  borderRadius: BorderRadius.circular(12.0),
                                  color:
                                      const Color.fromARGB(132, 255, 255, 255),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_city,
                                        color: Colors.indigo,
                                      ),
                                      SizedBox(
                                        width: 13.0,
                                      ),
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            dropdownColor: Colors.indigo,
                                            value: _cityController,
                                            iconEnabledColor: Colors.indigo,
                                            isExpanded: true,
                                            style: const TextStyle(
                                                color: Colors.black87),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _cityController = newValue;
                                              });
                                            },
                                            items: cities
                                                .map<DropdownMenuItem<String>>(
                                              (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 12.0),
                                                    child: Text(
                                                      value,
                                                      style: const TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            hint: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12.0),
                                              child: Text(
                                                'Seleccione una ciudad',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
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
                      height: 15.0,
                    ),
                    TextField(
                      controller: _petStrayAddress,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.place,
                          color: Colors.indigo,
                        ),
                        contentPadding: const EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        hintText: 'Dirección de extravío',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(132, 255, 255, 255),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.date_range,
                          color: Colors.indigo,
                        ),
                        contentPadding: const EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        hintText: 'Fecha de extravío',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(132, 255, 255, 255),
                      ),
                      readOnly: true,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 300,
                              child: SfDateRangePicker(
                                onSelectionChanged:
                                    (DateRangePickerSelectionChangedArgs args) {
                                  // Actualizar el campo de texto con la fecha seleccionada
                                  setState(() {
                                    _selectedDate = args.value;
                                  });
                                  Navigator.pop(context);
                                },
                                initialSelectedDate: _selectedDate,
                                maxDate: _maximumDate,
                              ),
                            );
                          },
                        );
                      },
                      controller: TextEditingController(
                        text: _selectedDate != null
                            ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                            : '',
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _petBounty,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.monetization_on,
                          color: Colors.indigo,
                        ),
                        contentPadding: const EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        hintText: 'Recompensa (opcional)',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(132, 255, 255, 255),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _petDesc,
                      maxLines:
                          null, // Permite que el campo de entrada se expanda automáticamente
                      keyboardType: TextInputType
                          .multiline, // Permite varias líneas de texto
                      textInputAction: TextInputAction.newline,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.info,
                          color: Colors.indigo,
                        ),
                        contentPadding: const EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.indigo,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        hintText: 'Descripción',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(132, 255, 255, 255),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    InkWell(
                      onTap: () async {
                        toggleLoading();
                        _submitPost();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 2),
                          color:
                              _isColorChanged ? Colors.black87 : Colors.indigo,
                          alignment: Alignment.center,
                          height: 44,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Visibility(
                                visible: !isLoading,
                                child: const Text(
                                  'Crear publicación',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                              Visibility(
                                visible: isLoading,
                                child: const SizedBox(
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
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitPost() {
    if (_image == null) {
      toast("Selecciona una imagen");
      toggleLoading();
      return;
    }
    if (_petName.text.isEmpty) {
      toast("Inserta el nombre de la mascota");
      toggleLoading();
      return;
    }

    if (_petRace.text.isEmpty) {
      toast("Inserta una raza");
      toggleLoading();
      return;
    }

    if (_petOwner.text.isEmpty) {
      toast("Inserta un dueño");
      toggleLoading();
      return;
    }

    if (_locationController == '' || _locationController == null) {
      toast("Inserta un estado");
      toggleLoading();
      return;
    }

    if (_cityController == '' || _cityController == null) {
      toast("Inserta una ciudad");
      toggleLoading();
      return;
    }

    if (_petStrayAddress.text.isEmpty) {
      toast("Inserta una dirección");
      toggleLoading();
      return;
    }

    if (_petStrayAddress.text.isEmpty) {
      toast("Inserta una dirección");
      toggleLoading();
      return;
    }

    if (_selectedDate == null) {
      toast("Inserta una fecha");
      toggleLoading();
      return;
    }

    if (_petDesc.text.isEmpty) {
      toast("Inserta una descripción");
      toggleLoading();
      return;
    }
  }
}
