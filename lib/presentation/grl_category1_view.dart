import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCategory1View extends StatefulWidget {
  @override
  State<GrlCategory1View> createState() => _GrlCategory1ViewState();
}

class _GrlCategory1ViewState extends State<GrlCategory1View> {
  String searchQuery = "";
  String selectedFilter = "all";
  
  List<Map<String, dynamic>> categories = [
    {
      "id": 1,
      "name": "Electronics",
      "description": "Latest smartphones, laptops, and gadgets",
      "icon": "electronics",
      "itemCount": 1247,
      "imageUrl": "https://picsum.photos/300/200?random=1&keyword=electronics",
      "trending": true,
      "subcategories": ["Smartphones", "Laptops", "Tablets", "Accessories"],
      "popularBrands": ["Apple", "Samsung", "Sony", "Dell"],
    },
    {
      "id": 2,
      "name": "Fashion & Style",
      "description": "Trendy clothing, shoes, and accessories",
      "icon": "fashion",
      "itemCount": 892,
      "imageUrl": "https://picsum.photos/300/200?random=2&keyword=fashion",
      "trending": false,
      "subcategories": ["Men's Wear", "Women's Wear", "Shoes", "Bags"],
      "popularBrands": ["Nike", "Adidas", "Zara", "H&M"],
    },
    {
      "id": 3,
      "name": "Home & Living",
      "description": "Furniture, decor, and home essentials",
      "icon": "home",
      "itemCount": 654,
      "imageUrl": "https://picsum.photos/300/200?random=3&keyword=home",
      "trending": true,
      "subcategories": ["Furniture", "Decor", "Kitchen", "Bedding"],
      "popularBrands": ["IKEA", "Ashley", "Wayfair", "Target"],
    },
    {
      "id": 4,
      "name": "Sports & Fitness",
      "description": "Equipment, apparel, and wellness products",
      "icon": "sports",
      "itemCount": 423,
      "imageUrl": "https://picsum.photos/300/200?random=4&keyword=sports",
      "trending": false,
      "subcategories": ["Gym Equipment", "Sportswear", "Outdoor", "Wellness"],
      "popularBrands": ["Nike", "Adidas", "Under Armour", "Reebok"],
    },
    {
      "id": 5,
      "name": "Books & Media",
      "description": "Books, movies, music, and educational content",
      "icon": "books",
      "itemCount": 789,
      "imageUrl": "https://picsum.photos/300/200?random=5&keyword=books",
      "trending": false,
      "subcategories": ["Fiction", "Non-Fiction", "Movies", "Music"],
      "popularBrands": ["Amazon", "Barnes & Noble", "Penguin", "Disney"],
    },
    {
      "id": 6,
      "name": "Beauty & Care",
      "description": "Skincare, makeup, and personal care products",
      "icon": "beauty",
      "itemCount": 567,
      "imageUrl": "https://picsum.photos/300/200?random=6&keyword=beauty",
      "trending": true,
      "subcategories": ["Skincare", "Makeup", "Hair Care", "Fragrance"],
      "popularBrands": ["L'Oreal", "Maybelline", "Clinique", "MAC"],
    },
  ];

  List<Map<String, dynamic>> get filteredCategories {
    var filtered = categories.where((category) {
      bool matchesSearch = category["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          category["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "all" ||
                          (selectedFilter == "trending" && category["trending"] == true) ||
                          (selectedFilter == "popular" && (category["itemCount"] as int) > 500);
      
      return matchesSearch && matchesFilter;
    }).toList();
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explore Categories",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Discover products from ${categories.length} different categories",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: QTextField(
                      label: "Search categories...",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Filter Options
            QHorizontalScroll(
              children: [
                {"label": "All Categories", "value": "all"},
                {"label": "Trending", "value": "trending"},
                {"label": "Popular", "value": "popular"},
              ].map((filter) => GestureDetector(
                onTap: () {
                  selectedFilter = filter["value"]!;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: selectedFilter == filter["value"] ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Text(
                    filter["label"]!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: selectedFilter == filter["value"] ? Colors.white : primaryColor,
                    ),
                  ),
                ),
              )).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Categories Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredCategories.map((category) => Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Image
                    Stack(
                      children: [
                        Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                            child: Image.network(
                              "${category["imageUrl"]}",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: primaryColor.withAlpha(50),
                                  child: Icon(
                                    _getCategoryIcon(category["icon"]),
                                    size: 40,
                                    color: primaryColor,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        if (category["trending"] == true)
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "TRENDING",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    
                    // Category Info
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getCategoryIcon(category["icon"]),
                                size: 20,
                                color: primaryColor,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${category["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${category["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spMd),
                          
                          // Item Count
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${(category["itemCount"] as int).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} items",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Subcategories
                          Text(
                            "Popular:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: (category["subcategories"] as List).take(3).map((sub) => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$sub",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                ),
                              ),
                            )).toList().cast<Widget>(),
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Action Button
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Explore",
                              size: bs.sm,
                              onPressed: () {
                                // navigateTo(CategoryDetailView(category: category));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Summary Stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "Category Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${categories.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Categories",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${categories.where((c) => c["trending"] == true).length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Trending",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${((categories.map((c) => c["itemCount"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Total Items",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String iconType) {
    switch (iconType) {
      case 'electronics':
        return Icons.devices;
      case 'fashion':
        return Icons.checkroom;
      case 'home':
        return Icons.home;
      case 'sports':
        return Icons.sports;
      case 'books':
        return Icons.menu_book;
      case 'beauty':
        return Icons.face;
      default:
        return Icons.category;
    }
  }
}
