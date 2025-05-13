class DemandModel {
  final int id;
  final Domaine domaine;
  final String statusDemand;
  final Client client;
  final bool read;
  final String dateCreation;

  DemandModel({
    required this.id,
    required this.domaine,
    required this.statusDemand,
    required this.client,
    required this.read,
    required this.dateCreation,
  });

  factory DemandModel.fromJson(Map<String, dynamic> json) {
    return DemandModel(
      id: json['id'],
      domaine: Domaine.fromJson(json['domaine']),
      statusDemand: json['statusDemand'],
      client: Client.fromJson(json['client']),
      read: json['read'],
      dateCreation: json['dateCreation'].toString(),
    );
  }

  static List<DemandModel> fromList(List<dynamic> list) {
    return list.map((e) => DemandModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'domaine': domaine.toJson(),
      'statusDemand': statusDemand,
      'client': client.toJson(),
      'read': read,
      'dateCreation': dateCreation,
    };
  }
}

class Domaine {
  final int id;
  final String label;
  final String code;
  final String description;
  final String img;

  Domaine({
    required this.id,
    required this.label,
    required this.code,
    required this.description,
    required this.img,
  });

  factory Domaine.fromJson(Map<String, dynamic> json) {
    return Domaine(
      id: json['id'],
      label: json['label'],
      code: json['code'],
      description: json['description'],
      img: json['img'],
    );
  }

  static List<Domaine> fromList(List<dynamic> list) {
    return list.map((e) => Domaine.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'code': code,
      'description': description,
      'img': img,
    };
  }
}

class Client {
  final String prenom;
  final String nom;
  final String email;
  final int id;

  Client({
    required this.prenom,
    required this.nom,
    required this.email,
    required this.id,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      prenom: json['prenom'],
      nom: json['nom'],
      email: json['email'],
      id: json['id'],
    );
  }

  static List<Client> fromList(List<dynamic> list) {
    return list.map((e) => Client.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'prenom': prenom,
      'nom': nom,
      'email': email,
      'id': id,
    };
  }
}
