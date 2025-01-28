import 'package:isentcare/modals/signup_modal.dart';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getGetApiSimple(String url);

  Future<dynamic> getPostApiResponse(String url, Map<String, dynamic> data);

  Future<dynamic> postApiResponse(String url, dynamic data);

  // Future<dynamic> putApiResponse(String url, dynamic data);
  Future<dynamic> deleteApiResponse(String url);

  Future<dynamic> patchApiResponse(String url, dynamic data);
  Future<dynamic> patchApi(String url);

  Future<dynamic> multiPartSignUp(String url, SingUpModal data);
  Future<dynamic> multiPartLicenseCreate(String url, dynamic data);

  // Future<dynamic> editProfileMultiPart(
  //   dynamic data,
  //   String url,
  // );
}
