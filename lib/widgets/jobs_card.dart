import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:isentcare/modals/permanentjobs_modal.dart';
import 'package:isentcare/models/permanentjobs_viewController.dart';
import 'package:isentcare/widget/container/text_container.dart';
import 'package:isentcare/widget/dialog/confirmation_dialog.dart';
import '../../../../resources/constants/app_strings.dart';

class JobCard extends StatelessWidget {
  final Result job;

  JobCard({super.key, required this.job});
  final PermanentJobsController controller = Get.put(PermanentJobsController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextContainer(
                    containerColor: const Color.fromRGBO(227, 242, 253, 1),
                    text: job.speciality.name,
                  ),
                  TextContainer(
                    containerColor: const Color.fromRGBO(227, 242, 253, 1),
                    text: job.fixTime
                        ? 'Fix Term'
                        : job.traAssign
                            ? 'TRA Assign'
                            : job.perPlace
                                ? 'Per Place'
                                : 'No Status Available',
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                job.profession!.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SvgPicture.asset(
                    "${AppStrings.imagePath}LocationIcon.svg",
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    job.state,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmationDialog(
                        onTap: () {
                          final jobData = {
                            "job": job.id,
                          };
                          controller.permanentJob(jobData, context);
                        },
                        dilogdescription: "Are you sure to apply for this job?",
                      ),
                    );
                  },
                  child: const Text("Apply"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
