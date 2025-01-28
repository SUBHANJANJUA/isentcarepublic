import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isentcare/feature/auth/controller/citizenship_controller.dart';

class CitizenshipForm extends StatelessWidget {
  final CitizenshipController controller = Get.put(CitizenshipController());

  CitizenshipForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          spacing: 10,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(
                  value: 1,
                  groupValue: controller.selectedOption.value,
                  onChanged: (int? value) {
                    controller.updateSelectedOption(value!);
                  },
                ),
                const Text('A citizen of the United States'),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(
                  value: 2,
                  groupValue: controller.selectedOption.value,
                  onChanged: (int? value) {
                    controller.updateSelectedOption(value!);
                  },
                ),
                Expanded(
                    child: const Text(
                        'A noncitizen national of the United States')),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(
                  value: 3,
                  groupValue: controller.selectedOption.value,
                  onChanged: (int? value) {
                    controller.updateSelectedOption(value!);
                  },
                ),
                const Expanded(
                    flex: 2,
                    child: Text('A lawful permanent resident. USCIS A')),
                Expanded(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return controller.selectedOption.value == 3
                            ? 'Required field'
                            : null;
                      }
                      return null;
                    },
                    controller: controller.uscisController,
                    onChanged: (value) =>
                        controller.uscisController.text = value,
                    decoration: const InputDecoration(
                      filled: false,
                      isDense: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(
                  value: 4,
                  groupValue: controller.selectedOption.value,
                  onChanged: (int? value) {
                    controller.updateSelectedOption(value!);
                  },
                ),
                const Expanded(
                    flex: 3,
                    child: Text(
                        'A noncitizen authorized to work USCIS A/ Form I-9/')),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return controller.selectedOption.value == 4
                            ? 'Required field'
                            : null;
                      }
                      return null;
                    },
                    controller: controller.passportController,
                    onChanged: (value) =>
                        controller.passportController.text = value,
                    decoration: const InputDecoration(
                      filled: false,
                      isDense: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
