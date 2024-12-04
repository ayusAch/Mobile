import 'package:flutter/material.dart';
import 'package:ballboys/app/Football/model/detailmodel.dart';
import 'package:ballboys/app/Football/pages/ListDetail.dart';
import 'package:ballboys/app/Football/model/timmodel.dart';
import 'package:ballboys/app/Football/service/HttpService.dart';

class ListTim extends StatelessWidget {
  final int leagueId;
  final String leagueName;

  ListTim({required this.leagueId, required this.leagueName});

  @override
  Widget build(BuildContext context) {
    final ApiTim apiService = ApiTim();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$leagueName',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Color.fromARGB(255, 0, 0, 0),
            ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
      ),
      body: FutureBuilder<List<Timmodel>?>(
        future: apiService.getTeams(leagueId, 2021),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No teams available'),
            );
          } else {
            final teams = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dua kolom dalam satu baris
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 5 / 5, // Proporsi kartu
              ),
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];

                return GestureDetector(
                  onTap: () async {
                    final teamDetails = await apiService.getTeamDetails(team.id);
                    if (teamDetails != null) {
                      final timDetail = detailModel(
                        name: team.name,
                        logo: team.logo,
                        stadium: teamDetails.stadium,
                        image: teamDetails.image,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListDetail(tim: timDetail),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Unable to fetch team details')),
                      );
                    }
                  },
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color:  Color.fromARGB(255, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          child: Image.network(
                            team.logo,
                            width: 100.0,
                            height: 90.0,
                            //fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            team.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color:  Color.fromARGB(255, 255, 255, 255),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
