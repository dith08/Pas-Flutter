import 'package:get/get.dart';
import 'sport_service.dart';
import 'sport_model.dart';

class TeamController extends GetxController {
  final TeamService _teamService = TeamService();
  
  var teams = <Team>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    getTeams();
    super.onInit();
  }

  Future<void> getTeams() async {
    try {
      isLoading.value = true;
      error.value = '';
      final result = await _teamService.getEPLTeams();
      
      if (result.isEmpty) {
        error.value = 'Tidak ada data tim ditemukan';
      } else {
        teams.value = result;
      }
    } catch (e) {
      error.value = e.toString();
      print('Controller error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}