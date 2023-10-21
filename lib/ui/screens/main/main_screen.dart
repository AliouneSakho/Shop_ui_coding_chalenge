import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:plants_ui/ui/screens/favorites_and_purchases/favorites_and_purchases_screen.dart';
import 'package:plants_ui/ui/screens/home/home_screen.dart';
import 'package:plants_ui/ui/screens/main/componants/navigation_bar.dart';
import 'package:plants_ui/ui/screens/user/user_screen.dart';

class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const initIndex = 1;
    final selectedItem = useState(initIndex);

    final items = <IconData>[
      Icons.person,
      Icons.home,
      Icons.shopping_cart,
    ];

    final screens = <Widget>[
      const UserScreen(),
      const HomeScreen(),
      const FavoritesAndPurchasesScreen(),
    ];

    return SafeArea(
      child: Material(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).indicatorColor, width: 3),
        ),
        child: Scaffold(
          body: screens[selectedItem.value],
          bottomNavigationBar: PlantNavigationBar(
            icons: items,
            initialIndex: initIndex,
            onTap: (value) => selectedItem.value = value,
          ),
        ),
      ),
    );
  }
}
 // useEffect(() {
    //   items.map((item) => item.color.)
    //   return null;
    // }, [selectedItem]);