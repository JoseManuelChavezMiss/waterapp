class LoginUser {
  final String nombreUsuario;
  final String password;

  LoginUser({
    required this.nombreUsuario,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombreUsuario': nombreUsuario,
      'password': password,
    };
  }
}