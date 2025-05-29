class GoogleUser {
  final String email;
  final bool emailVerified;
  final String name;
  final String picture;
  final String givenName;
  final String familyName;
  late  String profile;

  GoogleUser({

    required this.email,
    required this.emailVerified,
    required this.name,
    required this.picture,
    required this.givenName,
    required this.familyName,
    required this.profile,
  });

  factory GoogleUser.fromJson(Map<String, dynamic> json) {
    return GoogleUser(
      email: json['email'],
      emailVerified: json['email_verified'],
      name: json['name'],
      picture: json['picture'],
      givenName: json['given_name'],
      familyName: json['family_name'],
      profile: json['profile'] ?? 'MECANO',
    );
  }

  Map<String, dynamic> toJson() {
    return {

      'email': email,
      'emailVerified': emailVerified,
      'name': name,
      'picture': picture,
      'givenName': givenName,
      'familyName': familyName,
      'profile': profile,
    };
  }
}
