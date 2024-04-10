import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:posta/features/authentication/widgets/celevated_button.dart';
import 'package:posta/features/authentication/widgets/ctextfield.dart';
import 'package:posta/features/authentication/widgets/social_button.dart';
import 'package:posta/utils/Navigation.dart';
import 'package:posta/utils/constants.dart';
import 'package:posta/utils/dimensions.dart';

class SignIn extends HookWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordController = useTextEditingController();
    final emailController = useTextEditingController();
    bool value = false;
    var isVisibleProvider = StateProvider((ref) => value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Hello, welcome back!",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: Dimensions.contentPadding,
        ),
        Text(
          'Log in to continue',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: Dimensions.contentPadding,
        ),
        CTextField(
          hintText: 'Email',
          textInputType: TextInputType.text,
          controller: emailController,
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
                ref.watch(isVisibleProvider.notifier).state = value = !value;
              },
            );
          },
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            onPressed: () {
              context.pushNamed(
                Navigation.forgotPassword,
              );
            },
            child: const Text(
              "Forgot your password?",
            ),
          ),
        ),
        CElevatedButton(
          title: 'Sign In',
          action: () {
            context.pushNamed(Navigation.entry);
          },
        ),
        const SizedBox(
          height: Dimensions.contentPadding,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimensions.contentPadding,
          ),
          child: Text(
            'Or sign in with',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        const SizedBox(
          height: Dimensions.contentPadding,
        ),
        SocialButton(
          title: 'Sign In with Google',
          asset: Constants.googleLogoPath,
          action: () {},
        ),
        SocialButton(
          title: 'Sign In with Facebook',
          asset: Constants.facebookLogoPath,
          action: () {},
        ),
      ],
    );
  }
}
