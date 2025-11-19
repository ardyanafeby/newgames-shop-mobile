import 'package:flutter/material.dart';
import 'package:newgames_shop/models/product_entry.dart';

class ProductDetailPage extends StatelessWidget {
  final Item product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final String sellerName = (product.seller != null && product.seller!.isNotEmpty)
      ? product.seller! : 'Anonymous';
    final String rawCategory =
        product.categoryDisplay ?? product.category;
    final String categoryText =
    rawCategory.isNotEmpty ? rawCategory : 'Uncategorized';

    final bool isOnSale = product.isOnSale;
    final bool isFeatured = product.isFeatured;

    final int price = product.price;
    final int? salePrice = product.salePrice;

    final int stock = product.stock;
    final String brand =
    (product.brand != null && product.brand!.isNotEmpty)
        ? product.brand!
        : 'Tanpa Brand';

    final String? thumbnail = product.thumbnail;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (thumbnail != null && thumbnail.isNotEmpty)
              Image.network(
                'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(thumbnail)}',
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 260,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 48),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        label: Text(
                          categoryText,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        backgroundColor: const Color(0xFF2563EB),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                      if (isFeatured)
                        Chip(
                          label: const Text(
                            'Featured',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: const Color(0xFFD9F99D),
                          labelStyle:
                          const TextStyle(color: Color(0xFF4D7C0F)),
                        ),
                      if (isOnSale)
                        Chip(
                          label: const Text(
                            'SALE',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          backgroundColor: const Color(0xFFFFEDD5),
                          labelStyle:
                          const TextStyle(color: Color(0xFFC05621)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Text(
                        brand,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'Stock: $stock',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2563EB),
                    Color(0xFFFB923C),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Price block
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isOnSale && salePrice != null) ...[
                        Text(
                          'Rp $salePrice',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Rp $price',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Special Offer!',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ] else ...[
                        Text(
                          'Rp $price',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ],
                  ),

                  // “Seller” style block
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Seller: $sellerName',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
