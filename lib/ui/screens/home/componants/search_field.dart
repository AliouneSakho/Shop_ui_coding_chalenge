import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/helpers/pop_ups_helper.dart';
import 'package:plants_ui/ui/screens/home/componants/suggestion_box.dart';

final searchInputProvider = StateProvider<String?>((_) {
  return;
});

class SearchField extends StatefulHookConsumerWidget {
  const SearchField({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField> {
  OverlayEntry? entry;
  final filterWidth = 40.0;
  final paddingValue = 8.0;

  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: offset.dy + size.height,
          left: offset.dx + 8,
          width: size.width - filterWidth - (paddingValue * 2) - 4,
          child: const SuggestionBoxWidget(),
        );
      },
    );
    overlay.insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  @override
  void dispose() {
    hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final controllerListener = useListenable(controller);
    // final focusNode = useFocusNode();
    // final focusNodeListener = useListenable(focusNode);

    useEffect(
      () {
        controllerListener.addListener(() {
          ref
              .read(searchInputProvider.notifier)
              .update((state) => controller.text);

          if (controller.text.isNotEmpty) {
            if (entry == null) {
              showOverlay();
            } else {
              hideOverlay();
              showOverlay();
            }
          }
          if (controller.text.isEmpty) {
            hideOverlay();
          }
        });

        return null;
      },
      [
        controller,
        // focusNode,
      ],
    );

    return Padding(
      padding: EdgeInsets.all(paddingValue),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextField(
                // focusNode: focusNode,
                controller: controller,
                maxLines: 1,

                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: controllerListener.text.isNotEmpty
                      ? IconButton(
                          onPressed: () => controller.clear(),
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Search product',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            splashColor: Theme.of(context).colorScheme.primary,
            onTap: () =>
                PopUpsHandler.instance().showFiltersBottomSheet(context),
            child: Ink(
              height: 50,
              width: filterWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: const Icon(Icons.tune),
            ),
          )
        ],
      ),
    );
  }
}
