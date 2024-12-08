import 'package:auppist_app/common/color_extension.dart';
import 'package:flutter/material.dart';

class ItemDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function(Map<String, dynamic>) onAddToCart;

  ItemDetailPage({
    required this.item,
    required this.onAddToCart,
  });

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
        title: Text(
          "Details",
          style: TextStyle(
            fontFamily: "Parkinsans",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: TColor.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image and Name
            Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      item['image'],
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Time, Rating, Calories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.grey),
                    SizedBox(width: 4),
                    const Text("15 Mins"),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange),
                    SizedBox(width: 4),
                    Text("${item['rating']}"),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.local_fire_department, color: Colors.red),
                    SizedBox(width: 4),
                    const Text("325 kcal"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Price
            Text(
              '\$${item['price'].toString()}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Ingredients Section
            const Text(
              "Extras",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 1; i <= 3; i++)
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.restaurant, color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text("Add item $i"),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 20),
            // About Section
            const Text(
              "About",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            const Text(
              "Food description",
              style: TextStyle(fontSize: 14),
            ),
            Spacer(),
            // Add to Cart and View Cart Buttons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      onAddToCart(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${item['name']} added to cart!"),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart, color: TColor.white),
                    label: Text(
                      "Add to Cart",
                      style: TextStyle(color: TColor.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColor.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10), // Spacing between buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.shopping_basket, color: TColor.primary),
                    label: Text(
                      "View Cart",
                      style: TextStyle(color: TColor.primary),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColor.white,
                      side: BorderSide(color: TColor.primary, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
