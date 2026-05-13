import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaProductListView extends StatefulWidget {
  const SpaProductListView({super.key});

  @override
  State<SpaProductListView> createState() => _SpaProductListViewState();
}

class _SpaProductListViewState extends State<SpaProductListView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Popular";
  bool showFilters = false;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Skincare", "value": "Skincare"},
    {"label": "Haircare", "value": "Haircare"},
    {"label": "Body Care", "value": "Body Care"},
    {"label": "Aromatherapy", "value": "Aromatherapy"},
    {"label": "Makeup", "value": "Makeup"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Popular", "value": "Popular"},
    {"label": "Price: Low to High", "value": "Price: Low to High"},
    {"label": "Price: High to Low", "value": "Price: High to Low"},
    {"label": "Newest", "value": "Newest"},
    {"label": "Rating", "value": "Rating"},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": "1",
      "name": "Hydrating Facial Serum",
      "brand": "LuxeSpa",
      "category": "Skincare",
      "price": 89.99,
      "originalPrice": 120.00,
      "rating": 4.8,
      "reviews": 324,
      "image": "https://picsum.photos/200/200?random=1&keyword=serum",
      "isOnSale": true,
      "discount": 25,
      "tags": ["Bestseller", "Organic"],
      "description": "Premium hydrating serum with hyaluronic acid",
    },
    {
      "id": "2",
      "name": "Rejuvenating Night Cream",
      "brand": "GlowBeauty",
      "category": "Skincare",
      "price": 156.50,
      "originalPrice": 156.50,
      "rating": 4.7,
      "reviews": 189,
      "image": "https://picsum.photos/200/200?random=2&keyword=cream",
      "isOnSale": false,
      "discount": 0,
      "tags": ["Premium"],
      "description": "Anti-aging night cream with retinol and peptides",
    },
    {
      "id": "3",
      "name": "Volumizing Shampoo",
      "brand": "HairLux",
      "category": "Haircare",
      "price": 32.99,
      "originalPrice": 45.99,
      "rating": 4.5,
      "reviews": 267,
      "image": "https://picsum.photos/200/200?random=3&keyword=shampoo",
      "isOnSale": true,
      "discount": 28,
      "tags": ["Natural"],
      "description": "Sulfate-free volumizing shampoo for fine hair",
    },
    {
      "id": "4",
      "name": "Lavender Body Oil",
      "brand": "AromaBliss",
      "category": "Aromatherapy",
      "price": 24.99,
      "originalPrice": 24.99,
      "rating": 4.9,
      "reviews": 456,
      "image": "https://picsum.photos/200/200?random=4&keyword=oil",
      "isOnSale": false,
      "discount": 0,
      "tags": ["Bestseller", "Organic"],
      "description": "Pure lavender essential oil for relaxation",
    },
    {
      "id": "5",
      "name": "Exfoliating Body Scrub",
      "brand": "PureSpa",
      "category": "Body Care",
      "price": 18.75,
      "originalPrice": 25.00,
      "rating": 4.6,
      "reviews": 198,
      "image": "https://picsum.photos/200/200?random=5&keyword=scrub",
      "isOnSale": true,
      "discount": 25,
      "tags": ["Natural"],
      "description": "Dead sea salt exfoliating scrub with coconut oil",
    },
    {
      "id": "6",
      "name": "Matte Liquid Lipstick",
      "brand": "ColorPop",
      "category": "Makeup",
      "price": 12.99,
      "originalPrice": 12.99,
      "rating": 4.4,
      "reviews": 892,
      "image": "https://picsum.photos/200/200?random=6&keyword=lipstick",
      "isOnSale": false,
      "discount": 0,
      "tags": ["Trending"],
      "description": "Long-wearing matte liquid lipstick in rose shade",
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> filtered = products;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((product) => product["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((product) => 
        product["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        product["brand"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spa Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              si("Shopping cart");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchBar(),
            _buildCategoryFilter(),
            _buildProductStats(),
            if (showFilters) _buildFilterOptions(),
            _buildProductGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
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
              hint: "Search by name or brand",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.tune,
            size: bs.sm,
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
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
            "Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QCategoryPicker(
            items: categories,
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductStats() {
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
            child: Column(
              children: [
                Text(
                  "${filteredProducts.length}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Products Found",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${(filteredProducts.where((p) => p["isOnSale"] == true).length)}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "On Sale",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${categories.length - 1}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOptions() {
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
            "Sort & Filter",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Sort by",
            items: sortOptions,
            value: sortBy,
            onChanged: (value, label) {
              sortBy = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
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
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                  child: Image.network(
                    "${product["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (product["isOnSale"] == true)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "-${product["discount"]}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(200),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.favorite_border, size: 16),
                    onPressed: () {
                      si("Added to wishlist");
                    },
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
                Row(
                  children: [
                    ...((product["tags"] as List).take(2).map((tag) {
                      return Container(
                        margin: EdgeInsets.only(right: spXs),
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$tag",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      );
                    }).toList()),
                  ],
                ),
                Text(
                  "${product["brand"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
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
                  "${product["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${product["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      " (${product["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "\$${(product["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (product["isOnSale"] == true) ...[
                      SizedBox(width: spXs),
                      Text(
                        "\$${(product["originalPrice"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Add to Cart",
                    size: bs.sm,
                    onPressed: () {
                      ss("${product["name"]} added to cart");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
