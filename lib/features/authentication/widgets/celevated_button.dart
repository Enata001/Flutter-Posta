import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CElevatedButton extends StatelessWidget {
  const CElevatedButton({
    super.key,
    required this.action,
    required this.title,
  });

  final VoidCallback action;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          onPressed: action,
          child: Text(
            title,
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
