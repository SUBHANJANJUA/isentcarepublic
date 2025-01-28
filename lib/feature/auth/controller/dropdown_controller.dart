import 'dart:developer';

import 'package:get/get.dart';
import 'package:isentcare/modals/education_modal.dart';
import 'package:isentcare/modals/emp_auth_model.dart';
import 'package:isentcare/modals/id_doc_model.dart';
import 'package:isentcare/modals/id_emp_Model.dart';
import 'package:isentcare/modals/professiona_modal.dart';

import 'package:isentcare/modals/state_modal.dart';
import 'package:isentcare/repo/dropdown_repo.dart';

class DropdownController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchStates();
  }

  RxString selectedValue = ''.obs;
  RxInt selectedCountryId = 0.obs;
  RxInt selectedIdEmpId = 0.obs;
  RxInt selectedEmpAuthId = 0.obs;
  RxInt selectedIdDocId = 0.obs;
  RxInt selectedProfessionId = 0.obs;
  RxInt selectedStateId = 0.obs;
  RxString selectedProfessionName = ''.obs;
  RxString selectedStateName = ''.obs;
  RxString selectedCountryName = ''.obs;
  RxString selectedIdEmpName = ''.obs;
  RxString selectedEmpAuthName = ''.obs;
  RxString selectedIdDocName = ''.obs;

  RxList<Country> countries = <Country>[].obs;
  RxList<IdEmpModel> idEmpList = <IdEmpModel>[].obs;
  RxList<EmpAuthModel> empAuthList = <EmpAuthModel>[].obs;
  RxList<IdDocModel> idDocList = <IdDocModel>[].obs;
  RxList<Result> states = <Result>[].obs;
  RxList<Profession> professions = <Profession>[].obs;

  final _myRepo = DropDownRepository();

  RxInt indexvalue = 0.obs;
  void setIndexvalue(int enterIndex) {
    indexvalue = enterIndex.obs;
  }

  Future<void> fetchStates() async {
    try {
      var response = await _myRepo.getStates();

      if (response != null && response['results'] != null) {
        states.value = (response['results'] as List)
            .map((item) => Result.fromJson(item))
            .toList();
        update();
      } else {
        log("response of rapo is null");
      }
    } catch (e) {
      log("show erorr for go to rapo state");
      log("Error fetching states: $e");
    }
  }

  void setSelectedState(Result state) {
    selectedStateId.value = state.id;
    selectedStateName.value = state.name;
    update();
    log("Updated State ID: ${selectedStateId.value}, Name: ${selectedStateName.value}");
  }

  Future<void> fetchProfessions() async {
    try {
      var response = await _myRepo.getProfessions();
      if (response != null && response['results'] != null) {
        professions.value = (response['results'] as List)
            .map((item) => Profession.fromJson(item))
            .toList();
        update();
        log("Data store in states ${Profession}");
      } else {
        log("response of rapo is null");
      }
    } catch (e) {
      log("Error fetching states: $e");
    }
  }

  void setSelectedProfession(Profession pro) {
    selectedProfessionId.value = pro.id;
    selectedProfessionName.value = pro.name;
    update();
    log("this is profession id log print for test");
    log("Updated Profession ID: ${selectedProfessionId.value}, Name: ${selectedProfessionName.value}");
  }

  Future<void> fetchCountry() async {
    try {
      var response = await _myRepo.getCountry();
      if (response != null && response['results'] != null) {
        countries.value = (response['results'] as List)
            .map((item) => Country.fromJson(item))
            .toList();
        update();
        log("Data store in states ${Country}");
      } else {
        log("response of rapo is null");
      }
    } catch (e) {
      log("Error fetching states: $e");
    }
  }

  void setSelectedCountry(Country country) {
    selectedCountryId.value = country.id;
    selectedCountryName.value = country.name;
    update();
    log("Updated Profession ID: ${selectedCountryId.value}, Name: ${selectedCountryName.value}");
  }

  Future<void> fetchIdEmpList() async {
    log("call to function");
    try {
      var response = await _myRepo.getIdEmpList();
      log("call to function: $response");
      response.forEach((item) {
        log(item['name']);
      });

      if (response != null && response is List) {
        idEmpList.value =
            response.map((item) => IdEmpModel.fromJson(item)).toList();
        update();
      } else {
        log("Response is null or not a list");
      }
    } catch (e) {
      log("show erorr for go to rapo IdEmp");
      log("Error fetching IdEmp: $e");
    }
  }

  Future<void> fetchEmpAuthList() async {
    log("call to function");
    try {
      var response = await _myRepo.getEmpAuthList();
      log("call to function: $response");
      response.forEach((item) {
        log(item['name']);
      });

      if (response != null && response is List) {
        empAuthList.value =
            response.map((item) => EmpAuthModel.fromJson(item)).toList();
        update();
      } else {
        log("Response is null or not a list");
      }
    } catch (e) {
      log("show erorr for go to rapo IdEmp");
      log("Error fetching IdEmp: $e");
    }
  }

  Future<void> fetchIdDocList() async {
    log("call to function");
    try {
      var response = await _myRepo.getIdDocList();
      log("call to function: $response");
      response.forEach((item) {
        log(item['name']);
      });

      if (response != null && response is List) {
        idDocList.value =
            response.map((item) => IdDocModel.fromJson(item)).toList();
        update();
      } else {
        log("Response is null or not a list");
      }
    } catch (e) {
      log("show erorr for go to rapo IdEmp");
      log("Error fetching IdEmp: $e");
    }
  }

  RxList<String> identity = [
    "Identity/Employment",
    "Employment Authorization",
    "Identity Document"
  ].obs;
}
