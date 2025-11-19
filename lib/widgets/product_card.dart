import 'package:flutter/material.dart';
import 'package:newgames_shop/models/item_homepage.dart';
import 'package:newgames_shop/screens/login.dart';
import 'package:newgames_shop/screens/product_entry_list.dart';
import 'package:newgames_shop/screens/productentry_form.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF8E2DE2),
            Color(0xFF4A00E0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content:
                  Text("Kamu menekan tombol ${item.name}!"),
                ),
              );

            if (item.name == "Create Product") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProductEntryFormPage(),
                ),
              );
            } else if (item.name == "All Products") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProductEntryListPage(
                    showOnlyMine: false,
                  ),
                ),
              );
            } else if (item.name == "My Products") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProductEntryListPage(
                    showOnlyMine: true,
                  ),
                ),
              );
            } else if (item.name == "Logout") {
              final response = await request
                  .logout("http://10.0.2.2:8000/auth/logout/");
              final String message = response["message"];

              if (context.mounted) {
                if (response['status']) {
                  final String uname = response["username"];
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                      Text("$message See you again, $uname."),
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginPage(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                }
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 36,
                ),
                const SizedBox(height: 10),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
