import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';

class MultiSelectionDropdownField extends StatefulWidget {
  final bool hasdropDownButton;
  final VoidCallback? onPressed;
  final String text;
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final List<String>? dropdownItems;
  final ValueChanged<Set<String>>? onChanged; // Accept multiple values

  const MultiSelectionDropdownField({
    super.key,
    required this.hasdropDownButton,
    this.onPressed,
    this.hintText,
    this.validator,
    required this.text,
    required this.controller,
    this.dropdownItems,
    this.onChanged,
  });

  @override
  _MultiSelectionDropdownFieldState createState() =>
      _MultiSelectionDropdownFieldState();
}

class _MultiSelectionDropdownFieldState
    extends State<MultiSelectionDropdownField> {
  Set<String> selectedValues = {}; // Track selected items locally

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: context.screenHeight * 0.005,
        ),
        TextFormField(
          onTap: widget.hasdropDownButton
              ? () {
                  _showMultiSelectDropdown(
                    context,
                    widget.dropdownItems ?? [],
                  );
                }
              : null,
          controller: widget.controller,
          validator: widget.validator,
          readOnly: true, // Always read-only for dropdown
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: widget.hintText,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 10.0),
            suffixIcon: widget.hasdropDownButton
                ? IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: () {
                      _showMultiSelectDropdown(
                        context,
                        widget.dropdownItems ?? [],
                      );
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }

  void _showMultiSelectDropdown(BuildContext context, List<String> items) {
    if (items.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight:
                      MediaQuery.of(context).size.height * 0.8, // Limit height
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Select Options",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    const Divider(thickness: 1),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: items.length,
                        separatorBuilder: (_, __) =>
                            const Divider(thickness: 0.5, color: Colors.grey),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final isSelected = selectedValues.contains(item);
                          return CheckboxListTile(
                            value: isSelected,
                            title: Text(item),
                            onChanged: (bool? checked) {
                              setDialogState(() {
                                if (checked == true) {
                                  selectedValues.add(item);
                                } else {
                                  selectedValues.remove(item);
                                }
                                setState(() {
                                  widget.controller.text =
                                      selectedValues.join(', ');
                                });
                                widget.onChanged?.call(selectedValues);
                              });
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("Done"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
