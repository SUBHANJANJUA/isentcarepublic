import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/auth/controller/dropdown_controller.dart';
import 'package:isentcare/resources/constants/app_sizer.dart';
import 'package:isentcare/resources/constants/color.dart';
import 'package:isentcare/resources/constants/sizes.dart';

class Dropdownfield extends StatefulWidget {
  final bool hasdropDownButton;
  final VoidCallback? onPressed;
  final String text;
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final List<String>? dropdownItems;
  final List<int>? dropdownItemsId;
  final ValueChanged<String?>? onChanged;

  Dropdownfield({
    super.key,
    required this.hasdropDownButton,
    this.onPressed,
    this.hintText,
    this.validator,
    required this.text,
    required this.controller,
    this.dropdownItems,
    this.dropdownItemsId,
    this.onChanged,
  });

  @override
  _DropdownfieldState createState() => _DropdownfieldState();
}

class _DropdownfieldState extends State<Dropdownfield> {
  String? localSelectedValue;
  final DropdownController dropdownController = Get.put(DropdownController());
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
                  _showDropdownMenu(
                    context,
                    widget.dropdownItems ?? [],
                    widget.dropdownItemsId ?? [],
                  );
                }
              : null,
          onChanged: widget.onChanged,
          controller: widget.controller,
          validator: widget.validator,
          readOnly: widget.hasdropDownButton,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: widget.hintText,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 10.0),
            suffixIcon: widget.hasdropDownButton
                ? IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: widget.hasdropDownButton
                        ? () {
                            _showDropdownMenu(
                              context,
                              widget.dropdownItems ?? [],
                              widget.dropdownItemsId ?? [],
                            );
                          }
                        : null,
                  )
                : null,
          ),
        ),
      ],
    );
  }

  void _showDropdownMenu(
      BuildContext context, List<String> items, List<int> indexes) {
    if (items.isEmpty || indexes.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Select an Option",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                const Divider(thickness: 1),
                SizedBox(
                  height: context.screenHeight * 0.8,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    separatorBuilder: (_, __) =>
                        const Divider(thickness: 0.5, color: Colors.grey),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final indexs = indexes[index];
                      final isSelected = localSelectedValue == item;

                      return ListTile(
                        leading: isSelected
                            ? const Icon(Icons.check, color: Colors.blue)
                            : null,
                        title: Text(
                          item,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            localSelectedValue = item;
                          });
                          dropdownController.setIndexvalue(indexs);

                          widget.controller.text = item;
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
