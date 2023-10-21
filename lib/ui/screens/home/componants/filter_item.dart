import 'package:flutter/material.dart';
import 'package:plants_ui/state/plant/enums/plant_filter.dart';
import 'package:plants_ui/state/plant/extensions/plantfiltericonextension_on_plantfilter.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plants_ui/state/plant/typedefs/pot_type.dart';

class FilterItem extends HookWidget {
  final PlantFilter plantFilter;

  const FilterItem({
    Key? key,
    required this.plantFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        plantFilter == PlantFilter.pot
            ? PotFilterOptions(
                plantFilter: plantFilter,
              )
            : NormaFilterItem(plantFilter: plantFilter),
      ],
    );
  }
}

class PotFilterOptions extends HookWidget {
  const PotFilterOptions({
    super.key,
    required this.plantFilter,
  });

  final PlantFilter plantFilter;

  @override
  Widget build(BuildContext context) {
    final List<PotType> potTypes =
        PotType.values.map((poType) => poType).toList();
    final selectedOption = useState(potTypes.first);

    return ExpansionPanelList.radio(
      expandedHeaderPadding: EdgeInsets.zero,
      elevation: 0,
      children: [
        ExpansionPanelRadio(
          canTapOnHeader: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          value: plantFilter,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: -3,
              title: Text(
                plantFilter.name,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              leading: Image.asset(
                plantFilter.iconPath,
                height: 25,
              ),
            );
          },
          body: Column(
            children: potTypes.map<Widget>((potType) {
              return RadioListTile<PotType>(
                title: Text(
                  potType.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                value: potType,
                groupValue: selectedOption.value,
                onChanged: (PotType? value) {
                  selectedOption.value = value!;
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class NormaFilterItem extends StatelessWidget {
  final PlantFilter plantFilter;
  const NormaFilterItem({
    super.key,
    required this.plantFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(
            plantFilter.iconPath,
            height: 25,
          ),
          const SizedBox(width: 10),
          Text(
            plantFilter.name,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
