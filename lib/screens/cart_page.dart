import 'package:flutter/material.dart';
import '../common/color_extension.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final Function(Map<String, dynamic>) onAddToCart;
  final Function(Map<String, dynamic>) onRemoveFromCart;
  final VoidCallback updateCart;

  CartPage({
    required this.cart,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.updateCart,
  });

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double getTotalPrice() {
    double total = 0;
    for (var item in widget.cart) {
      double price = item['price'] ?? 0.0; // Default to 0.0 if price is null
      int quantity = item['quantity'] ?? 0; // Default to 0 if quantity is null
      total += price * quantity;
    }
    return total;
  }

  void _addItem(Map<String, dynamic> item) {
    widget.onAddToCart(item);
    setState(() {}); // Update UI
    widget.updateCart(); // Notify parent to refresh
  }

  void _removeItem(Map<String, dynamic> item) {
    widget.onRemoveFromCart(item);
    setState(() {}); // Update UI
    widget.updateCart(); // Notify parent to refresh
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.primary,
        title: const Text(
          "Your Cart",
          style: TextStyle(color: Colors.white, 
          fontWeight: FontWeight.bold),
          
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: widget.cart.isEmpty
          ? Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      final item = widget.cart[index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          child: ListTile(
                            title: Text(item['name']),
                            subtitle: Row(
                              children: [
                                Text('\$${item['price']}'),
                                const SizedBox(width: 10),
                                Text('x ${item['quantity']}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () => _removeItem(item),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => _addItem(item),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$${getTotalPrice().toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: TColor.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColor.primary,
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Proceed to Pay"),
                                content: Text(
                                  "Total amount: \$${getTotalPrice().toStringAsFixed(2)}",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Add your payment processing logic here
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Prceed"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text("Proceed to Pay",
                        style: TextStyle(
                          color: TColor.white
                        ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
