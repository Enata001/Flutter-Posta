import 'dart:developer' as devtools;

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

extension Auth on BuildContext {
  T monitor<T>(ProviderBase<T> provider) {
    return ProviderScope.containerOf(this, listen: false).read(provider);
  }
}
