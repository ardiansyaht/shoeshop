import 'package:flutter/material.dart';
import 'shoe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends ChangeNotifier {
  List<Shoe> shoeShop = [
    Shoe(id: '1', name: 'Zoom FREAK', price: '136', description: 'FLY', imagePath: 'lib/images/zoomfreak.png'),
    Shoe(id: '2', name: 'Air Jordan', price: '240', description: 'HE CAN FLY', imagePath: 'lib/images/airjordan.png'),
    Shoe(id: '3', name: 'KD Trey', price: '210', description: 'GOOD', imagePath: 'lib/images/kdtrey.png'),
    Shoe(id: '4', name: 'Kyrie 6', price: '180', description: 'CHOICE', imagePath: 'lib/images/kyrie.png'),
  ];

  List<Shoe> userCart = [];
  late SharedPreferences prefs;

  Cart() {
    // Inisialisasi shared preferences
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();

    // Load keranjang belanja dari shared preferences
    loadCart();
  }

  List<Shoe> getShoeList() {
    return shoeShop;
  }

  List<Shoe> getUserCart() {
    return userCart;
  }

  List<Shoe> getFavoriteShoes() {
    return shoeShop.where((shoe) => shoe.isFavorite).toList();
  }

  void toggleFavorite(Shoe shoe) {
    shoe.isFavorite = !shoe.isFavorite;
    notifyListeners();
  }

  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    saveCart(); // Simpan keranjang belanja setiap kali ditambahkan
    notifyListeners();
  }

  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    saveCart(); // Simpan keranjang belanja setiap kali dihapus
    notifyListeners();
  }

  // Menyimpan keranjang belanja ke shared preferences
  Future<void> saveCart() async {
    List<String> cartList = userCart.map((shoe) => shoe.id).toList();
    await prefs.setStringList('cart', cartList);
  }

  // Memuat keranjang belanja dari shared preferences
  Future<void> loadCart() async {
    List<String>? cartList = prefs.getStringList('cart');
    if (cartList != null) {
      userCart = shoeShop.where((shoe) => cartList.contains(shoe.id)).toList();
      notifyListeners();
    }
  }
}
