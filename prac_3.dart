

import 'package:flutter/material.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodie Restaurant',

      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),

      home: const RestaurantHome(),
    );
  }
}

class RestaurantHome extends StatefulWidget {
  const RestaurantHome({super.key});

  @override
  State<RestaurantHome> createState() => _RestaurantHomeState();
}

class _RestaurantHomeState extends State<RestaurantHome> {
  String selectedFood = '';
  String message = 'Choose your favourite food!';

  void orderFood(String food) {
    setState(() {
      selectedFood = food;
      message =
          'Hello, Shalom! 👋\nYour $food will be ready in a few minutes! 🍽️';
    });
  }

  Widget foodCard(
    String food,
    String imageUrl,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () {
        orderFood(food);
      },

      child: Container(
        width: 150,
        margin: const EdgeInsets.all(8),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          children: [

            // Food Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),

              child: Image.network(
                imageUrl,
                height: 110,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 8),

            // Food Name
            Text(
              food,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            // Icon
            Icon(
              icon,
              color: Colors.orange,
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
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

          child: Column(
            children: [

              // Welcome Text
              const Text(
                'Welcome to Foodie!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'What would you like to order today?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 25),

              // Food Cards
              Wrap(
                alignment: WrapAlignment.center,
                children: [

                  foodCard(
                    'Burger',
                    'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
                    Icons.lunch_dining,
                  ),

                  foodCard(
                    'Pizza',
                    'https://images.unsplash.com/photo-1513104890138-7c749659a591',
                    Icons.local_pizza,
                  ),

                  foodCard(
                    'Pasta',
                    'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9',
                    Icons.restaurant,
                  ),

                  foodCard(
                    'Dessert',
                    'https://images.unsplash.com/photo-1551024506-0bccd828d307',
                    Icons.cake,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Selected Food Icon
              if (selectedFood.isNotEmpty)
                const Icon(
                  Icons.restaurant_menu,
                  size: 50,
                  color: Colors.orange,
                ),

              const SizedBox(height: 10),

              // Message Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Button
              ElevatedButton.icon(
                onPressed: selectedFood.isEmpty
                    ? null
                    : () {
                        setState(() {
                          selectedFood = '';
                          message = 'Choose your favourite food!';
                        });
                      },

                icon: const Icon(Icons.refresh),

                label: const Text('Choose Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
