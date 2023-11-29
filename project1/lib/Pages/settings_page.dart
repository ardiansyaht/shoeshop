import 'package:flutter/material.dart';
import 'package:project1/Pages/about_page.dart';
import 'package:project1/Pages/home_page.dart';
import 'package:project1/Pages/login.dart';
import 'package:project1/Pages/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:project1/components/themenotifier.dart';



class SettingsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    // Mendapatkan referensi ke ThemeNotifier
    ThemeNotifier themeNotifier = context.watch<ThemeNotifier>();



    void logout() {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => LoginPage(),
    ),
  );
}

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: themeNotifier.backgroundColor,
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Image.asset(
                    'lib/images/nike.png',
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Divider(
                    color: Colors.grey[800],
                  ),
                ),
                // other pages
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(Icons.shop),
                    iconColor: Colors.white,
                    title: Text('Shop'),
                    textColor: Colors.white,
                     onTap: () {
                      // Navigasi ke halaman profil
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                     },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(Icons.info),
                    iconColor: Colors.white,
                    title: Text('About'),
                    textColor: Colors.white,
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>AboutPage()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    iconColor: Colors.white,
                    title: Text('Profile'),
                    textColor: Colors.white,
                    onTap: () {
                      // Navigasi ke halaman profil
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                 child: ListTile(
                 leading: Icon(Icons.settings), // Icon untuk menu pengaturan
                  iconColor: Colors.white,
                  title: Text('Settings'),
                   textColor: Colors.white,
                   onTap: () {
                   // Navigasi ke halaman pengaturan
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                    },
                      ),
                     ),
                // Additional options
                // ... (tambahkan opsi tambahan jika diperlukan)
              ],
            ),
            // logo
            Padding(
              padding: EdgeInsets.only(left: 25.0, bottom: 25),
              child: ListTile(
                leading: Icon(Icons.logout),
                iconColor: Colors.white,
                title: Text('Logout'),
                textColor: Colors.white,
                onTap: logout, // Tambahkan ini untuk menangani logout
              ),
            ),
          ],
        ),
        
      ),
      body: Container(
        color: themeNotifier.backgroundColor, // Menyesuaikan warna latar belakang
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<ThemeNotifier>(
                builder: (context, themeNotifier, child) {
                  return ElevatedButton(
                    onPressed: () {
                      themeNotifier.toggleTheme();
                    },
                    child: Text('Toggle Theme'),
                  );
                },
              ),
              SizedBox(height: 20),
              // Widget lainnya di dalam halaman pengaturan
            ],
          ),
        ),
      ),
    );
  }
}
