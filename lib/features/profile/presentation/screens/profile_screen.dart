import 'package:code4health/core/constants/app_colors.dart';
import 'package:code4health/features/authentication/domain/error/exceptions.dart';
import 'package:code4health/features/authentication/domain/usecases/delete_account_use_case.dart';
import 'package:code4health/features/authentication/domain/usecases/sign_out_use_case.dart';
import 'package:code4health/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:code4health/features/profile/presentation/screens/edit_profile_screen.dart';
import '../../../../auth_gate.dart';
import '../../../../core/constants/text_styles.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/usecases/calculate_caloric_consumption_use_case.dart';
import '../../domain/usecases/get_user_profile_use_case.dart';
import '../widgets/bmi_gauge_card.dart';
import '../widgets/stat_card.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  // Obtenemos las instancias de los casos de uso
  final GetUserProfileUseCase _getUserProfileUseCase = sl<GetUserProfileUseCase>();
  final CalculateCaloricConsumptionUseCase _calculateCaloriesUseCase = sl<CalculateCaloricConsumptionUseCase>();

  void _showOptionsMenu(BuildContext context) {
    // Obtenemos las instancias de los casos de uso
    final signOutUseCase = sl<SignOutUseCase>();
    final deleteAccountUseCase = sl<DeleteAccountUseCase>();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bottomSheetContext) {
        final navigator = Navigator.of(context);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Editar Perfil
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.white),
                title: Text('Editar Perfil', style: TextStyles.parrafo(context)),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                  );
                },
              ),
              Divider(color: AppColors.bar),

              // Cerrar Sesión
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text('Cerrar Sesión', style: TextStyle(color: Colors.redAccent)),
                onTap: () async {
                  Navigator.pop(bottomSheetContext);
                  await signOutUseCase.call();

                  navigator.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const AuthGate()),
                        (route) => false,
                  );
                },
              ),
              Divider(color: AppColors.bar),

              // Eliminar Cuenta
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
                title: const Text('Eliminar Cuenta', style: TextStyle(color: Colors.redAccent)),
                onTap: () async {
                  // Cerramos el menú de opciones inferior
                  Navigator.pop(bottomSheetContext);

                  // Mostramos el diálogo de confirmación
                  final bool? confirmacion = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text('¿Estás seguro?'),
                      content: const Text('Esta acción eliminará tu cuenta y todos tus datos de forma permanente. No se puede deshacer.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(dialogContext).pop(false),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(dialogContext).pop(true),
                          child: const Text('Eliminar', style: TextStyle(color: Colors.redAccent)),
                        ),
                      ],
                    ),
                  );

                  if (confirmacion != true) return;

                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  final rootNavigator = Navigator.of(context, rootNavigator: true);

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(child: CircularProgressIndicator()),
                  );

                  try {
                    await deleteAccountUseCase.call();

                    rootNavigator.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const AuthGate()),
                          (route) => false,
                    );
                  } catch (e) {
                    navigator.pop(); // Cierra el diálogo de carga

                    String errorMessage = 'Ocurrió un error inesperado.';
                    if (e is RequiresRecentLoginException) {
                      errorMessage = 'Por seguridad, debes volver a iniciar sesión para eliminar tu cuenta.';
                    }

                    scaffoldMessenger.showSnackBar(
                      SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),

              // Botón de Cancelar
              TextButton(
                onPressed: () {
                  Navigator.pop(bottomSheetContext);
                },
                child: const Text('Cancelar', style: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Perfil', style: TextStyles.title(context)),
        backgroundColor: AppColors.bar,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {
              _showOptionsMenu(context);
            },
          ),
        ],
      ),

      body: StreamBuilder<UserProfileEntity?>(

        stream: _getUserProfileUseCase.call(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No se encontró información del perfil.'));
          }

          final userProfile = snapshot.data!;

          // Calcula los valores derivados
          final double imc = userProfile.peso / ((userProfile.altura / 100) * (userProfile.altura / 100));
          final double caloricConsumption = _calculateCaloriesUseCase.call(
            peso: userProfile.peso,
            altura: userProfile.altura,
            edad: userProfile.edad,
            sexo: userProfile.sexo,
            nivelActividad: userProfile.nivelActividad,
          );

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.025),
                  CircleAvatar(
                    radius: screenWidth * 0.12,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: screenWidth * 0.15, color: Colors.white),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    userProfile.name ?? 'Usuario',
                    style: TextStyles.subEncabezado(context),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundContainer,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.backgroundContainer),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: StatCard(label: 'Edad', value: userProfile.edad.toString())),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(child: StatCard(label: 'Peso', value: userProfile.peso.toString())),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(child: StatCard(label: 'Altura', value: userProfile.altura.toString())),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  BmiGaugeCard(bmi: imc),
                  SizedBox(height: screenHeight * 0.03),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(screenHeight * 0.04),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundContainer,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.backgroundContainer),
                    ),
                    child: Column(
                      children: [
                        Text('Consumo calórico', style: TextStyles.parrafo(context)),
                        SizedBox(height: 4),
                        Text(
                            '${caloricConsumption.toStringAsFixed(2)} kcal. por día',
                            style: TextStyles.subEncabezado(context)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}