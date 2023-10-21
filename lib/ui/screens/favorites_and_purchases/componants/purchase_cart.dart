import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plants_ui/state/helpers/pop_ups_helper.dart';
import 'package:plants_ui/state/plant/models/plant.dart';
import 'package:plants_ui/ui/screens/favorites_and_purchases/componants/minicard_product.dart';
import 'package:plants_ui/ui/screens/favorites_and_purchases/componants/update_quantity_button.dart';
import 'package:plants_ui/ui/screens/favorites_and_purchases/extensions/update.dart';

class PurchaseCard extends HookWidget {
  const PurchaseCard({
    super.key,
    required this.plant,
  });

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final quantity = useState(1);

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 6.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MiniCardProduct(
            plant: plant,
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Text(
                '  Total: \$${(plant.price * quantity.value).toStringAsFixed(2)}',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              UpdateQuantiyButton(
                quantity: quantity,
                icon: Icons.remove,
                upadate: UpadateType.remove,
              ),
              const SizedBox(width: 6),
              Text('${quantity.value}'),
              const SizedBox(width: 6),
              UpdateQuantiyButton(
                quantity: quantity,
                icon: Icons.add,
                upadate: UpadateType.add,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Remove',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  PopUpsHandler.instance().validatePaymentSheet(
                    context,
                    plant: plant,
                    totalPrice: plant.price * quantity.value,
                  );
                },
                child: Text(
                  'Validate',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.indicatorColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
