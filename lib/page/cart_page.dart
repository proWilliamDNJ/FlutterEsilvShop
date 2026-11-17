import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../model/cart.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProducts = ref.watch(cartProvider);
    final total = cartProducts.fold<num>(
      0,
      (sum, product) => sum + product.price,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Panier'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Votre panier total est de"),
                Text(
                  "${total.toStringAsFixed(2)}€",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: cartProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Votre panier est vide"),
                        Icon(Icons.shopping_cart_outlined),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: cartProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product = cartProducts[index];
                      return ListTile(
                        title: Text(product.title, maxLines: 1),
                        subtitle: Text(
                          product.getPrice(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Image.network(product.image, width: 80),
                        trailing: TextButton(
                          onPressed: () {
                            ref.read(cartProvider.notifier).remove(product);
                          },
                          child: Text("Supprimer".toUpperCase()),
                        ),
                      );
                    },
                  ),
          ),
          if (cartProducts.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FilledButton(
                  onPressed: () {
                    context.go('/payment');
                  },
                  child: Text("Commander"),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
