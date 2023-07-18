import 'package:flutter/material.dart';

class AddData extends StatelessWidget {
  final VoidCallback onTap;
  const AddData({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.grey[400],
        radius: 25,
        child: const Center(
            child: Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        )),
      ),
    );
  }
}
