import 'package:flutter/material.dart';
import 'package:app_teamsoccer_flutter/models/tournament_model.dart';
import 'package:app_teamsoccer_flutter/models/team_model.dart';

class TournamentDetailsScreen extends StatelessWidget {
  const TournamentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Tournament tournament =
        ModalRoute.of(context)!.settings.arguments as Tournament;

    // Relación entre IDs de equipos y sus datos completos
    final Map<int, Team> teamsData = {
      1: Team(
        id: 1,
        name: "Manchester City",
        league: "Premier League",
        country: "Inglaterra",
        stadium: "Etihad Stadium",
        coach: "Pep Guardiola",
        foundationYear: 1880,
        players: [],
        titles: ["Premier League 2023", "UEFA Champions League 2023"],
      ),
      2: Team(
        id: 2,
        name: "Real Madrid",
        league: "LaLiga",
        country: "España",
        stadium: "Santiago Bernabéu",
        coach: "Carlo Ancelotti",
        foundationYear: 1902,
        players: [],
        titles: [
          "UEFA Champions League 2022",
          "LaLiga 2021",
          "Supercopa de Europa 2022",
        ],
      ),
      3: Team(
        id: 3,
        name: "River Plate",
        league: "Primera División",
        country: "Argentina",
        stadium: "Monumental",
        coach: "Martín Demichelis",
        foundationYear: 1901,
        players: [],
        titles: ["Copa Libertadores 2018", "Primera División 2021"],
      ),
      4: Team(
        id: 4,
        name: "Bayern Múnich",
        league: "Bundesliga",
        country: "Alemania",
        stadium: "Allianz Arena",
        coach: "Thomas Tuchel",
        foundationYear: 1900,
        players: [],
        titles: ["Bundesliga 2023", "DFB-Pokal 2022"],
      ),
      5: Team(
        id: 5,
        name: "Paris Saint-Germain",
        league: "Ligue 1",
        country: "Francia",
        stadium: "Parque de los Príncipes",
        coach: "Luis Enrique",
        foundationYear: 1970,
        players: [],
        titles: ["Ligue 1 2023", "Copa de Francia 2022"],
      ),
      6: Team(
        id: 6,
        name: "AC Milan",
        league: "Serie A",
        country: "Italia",
        stadium: "San Siro",
        coach: "Stefano Pioli",
        foundationYear: 1899,
        players: [],
        titles: ["Serie A 2022", "Supercopa Italiana 2022"],
      ),
    };

    // Normalizar el nombre del torneo para generar la ruta de la imagen
    String normalizedTournamentName = tournament.name
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ü', 'u')
        .replaceAll('ñ', 'n')
        .replaceAll('-', '_');
    String tournamentImagePath =
        'assets/images/teams/$normalizedTournamentName.png';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tournament.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1B5E20),
        elevation: 4,
      ),
      body: Stack(
        children: [
          // Fondo de pantalla
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/soccer_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen del torneo
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.blueGrey, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        tournamentImagePath,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.emoji_events,
                            color: Colors.blueGrey,
                            size: 100,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Información del torneo
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        icon: Icons.flag,
                        label: 'País',
                        value: tournament.country,
                      ),
                      _buildInfoRow(
                        icon: Icons.calendar_today,
                        label: 'Temporada Actual',
                        value: tournament.season,
                      ),
                      _buildInfoRow(
                        icon: Icons.sports_soccer,
                        label: 'Máximo Goleador',
                        value: tournament.currentTopScorer,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Equipos participantes
                Text(
                  'Equipos Participantes',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tournament.teams.length,
                  itemBuilder: (context, index) {
                    final teamId = tournament.teams[index];
                    final team = teamsData[teamId];

                    if (team == null) {
                      return ListTile(
                        title: Text('Equipo Desconocido (ID: $teamId)'),
                        leading: const Icon(Icons.sports_soccer),
                      );
                    }

                    String normalizedName = team.name
                        .toLowerCase()
                        .replaceAll(' ', '_')
                        .replaceAll('á', 'a')
                        .replaceAll('é', 'e')
                        .replaceAll('í', 'i')
                        .replaceAll('ó', 'o')
                        .replaceAll('ú', 'u')
                        .replaceAll('ü', 'u')
                        .replaceAll('ñ', 'n')
                        .replaceAll('-', '_');
                    String imagePath =
                        'assets/images/teams/$normalizedName.png';
                    debugPrint(
                      'Ruta de imagen generada para el equipo: $imagePath',
                    );

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.6),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            imagePath,
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              debugPrint(
                                'No se encontró la imagen en: $imagePath',
                              );
                              return const Icon(
                                Icons.sports_soccer,
                                color: Colors.green,
                                size: 40,
                              );
                            },
                          ),
                        ),
                        title: Text(
                          team.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${team.league} - ${team.country}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 4),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
