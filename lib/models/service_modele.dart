class ServiceModele {
  final int id;
  final String label;
  final String code;
  final String description;
  final String img;
  final bool deleted;
   bool selected;

  ServiceModele({
    required this.id,
    required this.label,
    required this.code,
    required this.description,
    required this.img,
    required this.deleted,
    required this.selected,
  });

  factory ServiceModele.fromJson(Map<String, dynamic> json) {
    return ServiceModele(
      id: json['id'],
      label: json['label'],
      code: json['code'],
      description: json['description'],
      img: json['img'],
      deleted: json['deleted'],
      selected: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'code': code,
      'description': description,
      'img': img,
      'deleted': deleted,
      'selected': deleted,
    };
  }

  static List<ServiceModele> fromList(List<dynamic> jsonList) {
    return jsonList.map((json) => ServiceModele.fromJson(json)).toList();
  }
}
