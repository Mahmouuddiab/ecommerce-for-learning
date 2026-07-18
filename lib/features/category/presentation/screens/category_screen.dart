import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Categories', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search categories...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Section Title
              const Text(
                'All Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Inlined Category Grid (2 columns)
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1, // Adjusted aspect ratio for grid items
                children: [
                  // Category Card 1: Development
                  Card(
                    elevation: 0,
                    color: Colors.blue[50],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.code, color: Colors.white, size: 24),
                            ),
                            const Spacer(),
                            const Text('Development', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                            const SizedBox(height: 4),
                            Text('142 Items', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Category Card 2: Design
                  Card(
                    elevation: 0,
                    color: Colors.purple[50],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.palette_outlined, color: Colors.white, size: 24),
                            ),
                            const Spacer(),
                            const Text('Design', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                            const SizedBox(height: 4),
                            Text('98 Items', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Category Card 3: Marketing
                  Card(
                    elevation: 0,
                    color: Colors.orange[50],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.trending_up, color: Colors.white, size: 24),
                            ),
                            const Spacer(),
                            const Text('Marketing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                            const SizedBox(height: 4),
                            Text('64 Items', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Category Card 4: Business
                  Card(
                    elevation: 0,
                    color: Colors.green[50],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.attach_money, color: Colors.white, size: 24),
                            ),
                            const Spacer(),
                            const Text('Business', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                            const SizedBox(height: 4),
                            Text('110 Items', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Category Card 5: Photography
                  Card(
                    elevation: 0,
                    color: Colors.pink[50],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 24),
                            ),
                            const Spacer(),
                            const Text('Photography', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                            const SizedBox(height: 4),
                            Text('45 Items', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Category Card 6: Music
                  Card(
                    elevation: 0,
                    color: Colors.teal[50],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.music_note, color: Colors.white, size: 24),
                            ),
                            const Spacer(),
                            const Text('Music', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                            const SizedBox(height: 4),
                            Text('32 Items', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Secondary Section Title
              const Text(
                'Trending Topics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Inlined Trending List Item 1
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.local_fire_department, color: Colors.white),
                  ),
                  title: Text('Artificial Intelligence', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('Trending hot macro category'),
                  trailing: Icon(Icons.chevron_right, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 8),

              // Inlined Trending List Item 2
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigo,
                    child: Icon(Icons.cloud_queue, color: Colors.white),
                  ),
                  title: Text('Cloud Computing', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('High workspace demand'),
                  trailing: Icon(Icons.chevron_right, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}