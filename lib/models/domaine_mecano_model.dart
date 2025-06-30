class DomaineMecanoModel {
  final int id;
  final String label;
  final String code;
  final String description;
  final String img;
  final bool deleted;
   bool selected;

  DomaineMecanoModel({
    required this.id,
    required this.label,
    required this.code,
    required this.description,
    required this.img,
    required this.deleted,
    required this.selected,
  });

  factory DomaineMecanoModel.fromJson(Map<String, dynamic> json) {
    return DomaineMecanoModel(
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

  static List<DomaineMecanoModel> fromList(List<dynamic> jsonList) {
    return jsonList.map((json) => DomaineMecanoModel.fromJson(json)).toList();
  }
}
