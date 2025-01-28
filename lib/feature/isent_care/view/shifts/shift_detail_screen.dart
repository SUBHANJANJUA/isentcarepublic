import 'package:flutter/material.dart';
import 'package:isentcare/resources/constants/app_strings.dart';
import 'package:isentcare/widget/heading/text_field_heading.dart';

class ShiftDetailScreen extends StatelessWidget {
  const ShiftDetailScreen({
    super.key,
    required this.facility,
    required this.status,
    required this.date,
    required this.time,
    required this.price,
  });

  final String facility;
  final String status;
  final String date;
  final String time;
  final String price;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "${AppStrings.imagePath}logo.png",
          fit: BoxFit.contain,
          height: 60,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  spacing: 10,
                  children: [
                    ShiftDetailRow(
                      title: "Facality",
                      text: facility,
                    ),
                    ShiftDetailRow(
                      title: "Status",
                      text: status,
                    ),
                    ShiftDetailRow(
                      title: "Date",
                      text: date,
                    ),
                    ShiftDetailRow(
                      title: "Time",
                      text: time,
                    ),
                    ShiftDetailRow(
                      title: "Price",
                      text: price,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Card(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "${AppStrings.imagePath}map.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class ShiftDetailRow extends StatelessWidget {
  const ShiftDetailRow({
    super.key,
    required this.title,
    required this.text,
  });
  final String title;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextFieldHeading(text: title),
        Text(text),
      ],
    );
  }
}
