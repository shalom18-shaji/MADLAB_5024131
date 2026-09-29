import 'package:flutter/material.dart';

void main() {
  runApp(const LayoutLabApp());
}

class LayoutLabApp extends StatelessWidget {
  const LayoutLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodie Layout Lab',

      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),

      home: const FoodieHomePage(),
    );
  }
}

class FoodieHomePage extends StatelessWidget {
  const FoodieHomePage({super.key});

  // Food Image Card
  Widget foodCard(
    String imageUrl,
    String foodName,
    String description,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),

        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.orange.shade300,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),

        child: Column(
          children: [

            // Food Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(11),
              ),

              child: Image.network(
                imageUrl,
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 8),

            // Food Name
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),

              child: Text(
                foodName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ),

            const SizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.all(5),

              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  // Information Card
  Widget infoCard(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.orange.shade200,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              size: 28,
              color: Colors.deepOrange,
            ),
          ),

          const SizedBox(width: 15),

          Flexible(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,

      appBar: AppBar(
        title: const Text(
          '🍴 Foodie Restaurant',
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,

            children: [

              // ================= HEADER =================

              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.deepOrange,
                      Colors.orange,
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(15),
                ),

                child: Column(
                  children: [

                    const Icon(
                      Icons.restaurant,
                      size: 50,
                      color: Colors.white,
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Welcome to Foodie!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Delicious food served with love',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ================= FOOD SECTION =================

              const Text(
                'Our Popular Food',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),

              const SizedBox(height: 12),

              // Row of Food Images
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  foodCard(
                    'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
                    'Burger',
                    'Fresh and delicious',
                  ),

                  foodCard(
                    

              // ================= INFORMATION SECTION =================

              const Text(
                'Restaurant Information',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),

              const SizedBox(height: 12),

              infoCard(
                Icons.access_time,
                'Opening Hours',
                'Open from 10:00 AM to 11:00 PM',
              ),

              infoCard(
                Icons.location_on,
              
            ],
          ),
        ),
      ),
    );
  }
}




