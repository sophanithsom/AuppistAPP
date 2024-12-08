import 'package:auppist_app/common/color_extension.dart';
import 'package:flutter/material.dart';

class DrinksDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function(Map<String, dynamic>) onAddToCart;

  DrinksDetailPage({
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
          "Drink Details",
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
                    const Text("5 Mins"),
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
                    const Text("50 kcal"),
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
            // item Size Options
            const Text(
              "Size Options",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (String size in ['Small', 'Medium', 'Large'])
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey[200],
                        child: Text(
                          size,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      // Text(size),
                    ],
                  ),
              ],
            ),
            
            SizedBox(height: 20),
            // Description Section
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "${item['description'].toString()}",
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
