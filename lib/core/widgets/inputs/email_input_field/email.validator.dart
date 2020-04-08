import 'dart:async';

import 'package:email_validator/email_validator.dart';

class ValidEmail extends EmailValidator {
  final StreamTransformer<String,String> validateEmail =
  StreamTransformer<String,String>.fromHandlers(handleData: (email, sink){
    if (!EmailValidator.validate(email) && email.isNotEmpty){
      sink.addError('');
    } else {
      sink.add(email);
    }
  });
}