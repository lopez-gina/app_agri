import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({super.key, required BuildContext context})
      : super(
            automaticallyImplyLeading: false, // Hides the back button
            title: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.black87,
              ),
              child: Text(
                'Agri App',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ));
}
