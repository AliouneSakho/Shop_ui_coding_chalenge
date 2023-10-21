import 'package:flutter/material.dart' show GlobalKey, FormState;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MailAndPasswordAuthenticationValidatorNotifier
    extends StateNotifier<bool> {
  final GlobalKey<FormState>? formState;
  MailAndPasswordAuthenticationValidatorNotifier(this.formState) : super(true);

  void validateForm() {
    if (formState!.currentState!.validate()) {
      state = true;
    } else {
      state = false;
    }
  }
}
