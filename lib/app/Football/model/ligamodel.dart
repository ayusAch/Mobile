class Ligamodel {
  final int id;
  final String name;
  final String logo;

  Ligamodel({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory Ligamodel.fromJson(Map<String, dynamic> json) {
    return Ligamodel(
      id: json['league']['id'] as int,
      name: json['league']['name'] as String,
      logo: json['league']['logo'] as String,
    );
  }
}
