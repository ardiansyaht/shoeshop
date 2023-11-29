import 'package:flutter/material.dart';
import 'package:project1/components/shoe_tile.dart';
import 'package:project1/models/shoe.dart';
import 'package:provider/provider.dart';
import 'package:project1/models/cart.dart';
import 'package:project1/components/themenotifier.dart';

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

  // Function to filter shoes based on search query
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

    // alert the user, shoe successfully added
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Successfully added!"),
        content: Text("Check your cart"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allShoes = Provider.of<Cart>(context).getShoeList();
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        backgroundColor: themeNotifier.backgroundColor,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: textColor),
            onPressed: () {
              // Handle search icon pressed
              // You can open a search dialog or perform any other action here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
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
                // Search TextField
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (query) {
                      filterShoes(query, allShoes);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                // Search Icon (Moved to AppBar)
              ],
            ),
          ),

          // Message
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'everyone flies.. some fly longer than others',
              style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
            ),
          ),

          // Hot Picks
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Hot Picks 🔥',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: textColor,
                  ),
                ),
                Text(
                  'See all',
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

          // List of shoes for sale using GridView
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: displayedShoes.isNotEmpty
                  ? displayedShoes.length
                  : allShoes.length,
              itemBuilder: (context, index) {
                // create shoe
                Shoe shoe =
                    displayedShoes.isNotEmpty ? displayedShoes[index] : allShoes[index];
                return ShoeTile(
                  shoe: shoe,
                  onTap: () => addShoeToCart(shoe),
                );
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
