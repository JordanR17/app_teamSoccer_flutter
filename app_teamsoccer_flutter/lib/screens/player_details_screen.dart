import 'package:flutter/material.dart';
import 'package:app_teamsoccer_flutter/models/player_model.dart';

class PlayerDetailsScreen extends StatelessWidget {
  const PlayerDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Player player = ModalRoute.of(context)!.settings.arguments as Player;

    // Generar rutas para las imágenes del jugador y del equipo
    String normalizedPlayerName = player.name
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
    String playerImagePath = 'assets/images/teams/$normalizedPlayerName.png';

    // Depuración: Imprimir la ruta generada en la consola
    debugPrint('Ruta de la imagen del jugador: $playerImagePath');

    // Relación entre IDs de equipos y nombres
    final Map<int, String> teamNames = {
      1: "Manchester City",
      2: "Real Madrid",
      3: "River Plate",
      4: "Bayern Múnich",
      5: "Paris Saint-Germain",
      6: "AC Milan",
    };
    String teamName = teamNames[player.team] ?? "Equipo Desconocido";
    String normalizedTeamName = teamName
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
    String teamImagePath = 'assets/images/teams/$normalizedTeamName.png';

    // Depuración: Imprimir la ruta generada para la imagen del equipo
    debugPrint('Ruta de la imagen del equipo: $teamImagePath');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          player.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1B5E20), // Verde oscuro
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
                // Imagen del jugador
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.green, width: 4),
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
                        playerImagePath,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            color: Colors.green,
                            size: 100,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Imagen del equipo asociado
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.blueGrey, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        teamImagePath,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.sports_soccer,
                            color: Colors.blueGrey,
                            size: 80,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Información del jugador
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.9,
                    ), // Transparente para resaltar el fondo
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
                        icon: Icons.group,
                        label: 'Equipo',
                        value: teamName,
                      ),
                      _buildInfoRow(
                        icon: Icons.sports,
                        label: 'Posición',
                        value: player.position,
                      ),
                      _buildInfoRow(
                        icon: Icons.flag,
                        label: 'Nacionalidad',
                        value: player.nationality,
                      ),
                      _buildInfoRow(
                        icon: Icons.calendar_today,
                        label: 'Edad',
                        value: player.age.toString(),
                      ),
                      if (player.goals != null)
                        _buildInfoRow(
                          icon: Icons.sports_soccer,
                          label: 'Goles',
                          value: player.goals.toString(),
                        ),
                      if (player.assists != null)
                        _buildInfoRow(
                          icon: Icons.handshake,
                          label: 'Asistencias',
                          value: player.assists.toString(),
                        ),
                    ],
                  ),
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
