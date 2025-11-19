import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newgames_shop/widgets/left_drawer.dart';
import 'package:newgames_shop/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductEntryFormPage extends StatefulWidget {
  const ProductEntryFormPage({super.key});

  @override
  State<ProductEntryFormPage> createState() => _ProductEntryFormPageState();
}

class _ProductEntryFormPageState extends State<ProductEntryFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  int _price = 0;
  String _description = "";
  String _thumbnail = "";
  String _category = "";
  int _stock = 0;
  String _brand = "";
  bool _isFeatured = false;

  // Kategori disesuaikan dengan CATEGORY_CHOICES di Django
  final List<Map<String, String>> _categories = [
    {"value": "fashion olahraga", "label": "Fashion Olahraga"},
    {"value": "peralatan olahraga", "label": "Peralatan Olahraga"},
    {"value": "suplemen olahraga", "label": "Suplemen Olahraga"},
    {"value": "kesehatan dan kebugaran", "label": "Kesehatan dan Kebugaran"},
    {"value": "bola", "label": "Bola"},
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create New Product',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Create New Product",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Sell your product and make your shop stand out!",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Nama Produk
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Produk",
                    labelText: "Nama Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama produk tidak boleh kosong!";
                    }
                    if (value.length < 3) {
                      return "Nama produk harus minimal 3 karakter!";
                    }
                    if (value.length > 100) {
                      return "Nama produk tidak boleh lebih dari 100 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // Harga
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Harga",
                    labelText: "Harga",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _price = int.tryParse(value) ?? 0;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harga tidak boleh kosong!";
                    }
                    final parsed = int.tryParse(value);
                    if (parsed == null) {
                      return "Harga harus berupa angka!";
                    }
                    if (parsed <= 0) {
                      return "Harga harus lebih dari 0!";
                    }
                    if (parsed > 1000000000) {
                      return "Harga terlalu besar!";
                    }
                    return null;
                  },
                ),
              ),

              // Deskripsi
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Deskripsi",
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      _description = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Deskripsi tidak boleh kosong!";
                    }
                    if (value.length < 10) {
                      return "Deskripsi harus minimal 10 karakter!";
                    }
                    if (value.length > 500) {
                      return "Deskripsi tidak boleh lebih dari 500 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // Thumbnail
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Thumbnail",
                    labelText: "Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _thumbnail = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "URL thumbnail tidak boleh kosong!";
                    }
                    if (!value.startsWith('http://') &&
                        !value.startsWith('https://')) {
                      return "URL harus dimulai dengan http:// atau https://";
                    }
                    if (!value.contains('.')) {
                      return "URL tidak valid!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Brand (opsional)",
                    labelText: "Brand",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _brand = value;
                    });
                  },
                  validator: (value) {
                    if (value != null && value.length > 50) {
                      return "Brand tidak boleh lebih dari 50 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Stok",
                    labelText: "Stok",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _stock = int.tryParse(value) ?? 0;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Stok tidak boleh kosong!";
                    }
                    final parsed = int.tryParse(value);
                    if (parsed == null) {
                      return "Stok harus berupa angka!";
                    }
                    if (parsed < 0) {
                      return "Stok tidak boleh negatif!";
                    }
                    return null;
                  },
                ),
              ),

              // Kategori
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _category.isEmpty ? null : _category,
                  items: _categories
                      .map(
                        (cat) => DropdownMenuItem<String>(
                      value: cat["value"],
                      child: Text(cat["label"]!),
                    ),
                  )
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _category = newValue ?? "";
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Kategori tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isFeatured,
                      onChanged: (value) {
                        setState(() {
                          _isFeatured = value ?? false;
                        });
                      },
                    ),
                    const Text("Produk Unggulan"),
                  ],
                ),
              ),

              // Tombol Simpan
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                          "http://localhost:8000/create-flutter/",
                          jsonEncode(<String, dynamic>{
                            "name": _name,
                            "price": _price,
                            "description": _description,
                            "thumbnail": _thumbnail,
                            "category": _category,
                            "stock": _stock,
                            "brand": _brand,
                            "is_featured": _isFeatured,
                          }),
                        );

                        if (!context.mounted) return;

                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Product successfully saved!"),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Something went wrong, please try again.",
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Publish Product",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
