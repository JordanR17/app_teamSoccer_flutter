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
  bool _isLoading = true;

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
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error al cargar jugadores: $e');
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
        title: const Text(
          'Jugadores de Fútbol',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: const Color(0xFF1B5E20), // Verde oscuro
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
              // Filtro por nacionalidad
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
                        value: _selectedNationality,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.green,
                        ),
                        underline: const SizedBox(),
                        dropdownColor: Colors.white,
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
                                    child: Text(
                                      nationality,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedNationality = value!;
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
                        : _players.isEmpty
                        ? const Center(
                          child: Text(
                            'No hay jugadores disponibles',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                        : ListView.builder(
                          itemCount: _filterPlayers().length,
                          itemBuilder: (context, index) {
                            final player = _filterPlayers()[index];
                            return _buildAnimatedCard(player);
                          },
                        ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard(Player player) {
    // Normalizar el nombre del jugador para generar la ruta de la imagen
    String normalizedName = player.name
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
              return const Icon(Icons.person, color: Colors.green, size: 40);
            },
          ),
        ),
        title: Text(
          player.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${player.position} - ${player.nationality}',
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/player-details', arguments: player);
        },
      ),
    );
  }
}
