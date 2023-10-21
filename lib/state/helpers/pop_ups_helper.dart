import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plants_ui/state/constantes/url_paths.dart';
import 'package:plants_ui/state/plant/enums/plant_filter.dart';
import 'package:plants_ui/state/plant/models/plant.dart';
import 'package:plants_ui/ui/screens/home/componants/filter_item.dart';
import 'package:plants_ui/ui/screens/validate_payement/validate_payement_screen.dart';

class PopUpsHandler {
  PopUpsHandler._sharedInstance();

  static final PopUpsHandler _shared = PopUpsHandler._sharedInstance();

  factory PopUpsHandler.instance() => _shared;

  ScaffoldMessengerState presentSnackbarErrror(
    BuildContext context, {
    required String errorText,
  }) {
    return ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          clipBehavior: Clip.none,
          duration: const Duration(seconds: 2),
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      errorText,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -68,
                left: -30,
                child: Image.asset(
                  UrlPaths.errorIllustration,
                  width: 75,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      );
  }

  ScaffoldMessengerState savedToCollectionToast(
    BuildContext context, {
    required String imageUrl,
    required String text,
  }) {
    return ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      );
  }

  OverlayEntry? _overlayEntry;

  void showProcessingOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.black.withAlpha(150),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 250,
              maxHeight: 450,
              minWidth: 250,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Lottie.asset(UrlPaths.lottieLoadingAnimation),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void hideProcessingOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Future showGenericBottomSheet(
    BuildContext context, {
    required Widget builder,
  }) {
    return showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 600, minHeight: 250),
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          constraints: const BoxConstraints(maxHeight: 500, minHeight: 250),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: builder,
        ),
      ),
    );
  }

  Future showFiltersBottomSheet(BuildContext context) {
    final theme = Theme.of(context);
    return showGenericBottomSheet(
      context,
      builder: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...PlantFilter.values.map(
            (plantFilter) => FilterItem(plantFilter: plantFilter),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {},
            child: Text(
              'Apply Filter',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future validatePaymentSheet(
    BuildContext context, {
    required Plant plant,
    required double totalPrice,
  }) {
    return showGenericBottomSheet(
      context,
      builder: ValidatePayementScreen(
        plant: plant,
        totalPrice: totalPrice,
      ),
    );
  }

  OverlayEntry? _toastOverlayEntry;

  void showToastgOverlay(BuildContext context) {
    _toastOverlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 250,
              maxHeight: 150,
              minWidth: 250,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).indicatorColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Added to cart',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_toastOverlayEntry!);
  }

  void hideToastOverlay() {
    _toastOverlayEntry?.remove();
    _toastOverlayEntry = null;
  }
}
