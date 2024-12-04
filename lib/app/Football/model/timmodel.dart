class Timmodel {
  final int id; 
  final String name;
  final String logo;

  Timmodel({
    required this.id, 
    required this.name,
    required this.logo,
  });

  factory Timmodel.fromJson(Map<String, dynamic> json) {
    return Timmodel(
      id: json['team']['id'], 
      name: json['team']['name'],
      logo: json['team']['logo'],
    );
  }
}
