import 'package:flutter/material.dart';
import 'package:pet_keeper_front/global/theme/style.dart';

class ContainerButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  final IconData? icon;
  const ContainerButton({Key? key, this.title, this.onTap, this.icon})
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
          color: greenColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    title!,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ],
              )
            : Text(
                title!,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
      ),
    );
  }
}
