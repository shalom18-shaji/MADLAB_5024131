import 'package:flutter/material.dart';

void main() {
  runApp(const MovieExplorerApp());
}

class MovieExplorerApp extends StatelessWidget {
  const MovieExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Explorer',

      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),

      // Named Route
      routes: {
        '/': (context) => const HomeScreen(),
        '/details': (context) => const MovieDetailsScreen(),
      },

      initialRoute: '/',
    );
  }
}

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void showGestureMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget movieCard(
    BuildContext context,
    String title,
    String imageUrl,
    String genre,
  ) {
    return GestureDetector(

      // Single Tap
      onTap: () {
        Navigator.pushNamed(
          context,
          '/details',
          arguments: {
            'title': title,
            'image': imageUrl,
            'genre': genre,
          },
        );
      },

      // Double Tap
      onDoubleTap: () {
        showGestureMessage(
          context,
          '❤️ $title added to your favourites!',
        );
      },

      // Long Press
      onLongPress: () {
        showGestureMessage(
          context,
          '🎬 You are viewing $title',
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 18),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),

          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // Movie Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(
                top: Radius.circular(18),
              ),

              child: Image.network(
                imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Movie Information
            Padding(
              padding: const EdgeInsets.all(14),

              child: Row(
                children: [

                  const Icon(
                    Icons.movie,
                    color: Colors.indigo,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          genre,
                          style: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFF3F5FA),

      appBar: AppBar(
        title: const Text(
          '🎬 Movie Explorer',
        ),
        centerTitle: true,

        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(
                'Discover Movies',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263238),
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Tap a movie to view its details',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 20),

              // Movie 1
              movieCard(
                context,
                'Interstellar',
                'https://images.unsplash.com/photo-1446776877081-d282a0f896e2',
                'Science Fiction • Adventure',
              ),

              // Movie 2
              movieCard(
                context,
                'The Adventure',
                'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
                'Adventure • Drama',
              ),

              // Movie 3
              movieCard(
                context,
                'Into the Wild',
                'https://images.unsplash.com/photo-1500534623283-312aade485b7',
                'Drama • Adventure',
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  'Tap • Double Tap • Long Press',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
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

// ============================================================
// MOVIE DETAILS SCREEN
// ============================================================

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Receive arguments
    final arguments =
        ModalRoute.of(context)!.settings.arguments
            as Map<String, String>;

    final String title = arguments['title']!;
    final String image = arguments['image']!;
    final String genre = arguments['genre']!;

    return Scaffold(

      backgroundColor: const Color(0xFFF3F5FA),

      appBar: AppBar(
        title: const Text('Movie Details'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),

          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // Large Movie Image
            Image.network(
              image,
              height: 280,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263238),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [

                      const Icon(
                        Icons.category,
                        color: Colors.indigo,
                      ),

                      const SizedBox(width: 8),

                      Text(
                        genre,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'About the Movie',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Experience an unforgettable cinematic '
                    'journey filled with adventure, emotion '
                    'and memorable moments.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Favourite Button
                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              '❤️ Added to your favourites!',
                            ),
                          ),
                        );
                      },

                      icon: const Icon(
                        Icons.favorite,
                      ),

                      label: const Padding(
                        padding:
                            EdgeInsets.all(13),

                        child: Text(
                          'Add to Favourites',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Back Button
                  SizedBox(
                    width: double.infinity,

                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(
                        Icons.arrow_back,
                      ),

                      label: const Padding(
                        padding:
                            EdgeInsets.all(12),

                        child: Text(
                          'Back to Movies',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}