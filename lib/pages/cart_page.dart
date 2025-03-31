import 'package:flutter/material.dart';
import 'package:styleswap/components/cart/cart_article_card.dart';
import 'package:styleswap/components/titlebar/titlebar.dart';
import 'package:styleswap/services/cart_service.dart';
import 'package:styleswap/services/localisation_service.dart';
import 'package:styleswap/services/user_service.dart';
import 'package:styleswap/pages/detail_article_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  TextEditingController addressController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _heightAnimation = Tween<double>(begin: 0, end: 350).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    String? currentAddress = await LocalisationService().getCurrentLocation();
    setState(() {
      addressController.text = currentAddress ?? 'Adresse non disponible';
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartService = CartService();
    final userService = UserService();
    final userInfo = userService.getUserInformations(1);

    List<Map<String, dynamic>> cartItems = cartService.getAllArticlesInCart(1);
    double totalPrice = cartItems.fold(
      0,
      (sum, item) => sum + (double.tryParse(item['price']?.replaceAll('€', '') ?? '0') ?? 0),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Panier',
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TitleBar(),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    "Votre panier est vide",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: <Widget>[
                SizedBox(height: 15),
                Text(
                  '(← swipez à gauche pour supprimer)',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailArticlePage(
                                product: cartItems[index],
                                isInCart: true,
                              ),
                            ),
                          );
                        },
                        child: Dismissible(
                          key: Key(cartItems[index]['id'].toString()),
                          onDismissed: (direction) {
                            cartService.removeArticleFromCart(cartItems[index]['id']);
                            setState(() {
                              cartItems.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Article supprimé du panier")),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.delete, color: Colors.white, size: 30),
                              ),
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          child: CartArticleCard(cartItem: cartItems[index]),
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                      if (isExpanded) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.1),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                          size: 30,
                          color: Colors.black,
                        ),
                        Text(
                          '€${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigoAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _heightAnimation,
                  builder: (context, child) {
                    return Container(
                      height: _heightAnimation.value,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      color: Colors.indigo.withOpacity(0.1),
                      child: _heightAnimation.value > 0
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: TextEditingController(text: userInfo['firstName']),
                                          decoration: InputDecoration(labelText: 'Nom'),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: TextField(
                                          controller: TextEditingController(text: userInfo['lastName']),
                                          decoration: InputDecoration(labelText: 'Prénom'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  TextField(
                                    controller: TextEditingController(text: userInfo['email']),
                                    decoration: InputDecoration(labelText: 'Email'),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: addressController,
                                          decoration: InputDecoration(labelText: 'Adresse de livraison'),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: IconButton(
                                          icon: Icon(Icons.location_on, size: 40, color: Colors.red),
                                          onPressed: _getCurrentLocation,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 55),
                                  ElevatedButton(
                                    onPressed: () {
                                      print("achat effectué");
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigoAccent,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Payer',
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 12),
                                        Icon(Icons.payment, color: Colors.white, size: 30),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                    );
                  },
                ),
              ],
            ),
    );
  }
}