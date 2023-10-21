import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:plants_ui/ui/screens/home/views/body_view.dart';
import 'package:plants_ui/ui/screens/home/views/header_view.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 7, right: 7, top: 20, bottom: 5),
      child: Column(
        children: [
          HeaderView(),
          SizedBox(height: 10),
          Expanded(child: BodyView()),
        ],
      ),
    );
  }
}
