import 'package:flutter/material.dart';

Padding alldoctorsearchbar({required ValueChanged<String> onchange}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: onchange,
        decoration: InputDecoration(
          hintText: "Search...",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.black87),
          ),
        ),
      ),
    ),
  );
}
