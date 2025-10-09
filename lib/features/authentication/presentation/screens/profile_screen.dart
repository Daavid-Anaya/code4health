import 'package:code4health/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/text_styles.dart';
import '../widgets/bmi_gauge_card.dart';
import '../widgets/stat_card.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            icon: const Icon(Icons.edit, color: Colors.white,),
            onPressed: () {
              
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              );
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
