class Team {
  final String? idTeam;
  final String? strTeam;
  final String? strBadge;
  final String? strStadium;
  final String? strDescriptionEN;

  Team({
    this.idTeam,
    this.strTeam,
    this.strBadge,
    this.strStadium,
    this.strDescriptionEN,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    String? processImageUrl(String? url) {
      if (url == null || url.isEmpty) return null;
      
      // Debug print
      print('Processing image URL: $url');
      
      // Pastikan URL menggunakan HTTPS
      if (url.startsWith('http://')) {
        return url.replaceFirst('http://', 'https://');
      }
      return url;
    }

    return Team(
      idTeam: json['idTeam']?.toString(),
      strTeam: json['strTeam']?.toString(),
      strBadge: processImageUrl(json['strBadge']?.toString()),
      strStadium: json['strStadium']?.toString(),
      strDescriptionEN: json['strDescriptionEN']?.toString(),
    );
  }
}