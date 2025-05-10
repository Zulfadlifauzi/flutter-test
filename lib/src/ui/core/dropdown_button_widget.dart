import 'package:flutter/material.dart';
import 'package:flutter_test_myeg/data/extension/string_extension.dart';

class DropdownButtonWidget extends StatelessWidget {
  final void Function(String)? customOnChanged;
  final List<DropdownMenuItem>? customItems;
  final String? customValue;
  const DropdownButtonWidget(
      {super.key, this.customOnChanged, this.customItems, this.customValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: DropdownButtonFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            dropdownColor: Colors.white,
            elevation: 1,
            value: customValue.toString().capitalize(),
            items: customItems,
            onChanged: (value) {
              customOnChanged!(value);
            }),
      ),
    );
  }
}
