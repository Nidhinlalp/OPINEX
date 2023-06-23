import 'dart:developer';

import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String error;
  const ErrorText({
    Key? key,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(error.toString());
    return Center(
      child: Text(error),
    );
  }
}
