import 'package:flutter/material.dart';
import 'package:newgames_shop/models/product_entry.dart';
import 'package:newgames_shop/widgets/left_drawer.dart';
import 'package:newgames_shop/widgets/product_entry_card.dart';
import 'package:newgames_shop/screens/product_details.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductEntryListPage extends StatefulWidget {
  final bool showOnlyMine; 

  const ProductEntryListPage({
    super.key,
    required this.showOnlyMine,
  });

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  late Future<ProductEntry> _future;

  @override
  void initState() {
    super.initState();
    final request = context.read<CookieRequest>();
    _future = _fetchProducts(request);
  }

  Future<ProductEntry> _fetchProducts(CookieRequest request) async {
    const baseUrl = "http://localhost:8000";
    final filterParam = widget.showOnlyMine ? 'my' : 'all';

    try {
      final response =
      await request.get("$baseUrl/api/items/?filter=$filterParam");
      return ProductEntry.fromJson(response);
    } catch (e) {
      throw Exception("Failed to load products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final title = widget.showOnlyMine ? 'My Products' : 'All Products';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2563EB), Color(0xFFFB923C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _future = _fetchProducts(request);
              });
            },
          ),
        ],
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<ProductEntry>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // loading sekali saja, tidak loop
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: Colors.red),
                    const SizedBox(height: 12),
                    Text(
                      'Gagal memuat produk.',
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _future = _fetchProducts(request);
                        });
                      },
                      child: const Text('Coba lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.store_mall_directory,
                        size: 70, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      widget.showOnlyMine
                          ? "Kamu belum punya produk."
                          : "Belum ada produk.",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Mulai jual produk olahragamu sekarang!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final items = snapshot.data!.items;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: items.length,
            itemBuilder: (_, index) {
              final item = items[index];

              return ProductEntryCard(
                product: item,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailPage(product: item),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
