import 'package:flutter/material.dart';

Widget myDrawerTile({
  required String title,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return ListTile(

    leading: Icon(icon, color: Colors.purple),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    hoverColor: Colors.purple.withOpacity(0.1),
  );
}
