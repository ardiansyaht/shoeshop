import 'package:flutter/material.dart';
import 'package:project1/components/shoe_tile.dart';
import 'package:project1/models/shoe.dart';
import 'package:provider/provider.dart';
import 'package:project1/models/cart.dart';
import 'package:project1/components/themenotifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  TextEditingController searchController = TextEditingController();
  List<Shoe> displayedShoes = [];
  late Color textColor;
  late Color backgroundColor;

  @override
  void initState() {
    super.initState();
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    textColor = themeNotifier.isDarkMode ? Colors.white : Colors.black;
    backgroundColor = themeNotifier.backgroundColor ?? Colors.transparent;
  }

  // Fungsi untuk menyaring sepatu berdasarkan pencarian
  void filterShoes(String query, List<Shoe> allShoes) {
    setState(() {
      displayedShoes = allShoes
          .where((shoe) =>
              shoe.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void addShoeToCart(Shoe shoe) {
    Provider.of<Cart>(context, listen: false).addItemToCart(shoe);
    addShoeToFirebase(shoe);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Berhasil ditambahkan!"),
        content: Text("Periksa keranjang Anda"),
      ),
    );
  }

  Future<void> addShoeToFirebase(Shoe shoe) async {
    // Cek apakah sepatu dengan ID yang sama sudah ada di database
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('shoeshop')
        .where('id', isEqualTo: shoe.id)
        .get();

    if (querySnapshot.size == 0) {
      // Jika sepatu dengan ID yang sama tidak ada, tambahkan ke database
      await FirebaseFirestore.instance.collection('shoeshop').doc(shoe.id).set(shoe.toMap());
    }
  }

  Future<List<Shoe>> getShoesFromFirebase() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('shoeshop').get();
    return querySnapshot.docs
        .map((doc) => Shoe.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateShoeInFirebase(Shoe updatedShoe) async {
    await FirebaseFirestore.instance
        .collection('shoeshop')
        .doc(updatedShoe.id)
        .update(updatedShoe.toMap());
  }

  Future<void> deleteShoeFromFirebase(String shoeId) async {
    await FirebaseFirestore.instance
        .collection('shoeshop')
        .doc(shoeId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    final allShoes = Provider.of<Cart>(context).getShoeList();
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Toko'),
        backgroundColor: themeNotifier.backgroundColor,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: textColor),
            onPressed: () {
              // Menghandle ketika ikon pencarian ditekan
              // Anda dapat membuka dialog pencarian atau melakukan tindakan lain di sini
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Bilah pencarian
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TextField Pencarian
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (query) {
                      filterShoes(query, allShoes);
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                // Ikon Pencarian (Dipindahkan ke AppBar)
              ],
            ),
          ),

          // Pesan
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'semua orang terbang.. beberapa terbang lebih lama dari yang lain',
              style: TextStyle(
                  color: Colors.grey[600], fontWeight: FontWeight.bold),
            ),
          ),

          // Pilihan Terpopuler
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Pilihan Terpopuler 🔥',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: textColor,
                  ),
                ),
                Text(
                  'Lihat semua',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Daftar sepatu yang dijual menggunakan GridView
          Expanded(
            child: FutureBuilder<List<Shoe>>(
              future: getShoesFromFirebase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Shoe> shoes =
                      displayedShoes.isNotEmpty ? displayedShoes : snapshot.data!;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: shoes.length,
                    itemBuilder: (context, index) {
                      Shoe shoe = shoes[index];
                      return ShoeTile(
                        shoe: shoe,
                        onTap: () {
                          addShoeToCart(shoe);
                          addShoeToFirebase(shoe);
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Divider(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
