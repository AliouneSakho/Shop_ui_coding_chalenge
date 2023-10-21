import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/ui/screens/favorites_and_purchases/enums/views.dart';
import 'package:plants_ui/ui/screens/favorites_and_purchases/extensions/tabextension_on_views.dart';
import 'package:plants_ui/ui/screens/favorites_and_purchases/extensions/vewtorenderextension_on_views.dart';

class FavoritesAndPurchasesScreen extends HookConsumerWidget {
  const FavoritesAndPurchasesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const viewsValue = Views.values;
    final tabController = useTabController(initialLength: viewsValue.length);
    final tabControllerListener = useListenable(tabController);
    final selectedView = useState(viewsValue.first);
    final borderRadius = BorderRadius.circular(30);
    final indicatorColor = Theme.of(context).indicatorColor;

    useEffect(
      () {
        tabControllerListener.addListener(() {
          selectedView.value = viewsValue
              .where(
                (element) => element.index == tabController.index,
              )
              .first;
        });
        return null;
      },
      [tabController],
    );

    return DefaultTabController(
      length: viewsValue.length,
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
              tabs: viewsValue
                  .map(
                    (view) => view.tab(
                      context,
                      indicatorColor: indicatorColor,
                      isSelected: selectedView.value == view,
                      borderRadius: borderRadius,
                    ),
                  )
                  .toList(),
              indicator: BoxDecoration(
                borderRadius: borderRadius,
                color: indicatorColor,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: viewsValue.map((view) => view.viewToRender).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
