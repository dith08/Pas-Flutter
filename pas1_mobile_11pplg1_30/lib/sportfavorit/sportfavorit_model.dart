class FavoriteTeam {
  final int idTeam;
  final String strTeam;
  final String strTeamBadge;
  final String strStadium;
  final String strDescriptionEN;
  final String imageUrl;

  FavoriteTeam({
    required this.idTeam,
    required this.strTeam,
    required this.strTeamBadge,
    required this.strStadium,
    required this.strDescriptionEN,
    required this.imageUrl,
  });

  factory FavoriteTeam.fromJson(Map<String, dynamic> json) {
    return FavoriteTeam(
      idTeam: json['idTeam'] as int,
      strTeam: json['strTeam'] as String,
      strTeamBadge: json['strTeamBadge'] as String,
      strStadium: json['strStadium'] as String,
      strDescriptionEN: json['strDescriptionEN'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idTeam': idTeam,
      'strTeam': strTeam,
      'strTeamBadge': strTeamBadge,
      'strStadium': strStadium,
      'strDescriptionEN': strDescriptionEN,
      'imageUrl': imageUrl,
    };
  }
} 