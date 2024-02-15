import 'package:flutter/material.dart';
import 'package:online_shop_fic/data/models/responses/product_response_model.dart';

import '../../../../core/components/spaces.dart';
import '../product_card.dart';
import '../title_content.dart';

class ProductList extends StatefulWidget {
  final String title;
  final VoidCallback onSeeAllTap;
  final List<Product> items;

  const ProductList({
    super.key,
    required this.title,
    required this.onSeeAllTap,
    required this.items,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleContent(
          title: widget.title,
          onSeeAllTap: widget.onSeeAllTap,
        ),
        const SpaceHeight(20.0),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 55.0,
          ),
          itemCount: widget.items.length,
          itemBuilder: (context, index) => ProductCard(
            data: widget.items[index],
          ),
        )
      ],
    );
  }
}
