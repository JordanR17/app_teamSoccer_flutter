import 'package:flutter/material.dart';
import 'package:app_teamsoccer_flutter/screens/home_screen.dart';
import 'package:app_teamsoccer_flutter/screens/team_details_screen.dart';
import 'package:app_teamsoccer_flutter/screens/contact_form_screen.dart';
import 'package:app_teamsoccer_flutter/screens/players_screen.dart';
import 'package:app_teamsoccer_flutter/screens/player_details_screen.dart';
import 'package:app_teamsoccer_flutter/screens/tournaments_screen.dart';
import 'package:app_teamsoccer_flutter/screens/tournament_details_screen.dart';
import 'package:app_teamsoccer_flutter/screens/players_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FutGoal app',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/players': (context) => const PlayersScreen(),
        '/team-details': (context) => const TeamDetailsScreen(),
        '/contact-form': (context) => const ContactFormScreen(),
        '/players': (context) => const PlayersScreen(),
        '/player-details': (context) => const PlayerDetailsScreen(),
        '/tournaments': (context) => const TournamentsScreen(),
        '/tournament-details': (context) => const TournamentDetailsScreen(),
      },
    );
  }
}
