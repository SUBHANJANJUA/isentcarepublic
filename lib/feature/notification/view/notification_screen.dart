import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/models/notifcation_viewController.dart';
import 'package:isentcare/network_data/response/status.dart';
import 'package:isentcare/resources/constants/app_strings.dart';
import 'package:isentcare/resources/helper_functions.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotifcationViewcontroller controller =
      Get.put(NotifcationViewcontroller());
  @override
  void initState() {
    controller.fetchNotificatons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notification'),
        ),
        body: Obx(() {
          final notification =
              controller.notificationsDetails.value.data?.results ?? [];
          final totalCount =
              controller.notificationsDetails.value.data?.count ?? 0;
          final hasMoreData = notification.length < totalCount &&
              controller.notificationsDetails.value.data?.next != null;
          if (controller.notificationsDetails.value.status == Status.LOADING) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (notification.isEmpty && !controller.isLoadingMore.value) {
            return const Center(
              child: Text('No Notification available'),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  itemCount: notification.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  itemBuilder: (context, index) {
                    final notifications = notification[index];
                    return NotificationCard(
                      text: notifications.message,
                      time: HelperUtil.timeAgo(notifications.createdAt),
                    );
                  },
                ),
                if (hasMoreData)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!controller.isLoadingMore.value) {
                            controller.fetchNotificatons(isLoadMore: true);
                          }
                        },
                        child: controller.isLoadingMore.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white))
                            : const Text('Load More'),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String text;
  final String time;

  const NotificationCard({
    required this.text,
    super.key,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
            children: [
              const CircleAvatar(
                backgroundImage:
                    AssetImage("${AppStrings.imagePath}profile.png"),
                radius: 28,
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

