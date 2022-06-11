import 'package:flutter/material.dart';
import 'item.dart';
import 'model/product.dart';

class Carousel extends StatelessWidget {
  const Carousel({Key? key, required this.products,}) : super(key: key);

  final List<Product> products;

  List<Widget> _buildItems() {
    List<Widget> Items = [];
    products.forEach((element) {
      Items.add(
          Item(
              authorName: element.authorName,
              authorPreview: element.authorPreview,
              productName: element.productName,
              productPreview: element.productPreview
          )
      );
    });
    return Items;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _buildItems(),
      ),
    );
  }
}
