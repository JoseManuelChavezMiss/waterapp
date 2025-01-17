class JwtDTO {
  final String token;
  final String type;
  final String nombreUsuario;
  final List<String> authorities;

  JwtDTO({
    required this.token,
    required this.type,
    required this.nombreUsuario,
    required this.authorities,
  });

  factory JwtDTO.fromJson(Map<String, dynamic> json) {
    return JwtDTO(
      token: json['token'] ?? '',
      type: json['type'] ?? '',
      nombreUsuario: json['nombreUsuario'] ?? '',
      authorities: json['authorities'] != null
          ? List<String>.from(json['authorities'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'type': type,
      'nombreUsuario': nombreUsuario,
      'authorities': authorities,
    };
  }
}