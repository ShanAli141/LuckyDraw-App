import 'dart:convert';

import 'package:luckywinner/features/participants/data/participant_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ParticipantsLocalDataSource {
  static const String _key = 'participants_list';

  Future<List<Participant>> loadParticipants() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    final List<dynamic> decoded = json.decode(jsonString) as List<dynamic>;
    return decoded
        .map((e) => Participant.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveParticipants(List<Participant> participants) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
        json.encode(participants.map((e) => e.toJson()).toList());
    await prefs.setString(_key, encoded);
  }
}