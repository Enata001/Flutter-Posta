import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:posta/features/authentication/widgets/celevated_button.dart';
import 'package:posta/features/authentication/widgets/ctextfield.dart';
import 'package:posta/features/authentication/widgets/social_button.dart';
import 'package:posta/utils/constants.dart';
import 'package:posta/utils/dimensions.dart';

class SignUp extends HookWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final emailController = useTextEditingController();
    final usernameController = useTextEditingController();
    bool isPasswordVisible = false;
    bool isConfirmPasswordVisible = false;
    var isVisibleProvider = StateProvider((ref) => isPasswordVisible);
    var isConfirmVisibleProvider =
        StateProvider((ref) => isConfirmPasswordVisible);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Sign Up here",
          style: Theme.of(context).textTheme.titleLarge,
        ),

        CTextField(
          hintText: 'Email',
          textInputType: TextInputType.text,
          controller: emailController,
        ),
        CTextField(
          hintText: 'Username',
          textInputType: TextInputType.text,
          controller: usernameController,
        ),
        Consumer(
          builder: (context, ref, child) {
            var isVisible = ref.watch(isVisibleProvider);
            return CTextField(
              hintText: 'Password',
              textInputType: TextInputType.text,
              isPassword: !isVisible,
              controller: passwordController,
              icon:
                  !isVisible ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
              action: () {
                ref.watch(isVisibleProvider.notifier).state =
                    isPasswordVisible = !isPasswordVisible;
              },
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            var isVisible = ref.watch(isConfirmVisibleProvider);
            return CTextField(
              hintText: 'Confirm Password',
              textInputType: TextInputType.text,
              isPassword: !isVisible,
              controller: confirmPasswordController,
              icon:
                  !isVisible ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
              action: () {
                ref.watch(isConfirmVisibleProvider.notifier).state =
                    isConfirmPasswordVisible = !isConfirmPasswordVisible;
              },
            );
          },
        ),
        const SizedBox(
          height: Dimensions.contentPadding,
        ),
        CElevatedButton(
          title: 'Sign Up',
          action: () {},
        ),
        const SizedBox(
          height: Dimensions.contentPadding,
        ),
        Padding(
          padding: const EdgeInsets.only(top: Dimensions.contentPadding),
          child: Text(
            'Or sign up with',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        const SizedBox(
          height: Dimensions.contentPadding,
        ),
        SocialButton(
            title: 'Sign Up with Google',
            asset: Constants.googleLogoPath,
            action: () {}),
        SocialButton(
            title: 'Sign Up with Facebook',
            asset: Constants.facebookLogoPath,
            action: () {}),
      ],
    );
  }
}
