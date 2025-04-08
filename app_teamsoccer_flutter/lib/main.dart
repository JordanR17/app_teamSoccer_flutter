import 'package:flutter/material.dart';
import 'package:app_teamsoccer_flutter/screens/home_screen.dart';
import 'package:app_teamsoccer_flutter/screens/team_details_screen.dart';
// import 'package:app_teamsoccer_flutter/screens/contact_form_screen.dart'; // Eliminado
import 'package:app_teamsoccer_flutter/screens/players_screen.dart';
import 'package:app_teamsoccer_flutter/screens/player_details_screen.dart';
import 'package:app_teamsoccer_flutter/screens/tournaments_screen.dart';
import 'package:app_teamsoccer_flutter/screens/tournament_details_screen.dart';
import 'package:app_teamsoccer_flutter/screens/teams_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FutGoal App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B5E20),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1B5E20),
          selectedItemColor: Color(0xFFFFD700),
          unselectedItemColor: Colors.white70,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScaffold(child: HomeScreen()),
        '/teams': (context) => const MainScaffold(child: TeamsScreen()),
        '/team-details': (context) => const TeamDetailsScreen(),
        // '/contact-form': (context) => const MainScaffold(child: ContactFormScreen()), // Eliminado
        '/players': (context) => const MainScaffold(child: PlayersScreen()),
        '/player-details': (context) => const PlayerDetailsScreen(),
        '/tournaments':
            (context) => const MainScaffold(child: TournamentsScreen()),
        '/tournament-details': (context) => const TournamentDetailsScreen(),
      },
    );
  }
}

class MainScaffold extends StatefulWidget {
  final Widget child;

  const MainScaffold({required this.child, Key? key}) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final Map<String, int> routeIndex = {
    '/': 0,
    '/teams': 1,
    '/players': 2,
    '/tournaments': 3,
  };

  int getCurrentIndex() {
    final routeName = ModalRoute.of(context)?.settings.name;
    return routeIndex[routeName] ?? 0;
  }

  void navigateTo(int index) {
    final routes = routeIndex.keys.toList();
    Navigator.pushNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = getCurrentIndex();

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: navigateTo,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Equipos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Jugadores'),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Torneos',
          ),
          // Eliminado el ítem de contacto
        ],
      ),
    );
  }
}
