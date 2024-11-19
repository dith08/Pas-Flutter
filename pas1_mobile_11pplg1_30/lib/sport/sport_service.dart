import 'dart:convert';
import 'package:http/http.dart' as http;
import 'sport_model.dart';

class TeamService {
  static const String _baseUrl = 'https://www.thesportsdb.com/api/v1/json/3';

  Future<List<Team>> getEPLTeams() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/search_all_teams.php?l=English%20Premier%20League'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        print('Raw API Response: ${response.body}');
        
        if (data['teams'] == null) {
          return [];
        }

        final teamsList = data['teams'] as List;
        return teamsList.map((team) {
          print('Team Name: ${team['strTeam']}');
          print('Team Badge URL: ${team['strTeamBadge']}');
          return Team.fromJson(team);
        }).toList();
      } else {
        throw Exception('Gagal mengambil data tim: ${response.statusCode}');
      }
    } catch (e) {
      print('Error detail: $e');
      throw Exception('Gagal memuat tim: $e');
    }
  }
}