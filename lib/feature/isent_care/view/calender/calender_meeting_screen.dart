import 'package:flutter/material.dart';
import 'package:isentcare/resources/constants/color.dart';

class ScheduleMeetingScreen extends StatelessWidget {
  const ScheduleMeetingScreen({
    super.key,
    this.title = "",
    this.selectTime = "",
    this.date = "",
    required this.time,
    this.color,
    this.danger = false,
    this.participants = const [],
  });
  final String? title;
  final String? selectTime;
  final String? date;
  final String time;
  final Color? color;
  final bool? danger;
  final List<Map<String, dynamic>>? participants;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Schedule Meeting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: date == ""
            ? Center(
                child: Text("Not found"),
              )
            : title == ""
                ? Center(
                    child: Text("Not found"),
                  )
                : Column(
                    children: [
                      Heading2Blue20(text: title ?? "Not fount"),
                      Heading2Blue20(
                        text: selectTime ?? "not fount",
                        size: 12,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: participants?.length,
                            itemBuilder: (context, index) {
                              final callback = participants![index];
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  child: ClipOval(
                                      child: Image.asset(callback["dp"])),
                                ),
                                title: HeadingBlack20(text: callback["name"]),
                                subtitle:
                                    TextBlack16(text: "id: ${callback["id"]}"),
                              );
                            }),
                      ),
                    ],
                  ),
      ),
    ));
  }
}

class Heading2Blue20 extends StatelessWidget {
  const Heading2Blue20({
    super.key,
    required this.text,
    this.size = 20,
    this.weight = FontWeight.w600,
  });
  final String text;
  final double? size;
  final FontWeight? weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size, fontWeight: weight, color: AppColors.primary),
    );
  }
}

class TextBlack16 extends StatelessWidget {
  const TextBlack16({
    super.key,
    required this.text,
    this.size = 16,
    this.weight = FontWeight.w400,
  });
  final String text;
  final double? size;
  final FontWeight? weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: Colors.black,
      ),
    );
  }
}

class HeadingBlack20 extends StatelessWidget {
  const HeadingBlack20({
    super.key,
    required this.text,
    this.size = 20,
    this.weight = FontWeight.w500,
  });
  final String text;
  final double? size;
  final FontWeight? weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: Colors.black,
      ),
    );
  }
}
