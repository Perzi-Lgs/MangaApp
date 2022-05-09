import 'package:flutter/material.dart';

class LogoButton extends StatelessWidget {
  const LogoButton({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Icon(
              icon,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}
