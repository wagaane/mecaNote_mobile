class ProfilModel {
  final int id;
  final String code;
  final String label;

  ProfilModel({
    required this.id,
    required this.code,
    required this.label,
  });

  factory ProfilModel.fromJson(Map<String, dynamic> json) {
    return ProfilModel(
      id: json['id'],
      code: json['code'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'label': label,
    };
  }

  static List<ProfilModel> fromList(List<dynamic> list) {
    return list.map((e) => ProfilModel.fromJson(e)).toList();
  }
}
