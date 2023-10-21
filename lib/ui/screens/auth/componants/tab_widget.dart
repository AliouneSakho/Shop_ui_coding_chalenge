import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plants_ui/state/auth/enums/auth_type.dart';
import 'package:plants_ui/state/auth/extensions/authtypelogoextension_on_authtype.dart';
import 'package:plants_ui/state/auth/extensions/authtypeviewtorenderextention_on_authtype.dart';
import 'package:plants_ui/state/auth/providers/auth_type_provider.dart';

class TabWidget extends HookConsumerWidget {
  const TabWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabsToRender = AuthType.values.where(
      (element) => element != AuthType.guest,
    );

    final tabs = tabsToRender
        .map(
          (authType) => tab(authType: authType),
        )
        .toList();

    final tabViews = tabsToRender.map((e) => e.viewToRender).toList();
    final tabController = useTabController(initialLength: tabsToRender.length);
    final tabControllerListener = useListenable(tabController);

    useEffect(
      () {
        tabControllerListener.addListener(
          () {
            switch (tabControllerListener.index) {
              case 0:
                ref.read(authTypeProvider.notifier).state =
                    AuthType.mailAndPassword;
                break;
              case 1:
                ref.read(authTypeProvider.notifier).state = AuthType.google;
                break;
              default:
                throw Exception();
            }
          },
        );
        return null;
      },
      [tabController],
    );

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: tabController,
            tabs: tabs,
            dividerColor: Colors.amberAccent,
            indicatorColor: Theme.of(context).indicatorColor,
            indicatorWeight: 4.0,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          ),
          Flexible(
            child: TabBarView(
              controller: tabController,
              children: tabViews,
            ),
          ),
        ],
      ),
    );
  }
}

Widget tab({
  required AuthType authType,
}) {
  return Tab(
    icon: Image.asset(authType.logoPath),
  );
}
