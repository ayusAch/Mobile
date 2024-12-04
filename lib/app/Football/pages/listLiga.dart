import 'package:flutter/material.dart';
import 'package:ballboys/app/Football/pages/listtim.dart';
import 'package:ballboys/app/Football/service/HttpService.dart';
import 'package:ballboys/app/Football/model/ligamodel.dart';

class LigaList extends StatelessWidget {
  const LigaList({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiLiga apiService = ApiLiga();

    return FutureBuilder<List<Ligamodel>?>( 
      future: apiService.getLeague(),
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
            child: Text('No leagues available'),
          );
        } else {
          final leagues = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            itemCount: leagues.length,
            itemBuilder: (context, index) {
              final league = leagues[index];
              return GestureDetector(
                onTap: () {
                  final leagueId = league.id;
                  final leagueName = league.name;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListTim(
                        leagueId: leagueId, 
                        leagueName: leagueName,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(231, 255, 255, 255), // Warna solid
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    width: 180.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        ClipRRect(
                          child: Image.network(
                            league.logo,
                            width: 150.0, 
                            height: 150.0,
                            fit: BoxFit.contain, 
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
