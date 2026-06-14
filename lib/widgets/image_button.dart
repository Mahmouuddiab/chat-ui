import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  const   ImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.image,
        color: Colors.grey,
      ),
    );
  }
}