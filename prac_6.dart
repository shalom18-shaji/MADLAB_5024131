import 'package:flutter/material.dart';

void main() {
  runApp(const TravelDashboardApp());
}

class TravelDashboardApp extends StatelessWidget {
  const TravelDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TravelDashboard(),
    );
  }
}

class TravelDashboard extends StatelessWidget {
  const TravelDashboard({super.key});

  // ================= STATISTICS CARD =================

  Widget statisticCard(
    IconData icon,
    String value,
    String title,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),

          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(9),

              decoration: const BoxDecoration(
                color: Color(0xFFE8EEF5),
                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                size: 23,
                color: const Color(0xFF355C7D),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),

            const SizedBox(height: 3),

            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF7A8793),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= CHART BAR =================

  Widget chartBar(
    String month,
    int value,
    double height,
    Color color,
  ) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4A5560),
            ),
          ),

          const SizedBox(height: 7),

          Container(
            width: 30,
            height: height,

            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(7),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            month,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF59636E),
            ),
          ),
        ],
      ),
    );
  }

  // ================= FEATURED DESTINATION =================

  Widget destinationCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(18),
            ),

            child: Image.network(
              'https://images.unsplash.com/photo-1537996194471-e657df975ab4',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15),

            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Color(0xFF355C7D),
                ),

                const SizedBox(width: 8),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'Bali, Indonesia',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        'Beaches, culture and unforgettable sunsets.',
                        style: TextStyle(
                          color: Color(0xFF7A8793),
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.favorite_border,
                  color: Color(0xFF355C7D),
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
      backgroundColor: const Color(0xFFF3F6F8),

      appBar: AppBar(
        title: const Text(
          '✈️ Travel Explorer',
        ),
        centerTitle: true,

        backgroundColor: const Color(0xFF355C7D),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [

              // ================= HERO IMAGE =================

              ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: Stack(
                  alignment: Alignment.center,

                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1469474968028-56623f02e42e',
                      height: 190,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    Container(
                      height: 190,
                      color: Colors.black38,
                    ),

                    const Column(
                      children: [
                        Icon(
                          Icons.flight_takeoff,
                          size: 48,
                          color: Colors.white,
                        ),

                        SizedBox(height: 10),

                        Text(
                          'Explore The World',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Every journey begins with a single step',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ================= TRAVEL OVERVIEW =================

              const Text(
                'Travel Overview',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  statisticCard(
                    Icons.flight_takeoff,
                    '12',
                    'Flights',
                  ),

                  statisticCard(
                    Icons.location_on,
                    '8',
                    'Places',
                  ),

                  statisticCard(
                    Icons.hotel,
                    '15',
                    'Stays',
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ================= TRAVEL ACTIVITY =================

              const Text(
                'Travel Activity',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),

                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    const Text(
                      'Trips Completed',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      height: 170,

                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.end,

                        children: [
                          chartBar(
                            'Jan',
                            55,
                            70,
                            const Color(0xFF8FA7B8),
                          ),

                          chartBar(
                            'Mar',
                            80,
                            105,
                            const Color(0xFF6F8FA6),
                          ),

                          chartBar(
                            'May',
                            65,
                            85,
                            const Color(0xFF7895A8),
                          ),

                          chartBar(
                            'Jul',
                            95,
                            125,
                            const Color(0xFF355C7D),
                          ),

                          chartBar(
                            'Sep',
                            75,
                            95,
                            const Color(0xFF5E7E95),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ================= FEATURED DESTINATION =================

              const Text(
                'Featured Destination',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),

              const SizedBox(height: 12),

              destinationCard(),

              const SizedBox(height: 25),

              // ================= FOOTER =================

              const Center(
                child: Text(
                  'Made with ❤️ for the love of travel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF355C7D),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}