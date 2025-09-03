import 'package:flutter/material.dart';

class DetailsColumn extends StatelessWidget {
  final double value;
  final String unity;
  final String image;
  final String name;

  const DetailsColumn({
    super.key,
    required this.name,
    required this.value,
    required this.unity,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 25, height: 25, child: Image.asset(image)),
        Text(
          "${name == "Humidity" ? value.toStringAsFixed(0) : value.toStringAsFixed(1)} $unity",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        Text(
          name,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ],
    );
  }
}
