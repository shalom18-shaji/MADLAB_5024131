

import 'package:flutter/material.dart';

void main() {
  runApp(const RestaurantFormApp());
}

class RestaurantFormApp extends StatelessWidget {
  const RestaurantFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Table Reservation',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const ReservationForm(),
    );
  }
}

class ReservationForm extends StatefulWidget {
  const ReservationForm({super.key});

  @override
  State<ReservationForm> createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  // Global key to manage the form
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  String selectedGuests = '2';
  bool agreedToTerms = false;
  bool obscurePassword = true;

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      if (!agreedToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please agree to the terms before submitting!',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '🎉 Reservation successful for ${nameController.text}! '
            'Table for $selectedGuests guests is reserved.',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🍴 Foodie Restaurant'),
        centerTitle: true,
      ),

      backgroundColor: Colors.orange.shade50,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [

                // Heading
                const Icon(
                  Icons.table_restaurant,
                  size: 70,
                  color: Colors.orange,
                ),

                const SizedBox(height: 10),

                const Text(
                  'Reserve Your Table',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                // Name Field
                TextFormField(
                  controller: nameController,

                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }

                    if (value.length < 3) {
                      return 'Name must contain at least 3 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Email Field
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,

                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Password Field
                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,

                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),

                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),

                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }

                    if (value.length < 6) {
                      return 'Password must contain at least 6 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Dropdown
                DropdownButtonFormField<String>(
                  value: selectedGuests,

                  decoration: const InputDecoration(
                    labelText: 'Number of Guests',
                    prefixIcon: Icon(Icons.people),
                    border: OutlineInputBorder(),
                  ),

                  items: ['1', '2', '3', '4', '5', '6']
                      .map(
                        (guest) => DropdownMenuItem(
                          value: guest,
                          child: Text('$guest Guests'),
                        ),
                      )
                      .toList(),

                  onChanged: (value) {
                    setState(() {
                      selectedGuests = value!;
                    });
                  },
                ),

                const SizedBox(height: 15),

                // Checkbox
                CheckboxListTile(
                  title: const Text(
                    'I agree to the restaurant terms and conditions',
                  ),

                  value: agreedToTerms,

                  activeColor: Colors.orange,

                  onChanged: (value) {
                    setState(() {
                      agreedToTerms = value!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                // Submit Button
                ElevatedButton.icon(
                  onPressed: submitForm,

                  icon: const Icon(Icons.check_circle),

                  label: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Reserve Table',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
