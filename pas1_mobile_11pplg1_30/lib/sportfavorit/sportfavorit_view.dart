import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_30/sport/sport_model.dart';
import 'package:pas1_mobile_11pplg1_30/sportfavorit/databasehelper.dart';
import 'package:pas1_mobile_11pplg1_30/sportfavorit/sportfavorit_model.dart';
import 'package:pas1_mobile_11pplg1_30/widget/reusable/teamlistitem.dart';

class FavoriteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tim Favorit Saya', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<FavoriteTeam>>(
        future: DatabaseHelper.instance.getAllFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Belum ada tim favorit'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final favoriteTeam = snapshot.data![index];
              return Dismissible(
                key: Key(favoriteTeam.idTeam.toString()),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) async {
                  await DatabaseHelper.instance.removeFavorite(favoriteTeam.idTeam);
                  Get.snackbar('Sukses', 'Tim telah dihapus dari favorit');
                },
                child: TeamListItem(
                  team: Team(
                    idTeam: favoriteTeam.idTeam.toString(),
                    strTeam: favoriteTeam.strTeam,
                    strBadge: favoriteTeam.strTeamBadge,
                    strStadium: favoriteTeam.strStadium,
                    strDescriptionEN: favoriteTeam.strDescriptionEN,
                  ),
                  onDelete: () {
                    Get.forceAppUpdate();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}