import 'package:flutter/material.dart';
import 'package:app_teamsoccer_flutter/models/player_model.dart';
import 'package:app_teamsoccer_flutter/services/api_service.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({Key? key}) : super(key: key);

  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  final ApiService _apiService = ApiService();
  List<Player> _players = [];
  String _selectedNationality = "Todos";

  @override
  void initState() {
    super.initState();
    _fetchPlayers();
  }

  Future<void> _fetchPlayers() async {
    try {
      final playersData = await _apiService.fetchPlayers();
      setState(() {
        _players =
            playersData.map((player) => Player.fromJson(player)).toList();
      });
    } catch (e) {
      print('Error al cargar jugadores: $e');
    }
  }

  List<Player> _filterPlayers() {
    if (_selectedNationality == "Todos") return _players;
    return _players
        .where((player) => player.nationality == _selectedNationality)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jugadores de Fútbol'),
        actions: [
          DropdownButton<String>(
            value: _selectedNationality,
            items:
                [
                      "Todos",
                      "Noruega",
                      "Bélgica",
                      "Inglaterra",
                      "Francia",
                      "Brasil",
                      "Argentina",
                    ]
                    .map(
                      (nationality) => DropdownMenuItem<String>(
                        value: nationality,
                        child: Text(nationality),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              setState(() {
                _selectedNationality = value!;
              });
            },
          ),
        ],
      ),
      body:
          _players.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _filterPlayers().length,
                itemBuilder: (context, index) {
                  final player = _filterPlayers()[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person, size: 40),
                      title: Text(player.name),
                      subtitle: Text(
                        '${player.position} - ${player.nationality}',
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/player-details',
                          arguments: player,
                        );
                      },
                    ),
                  );
                },
              ),
    );
  }
}
