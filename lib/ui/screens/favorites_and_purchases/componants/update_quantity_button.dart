import 'package:flutter/material.dart';
import 'package:plants_ui/ui/screens/favorites_and_purchases/extensions/update.dart';

class UpdateQuantiyButton extends StatelessWidget {
  const UpdateQuantiyButton({
    super.key,
    required this.quantity,
    required this.icon,
    required this.upadate,
  });

  final ValueNotifier<int> quantity;
  final IconData icon;
  final UpadateType upadate;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        switch (upadate) {
          case UpadateType.add:
            quantity.value++;
            break;
          case UpadateType.remove:
            if (quantity.value > 1) {
              quantity.value--;
            }
            break;
        }
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          const CircleBorder(),
        ),
      ),
      child: Icon(
        icon,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}
