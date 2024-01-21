// shoe_firestore.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:project1/models/shoe.dart';

class ShoeFirestore {
  static Future<String?> uploadImageToStorage(String imagePath) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('shoe_images/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(File(imagePath));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print("Error uploading image to Storage: $error");
      return null;
    }
  }

  static Future<void> createShoeInFirestore(Shoe newShoe) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('shoeshop')
          .where('id', isEqualTo: newShoe.id)
          .get();

      if (querySnapshot.size == 0) {
        await FirebaseFirestore.instance.collection('shoeshop').doc(newShoe.id).set(newShoe.toMap());
      }
    } catch (error) {
      print("Error creating shoe in Firestore: $error");
    }
  }
}
