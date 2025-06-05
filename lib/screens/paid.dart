import 'package:flutter/material.dart';
import '../utils/app_fonts.dart';

class PaymentScreen extends StatefulWidget {
  final String destinationName;
  final double price;

  const PaymentScreen({
    Key? key,
    required this.destinationName,
    required this.price,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 0;
  final List<String> _paymentMethods = ['Credit Card', 'PayPal', 'Bank Transfer'];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _processPayment() {
    // Validar solo si es tarjeta de crédito (requiere formulario)
    bool isFormValid = true;
    if (_selectedPaymentMethod == 0) {
      isFormValid = _formKey.currentState!.validate();
    }

    if (isFormValid) {
      setState(() {
        _isLoading = true;
      });
      
      // Simular proceso de pago
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        
        // Mostrar diálogo de confirmación exitosa
        _showSuccessDialog();
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icono de éxito
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              
              // Título
              const Text(
                '¡Pago Exitoso!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              
              // Mensaje
              Text(
                'Tu pago de \$${widget.price.toStringAsFixed(2)} para ${widget.destinationName} ha sido procesado correctamente.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              
              // Método de pago usado
              Text(
                'Método: ${_paymentMethods[_selectedPaymentMethod]}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar diálogo
                  Navigator.of(context).pop(); // Regresar a pantalla anterior
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Continuar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCreditCardForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nombre en la tarjeta',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el nombre';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _cardNumberController,
            decoration: const InputDecoration(
              labelText: 'Número de tarjeta',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el número de tarjeta';
              } else if (value.length < 16 || value.length > 16) {
                return 'El número debe tener 16 dígitos';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _expiryDateController,
                  decoration: const InputDecoration(
                    labelText: 'Fecha de expiración (MM/AA)',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese la fecha';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _cvvController,
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el CVV';
                    } else if (value.length < 3 || value.length > 4) {
                      return 'CVV inválido';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPayPalForm() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Center(
        child: Text(
          'Serás redirigido a PayPal para completar el pago',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildBankTransferForm() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Detalles de la cuenta bancaria:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text('Banco: Banco Nacional'),
          Text('Cuenta: 1234-5678-9012-3456'),
          Text('Titular: Travel App Inc.'),
          Text('Referencia: Incluir tu nombre completo'),
          SizedBox(height: 16),
          Text(
            'Una vez realizada la transferencia, envíanos el comprobante a payments@travelapp.com',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentForm() {
    switch (_selectedPaymentMethod) {
      case 0:
        return _buildCreditCardForm();
      case 1:
        return _buildPayPalForm();
      case 2:
        return _buildBankTransferForm();
      default:
        return _buildCreditCardForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.white;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Opciones de Pago'),
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor ?? 
                          Theme.of(context).colorScheme.surface,
      ),
      body: Container(
        color: backgroundColor,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Resumen de la reserva
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Destino: ${widget.destinationName}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Precio total: \$${widget.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Métodos de pago
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Selecciona tu método de pago:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Opciones de pago
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: _paymentMethods.asMap().entries.map((entry) {
                      final index = entry.key;
                      final method = entry.value;
                      
                      return RadioListTile<int>(
                        title: Text(method),
                        value: index,
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                        secondary: Icon(_getPaymentIcon(index)),
                        activeColor: Theme.of(context).colorScheme.primary,
                      );
                    }).toList(),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Formulario del método de pago seleccionado
                _buildPaymentForm(),
                
                const SizedBox(height: 32),
                
                // Botón de pago
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _processPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(minHeight: 50),
                      child: _isLoading
                          ? const Center(
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  'Procesar Pago',
                                  style: AppFonts.botonInicio(18.0),
                                ),
                              ),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getPaymentIcon(int index) {
    switch (index) {
      case 0:
        return Icons.credit_card;
      case 1:
        return Icons.payment;
      case 2:
        return Icons.account_balance;
      default:
        return Icons.credit_card;
    }
  }
}