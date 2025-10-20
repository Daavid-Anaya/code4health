class UserProfileEntity {
  final String uid;
  final String? name; // El nombre puede venir de FirebaseAuth
  final int edad;
  final double peso;
  final double altura;
  final String sexo;
  final String nivelActividad;

  UserProfileEntity({
    required this.uid,
    this.name,
    required this.edad,
    required this.peso,
    required this.altura,
    required this.sexo,
    required this.nivelActividad,
  });
}