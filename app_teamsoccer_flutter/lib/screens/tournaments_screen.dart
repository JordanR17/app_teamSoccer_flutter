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
  bool _isLoading = true;

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
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error al cargar torneos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Torneos de Fútbol',
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
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Colors.green),
              )
              : _tournaments.isEmpty
              ? const Center(
                child: Text(
                  'No hay torneos disponibles',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
              : ListView.builder(
                itemCount: _tournaments.length,
                itemBuilder: (context, index) {
                  final tournament = _tournaments[index];
                  return _buildAnimatedCard(tournament);
                },
              ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard(Tournament tournament) {
    // Normalizar el nombre del torneo para generar la ruta de la imagen
    String normalizedName = tournament.name
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
              return const Icon(
                Icons.emoji_events,
                color: Colors.green,
                size: 40,
              );
            },
          ),
        ),
        title: Text(
          tournament.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'País: ${tournament.country}',
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/tournament-details',
            arguments: tournament,
          );
        },
      ),
    );
  }
}
