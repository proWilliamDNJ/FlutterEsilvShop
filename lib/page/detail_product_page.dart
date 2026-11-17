import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../model/cart.dart';
import '../model/product.dart';

class DetailProductPage extends ConsumerWidget {
  final Product product;

  const DetailProductPage({required this.product, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(product.title),
        actions: [
          IconButton(
            onPressed: () => context.go('/cart'),
            icon: Badge.count(child: Icon(Icons.shopping_cart),
                count: ref.watch(cartProvider).length),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Container(
            color: Colors.black12,
            child: Image.network(
              product.image,
              width: MediaQuery.of(context).size.width,
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Row(
                  children: List.generate(5, (index) {
                    if (product.rate >= index + 1) {
                      return Icon(Icons.star, color: Colors.amber, size: 20);
                    } else if (product.rate >= index + 0.5) {
                      return Icon(Icons.star_half, color: Colors.amber, size: 20);
                    } else {
                      return Icon(Icons.star_border, color: Colors.amber, size: 20);
                    }
                  }),
                ),
                const SizedBox(width: 8),
                Text("${product.rate}/5"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(product.getPrice()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(product.description),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Chip(label: Text(product.category)),
          ),
          if(ref.watch(cartProvider).contains(product))
            Chip(label: Text("LE PRODUIT EST DANS LE PANIER")),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FilledButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).add(product);
                },
                child: Text("Ajouter au panier"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
