import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:madlab_5024125/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const CampusVaultApp());
}

class CampusVaultApp extends StatelessWidget {
  const CampusVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CampusVault',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      home: const CampusVaultHome(),
    );
  }
}

class CampusVaultHome extends StatefulWidget {
  const CampusVaultHome({super.key});

  @override
  State<CampusVaultHome> createState() => _CampusVaultHomeState();
}

class _CampusVaultHomeState extends State<CampusVaultHome> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final courseController = TextEditingController();

  final DatabaseReference studentsRef =
      FirebaseDatabase.instance.ref('students');

  String status = '';

  Future<void> saveStudent() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final course = courseController.text.trim();

    if (name.isEmpty || email.isEmpty || course.isEmpty) {
      setState(() {
        status = 'Please complete all fields.';
      });
      return;
    }

    try {
      final student = studentsRef.push();

      await student.set({
        'name': name,
        'email': email,
        'course': course,
        'timestamp': DateTime.now().toIso8601String(),
      });

      nameController.clear();
      emailController.clear();
      courseController.clear();

      setState(() {
        status = 'Student added successfully!';
      });
    } catch (e) {
      setState(() {
        status = 'Unable to save data.';
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    courseController.dispose();
    super.dispose();
  }

  Widget inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE4E7EC),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFF6366F1),
            width: 2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(32, 45, 32, 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF4F46E5),
                    Color(0xFF7C3AED),
                    Color(0xFF9333EA),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 950),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.school_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CampusVault',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Student data, connected to the cloud',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      const Text(
                        'Student Cloud Registry',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Add and manage student information securely using Firebase Realtime Database.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 950),
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.person_add_alt_1_rounded,
                            size: 25,
                            color: Color(0xFF4F46E5),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Add Student',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            inputField(
                              controller: nameController,
                              label: 'Student Name',
                              icon: Icons.person_outline_rounded,
                            ),

                            const SizedBox(height: 15),

                            inputField(
                              controller: emailController,
                              label: 'Email Address',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                            ),

                            const SizedBox(height: 15),

                            inputField(
                              controller: courseController,
                              label: 'Course / Department',
                              icon: Icons.school_outlined,
                            ),

                            const SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton.icon(
                                onPressed: saveStudent,
                                icon: const Icon(
                                  Icons.cloud_upload_rounded,
                                ),
                                label: const Text(
                                  'Save Student to Cloud',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4F46E5),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),

                            if (status.isNotEmpty) ...[
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    size: 18,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    status,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 35),

                      StreamBuilder<DatabaseEvent>(
                        stream: studentsRef.onValue,
                        builder: (context, snapshot) {
                          final data = snapshot.data?.snapshot.value;

                          int count = 0;

                          if (data is Map) {
                            count = data.length;
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.groups_rounded,
                                    color: Color(0xFF4F46E5),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Cloud Students',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEDE9FE),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '$count Students',
                                      style: const TextStyle(
                                        color: Color(0xFF5B21B6),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 18),

                              if (snapshot.hasError)
                                const Center(
                                  child: Text(
                                    'Unable to load Firebase data.',
                                  ),
                                )
                              else if (!snapshot.hasData)
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(40),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              else if (data == null)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(40),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: const Column(
                                    children: [
                                      Icon(
                                        Icons.cloud_off_rounded,
                                        size: 45,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        'No students yet',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Add your first student above.',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                ...Map<dynamic, dynamic>.from(data as Map)
                                    .entries
                                    .map((entry) {
                                  final student =
                                      Map<dynamic, dynamic>.from(
                                    entry.value as Map,
                                  );

                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.04),
                                          blurRadius: 15,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 8,
                                      ),
                                      leading: CircleAvatar(
                                        radius: 26,
                                        backgroundColor:
                                            const Color(0xFFEDE9FE),
                                        child: Text(
                                          (student['name'] ?? 'S')
                                              .toString()
                                              .substring(0, 1)
                                              .toUpperCase(),
                                          style: const TextStyle(
                                            color: Color(0xFF5B21B6),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        student['name'] ?? 'Unknown',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5),
                                        child: Text(
                                          '${student['email'] ?? ''}  •  ${student['course'] ?? ''}',
                                        ),
                                      ),
                                      trailing: const Icon(
                                        Icons.cloud_done_rounded,
                                        color: Colors.green,
                                      ),
                                    ),
                                  );
                                }),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}