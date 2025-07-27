import 'file_data.dart';

class GarageResponse {
  final int id;
  final String nom;
  final FileData? file;
  final String ? date;

  GarageResponse({
    required this.id,
    required this.nom,
    this.file,
    this.date,
  });

  factory GarageResponse.fromJson(Map<String, dynamic> json) {
    return GarageResponse(
      date: json['date'] ?? '',
      id: json['id'] ?? '',
      nom: json['nom'] ?? '',
      file: json['file'] != null ? FileData.fromJson(json['file']) : null,
    );
  }

  static List<GarageResponse> jsonList(List<dynamic> jsonList) {
    return jsonList
        .map((item) => GarageResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'nom': nom,
      'file': file?.toJson(),
    };
  }
}