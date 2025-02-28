// lib/screens/explore.dart
import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import '../utils/app_fonts.dart';
import '../themes/app_colors.dart';
import '../themes/app_themes.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String? _selectedCountry;
  String? _selectedCategory;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCountry = 'MX';
    _selectedCategory = 'Location'; // Categoría seleccionada por defecto
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
          Container(
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
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¡Bienvenido a la sección de exploración!',
                    style: TextStyle(
                      fontFamily: 'Hiatus',
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text(
                      'Volver',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
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