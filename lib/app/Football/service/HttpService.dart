import 'dart:io';
import 'package:ballboys/app/Football/model/detailmodel.dart';
import 'package:ballboys/app/Football/model/timmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ballboys/app/Football/model/ligamodel.dart';

class ApiLiga {
  final String apiKey = '9f2ca45b1ef7693654691ceb9d6d4559';
  final String baseUrl = 'https://v3.football.api-sports.io';

  // Daftar ID liga yang diinginkan
  final List<int> targetLeagueIds = [140, 135, 39, 78];

  Future<List<Ligamodel>?> getLeague() async {
    final String uri = '$baseUrl/leagues';

    try {
      // Kirim permintaan GET dengan header API key
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          'x-rapidapi-key': apiKey,
          'x-rapidapi-host': 'v3.football.api-sports.io',
        },
      );

      // Periksa status response
      if (response.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(response.body);

        // Ambil data dari key "response"
        final leagues = jsonResponse['response'] as List;

        // Filter hanya liga yang sesuai targetLeagueIds
        return leagues
            .where((item) =>
                targetLeagueIds.contains(item['league']['id'] as int))
            .map((item) => Ligamodel.fromJson(item))
            .toList();
      } else {
        print("HTTP Error: ${response.statusCode} - ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}

// Pastikan ApiTim memiliki metode getTeamDetails
class ApiTim {
  final String apiKey = '9f2ca45b1ef7693654691ceb9d6d4559'; // Ganti dengan API key Anda
  final String baseUrl = 'https://v3.football.api-sports.io'; // URL API

  // Mengambil daftar tim berdasarkan leagueId
  Future<List<Timmodel>> getTeams(int leagueId, int season) async {
    final uri = '$baseUrl/teams?league=$leagueId&season=$season';

    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          'x-rapidapi-key': apiKey,
          'x-rapidapi-host': 'v3.football.api-sports.io',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['response'];
        return data.map((team) => Timmodel.fromJson(team)).toList();
      } else {
        throw Exception('Failed to load teams');
      }
    } catch (e) {
      throw Exception('Failed to load teams: $e');
    }
  }

  // Mendapatkan detail tim berdasarkan teamId
  Future<detailModel?> getTeamDetails(int teamId) async {
    final uri = '$baseUrl/teams?id=$teamId';

    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          'x-rapidapi-key': apiKey,
          'x-rapidapi-host': 'v3.football.api-sports.io',
        },
      );

      if (response.statusCode == 200) {
        final teamDetail = json.decode(response.body)['response'][0];
        return detailModel.fromJson(teamDetail); // Pastikan method `fromJson` ada di `detailModel`
      } else {
        throw Exception('Failed to load team details');
      }
    } catch (e) {
      throw Exception('Failed to load team details: $e');
    }
  }
}



class DetailApi {
  final String apiKey = '9f2ca45b1ef7693654691ceb9d6d4559';  // API key
  final String baseUrl = 'https://v3.football.api-sports.io';  // Base URL API

  // Method untuk mengambil detail tim berdasarkan ID tim
  Future<detailModel?> getTeamDetails(int teamId) async {
    final String uri = '$baseUrl/teams?id=$teamId';  // Endpoint untuk detail tim

    try {
      // Kirim permintaan GET dengan header API key
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          'x-rapidapi-key': apiKey,
          'x-rapidapi-host': 'v3.football.api-sports.io',
        },
      );

      // Periksa status response
      if (response.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(response.body);

        // Pastikan response memiliki data pada key 'response'
        if (jsonResponse['response'] != null) {
          final teamDetail = jsonResponse['response'][0];  // Ambil data detail tim
          return detailModel.fromJson(teamDetail);  // Ubah data JSON menjadi object detailModel
        } else {
          print("Response 'response' key is null");
          return null;
        }
      } else {
        print("HTTP Error: ${response.statusCode} - ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}


