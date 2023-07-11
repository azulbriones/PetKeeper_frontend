import 'package:flutter/material.dart';
import 'package:pet_keeper_front/global/theme/style.dart';

class ContainerButtonDanger extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  const ContainerButtonDanger({Key? key, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 44,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: redColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          title!,
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}
