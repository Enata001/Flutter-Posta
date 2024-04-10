import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:posta/features/authentication/widgets/sign_in.dart';
import 'package:posta/features/authentication/widgets/sign_up.dart';
import 'package:posta/utils/dimensions.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSignIn = true;
    final isSignInProvider = StateProvider((ref) => isSignIn);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimensions.logoTopPadding,
                    bottom: Dimensions.logoBottomPadding,
                  ),
                  child: Image.asset(
                    'assets/images/posta_logo.png',
                    fit: BoxFit.contain,
                    scale: Dimensions.logoScaleSize,
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final isSignedIn = ref.watch(isSignInProvider);
                    return Column(
                      children: [
                        isSignedIn ? const SignIn() : const SignUp(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isSignedIn
                                  ? "Don't have an profile?"
                                  : 'Already have an profile?',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            TextButton(
                              onPressed: () {
                                ref.watch(isSignInProvider.notifier).state =
                                    isSignIn = !isSignIn;
                              },
                              child: Text(
                                isSignedIn ? "Sign Up" : 'Sign In',
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
