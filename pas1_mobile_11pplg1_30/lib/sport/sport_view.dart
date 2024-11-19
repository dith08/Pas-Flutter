import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pas1_mobile_11pplg1_30/sport/sport_controller.dart';
import 'package:pas1_mobile_11pplg1_30/sport/sport_model.dart';
import 'package:pas1_mobile_11pplg1_30/widget/reusable/teamlistitem.dart';

class TeamView extends StatelessWidget {
  final TeamController teamController = Get.put(TeamController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Team'),
      ),
      body: Obx(() {
        if (teamController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: teamController.teams.length,
          itemBuilder: (context, index) {
            return TeamListItem(team: teamController.teams[index]);
          },
        );
      }),
    );
  }
}
