import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../screens/paid.dart';

class LocationDetailsScreen extends StatefulWidget {
  final String imagePath;

  const LocationDetailsScreen({
    super.key,
    required this.imagePath,
  });

  @override
  State<LocationDetailsScreen> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  bool _expanded = false;
  bool _isFavorite = false; // Variable para controlar el estado del favorito

  // Método para obtener el título basado en la ruta de la imagen
  String _getTitle() {
    if (widget.imagePath.contains('location1')) return 'Alley Palace';
    if (widget.imagePath.contains('location2')) return 'Coeurdes Alpes';
    if (widget.imagePath.contains('location3')) return 'Mountain View';
    if (widget.imagePath.contains('location4')) return 'Lake Resort';
    return 'Location Details';
  }

  // Método para obtener la calificación basada en la ruta de la imagen
  double _getRating() {
    if (widget.imagePath.contains('location1')) return 4.5;
    if (widget.imagePath.contains('location2')) return 5.0;
    return 4.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                          widget.imagePath,
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
                  // Botón de favorito (corazón)
                  Positioned(
                    bottom: 30,
                    right: 40,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFavorite = !_isFavorite; // Toggle del estado de favorito
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Image.asset(
                          _isFavorite 
                            ? 'assets/images2/heart.png' // Corazón lleno
                            : 'assets/images2/heart.png', // Usa el mismo archivo pero aplicamos opacidad
                          width: 24,
                          height: 24,
                          color: _isFavorite ? Colors.red : Colors.red.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Fila con título y "Show map"
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Título
                    Expanded(
                      child: Text(
                        _getTitle(),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Texto "Show map" clickeable
                    GestureDetector(
                      onTap: () {
                        // Acción cuando se hace clic en "Show map"
                        print('Show map clicked');
                        // Aquí puedes agregar la navegación al mapa
                      },
                      child: Text(
                        "Show map",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
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
              
              // Espacio entre calificación y descripción
              SizedBox(height: 16),
              
              // Descripción con Read more/less
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Aspen is as close as one can get to a storybook alpine town in America. The choose-your-own-adventure possibilities—skiing, hiking, dining shopping and ....",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                    
                    // Texto expandible
                    if (_expanded)
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "Disfruta de los maravillosos paisajes y experiencias",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                      ),
                    
                    // Botón Read more/less
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _expanded = !_expanded;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          _expanded ? "Read less" : "Read more",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Espacio entre descripción y facilities
              SizedBox(height: 24),
              
              // Sección de Facilities
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título de Facilities
                    Text(
                      "Facilities",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    // Espacio entre título y los iconos
                    SizedBox(height: 16),
                    
                    // Fila de iconos de facilities
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Facility 1 - Heater
                        _buildFacilityItem(
                          'assets/facilities/facilitie1.png', 
                          'Heater'
                        ),
                        
                        // Facility 2 - Dinner
                        _buildFacilityItem(
                          'assets/facilities/facilitie2.png', 
                          'Dinner'
                        ),
                        
                        // Facility 3 - Tub
                        _buildFacilityItem(
                          'assets/facilities/facilitie3.png', 
                          'Tub'
                        ),
                        
                        // Facility 4 - Pool
                        _buildFacilityItem(
                          'assets/facilities/facilitie4.png', 
                          'Pool'
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Espacio entre facilities y precio
              SizedBox(height: 24),
              
              // Sección de Precio y botón Book Now
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Columna de precio
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "\$199",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    
                    // Botón Book Now
                    ElevatedButton(
                      onPressed: () {
                        // Navegar a la pantalla de pagos cuando se hace clic en "Book Now"
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              destinationName: "París", // Valor estático de ejemplo
                              price: 1299.99, // Valor estático de ejemplo
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Book Now",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Espacio al final
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  
  // Widget para construir cada ítem de facility
  Widget _buildFacilityItem(String imagePath, String label) {
    return Column(
      children: [
        // Icono con fondo gris circular
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              width: 35,
              height: 35,
            ),
          ),
        ),
        
        // Espacio entre icono y texto
        SizedBox(height: 8),
        
        // Texto debajo del icono
        Text(
          label,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}