import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AssetsMediaPage extends StatefulWidget {
  const AssetsMediaPage({super.key});

  @override
  State<AssetsMediaPage> createState() => _AssetsMediaPageState();
}

class _AssetsMediaPageState extends State<AssetsMediaPage> {
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  int _currentIndex = 0; // state untuk BottomNavigationBar

  @override
  void initState() {
    super.initState();
    // Saat audio selesai, ikon kembali ke play
    player.onPlayerComplete.listen((_) {
      if (mounted) setState(() => isPlaying = false);
    });
  }

  void playAudio() async {
    if (isPlaying) {
      await player.pause();
    } else {
      await player.play(AssetSource('audios/music.mp3'));
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F8),

      // ===== APPBAR =====
      appBar: AppBar(
        title: const Text('Beranda Assets & Media'),
        backgroundColor: const Color(0xFFFFE0EC),
      ),

      // ===== DRAWER =====
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFD6336C)),
              child: Text(
                'Menu Navigasi',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.video_library,
                color: Color(0xFFD6336C),
              ),
              title: const Text('Halaman Video'),
              onTap: () {
                // Tutup drawer dulu (Pop)
                Navigator.pop(context);
                // Pindah ke halaman detail sambil membawa data
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: 'Data dari Halaman Beranda',
                );
              },
            ),
          ],
        ),
      ),

      // ===== BODY =====
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // ----- PROFILE -----
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/profile.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Meidina Aulia',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ----- AUDIO -----
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Audio Motivasi',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE0EC),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 27,
                            backgroundColor: const Color(0xFFD6336C),
                            child: IconButton(
                              onPressed: playAudio,
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          const Expanded(
                            child: LinearProgressIndicator(
                              minHeight: 6,
                              backgroundColor: Color(0xFFF8BBD0),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFD6336C),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          const Icon(Icons.volume_up, color: Color(0xFF5A1A36)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // ===== BOTTOM NAVIGATION BAR =====
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFD6336C),
        onTap: (index) async {
          if (index == 1) {
            setState(() => _currentIndex = 1);
            await Navigator.pushNamed(context, '/detail');
            if (!mounted) return;
            setState(() => _currentIndex = 0); // balik ke tab Beranda
          } else {
            setState(() => _currentIndex = index);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Video',
          ),
        ],
      ),
    );
  }
}
