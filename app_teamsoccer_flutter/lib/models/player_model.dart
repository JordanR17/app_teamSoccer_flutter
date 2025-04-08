class Player {
  final int id;
  final String name;
  final int team; // ID del equipo
  final String position;
  final String nationality;
  final int age;
  final int? goals;
  final int? assists;
  final int? cleanSheets;

  Player({
    required this.id,
    required this.name,
    required this.team,
    required this.position,
    required this.nationality,
    required this.age,
    this.goals,
    this.assists,
    this.cleanSheets,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      team: json['team'],
      position: json['position'],
      nationality: json['nationality'],
      age: json['age'],
      goals: json['goals'] ?? 0,
      assists: json['assists'] ?? 0,
      cleanSheets: json['clean_sheets'] ?? 0,
    );
  }
}
