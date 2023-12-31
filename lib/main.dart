import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Product {
  final String name;
  final double price;
  int quantity = 0;

  Product(this.name, this.price);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product("Product 1", 310.0),
    Product("Product 2", 320.0),
    Product("Product 3", 330.0),
    Product("Product 4", 330.0),
    Product("Product 5", 340.0),
    Product("Product 6", 350.0),
    Product("Product 7", 360.0),
    Product("Product 8", 370.0),
    Product("Product 9", 380.0),
    Product("Product 10", 390.0),
    Product("Product 11", 400.0),
    Product("Product 12", 410.0),


  ];

  void _addToCart(Product product) {
    setState(() {
      product.quantity++;
      if (product.quantity == 5) {
        _showCongratulationsDialog(product);
      }
    });
  }


  Future<void> _showCongratulationsDialog(Product product) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You\'ve bought 5 ${product.name}!'),
          actions: <Widget>[
            TextButton(onPressed: (){
              Navigator.pop(context);

            }, child: Text("OK"))
          ],
        );
      },
    );
  }

  void _goToCart() {
    int totalItemsBought = products
        .map((product) => product.quantity)
        .reduce((a, b) => a + b);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(totalItemsBought),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        centerTitle: true,

      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: Row(

              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('${product.quantity}')),


                ElevatedButton(onPressed: () => _addToCart(product), child: Text("Buy Now"))

              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.shopping_cart),
        onPressed: () {

          _goToCart();
        },
      ),

    );
  }
}

class CartPage extends StatelessWidget {
  final int totalItemsBought;

  CartPage(this.totalItemsBought);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Total Items Bought: $totalItemsBought',style: TextStyle(fontSize: 24),),
      ),


    );
  }
}



