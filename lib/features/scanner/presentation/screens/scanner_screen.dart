import 'package:code4health/features/products/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../injection_container.dart';
import '../../../history/domain/usecases/add_to_history_use_case.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../products/domain/usecases/get_product_by_barcode_use_case.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController controller = MobileScannerController();
  final GetProductByBarcodeUseCase _getProductUseCase = sl<GetProductByBarcodeUseCase>();
  final AddToHistoryUseCase _addToHistoryUseCase = sl<AddToHistoryUseCase>();

  // Variable para que represente el estado de carga/procesamiento
  bool _isProcessing = false;

  // Variable para manejar manualmente el estado del flash
  bool isTorchOn = false;

  Future<void> _handleBarcodeDetect(BarcodeCapture capture) async {
    // Si ya estamos procesando un código, no hagas nada
    if (_isProcessing) return;

    // Obtenemos el código de barras
    final String code = capture.barcodes.first.rawValue ?? 'N/A';
    if (code == 'N/A') return; // Ignora si no hay código

    // Inicia el estado de carga
    setState(() {
      _isProcessing = true;
    });

    try {
      // Llama al Caso de Uso para obtener el producto desde la API
      final ProductEntity product = await _getProductUseCase.call(code);

      // Guardar en el historial
      await _addToHistoryUseCase.call(product);

      // Si tiene éxito, navega a la pantalla de detalles con el producto
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            // Pasa el objeto 'product' a la pantalla de detalles
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      }
    } catch (e) {
      // Si falla, muestra un error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      // Permite un nuevo escaneo después de un breve retraso
      // para evitar escaneos múltiples accidentales.
      await Future.delayed(const Duration(seconds: 4));
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
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
        title: Text('Escanear Producto', style: TextStyles.title(context),),
        actions: [

          IconButton(
            color: Colors.white,

            icon: Icon(
              isTorchOn ? Icons.flash_on : Icons.flash_off,
              color: isTorchOn ? Colors.purple : Colors.white,
            ),
            onPressed: () {
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
            onDetect: _handleBarcodeDetect,
          ),
          Container(
            width: scanArea,
            height: scanArea,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5), width: 4),
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          if (_isProcessing)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Buscando producto...',
                      style: TextStyles.parrafo(context),
                    ),
                  ],
                ),
              ),
            ),

        ],
      ),
    );
  }
}