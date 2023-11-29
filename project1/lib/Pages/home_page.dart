import 'package:flutter/material.dart';
import 'package:project1/Pages/about_page.dart';
import 'package:project1/Pages/cart_page.dart';
import 'package:project1/Pages/login.dart';
import 'package:project1/Pages/profile_page.dart';
import 'package:project1/Pages/settings_page.dart';
import 'package:project1/Pages/shop_page.dart';
import '../components/bottom_nav_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigationBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void logout() {
  // Lakukan operasi logout di sini, jika diperlukan
  // Pindahkan ke halaman login
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => LoginPage(),
    ),
  );
}

  //page display
  final List<Widget> _pages = [
    //shop page
    const ShopPage(),

    // cart page
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigationBottomBar(index),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
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
      body: _pages[_selectedIndex],
    );
  }
}
