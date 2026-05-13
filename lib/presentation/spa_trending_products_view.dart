import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaTrendingProductsView extends StatefulWidget {
  const SpaTrendingProductsView({super.key});

  @override
  State<SpaTrendingProductsView> createState() => _SpaTrendingProductsViewState();
}

class _SpaTrendingProductsViewState extends State<SpaTrendingProductsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedTrend = "This Week";
  bool loading = false;

  List<Map<String, dynamic>> trendingProducts = [
    {
      "id": 1,
      "name": "Vitamin C Brightening Serum",
      "brand": "GlowBeauty",
      "price": 45.99,
      "originalPrice": 59.99,
      "discount": 23,
      "image": "https://picsum.photos/300/300?random=1&keyword=serum",
      "rating": 4.8,
      "reviewCount": 1247,
      "category": "Skincare",
      "trending": "hot",
      "sales": 2847,
      "growthRate": 85.2,
      "tags": ["New", "Bestseller"],
      "description": "Powerful anti-aging serum with 20% Vitamin C"
    },
    {
      "id": 2,
      "name": "Hyaluronic Acid Moisturizer",
      "brand": "AquaGlow",
      "price": 32.50,
      "originalPrice": 42.00,
      "discount": 23,
      "image": "https://picsum.photos/300/300?random=2&keyword=moisturizer",
      "rating": 4.7,
      "reviewCount": 956,
      "category": "Skincare",
      "trending": "rising",
      "sales": 1893,
      "growthRate": 124.7,
      "tags": ["Trending", "Hydrating"],
      "description": "Deep hydration with triple hyaluronic acid complex"
    },
    {
      "id": 3,
      "name": "Luxury Hair Treatment Mask",
      "brand": "SilkHair",
      "price": 78.99,
      "originalPrice": 98.00,
      "discount": 19,
      "image": "https://picsum.photos/300/300?random=3&keyword=hairmask",
      "rating": 4.9,
      "reviewCount": 654,
      "category": "Hair Care",
      "trending": "hot",
      "sales": 1256,
      "growthRate": 67.3,
      "tags": ["Premium", "Salon Quality"],
      "description": "Professional-grade hair restoration treatment"
    },
    {
      "id": 4,
      "name": "Organic Rose Face Oil",
      "brand": "NaturalGlow",
      "price": 54.25,
      "originalPrice": 69.99,
      "discount": 22,
      "image": "https://picsum.photos/300/300?random=4&keyword=faceoil",
      "rating": 4.6,
      "reviewCount": 743,
      "category": "Skincare",
      "trending": "rising",
      "sales": 2156,
      "growthRate": 156.8,
      "tags": ["Organic", "Anti-aging"],
      "description": "100% organic rose hip oil for mature skin"
    },
    {
      "id": 5,
      "name": "Collagen Peptide Cream",
      "brand": "YouthRevive",
      "price": 89.99,
      "originalPrice": 120.00,
      "discount": 25,
      "image": "https://picsum.photos/300/300?random=5&keyword=collagen",
      "rating": 4.7,
      "reviewCount": 1089,
      "category": "Anti-aging",
      "trending": "hot",
      "sales": 1674,
      "growthRate": 92.4,
      "tags": ["Clinical", "Firming"],
      "description": "Advanced collagen boosting night cream"
    },
    {
      "id": 6,
      "name": "Botanical Cleansing Foam",
      "brand": "PureNature",
      "price": 28.75,
      "originalPrice": 35.00,
      "discount": 18,
      "image": "https://picsum.photos/300/300?random=6&keyword=cleanser",
      "rating": 4.5,
      "reviewCount": 892,
      "category": "Skincare",
      "trending": "rising",
      "sales": 3421,
      "growthRate": 201.3,
      "tags": ["Gentle", "Sulfate-free"],
      "description": "Gentle botanical cleanser for sensitive skin"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "All"},
    {"label": "Skincare", "value": "Skincare"},
    {"label": "Hair Care", "value": "Hair Care"},
    {"label": "Makeup", "value": "Makeup"},
    {"label": "Anti-aging", "value": "Anti-aging"},
    {"label": "Body Care", "value": "Body Care"},
  ];

  List<Map<String, dynamic>> trendPeriods = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return trendingProducts.where((product) {
      bool matchesSearch = product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          product["brand"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || product["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchSection(),
                  SizedBox(height: spLg),
                  _buildTrendingStats(),
                  SizedBox(height: spLg),
                  _buildFilters(),
                  SizedBox(height: spLg),
                  _buildProductGrid(),
                ],
              ),
            ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Discover What's Trending",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Find the most popular products loved by customers",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Search trending products...",
            value: searchQuery,
            hint: "Enter product name or brand",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          _buildStatCard("Total Products", "2,847", Icons.trending_up, successColor),
          SizedBox(width: spSm),
          _buildStatCard("Avg Growth", "127%", Icons.analytics, infoColor),
          SizedBox(width: spSm),
          _buildStatCard("Top Category", "Skincare", Icons.category, warningColor),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: QDropdownField(
            label: "Category",
            items: categories,
            value: selectedCategory,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QDropdownField(
            label: "Trending Period",
            items: trendPeriods,
            value: selectedTrend,
            onChanged: (value, label) {
              selectedTrend = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid() {
    if (filteredProducts.isEmpty) {
      return Container(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 48,
                color: disabledBoldColor,
              ),
              SizedBox(height: spSm),
              Text(
                "No trending products found",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 200,
      children: filteredProducts.map((product) {
        return _buildProductCard(product);
      }).toList(),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(product),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductInfo(product),
                SizedBox(height: spSm),
                _buildPriceSection(product),
                SizedBox(height: spSm),
                _buildTrendingBadge(product),
                SizedBox(height: spSm),
                _buildActionButtons(product),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(Map<String, dynamic> product) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
          child: Image.network(
            "${product["image"]}",
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: spSm,
          left: spSm,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: product["trending"] == "hot" ? dangerColor : warningColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              product["trending"] == "hot" ? "🔥 HOT" : "📈 RISING",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if ((product["discount"] as int) > 0)
          Positioned(
            top: spSm,
            right: spSm,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "-${product["discount"]}%",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProductInfo(Map<String, dynamic> product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${product["brand"]}",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: spXs),
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
        SizedBox(height: spXs),
        Row(
          children: [
            Icon(
              Icons.star,
              color: warningColor,
              size: 16,
            ),
            SizedBox(width: spXs),
            Text(
              "${product["rating"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(width: spXs),
            Text(
              "(${product["reviewCount"]})",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceSection(Map<String, dynamic> product) {
    return Row(
      children: [
        Text(
          "\$${(product["price"] as double).toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        if ((product["discount"] as int) > 0)
          Text(
            "\$${(product["originalPrice"] as double).toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              decoration: TextDecoration.lineThrough,
            ),
          ),
      ],
    );
  }

  Widget _buildTrendingBadge(Map<String, dynamic> product) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: successColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.trending_up,
            color: successColor,
            size: 14,
          ),
          SizedBox(width: spXs),
          Text(
            "+${(product["growthRate"] as double).toStringAsFixed(1)}%",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "${product["sales"]} sold",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> product) {
    return Row(
      children: [
        Expanded(
          child: QButton(
            label: "Add to Cart",
            size: bs.sm,
            onPressed: () {
              ss("${product["name"]} added to cart");
            },
          ),
        ),
        SizedBox(width: spSm),
        QButton(
          icon: Icons.favorite_border,
          size: bs.sm,
          onPressed: () {
            ss("Added to wishlist");
          },
        ),
      ],
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Additional filters will be available soon."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
