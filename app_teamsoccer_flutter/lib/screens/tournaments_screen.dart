import 'package:flutter/material.dart';
import 'package:app_teamsoccer_flutter/models/tournament_model.dart';
import 'package:app_teamsoccer_flutter/services/api_service.dart';

class TournamentsScreen extends StatefulWidget {
  const TournamentsScreen({Key? key}) : super(key: key);

  @override
  _TournamentsScreenState createState() => _TournamentsScreenState();
}

class _TournamentsScreenState extends State<TournamentsScreen> {
  final ApiService _apiService = ApiService();
  List<Tournament> _tournaments = [];

  @override
  void initState() {
    super.initState();
    _fetchTournaments();
  }

  Future<void> _fetchTournaments() async {
    try {
      final tournamentsData = await _apiService.fetchTournaments();
      setState(() {
        _tournaments =
            tournamentsData
                .map((tournament) => Tournament.fromJson(tournament))
                .toList();
      });
    } catch (e) {
      print('Error al cargar torneos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Torneos de Fútbol')),
      body:
          _tournaments.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _tournaments.length,
                itemBuilder: (context, index) {
                  final tournament = _tournaments[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.emoji_events, size: 40),
                      title: Text(tournament.name),
                      subtitle: Text('País: ${tournament.country}'),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/tournament-details',
                          arguments: tournament,
                        );
                      },
                    ),
                  );
                },
              ),
    );
  }
}
