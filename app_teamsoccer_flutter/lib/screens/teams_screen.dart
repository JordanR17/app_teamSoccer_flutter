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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text(
            'Equipos de Fútbol',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 4,
        ),
      ),
      body: Stack(
        children: [
          // Fondo con gradiente suave
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE8F5E9), Color(0xFFFAFAFA)],
              ),
            ),
          ),
          Column(
            children: [
              // Dropdown de filtro de ligas
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.filter_list, color: Colors.green),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedLeague,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.green,
                        ),
                        underline: const SizedBox(),
                        dropdownColor: Colors.white,
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
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
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
                  ],
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
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
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
    // Normalizar el nombre del equipo para generar la ruta de la imagen
    String normalizedName = team.name
        .toLowerCase()
        .replaceAll(' ', '_') // Sustituir espacios por guiones bajos
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ü', 'u') // Manejar caracteres como "ü"
        .replaceAll('ñ', 'n')
        .replaceAll(
          '-',
          '_',
        ); // Reemplazar guiones por guiones bajos si es necesario

    String imagePath = 'assets/images/teams/$normalizedName.png';
    debugPrint('Ruta de imagen generada: $imagePath');

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
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            width: 45,
            height: 45,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('No se encontró la imagen en: $imagePath');
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
