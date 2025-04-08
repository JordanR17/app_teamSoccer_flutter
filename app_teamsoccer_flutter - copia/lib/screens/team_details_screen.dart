import 'package:flutter/material.dart';
import 'package:app_teamsoccer_flutter/models/team_model.dart';
import 'package:app_teamsoccer_flutter/services/api_service.dart';

class TeamDetailsScreen extends StatefulWidget {
  const TeamDetailsScreen({Key? key}) : super(key: key);

  @override
  _TeamDetailsScreenState createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends State<TeamDetailsScreen> {
  final ApiService _apiService = ApiService();
  Map<int, String> _playerNames = {}; // Almacena nombres de jugadores
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPlayerNames();
  }

  Future<void> _fetchPlayerNames() async {
    try {
      final playersData = await _apiService.fetchPlayers();
      setState(() {
        _playerNames = {
          for (var player in playersData) player['id']: player['name'],
        };
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error al cargar nombres de jugadores: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Team team = ModalRoute.of(context)!.settings.arguments as Team;

    return Scaffold(
      appBar: AppBar(title: Text(team.name)),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'País: ${team.country}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Estadio: ${team.stadium}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Entrenador: ${team.coach}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Liga: ${team.league}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Año de Fundación: ${team.foundationYear}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Jugadores:',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: team.players.length,
                        itemBuilder: (context, index) {
                          final playerId = team.players[index];
                          return ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(
                              _playerNames[playerId] ?? 'Cargando...',
                            ),
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
