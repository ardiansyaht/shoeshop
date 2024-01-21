import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart'; 
import 'package:project1/Pages/shoe_firestore.dart'; 
import 'package:project1/models/shoe.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class CreateShoePage extends StatefulWidget {
  @override
  _CreateShoePageState createState() => _CreateShoePageState();
}

class _CreateShoePageState extends State<CreateShoePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Shoe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Harga'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            // Existing TextFields...

            // Image selection button
            ElevatedButton(
              onPressed: () async {
                // Open the image picker
                final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

                // Update the state with the selected image file
                setState(() {
                  if (pickedFile != null) {
                    _image = File(pickedFile.path);
                  }
                });
              },
              child: Text('Pilih Gambar'),
            ),
            
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_image == null) {
                  Fluttertoast.showToast(msg: "Pilih gambar terlebih dahulu!");
                  return;
                }

                // Membuat objek Sepatu dari input pengguna
                Shoe newShoe = Shoe(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  price: priceController.text,
                  description: descriptionController.text,
                  imagePath: '', 
                );

                // Upload gambar dan dapatkan URL unduhan
                String imageUrl = await uploadImageAndGetUrl(_image!);
                newShoe.imagePath = imageUrl;

                // Menambahkan sepatu ke Firestore
                await ShoeFirestore.createShoeInFirestore(newShoe);

                // Tampilkan notifikasi keberhasilan
                Fluttertoast.showToast(msg: "Sepatu berhasil dibuat!");

                // Kosongkan nilai TextField setelah pembuatan sepatu
                nameController.clear();
                priceController.clear();
                descriptionController.clear();
              },
              child: Text('Buat Sepatu'),
            ),
          ],
        ),
      ),
    );
  }

  // Metode untuk mengunggah gambar dan mendapatkan URL unduhan
  Future<String> uploadImageAndGetUrl(File imageFile) async {
    try {
      // Menghasilkan nama file dengan ekstensi .jpg
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
          '_' +
          path.basename(imageFile.path);

      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);

      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      print("Download URL: $imageUrl");

      return imageUrl;
    } catch (e) {
      // Tangani kesalahan pengunggahan gambar di sini
      print("Error uploading image: $e");
      Fluttertoast.showToast(msg: "Terjadi kesalahan saat mengunggah gambar");
      return ''; // Atau kembalikan nilai lain yang sesuai dengan kebutuhan Anda
    }
  }
}
