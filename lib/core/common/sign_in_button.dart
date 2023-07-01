// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/pallete.dart';
import '../../features/auth/controller/auth_controller.dart';
import '../constants/constant.dart';

class SignInButton extends ConsumerWidget {
  final bool isFromLogin;
  const SignInButton({
    super.key,
    this.isFromLogin = true,
  });

  void signInwithGoogle(WidgetRef ref, BuildContext context) {
    ref
        .read(authControllerProvider.notifier)
        .signInWithGoogle(context, isFromLogin);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
        onPressed: () => signInwithGoogle(ref, context),
        icon: Image.asset(Constants.googlePath, width: 33),
        label: const Text(
          'Continue with Google',
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.greyColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
