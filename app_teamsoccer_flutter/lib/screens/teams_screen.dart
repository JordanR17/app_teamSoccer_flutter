import 'package:flutter/material.dart';
import 'package:app_teamsoccer_flutter/models/team_model.dart';
import 'package:app_teamsoccer_flutter/services/api_service.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  final ApiService _apiService = ApiService();
  List<Team> _teams = [];
  String _selectedLeague = "Todos";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTeams();
  }

  Future<void> _fetchTeams() async {
    try {
      final teamsData = await _apiService.fetchTeams();
      setState(() {
        _teams = teamsData.map((team) => Team.fromJson(team)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error al cargar equipos: $e');
    }
  }

  List<Team> _filterTeams() {
    if (_selectedLeague == "Todos") return _teams;
    return _teams.where((team) => team.league == _selectedLeague).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Equipos de Fútbol',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          // Fondo animado con gradiente
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green, Colors.white],
              ),
            ),
          ),
          Column(
            children: [
              // Filtro de ligas
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                color: Colors.green[700],
                child: DropdownButton<String>(
                  dropdownColor: Colors.green[300],
                  value: _selectedLeague,
                  items:
                      [
                            "Todos",
                            "Premier League",
                            "LaLiga",
                            "Primera División",
                            "Bundesliga",
                            "Ligue 1",
                            "Serie A",
                          ]
                          .map(
                            (league) => DropdownMenuItem<String>(
                              value: league,
                              child: Text(
                                league,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLeague = value!;
                    });
                  },
                ),
              ),
              Expanded(
                child:
                    _isLoading
                        ? const Center(
                          child: CircularProgressIndicator(color: Colors.green),
                        )
                        : _teams.isEmpty
                        ? const Center(
                          child: Text(
                            'No hay equipos disponibles',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                        : ListView.builder(
                          itemCount: _filterTeams().length,
                          itemBuilder: (context, index) {
                            final team = _filterTeams()[index];
                            return _buildAnimatedCard(team);
                          },
                        ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard(Team team) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
        leading: const Icon(Icons.sports_soccer, color: Colors.green, size: 40),
        title: Text(
          team.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${team.league} - ${team.country}',
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/team-details', arguments: team);
        },
      ),
    );
  }
}
