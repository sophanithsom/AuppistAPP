import 'package:flutter/material.dart';
import '../common/color_extension.dart';
import 'bistro_menu_page.dart';
import 'twobeans_menu_page.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> cart = [];

  // Add item to cart or increase quantity if it already exists
  void onAddToCart(Map<String, dynamic> item) {
    setState(() {
      final index = cart.indexWhere((cartItem) => cartItem['id'] == item['id']);
      if (index == -1) {
        cart.add({'id': item['id'], 'name': item['name'], 'price': item['price'], 'quantity': 1});
      } else {
        cart[index]['quantity']++;
      }
    });
  }

  // Remove one quantity of the item or remove it from the cart completely
  void onRemoveFromCart(Map<String, dynamic> item) {
    setState(() {
      final index = cart.indexWhere((cartItem) => cartItem['id'] == item['id']);
      if (index != -1) {
        if (cart[index]['quantity'] > 1) {
          cart[index]['quantity']--;
        } else {
          cart.removeAt(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of popular items
    final List<Map<String, dynamic>> popularItems = [
      {'id': 1, 'name': 'Fried Rice', 'price': 2.85, 'image': 'assets/images/friedrice.png', 'source': 'Bistro', 'rating': 4.7},
      {'id': 2, 'name': 'Steak', 'price': 5.25, 'image': 'assets/images/steak.png', 'source': 'Bistro', 'rating': 4.6},
      {'id': 3, 'name': 'Cappuccino', 'price': 3.75, 'image': 'assets/images/cappuccino.png', 'source': 'Two Beans', 'rating': 3.9},
      {'id': 4, 'name': 'Latte', 'price': 3.50, 'image': 'assets/images/latte.png', 'source': 'Two Beans', 'rating': 4.2},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        title: Text('AUPPist Marketplace', style: TextStyle(color: TColor.primary),),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontFamily: "Parkinsans",
          fontSize: 25,
          fontWeight: FontWeight.w800,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome text
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Good Morning, Sophanith.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Choose where you want to order today:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Grid with Bistro and Two Beans
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton(context, 'BISTRO', Icons.restaurant, true),
                _buildCategoryButton(context, 'TWO BEANS', Icons.local_cafe, false),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Popular Items Section (Scrollable List)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Popular Dishes and Drinks',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: popularItems.length,
                      itemBuilder: (context, index) {
                        final item = popularItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: TColor.primary,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
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
                              title: Text(item['name'], style: TextStyle(color: TColor.white)),
                              subtitle: Row(
                                children: [
                                  Text('\$${item['price']}', style: TextStyle(color: TColor.white)),
                                  const SizedBox(width: 10),
                                  Text('⭐ ${item['rating']}', style: TextStyle(color: TColor.white)),
                                ],
                              ),
                              trailing: ElevatedButton(
                                onPressed: () => onAddToCart(item),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: TColor.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Add to cart',
                                  style: TextStyle(
                                    color: TColor.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Section with Cart Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColor.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                label: const Text(
                  'Go to Cart',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(
                        cart: cart,
                        onAddToCart: onAddToCart,
                        onRemoveFromCart: onRemoveFromCart,
                        updateCart: () {
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build category buttons (Bistro/Two Beans)
  Widget _buildCategoryButton(BuildContext context, String title, IconData icon, bool isBistro) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => isBistro
                ? BistroMenuPage(
                    cart: cart,
                    onAddToCart: onAddToCart,
                    onRemoveFromCart: onRemoveFromCart,
                  )
                : TwoBeansMenuPage(
                    cart: cart,
                    onAddToCart: onAddToCart,
                    onRemoveFromCart: onRemoveFromCart,
                  ),
          ),
        );
      },
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: TColor.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
