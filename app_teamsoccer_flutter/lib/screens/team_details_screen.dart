import 'package:flutter/material.dart';
import 'package:app_teamsoccer_flutter/models/team_model.dart';

class TeamDetailsScreen extends StatefulWidget {
  const TeamDetailsScreen({Key? key}) : super(key: key);

  @override
  _TeamDetailsScreenState createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends State<TeamDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Team team = ModalRoute.of(context)!.settings.arguments as Team;

    // Generar la ruta de la imagen del equipo
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
    String teamImagePath = 'assets/images/teams/$normalizedName.png';

    // Depuración: Imprimir la ruta generada en la consola
    debugPrint('Ruta de la imagen del equipo: $teamImagePath');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          team.name,
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
                // Imagen del equipo
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
                        teamImagePath,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.sports_soccer,
                            color: Colors.green,
                            size: 100,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Información del equipo
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.9,
                    ), // Fondo semitransparente
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
                        value: team.country,
                      ),
                      _buildInfoRow(
                        icon: Icons.stadium,
                        label: 'Estadio',
                        value: team.stadium,
                      ),
                      _buildInfoRow(
                        icon: Icons.person,
                        label: 'Entrenador',
                        value: team.coach,
                      ),
                      _buildInfoRow(
                        icon: Icons.sports_soccer,
                        label: 'Liga',
                        value: team.league,
                      ),
                      _buildInfoRow(
                        icon: Icons.calendar_today,
                        label: 'Fundación',
                        value: team.foundationYear.toString(),
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
