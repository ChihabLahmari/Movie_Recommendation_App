import 'package:movies_clean_architecture_mvvm/app/constants.dart';

extension NoNullString on String? {
  String orEmpty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

extension NoNullInt on int? {
  int orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}

extension NoNullDoubel on double? {
  double orZeroDouble() {
    if (this == null) {
      return Constants.zeroDouble;
    } else {
      return this!;
    }
  }
}
