import 'package:flutter/material.dart';
import '../common/color_extension.dart';
import 'cart_page.dart';
import 'item_detail_page.dart';

class BistroMenuPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final Function(Map<String, dynamic>) onAddToCart;
  final Function(Map<String, dynamic>) onRemoveFromCart;

  BistroMenuPage({
    required this.cart,
    required this.onAddToCart,
    required this.onRemoveFromCart,
  });

  @override
  _BistroMenuPageState createState() => _BistroMenuPageState();
}

class _BistroMenuPageState extends State<BistroMenuPage> {
  List<Map<String, dynamic>> sortedMenu = [];
  String _sortBy = "Sort by Price";
  String _searchQuery = "";

  final List<Map<String, dynamic>> bistroMenu = [
    {'id': 1, 'name': 'Fried Rice', 'price': 2.85, 'image': 'assets/images/friedrice.png', 'rating': 4.5},
    {'id': 2, 'name': 'Chicken Salad', 'price': 3.50, 'image': 'assets/images/chicken_salad.png', 'rating': 4.2},
    {'id': 3, 'name': 'Steak', 'price': 5.25, 'image': 'assets/images/steak.png', 'rating': 4.8},
    {'id': 4, 'name': 'Grilled Fish', 'price': 4.00, 'image': 'assets/images/grilled_fish.png', 'rating': 4.3},
  ];

  @override
  void initState() {
    super.initState();
    sortedMenu = List.from(bistroMenu);
  }

  void _sortMenu(String sortBy) {
    setState(() {
      _sortBy = sortBy;
      if (sortBy == "Sort by Lowest Price") {
        sortedMenu.sort((a, b) => a['price'].compareTo(b['price']));
      } else if (sortBy == "Sort by Highest Price") {
        sortedMenu.sort((a, b) => b['price'].compareTo(a['price']));
      } else if (sortBy == "A-Z") {
        sortedMenu.sort((a, b) => a['name'].compareTo(b['name']));
      } else if (sortBy == "Sort by Rating") {
        sortedMenu.sort((a, b) => b['rating'].compareTo(a['rating']));
      } else if (sortBy == "Z-A") {
        sortedMenu.sort((a, b) => b['name'].compareTo(a['name']));
      }
    });
  }

  void _filterMenu() {
    setState(() {
      sortedMenu = bistroMenu
          .where((item) => item['name'].toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    });
  }

  void _addToCart(Map<String, dynamic> item) {
    widget.onAddToCart(item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${item['name']} added to cart!"),
        duration: Duration(seconds: 1),
        backgroundColor: TColor.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "BISTRO",
          style: TextStyle(
            fontFamily: "Parkinsans",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                  _filterMenu();
                });
              },
              decoration: InputDecoration(
                labelText: "Search for dishes here",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          // Sort Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _sortMenu("Sort by Lowest Price"),
                  child: Text("Lowest Price"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: _sortBy == "Sort by Lowest Price" ? Colors.white : Colors.black,
                    backgroundColor: _sortBy == "Sort by Lowest Price" ? TColor.primary : Colors.grey[200],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _sortMenu("Sort by Highest Price"),
                  child: Text("Highest Price"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: _sortBy == "Sort by Highest Price" ? Colors.white : Colors.black,
                    backgroundColor: _sortBy == "Sort by Highest Price" ? TColor.primary : Colors.grey[200],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _sortMenu("Sort by Rating"),
                  child: Text("Rating"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: _sortBy == "Sort by Rating" ? Colors.white : Colors.black,
                    backgroundColor: _sortBy == "Sort by Rating" ? TColor.primary : Colors.grey[200],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _sortMenu("A-Z"),
                  child: Text("A-Z"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: _sortBy == "A-Z" ? Colors.white : Colors.black,
                    backgroundColor: _sortBy == "A-Z" ? TColor.primary : Colors.grey[200],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _sortMenu("Z-A"),
                  child: Text("Z-A"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: _sortBy == "Z-A" ? Colors.white : Colors.black,
                    backgroundColor: _sortBy == "Z-A" ? TColor.primary : Colors.grey[200],
                  ),
                ),
              ],
            ),
          ),
          // Menu List
          Expanded(
            child: ListView.builder(
              itemCount: sortedMenu.length,
              itemBuilder: (context, index) {
                final item = sortedMenu[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        item['image'], // Dynamically load the image using the path
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item['name']),
                      subtitle: Row(
                        children: [
                          Text('\$${item['price']}'),
                          const SizedBox(width: 10),
                          Text('⭐ ${item['rating']}'),
                        ],
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: TColor.primary),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemDetailPage(
                                item: item,
                                onAddToCart: widget.onAddToCart,
                              ),
                            ),
                          );
                        },

                        child: const Text(
                          'View Details',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // "Go to Cart" Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: TColor.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              label: const Text("Go to Cart", style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(
                      cart: widget.cart,
                      onAddToCart: widget.onAddToCart,
                      onRemoveFromCart: widget.onRemoveFromCart,
                      updateCart: () {
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
