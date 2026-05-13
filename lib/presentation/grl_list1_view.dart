import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlList1View extends StatefulWidget {
  @override
  State<GrlList1View> createState() => _GrlList1ViewState();
}

class _GrlList1ViewState extends State<GrlList1View> {
  String searchQuery = "";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Clothing", "value": "Clothing"},
    {"label": "Books", "value": "Books"},
    {"label": "Sports", "value": "Sports"},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Wireless Headphones",
      "category": "Electronics",
      "price": 299.99,
      "rating": 4.5,
      "reviews": 128,
      "image": "https://picsum.photos/200/200?random=1&keyword=headphones",
      "description": "Premium wireless headphones with noise cancellation",
      "inStock": true,
    },
    {
      "id": 2,
      "name": "Running Shoes",
      "category": "Sports",
      "price": 149.99,
      "rating": 4.8,
      "reviews": 256,
      "image": "https://picsum.photos/200/200?random=2&keyword=shoes",
      "description": "Comfortable running shoes for daily workouts",
      "inStock": true,
    },
    {
      "id": 3,
      "name": "Programming Book",
      "category": "Books",
      "price": 45.99,
      "rating": 4.3,
      "reviews": 89,
      "image": "https://picsum.photos/200/200?random=3&keyword=book",
      "description": "Complete guide to modern programming",
      "inStock": false,
    },
    {
      "id": 4,
      "name": "Cotton T-Shirt",
      "category": "Clothing",
      "price": 29.99,
      "rating": 4.2,
      "reviews": 167,
      "image": "https://picsum.photos/200/200?random=4&keyword=shirt",
      "description": "100% cotton comfortable t-shirt",
      "inStock": true,
    },
    {
      "id": 5,
      "name": "Bluetooth Speaker",
      "category": "Electronics",
      "price": 89.99,
      "rating": 4.6,
      "reviews": 203,
      "image": "https://picsum.photos/200/200?random=5&keyword=speaker",
      "description": "Portable bluetooth speaker with rich bass",
      "inStock": true,
    },
    {
      "id": 6,
      "name": "Yoga Mat",
      "category": "Sports",
      "price": 35.99,
      "rating": 4.4,
      "reviews": 94,
      "image": "https://picsum.photos/200/200?random=6&keyword=yoga",
      "description": "Premium non-slip yoga mat",
      "inStock": true,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      bool matchesSearch = "${product["name"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || product["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        actions: [
          Icon(Icons.shopping_cart),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search products",
                    value: searchQuery,
                    hint: "Search by name...",
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

            QDropdownField(
              label: "Category",
              items: categories,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Products (${filteredProducts.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Filter",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
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
                          spacing: spXs,
                          children: [
                            Text(
                              "${product["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${product["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex < (product["rating"] as double).floor()
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: warningColor,
                                      size: 16,
                                    );
                                  }),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "(${product["reviews"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${((product["price"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (product["inStock"] as bool)
                                        ? successColor.withAlpha(20)
                                        : dangerColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    (product["inStock"] as bool) ? "In Stock" : "Out of Stock",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: (product["inStock"] as bool)
                                          ? successColor
                                          : dangerColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Column(
                        spacing: spXs,
                        children: [
                          QButton(
                            icon: Icons.favorite_border,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          QButton(
                            icon: Icons.shopping_cart,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
