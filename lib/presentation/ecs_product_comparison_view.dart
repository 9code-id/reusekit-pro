import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsProductComparisonView extends StatefulWidget {
  const EcsProductComparisonView({super.key});

  @override
  State<EcsProductComparisonView> createState() => _EcsProductComparisonViewState();
}

class _EcsProductComparisonViewState extends State<EcsProductComparisonView> {
  List<Map<String, dynamic>> selectedProducts = [];
  String searchQuery = "";
  String selectedCategory = "All";

  List<Map<String, dynamic>> allProducts = [
    {
      "id": 1,
      "name": "iPhone 15 Pro",
      "image": "https://picsum.photos/200/200?random=1&keyword=iphone",
      "price": 999.0,
      "rating": 4.8,
      "reviews": 2847,
      "category": "Electronics",
      "brand": "Apple",
      "specs": {
        "Display": "6.1-inch Super Retina XDR",
        "Processor": "A17 Pro chip",
        "Storage": "128GB",
        "Camera": "48MP main camera",
        "Battery": "Up to 23 hours video",
        "Weight": "187g",
        "OS": "iOS 17",
        "5G": "Yes",
      },
    },
    {
      "id": 2,
      "name": "Samsung Galaxy S24",
      "image": "https://picsum.photos/200/200?random=2&keyword=samsung",
      "price": 899.0,
      "rating": 4.6,
      "reviews": 1923,
      "category": "Electronics",
      "brand": "Samsung",
      "specs": {
        "Display": "6.2-inch Dynamic AMOLED",
        "Processor": "Snapdragon 8 Gen 3",
        "Storage": "256GB",
        "Camera": "50MP main camera",
        "Battery": "Up to 22 hours video",
        "Weight": "167g",
        "OS": "Android 14",
        "5G": "Yes",
      },
    },
    {
      "id": 3,
      "name": "Google Pixel 8",
      "image": "https://picsum.photos/200/200?random=3&keyword=pixel",
      "price": 699.0,
      "rating": 4.5,
      "reviews": 1456,
      "category": "Electronics",
      "brand": "Google",
      "specs": {
        "Display": "6.2-inch OLED",
        "Processor": "Google Tensor G3",
        "Storage": "128GB",
        "Camera": "50MP main camera",
        "Battery": "Up to 24 hours",
        "Weight": "187g",
        "OS": "Android 14",
        "5G": "Yes",
      },
    },
    {
      "id": 4,
      "name": "MacBook Air M3",
      "image": "https://picsum.photos/200/200?random=4&keyword=macbook",
      "price": 1299.0,
      "rating": 4.9,
      "reviews": 987,
      "category": "Computers",
      "brand": "Apple",
      "specs": {
        "Display": "13.6-inch Liquid Retina",
        "Processor": "Apple M3 chip",
        "Storage": "256GB SSD",
        "RAM": "8GB",
        "Battery": "Up to 18 hours",
        "Weight": "1.24kg",
        "OS": "macOS Sonoma",
        "Ports": "2x Thunderbolt",
      },
    },
    {
      "id": 5,
      "name": "Dell XPS 13",
      "image": "https://picsum.photos/200/200?random=5&keyword=dell",
      "price": 1199.0,
      "rating": 4.4,
      "reviews": 756,
      "category": "Computers",
      "brand": "Dell",
      "specs": {
        "Display": "13.4-inch FHD+",
        "Processor": "Intel Core i7",
        "Storage": "512GB SSD",
        "RAM": "16GB",
        "Battery": "Up to 12 hours",
        "Weight": "1.27kg",
        "OS": "Windows 11",
        "Ports": "2x Thunderbolt 4",
      },
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Computers", "value": "Computers"},
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return allProducts.where((product) {
      bool matchesSearch = searchQuery.isEmpty || 
        product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || product["category"] == selectedCategory;
      bool notSelected = !selectedProducts.any((selected) => selected["id"] == product["id"]);
      return matchesSearch && matchesCategory && notSelected;
    }).toList();
  }

  void addProductToComparison(Map<String, dynamic> product) {
    if (selectedProducts.length < 3) {
      selectedProducts.add(product);
      setState(() {});
      ss("${product["name"]} added to comparison");
    } else {
      sw("You can compare maximum 3 products at once");
    }
  }

  void removeProductFromComparison(Map<String, dynamic> product) {
    selectedProducts.removeWhere((p) => p["id"] == product["id"]);
    setState(() {});
    si("${product["name"]} removed from comparison");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Comparison"),
        actions: [
          if (selectedProducts.isNotEmpty)
            IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: () {
                selectedProducts.clear();
                setState(() {});
                si("Comparison cleared");
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Header with selected products count
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
            ),
            child: Row(
              children: [
                Icon(Icons.compare_arrows, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Compare Products (${selectedProducts.length}/3)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                if (selectedProducts.length >= 2)
                  Text(
                    "Ready to compare!",
                    style: TextStyle(
                      fontSize: 14,
                      color: successColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),

          // Selected Products for Comparison
          if (selectedProducts.isNotEmpty) ...[
            Container(
              height: 120,
              padding: EdgeInsets.all(spMd),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedProducts.length,
                itemBuilder: (context, index) {
                  final product = selectedProducts[index];
                  return Container(
                    width: 100,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                              child: Image.network(
                                "${product["image"]}",
                                height: 60,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: spXs,
                              right: spXs,
                              child: GestureDetector(
                                onTap: () => removeProductFromComparison(product),
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(spXs),
                            child: Text(
                              "${product["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Compare Button
            if (selectedProducts.length >= 2)
              Container(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: QButton(
                  label: "Compare Selected Products",
                  size: bs.md,
                  onPressed: () {
                    _showComparisonTable();
                  },
                ),
              ),

            Divider(),
          ],

          // Search and Filter
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search products...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Category",
                  items: categories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Available Products
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${product["image"]}",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${product["brand"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.star, size: 16, color: warningColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${product["rating"]} (${product["reviews"]})",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$${(product["price"] as double).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Compare",
                        size: bs.sm,
                        onPressed: () => addProductToComparison(product),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showComparisonTable() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Product Comparison"),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                // Product Headers
                Row(
                  children: [
                    Container(width: 120), // Space for spec names
                    ...selectedProducts.map((product) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: spXs),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${product["image"]}",
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${product["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),

                SizedBox(height: spMd),

                // Basic Info Comparison
                _buildComparisonRow("Price", selectedProducts.map((p) => "\$${(p["price"] as double).currency}").toList()),
                _buildComparisonRow("Rating", selectedProducts.map((p) => "${p["rating"]} ⭐").toList()),
                _buildComparisonRow("Reviews", selectedProducts.map((p) => "${p["reviews"]}").toList()),
                _buildComparisonRow("Brand", selectedProducts.map((p) => "${p["brand"]}").toList()),

                SizedBox(height: spMd),

                // Specs Comparison
                ...selectedProducts.first["specs"].keys.map((specKey) {
                  return _buildComparisonRow(
                    specKey,
                    selectedProducts.map((p) => "${p["specs"][specKey] ?? "N/A"}").toList(),
                  );
                }).toList(),

                SizedBox(height: spMd),

                // Action Buttons
                Row(
                  children: selectedProducts.map((product) {
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: spXs),
                        child: QButton(
                          label: "Add to Cart",
                          size: bs.sm,
                          onPressed: () {
                            ss("${product["name"]} added to cart");
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComparisonRow(String title, List<String> values) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Container(
            width: 120,
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          ...values.asMap().entries.map((entry) {
            int index = entry.key;
            String value = entry.value;
            
            return Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: spXs),
                padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spXs),
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.grey.withAlpha(25) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
