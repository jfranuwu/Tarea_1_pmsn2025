// lib/screens/details.dart
import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class LocationDetailsScreen extends StatelessWidget {
  final String imagePath;

  const LocationDetailsScreen({
    super.key,
    required this.imagePath,
  });

  // Método para obtener el título basado en la ruta de la imagen
  String _getTitle() {
    if (imagePath.contains('location1')) return 'Alley Palace';
    if (imagePath.contains('location2')) return 'Coeurdes Alpes';
    if (imagePath.contains('location3')) return 'Mountain View';
    if (imagePath.contains('location4')) return 'Lake Resort';
    return 'Location Details';
  }

  // Método para obtener la calificación basada en la ruta de la imagen
  double _getRating() {
    if (imagePath.contains('location1')) return 4.5;
    if (imagePath.contains('location2')) return 5.0;
    return 4.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: double.infinity,
                height: constraints.maxHeight / 2,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: InteractiveViewer(
                    minScale: 1.0,
                    maxScale: 3.0,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              );
            },
          ),
          // Botón de retroceso personalizado
          Positioned(
            top: 40,
            left: 20,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70, 
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black45),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
          // Título y calificación
          Positioned(
            bottom: 40,
            left: 50,
            right: 50,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getTitle(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images2/shape_star.png',
                            width: 16,
                            height: 16,
                            color: AppColors.star,
                          ),
                          Image.asset(
                            'assets/images2/tone_star.png',
                            width: 16,
                            height: 16,
                            color: AppColors.star,
                          ),
                        ],
                      ),
                      SizedBox(width: 4),
                      Text(
                        _getRating().toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
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