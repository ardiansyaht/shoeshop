import 'package:flutter/material.dart';
import 'package:project1/Pages/home_page.dart';
import 'package:project1/Pages/login.dart';
import 'package:project1/Pages/profile_page.dart';
import 'package:project1/Pages/settings_page.dart';

class AboutPage extends StatelessWidget {
  void logout(BuildContext context) {
    // Lakukan operasi logout di sini, jika diperlukan
    // Pindahkan ke halaman login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.black,
        elevation: 0,
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
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(Icons.shop),
                    iconColor: Colors.white,
                    title: Text('Shop'),
                    textColor: Colors.white,
                    onTap: () {
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutPage()),
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
                    leading: Icon(Icons.settings),
                    iconColor: Colors.white,
                    title: Text('Settings'),
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, bottom: 25),
              child: ListTile(
                leading: Icon(Icons.logout),
                iconColor: Colors.white,
                title: Text('Logout'),
                textColor: Colors.white,
                onTap: () {
                  logout(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/images/nike.png',
              color: Colors.black,
              height: 80,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome To Nike',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Text(
              'Tentang Kami',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Nike adalah perusahaan olahraga dan gaya hidup global yang berkantor pusat di Beaverton, Oregon, AS. Kami dikenal dengan alas kaki, pakaian, perlengkapan, dan aksesori atletik kami. Misi kami adalah memberikan inspirasi dan inovasi kepada setiap atlet di dunia.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Text(
              'Sepatu Kami',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Nike menawarkan berbagai macam sepatu olahraga dan kasual yang dirancang untuk performa dan gaya. Mulai dari lari dan bola basket hingga gaya hidup dan mode, sepatu kami dibuat dengan teknologi dan bahan mutakhir untuk memenuhi beragam kebutuhan atlet dan penggemar.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
