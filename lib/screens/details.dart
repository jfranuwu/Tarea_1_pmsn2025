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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Parte superior con la imagen y botón de retroceso
            Stack(
              children: [
                // Imagen
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
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
                ),
                // Botón de retroceso
                Positioned(
                  top: 20,
                  left: 20,
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
              ],
            ),
            
            // Título (sobre fondo blanco)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                _getTitle(),
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Espacio entre título y calificación
            SizedBox(height: 8),
            
            // Calificación con estrellas y número de reviews
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images2/shape_star.png',
                        width: 18,
                        height: 18,
                        color: AppColors.star,
                      ),
                      Image.asset(
                        'assets/images2/tone_star.png',
                        width: 18,
                        height: 18,
                        color: AppColors.star,
                      ),
                    ],
                  ),
                  SizedBox(width: 6),
                  Text(
                    "${_getRating()} (355 reviews)",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            // Espacio para más contenido si es necesario
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}