import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import '../utils/app_fonts.dart';
import '../themes/app_colors.dart';
import '../screens/details.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String? _selectedCountry;
  String? _selectedCategory;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _imagePaths = [
    'assets/images2/location1.png',
    'assets/images2/location2.png'
  ];
  // Nueva lista para la sección Recommended
  final List<String> _recommendedImagePaths = [
    'assets/images2/location3.png',
    'assets/images2/location4.png'
  ];
  final Map<String, bool> _isExpanded = {};
  final Map<String, bool> _isFavorite = {}; // Nueva variable agregada

  @override
  void initState() {
    super.initState();
    _selectedCountry = 'MX';
    _selectedCategory = 'Location';

    for (var path in _imagePaths) {
      _isExpanded[path] = false;
      _isFavorite[path] = false; // Inicialización añadida
    }
   for (var path in _recommendedImagePaths) {
      _isExpanded[path] = false;
      _isFavorite[path] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explore',
              style: AppFonts.subtitleWithColorNFontsize(15.0, Colors.black, FontWeight.w400),
            ),
            Text(
              'Aspen',
              style: AppFonts.subtitleWithColorNFontsize(30.0, Colors.black, FontWeight.w600),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedCountry,
                  items: ['ES', 'MX', 'AR','IT'].map((String pais) {
                    return DropdownMenuItem<String>( 
                      value: pais,
                      child: Row(
                        children: [
                          CountryFlag.fromCountryCode(
                            pais,
                            shape: const Circle(),
                          ),
                          const SizedBox(width: 8),
                          Text(pais),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (valor) {
                    setState(() {
                      _selectedCountry = valor;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return ['ES', 'MX', 'AR','IT'].map((String pais) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageIcon(
                            const AssetImage('assets/images/tone.png'),
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Aspen, ${_selectedCountry ?? pais}',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            'assets/images/down-arrow.png',
                            color: AppColors.primary,
                            width: 24,
                            height: 24,
                          ),
                        ],
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/images/Search.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  hintText: 'Find things to do',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'Location', 'Hotels', 'Food', 'Adventure', 'Shopping', 'Events', 'Transport'
                ].map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedCategory == category
                            ? Colors.grey[200]
                            : Colors.white,
                            elevation: 0,
                            
                        foregroundColor: _selectedCategory == category
                            ? AppColors.primary
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: _selectedCategory == category
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      child: Text(category),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PopularScreen()),
                    );
                  },
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: _imagePaths.map((path) {
                      // Obtener la calificación basada en el path de la imagen
                      double rating = path.contains('location1') ? 4.5 : 5.0;
                      // Obtener el título basado en el path de la imagen
                      String title = path.contains('location1') 
                          ? 'Alley Palace'
                          : path.contains('location2') 
                              ? 'Coeurdes Alpes'
                              : ''; // Para las nuevas imágenes

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // Check current state before changing
                            bool wasExpanded = _isExpanded[path] ?? false;
                            // Reset ALL images (both popular and recommended)
                            for (var imgPath in [..._imagePaths, ..._recommendedImagePaths]) {
                            _isExpanded[imgPath] = false;
                            }
                           // If this image wasn't expanded before, expand it now
                            if (!wasExpanded) {
                              _isExpanded[path] = true;
                            } else {
                              // If it was already expanded, navigate to details
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LocationDetailsScreen(
                                    imagePath: path,
                                  ),
                                ),
                              );
                            }
                          });
                        },
                        child: Stack(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: (MediaQuery.of(context).size.width - 48) / 2,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              transform: Matrix4.identity()
                                ..scale(_isExpanded[path]! ? 1.1 : 1.0),
                              transformAlignment: Alignment.center,
                            ),
                            // Añadir el título si existe
                            if (title.isNotEmpty)
                              Positioned(
                                left: 12,
                                bottom: 40, // Posicionado arriba del rating
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            Positioned(
                              left: 12,
                              bottom: 12,
                              child: Row(
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
                                  const SizedBox(width: 4),
                                  Text(
                                    rating.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(1, 1),
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // CORRECCIÓN: Botón de favorito ahora usa los iconos integrados de Flutter
                            Positioned(
                              right: 12,
                              bottom: 12,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isFavorite[path] = !_isFavorite[path]!;
                                  });
                                },
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      _isFavorite[path]! 
                                          ? Icons.favorite  // Icono de corazón lleno
                                          : Icons.favorite_border,  // Icono de corazón vacío
                                      size: 20,
                                      color: _isFavorite[path]! 
                                          ? AppColors.accent 
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  
                  // Título "Recommended" movido aquí, justo después de las imágenes
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recommended',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Aquí puedes añadir el contenido recomendado si lo tienes
                  // Contenido recomendado con las nuevas imágenes
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: _recommendedImagePaths.map((path) {
                      // Obtener títulos para las nuevas imágenes
                      String title = path.contains('location3') 
                          ? 'Mountain View'
                          : path.contains('location4') 
                              ? 'Lake Resort'
                              : '';
                      
                      return GestureDetector(
                       onTap: () {
                        setState(() {
                        // Check current state before changing
                        bool wasExpanded = _isExpanded[path] ?? false;
    
                        //   Reset ALL images (both popular and recommended)
                        for (var imgPath in [..._imagePaths, ..._recommendedImagePaths]) {
                          _isExpanded[imgPath] = false;
                        }
                        
                        // If this image wasn't expanded before, expand it now
                        if (!wasExpanded) {
                          _isExpanded[path] = true;
                        } else {
                          // If it was already expanded, navigate to details
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationDetailsScreen(
                                imagePath: path,
                              ),
                            ),
                          );
                        }
                      });
                    }, 
                    child: Stack(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: (MediaQuery.of(context).size.width - 48) / 2,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              transform: Matrix4.identity()
                                ..scale(_isExpanded[path]! ? 1.1 : 1.0),
                              transformAlignment: Alignment.center,
                            ),
                            // Añadir el título
                            if (title.isNotEmpty)
                              Positioned(
                                left: 12,
                                bottom: 12, // Actualizado: Posicionado abajo sin el rating
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            // CORRECCIÓN: Añadir botón de favorito a las tarjetas recomendadas
                            Positioned(
                              right: 12,
                              top: 12,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isFavorite[path] = !_isFavorite[path]!;
                                  });
                                },
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      _isFavorite[path]! 
                                          ? Icons.favorite  // Icono de corazón lleno
                                          : Icons.favorite_border,  // Icono de corazón vacío
                                      size: 20,
                                      color: _isFavorite[path]! 
                                          ? AppColors.accent 
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular'),
      ),
      body: Center(
        child: Text('Contenido Popular'),
      ),
    );
  }
}