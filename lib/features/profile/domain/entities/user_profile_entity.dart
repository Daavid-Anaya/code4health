class UserProfileEntity {
  final String uid;
  final String? name;
  final int edad;
  final double peso;
  final double altura;
  final String sexo;
  final String nivelActividad;

  final bool? tratamientoHipertension;
  final bool? fumador;
  final bool? diabetico;
  final int? presionSistolica;
  final int? hdl;
  final int? colesterol;

  UserProfileEntity({
    required this.uid,
    this.name,
    required this.edad,
    required this.peso,
    required this.altura,
    required this.sexo,
    required this.nivelActividad,

    this.tratamientoHipertension,
    this.fumador,
    this.diabetico,
    this.presionSistolica,
    this.hdl,
    this.colesterol,
  });
}