import 'file_data.dart';

class GarageResponse {
  final String nom;
  final FileData? file;

  GarageResponse({
    required this.nom,
    this.file,
  });

  factory GarageResponse.fromJson(Map<String, dynamic> json) {
    return GarageResponse(
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
      'nom': nom,
      'file': file?.toJson(),
    };
  }
}