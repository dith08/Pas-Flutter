import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_30/sportfavorit/databasehelper.dart';
import 'package:pas1_mobile_11pplg1_30/sportfavorit/sportfavorit_model.dart';
import 'package:pas1_mobile_11pplg1_30/sport/sport_model.dart';
import 'package:pas1_mobile_11pplg1_30/sport/sport_service.dart';
import 'package:pas1_mobile_11pplg1_30/sport/sport_controller.dart';
import 'package:pas1_mobile_11pplg1_30/sport/sport_detaill_view.dart';

class TeamListItem extends StatelessWidget {
  final Team team;
  final bool showBookmark;
  final VoidCallback? onDelete;

  const TeamListItem({
    Key? key,
    required this.team,
    this.showBookmark = true,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Get.to(() => TeamDetailView(team: team));
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: team.strBadge != null && team.strBadge!.isNotEmpty
                      ? Image.network(
                          team.strBadge!,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading image: $error');
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline, color: Colors.red),
                                  SizedBox(height: 4),
                                  Text(
                                    'Gagal memuat logo',
                                    style: TextStyle(fontSize: 10),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            team.strTeam?.substring(0, 1) ?? '?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      team.strTeam ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      team.strStadium ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              if (showBookmark) 
                FavoriteButton(team: team, onDelete: onDelete),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  final Team team;
  final VoidCallback? onDelete;

  const FavoriteButton({
    Key? key, 
    required this.team,
    this.onDelete,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final status = await DatabaseHelper.instance.isFavorite(int.parse(widget.team.idTeam ?? '0'));
    setState(() {
      isFavorite = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () async {
        try {
          if (isFavorite) {
            await DatabaseHelper.instance.removeFavorite(int.parse(widget.team.idTeam ?? '0'));
            Get.snackbar(
              'Berhasil',
              'Tim ${widget.team.strTeam} berhasil dihapus dari favorit',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red[100],
              colorText: Colors.red[900],
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(10),
              borderRadius: 10,
              icon: Icon(Icons.delete, color: Colors.red[900]),
            );
            widget.onDelete?.call();
          } else {
            final favoriteTeam = FavoriteTeam(
              idTeam: int.parse(widget.team.idTeam ?? '0'),
              strTeam: widget.team.strTeam ?? '',
              strTeamBadge: widget.team.strBadge ?? '',
              strStadium: widget.team.strStadium ?? '',
              strDescriptionEN: widget.team.strDescriptionEN ?? '',
              imageUrl: widget.team.strBadge ?? '',
            );
            await DatabaseHelper.instance.addFavorite(favoriteTeam);
            Get.snackbar(
              'Berhasil',
              'Tim ${widget.team.strTeam} berhasil ditambahkan ke favorit',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.blue[100],
              colorText: Colors.blue[900],
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(10),
              borderRadius: 10,
              icon: Icon(Icons.favorite, color: Colors.blue[900]),
            );
          }
          setState(() {
            isFavorite = !isFavorite;
          });
        } catch (e) {
          Get.snackbar(
            'Error',
            'Terjadi kesalahan: $e',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[100],
            colorText: Colors.red[900],
            duration: Duration(seconds: 3),
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.error_outline, color: Colors.red[900]),
          );
        }
      },
    );
  }
}