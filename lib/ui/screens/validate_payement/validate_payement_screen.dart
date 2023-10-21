import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plants_ui/state/constantes/url_paths.dart';
import 'package:plants_ui/state/plant/models/plant.dart';
import 'package:plants_ui/ui/screens/validate_payement/enums/payement_methode.dart';

/// I WAS IN A RUSH BECAUSE I THOUGH THAT THE DATE LIMITE WAS 29/10, SO DIDN'T HAD ENOUGH TIME TO REORDER

class ValidatePayementScreen extends HookWidget {
  const ValidatePayementScreen({
    Key? key,
    required this.plant,
    required this.totalPrice,
  }) : super(key: key);
  final Plant plant;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    final borderRdius = BorderRadius.circular(12.0);

    final selectedCard = useState(PayementMethod.mastercard);

    return SingleChildScrollView(
      reverse: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline,
                color: Colors.blue,
              ),
              const SizedBox(width: 5),
              Text(
                'This Page is just for demonstration purpose \n'
                'you don\'t have to fullfill any credentials.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                plant.imageUrls.first,
                height: 40,
                width: 40,
              ),
              Text(
                plant.plantName,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Card Number',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      hintText: '**** **** **** ****',
                      borderRdius: borderRdius,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  PayementMethodSelector(
                    borderRdius: borderRdius,
                    payementMethod: PayementMethod.mastercard,
                    method: selectedCard,
                  ),
                  const SizedBox(width: 10),
                  PayementMethodSelector(
                    borderRdius: borderRdius,
                    payementMethod: PayementMethod.visa,
                    method: selectedCard,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Holder Name',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                borderRdius: borderRdius,
                hintText: 'Name on Card',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Expiration date',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        TextFieldWidget(
                          borderRdius: borderRdius,
                          hintText: 'Month',
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFieldWidget(
                      hintText: 'Year',
                      borderRdius: borderRdius,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CVV',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        TextFieldWidget(
                          borderRdius: borderRdius,
                          keyboardType: TextInputType.number,
                          hintText: '* * * *',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Validate: \$${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.borderRdius,
    required this.keyboardType,
  });

  final BorderRadius borderRdius;
  final String hintText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRdius,
        ),
      ),
    );
  }
}

class PayementMethodSelector extends StatelessWidget {
  const PayementMethodSelector({
    super.key,
    required this.borderRdius,
    required this.payementMethod,
    required this.method,
  });

  final BorderRadius borderRdius;
  final PayementMethod payementMethod;
  final ValueNotifier<PayementMethod> method;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => method.value = payementMethod,
      child: Container(
        height: 60,
        width: 60,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: borderRdius,
          color: Colors.white,
          border: Border.all(
            width: 2.0,
            color: payementMethod == method.value
                ? Theme.of(context).indicatorColor
                : Colors.white,
          ),
        ),
        child: Image.asset(
          payementMethod == PayementMethod.mastercard
              ? UrlPaths.mastercard
              : UrlPaths.visa,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
