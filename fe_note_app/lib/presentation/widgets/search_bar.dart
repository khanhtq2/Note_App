import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const CustomSearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Container(
        width: width > 800 ? 600 : double.infinity,

        padding: EdgeInsets.symmetric(
          horizontal: width < 600 ? 16 : 24,
          vertical: 8,
        ),

        child: TextField(
          onChanged: onSearch,

          style: TextStyle(
            fontSize: width < 600 ? 16 : 15,
            color: isDark ? Colors.white : Colors.black,
          ),

          decoration: InputDecoration(
            hintText: 'Search notes...',

            hintStyle: TextStyle(
              color: isDark ? Colors.white70 : Colors.black54,
            ),

            prefixIcon: Icon(
              Icons.search,
              size: width < 600 ? 24 : 22,
              color: isDark ? Colors.white70 : Colors.black54,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),

            filled: true,

            fillColor: isDark ? Colors.grey[800] : Colors.grey.shade200,

            contentPadding: EdgeInsets.symmetric(
              vertical: width < 600 ? 14 : 12,
            ),
          ),
        ),
      ),
    );
  }
}
