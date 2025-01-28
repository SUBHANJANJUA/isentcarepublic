import 'package:flutter/material.dart';
import 'package:isentcare/widget/container/earnings_card_container.dart';

import '../../../../widget/chart/earnings_line_chart.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Earnings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "My Earnings",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          const EarningCardContainer(),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Earnings",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "\$1.5M",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  EarningsLineChart(
                    earnings: [
                      12.5,
                      20.0,
                      15.0,
                      25.0,
                      30.0,
                      35.0,
                      28.0
                    ], // Monthly earnings in thousands
                    months: [
                      'Jan',
                      'Feb',
                      'Mar',
                      'Apr',
                      'May',
                      'Jun',
                      'Jul'
                    ], // Corresponding months
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}
