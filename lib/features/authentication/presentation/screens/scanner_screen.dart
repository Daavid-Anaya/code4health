import 'package:code4health/features/authentication/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController controller = MobileScannerController();

  bool _isScanCompleted = false;

  // Variable para manejar manualmente el estado del flash
  bool isTorchOn = false;

  void _resetScan() {
    setState(() {
      _isScanCompleted = false;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double scanArea = screenWidth * 0.65;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.bar,
        elevation: 0,
        title: const Text('Escanear Producto', style: TextStyles.title,),
        actions: [

          IconButton(
            color: Colors.white,

            icon: Icon(
              isTorchOn ? Icons.flash_on : Icons.flash_off,
              color: isTorchOn ? Colors.purple : Colors.white,
            ),
            onPressed: () {
              //método para cambiar el flash
              controller.toggleTorch();

              setState(() {
                isTorchOn = !isTorchOn;
              });
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              if (!_isScanCompleted) {
                setState(() { _isScanCompleted = true; });
                final String code = capture.barcodes.first.rawValue ?? 'N/A';
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    title: const Text('Resultado del Escaneo'),
                    content: Text(code),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Cierra el diálogo
                          _resetScan(); // Permite un nuevo escaneo

                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const ProductDetailsScreen()),
                          );
                        },
                        child: const Text('VER DETALLES'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          Container(
            width: scanArea,
            height: scanArea,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5), width: 4),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}