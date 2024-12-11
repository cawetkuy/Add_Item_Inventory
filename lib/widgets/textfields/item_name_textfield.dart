import 'package:flutter/material.dart';

class ItemNameTextfield extends StatelessWidget {
  final TextEditingController controllerTyped;

  const ItemNameTextfield({super.key, required this.controllerTyped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 16),
      child: TextField(
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.black,
          fontSize: 13
        ),
        controller: controllerTyped,
        decoration: InputDecoration(
          fillColor: const Color(0xFFFAFAFA),
          filled: true,
          hintText: 'Skincare Product Name',
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFF8696BB),
            fontSize: 13
          ),
          prefixIcon: const Icon(
            Icons.inventory,
            color: Color(0xFF8696BB),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color.fromARGB(255, 238, 185, 11)),
              borderRadius: BorderRadius.circular(10),
            ),
        ),
      ),
    );
  }
}
