import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:posta/features/authentication/widgets/celevated_button.dart';
import 'package:posta/features/authentication/widgets/ctextfield.dart';
import 'package:posta/utils/constants.dart';
import 'package:posta/utils/dimensions.dart';

class ForgotPasswordScreen extends HookWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.contentPadding,
                ),
                child: Image.asset(
                  Constants.mailPath,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                "Enter your email and we will send you a password reset link",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              CTextField(
                hintText: 'Email',
                textInputType: TextInputType.text,
                controller: emailController,
              ),
              const SizedBox(
                height: Dimensions.contentPadding,
              ),
              CElevatedButton(
                title: 'Reset',
                action: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
