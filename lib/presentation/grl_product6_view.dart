import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProduct6View extends StatefulWidget {
  @override
  State<GrlProduct6View> createState() => _GrlProduct6ViewState();
}

class _GrlProduct6ViewState extends State<GrlProduct6View> {
  int selectedIndex = 0;
  String selectedBrand = 'all';
  String priceRange = 'all';
  double minPrice = 0;
  double maxPrice = 1000;

  List<Map<String, dynamic>> categories = [
    {"name": "Electronics", "icon": Icons.devices, "count": 45},
    {"name": "Fashion", "icon": Icons.checkroom, "count": 32},
    {"name": "Books", "icon": Icons.book, "count": 28},
    {"name": "Sports", "icon": Icons.sports_basketball, "count": 19},
    {"name": "Home", "icon": Icons.home, "count": 24},
    {"name": "Beauty", "icon": Icons.face, "count": 15},
  ];

  List<Map<String, dynamic>> brands = [
    {"label": "All Brands", "value": "all"},
    {"label": "Apple", "value": "apple"},
    {"label": "Samsung", "value": "samsung"},
    {"label": "Nike", "value": "nike"},
    {"label": "Adidas", "value": "adidas"},
    {"label": "Sony", "value": "sony"},
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "All Prices", "value": "all"},
    {"label": "Under \$50", "value": "under50"},
    {"label": "\$50 - \$100", "value": "50to100"},
    {"label": "\$100 - \$500", "value": "100to500"},
    {"label": "Over \$500", "value": "over500"},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "iPhone 15 Pro Max",
      "price": 1199.99,
      "originalPrice": 1299.99,
      "image": "https://picsum.photos/500/500?random=1&keyword=iphone",
      "rating": 4.8,
      "reviews": 3421,
      "brand": "apple",
      "category": "Electronics",
      "inStock": true,
      "fastDelivery": true,
      "warranty": 24,
      "colors": ["Space Black", "Natural Titanium", "White Titanium", "Blue Titanium"],
      "specifications": {
        "Display": "6.7-inch Super Retina XDR",
        "Chip": "A17 Pro",
        "Camera": "48MP Main Camera",
        "Storage": "256GB",
      },
      "features": ["Face ID", "Wireless Charging", "Water Resistant", "5G Ready"],
    },
    {
      "id": 2,
      "name": "Samsung Galaxy S24 Ultra",
      "price": 1099.99,
      "originalPrice": 1199.99,
      "image": "https://picsum.photos/500/500?random=2&keyword=samsung",
      "rating": 4.7,
      "reviews": 2876,
      "brand": "samsung",
      "category": "Electronics",
      "inStock": true,
      "fastDelivery": true,
      "warranty": 24,
      "colors": ["Titanium Gray", "Titanium Black", "Titanium Violet", "Titanium Yellow"],
      "specifications": {
        "Display": "6.8-inch Dynamic AMOLED 2X",
        "Processor": "Snapdragon 8 Gen 3",
        "Camera": "200MP Main Camera",
        "Storage": "512GB",
      },
      "features": ["S Pen", "Wireless Charging", "Water Resistant", "AI Photography"],
    },
    {
      "id": 3,
      "name": "Nike Air Max 270",
      "price": 149.99,
      "originalPrice": 179.99,
      "image": "https://picsum.photos/500/500?random=3&keyword=nike",
      "rating": 4.5,
      "reviews": 1892,
      "brand": "nike",
      "category": "Sports",
      "inStock": true,
      "fastDelivery": false,
      "warranty": 12,
      "colors": ["Black/White", "Triple White", "Red/Black", "Blue/White"],
      "specifications": {
        "Material": "Synthetic Upper",
        "Sole": "Air Max Unit",
        "Weight": "310g",
        "Origin": "Vietnam",
      },
      "features": ["Air Cushioning", "Breathable", "Durable", "Lightweight"],
    },
    {
      "id": 4,
      "name": "Adidas Ultraboost 22",
      "price": 189.99,
      "originalPrice": 219.99,
      "image": "https://picsum.photos/500/500?random=4&keyword=adidas",
      "rating": 4.6,
      "reviews": 1456,
      "brand": "adidas",
      "category": "Sports",
      "inStock": false,
      "fastDelivery": false,
      "warranty": 12,
      "colors": ["Core Black", "Cloud White", "Solar Red", "Navy Blue"],
      "specifications": {
        "Material": "Primeknit Upper",
        "Midsole": "Boost Technology",
        "Weight": "285g",
        "Drop": "10mm",
      },
      "features": ["Boost Cushioning", "Primeknit", "Continental Rubber", "Responsive"],
    },
    {
      "id": 5,
      "name": "Sony WH-1000XM5",
      "price": 349.99,
      "originalPrice": 399.99,
      "image": "https://picsum.photos/500/500?random=5&keyword=headphones",
      "rating": 4.9,
      "reviews": 2341,
      "brand": "sony",
      "category": "Electronics",
      "inStock": true,
      "fastDelivery": true,
      "warranty": 24,
      "colors": ["Black", "Silver", "Midnight Blue"],
      "specifications": {
        "Driver": "30mm Dynamic",
        "Frequency": "4Hz-40,000Hz",
        "Battery": "30 hours",
        "Weight": "250g",
      },
      "features": ["Noise Cancelling", "Quick Charge", "Multipoint", "Hi-Res Audio"],
    },
    {
      "id": 6,
      "name": "MacBook Air M2",
      "price": 999.99,
      "originalPrice": 1099.99,
      "image": "https://picsum.photos/500/500?random=6&keyword=macbook",
      "rating": 4.8,
      "reviews": 1789,
      "brand": "apple",
      "category": "Electronics",
      "inStock": true,
      "fastDelivery": true,
      "warranty": 12,
      "colors": ["Space Gray", "Silver", "Starlight", "Midnight"],
      "specifications": {
        "Chip": "Apple M2",
        "Display": "13.6-inch Liquid Retina",
        "Memory": "8GB Unified Memory",
        "Storage": "256GB SSD",
      },
      "features": ["Touch ID", "MagSafe", "Thunderbolt", "All-day Battery"],
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> filtered = products;

    // Filter by brand
    if (selectedBrand != 'all') {
      filtered = filtered.where((product) => product["brand"] == selectedBrand).toList();
    }

    // Filter by price range
    switch (priceRange) {
      case 'under50':
        filtered = filtered.where((product) => (product["price"] as double) < 50).toList();
        break;
      case '50to100':
        filtered = filtered.where((product) => 
          (product["price"] as double) >= 50 && (product["price"] as double) <= 100).toList();
        break;
      case '100to500':
        filtered = filtered.where((product) => 
          (product["price"] as double) > 100 && (product["price"] as double) <= 500).toList();
        break;
      case 'over500':
        filtered = filtered.where((product) => (product["price"] as double) > 500).toList();
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "Product Discovery",
      selectedIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: "Categories",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      children: [
        _buildHomeTab(),
        _buildCategoriesTab(),
        _buildSearchTab(),
        _buildProfileTab(),
      ],
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, successColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Discover amazing products from top brands",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Shop Now",
                        size: bs.sm,
                        onPressed: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Featured Products
          Text(
            "Featured Products",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: spSm),

          QHorizontalScroll(
            children: products.take(3).map((product) => _buildFeaturedProductCard(product)).toList(),
          ),

          SizedBox(height: spMd),

          // Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard("${products.length}", "Products", Icons.inventory),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("${brands.length - 1}", "Brands", Icons.business),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("${categories.length}", "Categories", Icons.category),
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Top Brands
          Text(
            "Top Brands",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: spSm),

          QHorizontalScroll(
            children: brands.skip(1).map((brand) => _buildBrandCard(brand)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories Grid
          Text(
            "Shop by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: spMd),

          ResponsiveGridView(
            minItemWidth: 200,
            children: categories.map((category) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        category["icon"],
                        size: 30,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${category["count"]} products",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Browse",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filters
          Text(
            "Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: spMd),

          QDropdownField(
            label: "Brand",
            items: brands,
            value: selectedBrand,
            onChanged: (value, label) {
              setState(() {
                selectedBrand = value;
              });
            },
          ),

          SizedBox(height: spMd),

          QDropdownField(
            label: "Price Range",
            items: priceRanges,
            value: priceRange,
            onChanged: (value, label) {
              setState(() {
                priceRange = value;
              });
            },
          ),

          SizedBox(height: spMd),

          // Results
          Text(
            "Products (${filteredProducts.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: spMd),

          ...filteredProducts.map((product) => _buildProductListItem(product)),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Profile Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "John Doe",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Premium Member",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Profile Options
          _buildProfileOption(Icons.shopping_bag, "My Orders", "Track your purchases"),
          _buildProfileOption(Icons.favorite, "Wishlist", "Save your favorite items"),
          _buildProfileOption(Icons.location_on, "Addresses", "Manage delivery addresses"),
          _buildProfileOption(Icons.payment, "Payment Methods", "Manage payment options"),
          _buildProfileOption(Icons.support, "Support", "Get help and support"),
          _buildProfileOption(Icons.settings, "Settings", "App preferences"),
        ],
      ),
    );
  }

  Widget _buildFeaturedProductCard(Map<String, dynamic> product) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusLg),
              topRight: Radius.circular(radiusLg),
            ),
            child: Image.network(
              "${product["image"]}",
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: warningColor),
                    SizedBox(width: 4),
                    Text(
                      "${product["rating"]}",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "\$${(product["price"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandCard(Map<String, dynamic> brand) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: primaryColor.withAlpha(20),
            child: Text(
              "${brand["label"]}"[0].toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${brand["label"]}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProductListItem(Map<String, dynamic> product) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusLg),
              bottomLeft: Radius.circular(radiusLg),
            ),
            child: Image.network(
              "${product["image"]}",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: warningColor),
                      SizedBox(width: 4),
                      Text(
                        "${product["rating"]}",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "(${product["reviews"]})",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${(product["price"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, String subtitle) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                icon,
                color: primaryColor,
                size: 20,
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: disabledBoldColor,
            ),
          ],
        ),
      ),
    );
  }
}
