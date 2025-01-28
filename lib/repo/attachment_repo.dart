import 'dart:developer';
import 'package:isentcare/modals/attachment_modal.dart';
import 'package:isentcare/network_data/network/BaseApiServices.dart';
import 'package:isentcare/resources/constants/api_endpoints.dart';
import '../network_data/network/NetworkApiService.dart';

class AttachmentRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<List<AttachmentModel>> getAttachments() async {
    try {
      const String url = ApiEndPoints.attachments;
      log("Api url: $url");
      dynamic response = await _apiServices.getGetApiResponse(url);
      log("Api Response: $response");

      // Assuming the response is a list of attachment objects
      List<AttachmentModel> attachmentList = List<AttachmentModel>.from(
          response.map((item) => AttachmentModel.fromJson(item))
      );
      return attachmentList;
    } catch (e) {
      log("Error in Api: $e");
      rethrow;
    }
  }
}
