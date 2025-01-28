import 'dart:developer';

import 'package:get/get.dart';
import 'package:isentcare/modals/Calender_Model.dart';

import '../../../../network_data/response/api_response.dart';
import '../../../../repo/calender_rapo.dart';
import '../../../../resources/constants/app_strings.dart';

class CalenderController extends GetxController {
  var ownDate = DateTime.now().toIso8601String().split('T')[0].obs;
  void storeDate(String date) {
    ownDate.value = date;
    log(" Store date is here ${ownDate}");
  }

  final _myRepo = CalenderRepository();
  var CalenderDetails = ApiResponse<List<CalenderModel>>.loading().obs;
  // Method to set education details
  setCalenderDetails(ApiResponse<List<CalenderModel>> response) {
    CalenderDetails.value = response;
  }

  Future<void> fetchCalender() async {
    setCalenderDetails(ApiResponse.loading());
    try {
      var calender = await _myRepo.getCalender();
      if (calender != null && calender is List) {
        List<CalenderModel> educationList = calender
            .map((item) => CalenderModel.fromJson(
                item)) // Convert each map to EducationModel
            .toList();

        setCalenderDetails(ApiResponse.completed(educationList));
      } else {
        setCalenderDetails(ApiResponse.error(AppStrings.somethingWentWrong));
      }
    } catch (e) {
      log(e.toString());
      setCalenderDetails(ApiResponse.error(e.toString()));
    }
  }

  final List<Map<String, dynamic>> tesingList = [
    {
      "id": "45",
      "created_at": "2024-11-09T11:44:00.474617Z",
      "updated_at": "2024-11-09T11:44:00.474632Z",
      "start_date": "2025-01-09",
      "timing": "Evening",
      "profession": {"id": 22, "name": "RN"},
      "state": "Alabama",
      "bill_rate": 56.52,
      "facility": "Test Facility1",
      "facility_id": 1
    },
    {
      "id": "46",
      "created_at": "2024-11-09T11:44:00.474617Z",
      "updated_at": "2024-11-09T11:44:00.474632Z",
      "start_date": "2025-01-09",
      "timing": "Night",
      "profession": {"id": 23, "name": "RN"},
      "state": "Alabama",
      "bill_rate": 56.52,
      "facility": "Test Facility1",
      "facility_id": 1
    },
  ];

  final List<Map<String, dynamic>> timeList = [
    {
      "facility": "Test Facility1",
      "bill_rate": " 56.52",
      "timing": 'Evening',
      "start_date": '2025-01-09',
    },
    {
      "facility": "Test Facility2",
      "bill_rate": "56.52",
      "timing": 'Morning',
      "start_date": '2025-01-10',
    },
    {
      "facility": "Test Facility3",
      "bill_rate": "56.52",
      "timing": 'Night',
      "start_date": '2025-01-10',
    },
    {
      "facility": "Test Facility4",
      "bill_rate": "56.52",
      "timing": 'Evening',
      "start_date": '2025-01-12',
    },
  ];
}
