class Team {
  final int id;
  final String name;
  final String country;
  final String stadium;
  final String coach;
  final String league;
  final List<int> players; // IDs de jugadores
  final List<String> titles; // Títulos ganados
  final int foundationYear; // Año de fundación (nueva propiedad)

  Team({
    required this.id,
    required this.name,
    required this.country,
    required this.stadium,
    required this.coach,
    required this.league,
    required this.players,
    required this.titles,
    required this.foundationYear,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      stadium: json['stadium'],
      coach: json['coach'],
      league: json['league'],
      players: List<int>.from(json['players']),
      titles: List<String>.from(json['titles']),
      foundationYear: json['foundation_year'], // Mapeo de la propiedad nueva
    );
  }
}
