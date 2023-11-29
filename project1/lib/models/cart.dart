import 'package:flutter/material.dart';
import 'shoe.dart';

class Cart extends ChangeNotifier {
  List<Shoe> shoeShop = [
    Shoe(name: 'Zoom FREAK', price: '136', description: 'FLY', imagePath: 'lib/images/zoomfreak.png'),
    Shoe(name: 'Air Jordan', price: '240', description: 'HE CAN FLY', imagePath: 'lib/images/airjordan.png'),
    Shoe(name: 'KD Trey', price: '210', description: 'GOOD', imagePath: 'lib/images/kdtrey.png'),
    Shoe(name: 'Kyrie 6', price: '180', description: 'CHOICE', imagePath: 'lib/images/kyrie.png'),
  ];

  List<Shoe> userCart = [];

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
    notifyListeners();
  }

  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }
}

