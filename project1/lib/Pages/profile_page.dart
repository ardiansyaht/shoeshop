import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project1/Pages/about_page.dart';
import 'package:project1/Pages/home_page.dart';
import 'package:project1/Pages/login.dart';
import 'package:project1/Pages/settings_page.dart';




class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  String name = 'Ardhiansyah Tanjung';
  String email = 'ardiansyah3151@gmail.com';
  DateTime birthdate = DateTime(2003, 6, 11);
  String phoneNumber = '6281912388170';


  


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
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.grey[900],
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto Profil
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('lib/images/profile.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Informasi Pengguna
            buildInfoTile(Icons.person, 'Name', name),
            buildInfoTile(Icons.email, 'Email', email),
            buildInfoTile(Icons.calendar_today, 'Birthdate', DateFormat('dd MMMM yyyy').format(birthdate)),
            buildInfoTile(Icons.phone, 'Phone Number', phoneNumber, isNumeric: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showEditDialog(context),
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoTile(IconData icon, String label, String text, {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label: $text',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

 Future<void> _showEditDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _buildEditField('Name', name, (value) => name = value),
              _buildEditField('Email', email, (value) => email = value),
              _buildDateField('Birthdate', birthdate),
              _buildEditField('Phone Number', phoneNumber, (value) => phoneNumber = value, isNumeric: true),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Perform save operation
              // You can add validation or other logic here
              setState(() {}); 
              Navigator.of(context).pop(); 
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}

  Widget _buildEditField(String label, String initialValue, Function(String) onChanged,
      {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(labelText: label),
        controller: TextEditingController(text: initialValue),
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDateField(String label, DateTime selectedDate) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => _selectDate(context, selectedDate),
        child: Row(
          children: [
            Icon(Icons.calendar_today),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                '$label: ${DateFormat('dd MMMM yyyy').format(selectedDate)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
  }

 Future<void> _selectDate(BuildContext context, DateTime selectedDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (picked != null && picked != selectedDate) {
    setState(() {
      birthdate = picked;
    });
  }
}

}