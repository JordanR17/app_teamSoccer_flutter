class Tournament {
  final int id;
  final String name;
  final String country;
  final List<int> teams; // IDs de equipos
  final List<String> winners; // Ganadores anteriores
  final String currentTopScorer;
  final String season; // Nueva propiedad: Temporada

  Tournament({
    required this.id,
    required this.name,
    required this.country,
    required this.teams,
    required this.winners,
    required this.currentTopScorer,
    required this.season, // Aseguramos que sea requerida
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      teams: List<int>.from(json['teams']),
      winners: List<String>.from(json['winners']),
      currentTopScorer: json['current_top_scorer'],
      season: json['season'], // Mapeo de la propiedad nueva
    );
  }
}
