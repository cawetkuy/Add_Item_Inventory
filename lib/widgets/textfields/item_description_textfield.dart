import 'package:flutter/material.dart';

class ItemDescriptionTextfield extends StatelessWidget {
  final TextEditingController controllerTyped;

  const ItemDescriptionTextfield({super.key, required this.controllerTyped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 16),
      child: SizedBox(
        child: TextField(
          style: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.black,
          fontSize: 13
          ),
          controller: controllerTyped,
          maxLines: 6,
          minLines: 1,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            fillColor: const Color(0xFFFAFAFA),
            filled: true,
            hintText: 'Product Description',
            hintStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: Color(0xFF8696BB),
            ),
            prefixIcon: const Icon(
              Icons.description,
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
      ),
    );
  }
}
