import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:isentcare/models/signature_controller.dart';
import 'package:isentcare/resources/utils.dart';
import 'package:signature/signature.dart';

class SignaturePad extends StatefulWidget {
  final double width;
  final double height;
  final Color penColor;
  final Color backgroundColor;
  const SignaturePad({
    super.key,
    this.width = 300,
    this.height = 300,
    this.penColor = Colors.red,
    this.backgroundColor = Colors.lightBlueAccent,
  });
  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final signeController = Get.put(SignController());

  String? _signatureBase64;
  @override
  void initState() {
    super.initState();
    signeController.signatureController = SignatureController(
      penStrokeWidth: 5,
      penColor: widget.penColor,
      exportBackgroundColor: widget.backgroundColor,
    );
  }

  @override
  void dispose() {
    signeController.signatureController.dispose();
    super.dispose();
  }

  void clearCanvas() {
    signeController.signatureController.clear();
    signeController.signatureTextController.text.isEmpty;
  }

  Future<Uint8List?> exportAsImage() async {
    return await signeController.signatureController.toPngBytes();
  }

  bool get isCanvasEmpty => signeController.signatureController.isEmpty;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Signature(
            controller: signeController.signatureController,
            width: widget.width,
            height: widget.height,
            backgroundColor: widget.backgroundColor,
          ),
        ),
        const SizedBox(height: 10),
        // if (_signatureBase64 != null)
        //   Padding(
        //     padding: const EdgeInsets.only(top: 20),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         const Text("Base64 Encoded Signature:"),
        //         SelectableText(
        //           _signatureBase64!,
        //           style: const TextStyle(fontSize: 12, color: Colors.black),
        //         ),
        //       ],
        //     ),
        //   ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 20))),
              onPressed: clearCanvas,
              child: const Text("Clear"),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(Color.fromRGBO(117, 117, 117, 1)),
                padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 20)),
              ),
              onPressed: () async {
                await signeController
                    .saveSignature(signeController.signatureController);
                if (signeController.signatureBase64.value != null) {
                  Get.back();
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ],
    );
  }
}
