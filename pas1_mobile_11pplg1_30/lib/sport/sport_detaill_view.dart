import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sport_model.dart';

class TeamDetailView extends StatelessWidget {
  final Team team;

  const TeamDetailView({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(team.strTeam ?? 'Detail Tim'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan gambar tim
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[200],
              child: team.strBadge != null
                  ? Image.network(
                      team.strBadge!,
                      fit: BoxFit.contain,
                    )
                  : Icon(Icons.sports_soccer, size: 100),
            ),
            
            // Informasi tim
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Tim
                  Text(
                    team.strTeam ?? 'Nama Tim Tidak Tersedia',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  
                  // Stadion
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.stadium),
                      title: Text('Stadion'),
                      subtitle: Text(team.strStadium ?? 'Tidak tersedia'),
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Deskripsi
                  Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    team.strDescriptionEN ?? 'Deskripsi tidak tersedia',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}