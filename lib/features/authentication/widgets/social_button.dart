import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posta/utils/dimensions.dart';

class SocialButton extends StatelessWidget {
  final String title;
  final String asset;
  final VoidCallback action;

  const SocialButton({
    required this.title,
    required this.asset,
    required this.action,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      height: 50,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(25)),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: action,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(asset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: Dimensions.contentPadding,
            ),
            Text(
              title,
              style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
