import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  
import '../providers/basket_provider.dart'; // Import BasketProvider

class ProductDetail extends StatefulWidget {
  final String productName;
  final String productImage;
  final String productPrice;
  final String productDetail;

  const ProductDetail({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDetail,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    // Access the BasketProvider
    final basketProvider = Provider.of<BasketProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {} // Add functionality for favorites if needed
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                widget.productImage,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.productName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "1kg", // You can make this dynamic based on product unit if needed
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) {
                            quantity--;
                          }
                        });
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                Text(
                  "\$${widget.productPrice}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ExpansionTile(
              title: const Text(
                "Product Detail",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.productDetail,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text("Nutritions"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: const Text("Review"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star_border),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
              onTap: () {},
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 16,
                  ),
                ),
                onPressed: () {
                  // Add to basket functionality
                  basketProvider.addProductToBasket(
                    widget.productName,
                    widget.productImage,
                    double.parse(widget.productPrice),  
                    quantity,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${widget.productName} added to basket")),
                  );
                },
                child: const Text(
                  "Add To Basket",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
