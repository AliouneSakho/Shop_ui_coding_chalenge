import 'package:flutter/foundation.dart' show immutable;

@immutable
class ExceptionMessages {
  static const String couldNotLogoForThisAuthType =
      'Could not find logo for this authType';
  static const String viewToRenderForThisAuthTypeNotFound =
      'View To Render for this authType not found';

  static const String couldNotSaveToFavorites =
      'Could not find save to favorites';
  static const String couldNotRemoveToFavorites =
      'Could not find remove to favorites';
  static const String couldNotSaveToYourCart =
      'Could not find save to your Cart';
  static const String couldNotRemoveToCart = 'Could not find remove to cart';

  const ExceptionMessages._();
}
