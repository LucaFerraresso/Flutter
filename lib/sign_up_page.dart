import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Funzione di validazione per il nome e il cognome
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Il nome non può essere vuoto';
    } else if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
      return 'Il nome non può contenere numeri o caratteri speciali';
    }
    return null;
  }

  // Funzione di validazione per la data di nascita (opzionale)
  String? _validateDob(String? value) {
    if (value == null || value.isEmpty) {
      return 'La data di nascita non può essere vuota';
    }
    return null;
  }

  // Funzione di validazione per l'email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'L\'email non può essere vuota';
    } else if (!value.contains('@')) {
      return 'L\'email deve contenere una @';
    }
    return null;
  }

  // Funzione di validazione per la password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La password non può essere vuota';
    } else if (value.length < 6) {
      return 'La password deve contenere almeno 6 caratteri';
    }
    return null;
  }

  // Funzione per inviare il form
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrazione completata!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compila correttamente tutti i campi')),
      );
    }
  }

  // Funzione per selezionare la data di nascita
  Future<void> _selectDob(BuildContext context) async {
    final DateTime initialDate = DateTime.now();
    final DateTime firstDate = DateTime(1900);
    final DateTime lastDate = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text =
            '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrazione')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  // Titolo
                  Text(
                    'Crea un nuovo account',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 30),
                  // Nome
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    validator: _validateName,
                  ),
                  const SizedBox(height: 15),
                  // Cognome
                  TextFormField(
                    controller: _surnameController,
                    decoration: InputDecoration(
                      labelText: 'Cognome',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    validator: _validateName,
                  ),
                  const SizedBox(height: 15),
                  // Data di nascita
                  GestureDetector(
                    onTap: () => _selectDob(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _dobController,
                        decoration: InputDecoration(
                          labelText: 'Data di Nascita',
                          prefixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: _validateDob,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Email
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 15),
                  // Password
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    obscureText: true,
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 30),
                  // Pulsante di registrazione
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      iconColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Registrati'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
