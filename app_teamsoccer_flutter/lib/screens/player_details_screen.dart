import 'package:flutter/material.dart';
import 'package:app_teamsoccer_flutter/models/player_model.dart';

class PlayerDetailsScreen extends StatelessWidget {
  const PlayerDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Player player = ModalRoute.of(context)!.settings.arguments as Player;

    return Scaffold(
      appBar: AppBar(title: Text(player.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Equipo ID: ${player.team}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Posición: ${player.position}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Nacionalidad: ${player.nationality}',
              style: const TextStyle(fontSize: 18),
            ),
            Text('Edad: ${player.age}', style: const TextStyle(fontSize: 18)),
            if (player.goals != null)
              Text(
                'Goles: ${player.goals}',
                style: const TextStyle(fontSize: 18),
              ),
            if (player.assists != null)
              Text(
                'Asistencias: ${player.assists}',
                style: const TextStyle(fontSize: 18),
              ),
            if (player.cleanSheets != null)
              Text(
                'Hojas Limpias: ${player.cleanSheets}',
                style: const TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
