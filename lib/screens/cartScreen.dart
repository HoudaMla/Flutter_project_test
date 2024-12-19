import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  
import '../providers/basket_provider.dart'; 

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final basketProvider = Provider.of<BasketProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black), 
      ),
      body: basketProvider.basketItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: basketProvider.basketItems.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = basketProvider.basketItems[index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Image.asset(
                              item['image'],
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(item['quantityUnit'],
                                      style: const TextStyle(color: Colors.grey)),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          basketProvider.updateProductQuantity(
                                            item['name'], -1);
                                        },
                                      ),
                                      Text(item['quantity'].toString()),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          basketProvider.updateProductQuantity(
                                            item['name'], 1);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text("\$${item['price'].toStringAsFixed(2)}"),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                basketProvider.removeProductFromBasket(item['name']);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.0, -1.0), 
                      )
                    ]
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 16,
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Go to Checkout", style: TextStyle(color: Colors.white)),
                        Text("\$${basketProvider.totalPrice.toStringAsFixed(2)}", style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Shop"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourite"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Account"),
        ],
      ),
    );
  }
}
