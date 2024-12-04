class detailModel {
  final String name;
  final String logo;
  final String stadium; 
  final String image;  

  detailModel({
    required this.name,
    required this.logo,
    required this.stadium, 
    required this.image,  
  });

  factory detailModel.fromJson(Map<String, dynamic> json) {
    return detailModel(
      name: json['team']['name'],     
      logo: json['team']['logo'],    
      stadium: json['venue']['name'], 
      image: json['venue']['image'], 
    );
  }
}
