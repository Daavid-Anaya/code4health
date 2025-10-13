import 'package:code4health/core/constants/app_colors.dart';
import 'package:code4health/features/authentication/domain/error/exceptions.dart';
import 'package:code4health/features/authentication/domain/usecases/delete_account_use_case.dart';
import 'package:code4health/features/authentication/domain/usecases/sign_out_use_case.dart';
import 'package:code4health/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:code4health/features/authentication/presentation/screens/edit_profile_screen.dart';
import '../../../../auth_gate.dart';
import '../../../../core/constants/text_styles.dart';
import '../widgets/bmi_gauge_card.dart';
import '../widgets/stat_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
      // capturar el Navigator fuera de los callbacks asíncronos
      final navigator = Navigator.of(context);

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Editar Perfil
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white),
              title: const Text('Editar Perfil', style: TextStyles.parrafo),
              onTap: () {
                Navigator.pop(bottomSheetContext);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                );
              },
            ),
            const Divider(color: AppColors.bar),

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
            const Divider(color: AppColors.bar),

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

                // Si el usuario no confirmó, no hacemos nada más
                if (confirmacion != true) {
                  return;
                }

                //capturamos el ScaffoldMessenger antes de la operación asíncrona
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final rootNavigator = Navigator.of(context, rootNavigator: true);

                // Mostrar un indicador de carga
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(child: CircularProgressIndicator()),
                );

                try {
                  // Llamamos al caso de uso para eliminar la cuenta
                  await deleteAccountUseCase.call();

                  rootNavigator.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const AuthGate()),
                        (route) => false,
                  );
                } catch (e) {
                  // Cierra el diálogo de carga si hay un error
                  navigator.pop();

                  // Mostramos un mensaje de error
                  String errorMessage = 'Ocurrió un error inesperado.';
                  if (e is RequiresRecentLoginException) {
                    errorMessage = 'Por seguridad, debes volver a iniciar sesión para eliminar tu cuenta.';
                  }

                  // Usamos el 'scaffoldMessenger' capturado para mostrar el error
                  scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            
            // Botón de Cancelar (sin cambios)
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

    // Datos de ejemplo
    const double peso = 70; // kg
    const double altura = 170; // cm
    const double imc = peso / ((altura / 100) * (altura / 100));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Perfil', style: TextStyles.title),
        backgroundColor: AppColors.bar,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white,),
            onPressed: () {
              _showOptionsMenu(context);
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.025),

              // avatar, nombre, y las tarjetas de información
              CircleAvatar(
                radius: screenWidth * 0.12,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: screenWidth * 0.15, color: Colors.white),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Nombre
              const Text(
                'Nombre', // Reemplazar con el nombre del usuario
                style: TextStyles.subEncabezado,
              ),
              SizedBox(height: screenHeight * 0.03),

              // tarjetas de Edad, Peso y Altura
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.backgroundContainer,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.backgroundContainer),
                ),
                child: Row(
                  children: [
                    const Expanded(child: StatCard(label: 'Edad', value: '28')),
                    SizedBox(width: screenWidth * 0.03),
                    const Expanded(child: StatCard(label: 'Peso', value: '70')),
                    SizedBox(width: screenWidth * 0.03),
                    const Expanded(child: StatCard(label: 'Altura', value: '170')),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // tarjeta del IMC
              BmiGaugeCard(bmi: imc),
              SizedBox(height: screenHeight * 0.03),

              // tarjeta de consumo calórico
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(screenHeight * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.backgroundContainer,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.backgroundContainer),
                ),
                child: const Column(
                  children: [
                    Text('Consumo calórico', style: TextStyles.parrafo),
                    SizedBox(height: 4),
                    Text('2,411.41 kcal. por día', style: TextStyles.subEncabezado),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

            ],
          ),
        ),
      ),
    );
  }
}