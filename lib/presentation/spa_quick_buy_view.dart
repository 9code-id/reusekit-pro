import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaQuickBuyView extends StatefulWidget {
  const SpaQuickBuyView({super.key});

  @override
  State<SpaQuickBuyView> createState() => _SpaQuickBuyViewState();
}

class _SpaQuickBuyViewState extends State<SpaQuickBuyView> {
  String selectedCategory = "all";
  String searchQuery = "";
  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "iPhone 15 Pro Max",
      "category": "electronics",
      "price": 1199.00,
      "originalPrice": 1299.00,
      "discount": 8,
      "rating": 4.8,
      "reviews": 2547,
      "image": "https://picsum.photos/300/200?random=1&keyword=phone",
      "inStock": true,
      "fastDelivery": true,
      "brand": "Apple"
    },
    {
      "id": 2,
      "name": "Samsung 4K Smart TV",
      "category": "electronics",
      "price": 899.99,
      "originalPrice": 1099.99,
      "discount": 18,
      "rating": 4.6,
      "reviews": 1234,
      "image": "https://picsum.photos/300/200?random=2&keyword=tv",
      "inStock": true,
      "fastDelivery": false,
      "brand": "Samsung"
    },
    {
      "id": 3,
      "name": "Nike Air Jordan",
      "category": "fashion",
      "price": 159.99,
      "originalPrice": 199.99,
      "discount": 20,
      "rating": 4.9,
      "reviews": 890,
      "image": "https://picsum.photos/300/200?random=3&keyword=shoes",
      "inStock": true,
      "fastDelivery": true,
      "brand": "Nike"
    },
    {
      "id": 4,
      "name": "MacBook Pro M3",
      "category": "electronics",
      "price": 1999.00,
      "originalPrice": 2199.00,
      "discount": 9,
      "rating": 4.7,
      "reviews": 567,
      "image": "https://picsum.photos/300/200?random=4&keyword=laptop",
      "inStock": false,
      "fastDelivery": false,
      "brand": "Apple"
    },
    {
      "id": 5,
      "name": "Adidas Ultra Boost",
      "category": "fashion",
      "price": 129.99,
      "originalPrice": 169.99,
      "discount": 24,
      "rating": 4.5,
      "reviews": 1456,
      "image": "https://picsum.photos/300/200?random=5&keyword=sneakers",
      "inStock": true,
      "fastDelivery": true,
      "brand": "Adidas"
    },
    {
      "id": 6,
      "name": "PlayStation 5",
      "category": "gaming",
      "price": 499.99,
      "originalPrice": 559.99,
      "discount": 11,
      "rating": 4.8,
      "reviews": 3245,
      "image": "https://picsum.photos/300/200?random=6&keyword=gaming",
      "inStock": true,
      "fastDelivery": false,
      "brand": "Sony"
    }
  ];

  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> filtered = products;
    
    if (selectedCategory != "all") {
      filtered = filtered.where((product) => product["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((product) =>
        "${product["name"]}".toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quick Buy"),
        actions: [
          QButton(
            icon: Icons.shopping_cart,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchSection(),
            _buildCategoryFilter(),
            _buildQuickActions(),
            _buildProductGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
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
    );
  }

  Widget _buildCategoryFilter() {
    return QCategoryPicker(
      items: [
        {"label": "All", "value": "all"},
        {"label": "Electronics", "value": "electronics"},
        {"label": "Fashion", "value": "fashion"},
        {"label": "Gaming", "value": "gaming"},
      ],
      value: selectedCategory,
      onChanged: (index, label, value, item) {
        selectedCategory = value;
        setState(() {});
      },
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  "Buy Again",
                  Icons.refresh,
                  infoColor,
                  () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickActionButton(
                  "Wishlist",
                  Icons.favorite,
                  dangerColor,
                  () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickActionButton(
                  "Flash Sale",
                  Icons.flash_on,
                  warningColor,
                  () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            SizedBox(height: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    if (filteredProducts.isEmpty) {
      return Container(
        padding: EdgeInsets.all(sp2xl),
        child: Column(
          children: [
            Icon(
              Icons.shopping_bag,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No products found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Try adjusting your search or category filter",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 200,
      children: filteredProducts.map((product) => _buildProductCard(product)).toList(),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    bool inStock = product["inStock"] as bool;
    bool fastDelivery = product["fastDelivery"] as bool;
    int discount = product["discount"] as int;

    return Container(
      margin: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${product["image"]}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (discount > 0)
                Positioned(
                  top: spXs,
                  left: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "-$discount%",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (fastDelivery)
                Positioned(
                  top: spXs,
                  right: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Fast",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${product["brand"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: warningColor,
                      size: 14,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${product["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      " (${product["reviews"]})",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "\$${(product["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (discount > 0) ...[
                      SizedBox(width: spXs),
                      Text(
                        "\$${(product["originalPrice"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: inStock ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    inStock ? "In Stock" : "Out of Stock",
                    style: TextStyle(
                      fontSize: 10,
                      color: inStock ? successColor : dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: inStock ? "Quick Buy" : "Notify Me",
                    size: bs.sm,
                    onPressed: inStock ? () => _quickBuy(product) : () => _notifyWhenAvailable(product),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _quickBuy(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quick Buy"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Are you sure you want to buy ${product["name"]} for \$${(product["price"] as double).toStringAsFixed(2)}?"),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QNumberField(
                    label: "Quantity",
                    value: "1",
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => back(),
          ),
          QButton(
            label: "Buy Now",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Product added to cart successfully!");
            },
          ),
        ],
      ),
    );
  }

  void _notifyWhenAvailable(Map<String, dynamic> product) {
    ss("You'll be notified when ${product["name"]} is back in stock");
  }
}
