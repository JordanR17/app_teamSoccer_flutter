import 'package:flutter/material.dart';
import 'package:app_teamsoccer_flutter/models/tournament_model.dart';

class TournamentDetailsScreen extends StatelessWidget {
  const TournamentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Tournament tournament =
        ModalRoute.of(context)!.settings.arguments as Tournament;

    return Scaffold(
      appBar: AppBar(title: Text(tournament.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'País: ${tournament.country}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Temporada Actual: ${tournament.season}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Máximo Goleador: ${tournament.currentTopScorer}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Equipos Participantes:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tournament.teams.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.sports_soccer),
                    title: Text('ID Equipo: ${tournament.teams[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
