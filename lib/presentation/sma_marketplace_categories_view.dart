import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaMarketplaceCategoriesView extends StatefulWidget {
  const SmaMarketplaceCategoriesView({super.key});

  @override
  State<SmaMarketplaceCategoriesView> createState() => _SmaMarketplaceCategoriesViewState();
}

class _SmaMarketplaceCategoriesViewState extends State<SmaMarketplaceCategoriesView> {
  String searchQuery = "";
  String selectedView = "grid";

  List<Map<String, dynamic>> categories = [
    {
      "id": 1,
      "name": "Electronics",
      "description": "Phones, laptops, gadgets and more",
      "icon": Icons.devices,
      "color": Colors.blue,
      "itemCount": 1243,
      "newItems": 15,
      "image": "https://picsum.photos/300/200?random=1&keyword=electronics",
      "trending": true,
      "subcategories": ["Smartphones", "Laptops", "Gaming", "Audio", "Cameras"],
    },
    {
      "id": 2,
      "name": "Clothing & Fashion",
      "description": "Trendy clothes and accessories",
      "icon": Icons.checkroom,
      "color": Colors.pink,
      "itemCount": 892,
      "newItems": 23,
      "image": "https://picsum.photos/300/200?random=2&keyword=fashion",
      "trending": true,
      "subcategories": ["Men's Clothing", "Women's Clothing", "Shoes", "Accessories", "Bags"],
    },
    {
      "id": 3,
      "name": "Home & Garden",
      "description": "Furniture, decor and garden supplies",
      "icon": Icons.home,
      "color": Colors.green,
      "itemCount": 567,
      "newItems": 8,
      "image": "https://picsum.photos/300/200?random=3&keyword=home",
      "trending": false,
      "subcategories": ["Furniture", "Decor", "Kitchen", "Garden", "Tools"],
    },
    {
      "id": 4,
      "name": "Books & Education",
      "description": "Books, courses and learning materials",
      "icon": Icons.book,
      "color": Colors.orange,
      "itemCount": 334,
      "newItems": 12,
      "image": "https://picsum.photos/300/200?random=4&keyword=books",
      "trending": false,
      "subcategories": ["Textbooks", "Fiction", "Non-fiction", "Courses", "Magazines"],
    },
    {
      "id": 5,
      "name": "Sports & Recreation",
      "description": "Sports equipment and outdoor gear",
      "icon": Icons.sports_basketball,
      "color": Colors.red,
      "itemCount": 445,
      "newItems": 7,
      "image": "https://picsum.photos/300/200?random=5&keyword=sports",
      "trending": true,
      "subcategories": ["Team Sports", "Fitness", "Outdoor", "Water Sports", "Winter Sports"],
    },
    {
      "id": 6,
      "name": "Automotive",
      "description": "Cars, motorcycles and auto parts",
      "icon": Icons.directions_car,
      "color": Colors.indigo,
      "itemCount": 789,
      "newItems": 19,
      "image": "https://picsum.photos/300/200?random=6&keyword=cars",
      "trending": false,
      "subcategories": ["Cars", "Motorcycles", "Parts", "Accessories", "Services"],
    },
    {
      "id": 7,
      "name": "Health & Beauty",
      "description": "Skincare, cosmetics and wellness",
      "icon": Icons.spa,
      "color": Colors.purple,
      "itemCount": 223,
      "newItems": 5,
      "image": "https://picsum.photos/300/200?random=7&keyword=beauty",
      "trending": false,
      "subcategories": ["Skincare", "Makeup", "Hair Care", "Wellness", "Supplements"],
    },
    {
      "id": 8,
      "name": "Services",
      "description": "Professional services and skills",
      "icon": Icons.build,
      "color": Colors.teal,
      "itemCount": 156,
      "newItems": 3,
      "image": "https://picsum.photos/300/200?random=8&keyword=services",
      "trending": false,
      "subcategories": ["Repair", "Cleaning", "Tutoring", "Design", "Consulting"],
    },
    {
      "id": 9,
      "name": "Pets & Animals",
      "description": "Pet supplies and animal care",
      "icon": Icons.pets,
      "color": Colors.brown,
      "itemCount": 178,
      "newItems": 4,
      "image": "https://picsum.photos/300/200?random=9&keyword=pets",
      "trending": false,
      "subcategories": ["Pet Food", "Toys", "Accessories", "Healthcare", "Training"],
    },
    {
      "id": 10,
      "name": "Collectibles",
      "description": "Rare items, antiques and collectibles",
      "icon": Icons.collections,
      "color": Colors.amber,
      "itemCount": 89,
      "newItems": 2,
      "image": "https://picsum.photos/300/200?random=10&keyword=antique",
      "trending": false,
      "subcategories": ["Antiques", "Coins", "Cards", "Art", "Memorabilia"],
    },
  ];

  List<Map<String, dynamic>> get filteredCategories {
    if (searchQuery.isEmpty) return categories;
    return categories.where((category) {
      return (category["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
             (category["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
             (category["subcategories"] as List).any((sub) => 
               sub.toLowerCase().contains(searchQuery.toLowerCase()));
    }).toList();
  }

  List<Map<String, dynamic>> get trendingCategories {
    return categories.where((category) => category["trending"] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          IconButton(
            icon: Icon(selectedView == "grid" ? Icons.list : Icons.grid_view),
            onPressed: () {
              selectedView = selectedView == "grid" ? "list" : "grid";
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search categories...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
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
                          "Categories",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${categories.fold(0, (sum, cat) => sum + (cat["itemCount"] as int))}",
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
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${categories.fold(0, (sum, cat) => sum + (cat["newItems"] as int))}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "New Today",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Trending Categories
            if (trendingCategories.isNotEmpty) ...[
              Row(
                children: [
                  Icon(Icons.trending_up, color: warningColor, size: 20),
                  SizedBox(width: spXs),
                  Text(
                    "Trending Categories",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              QHorizontalScroll(
                children: trendingCategories.map((category) => _buildTrendingCategoryCard(category)).toList(),
              ),
            ],

            // All Categories
            Row(
              children: [
                Text(
                  "All Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredCategories.length} categories",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            // Categories Display
            if (selectedView == "grid")
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredCategories.map((category) => _buildCategoryCard(category)).toList(),
              )
            else
              Column(
                spacing: spSm,
                children: filteredCategories.map((category) => _buildCategoryListItem(category)).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingCategoryCard(Map<String, dynamic> category) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Trending Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  topRight: Radius.circular(radiusMd),
                ),
                child: Image.network(
                  "${category["image"]}",
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.trending_up, color: Colors.white, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "Trending",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: (category["color"] as Color).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        category["icon"],
                        size: 16,
                        color: category["color"],
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${category["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Text(
                  "${category["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Row(
                  children: [
                    Text(
                      "${category["itemCount"]} items",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                    Spacer(),
                    if ((category["newItems"] as int) > 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "+${category["newItems"]} new",
                          style: TextStyle(
                            fontSize: 9,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        //navigateTo('MarketplaceView', arguments: {'category': category["name"]})
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                  child: Image.network(
                    "${category["image"]}",
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (category["trending"] == true)
                  Positioned(
                    top: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.trending_up, color: Colors.white, size: 10),
                          SizedBox(width: spXs),
                          Text(
                            "Hot",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            // Content
            Padding(
              padding: EdgeInsets.all(spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (category["color"] as Color).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          category["icon"],
                          size: 16,
                          color: category["color"],
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${category["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Text(
                    "${category["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Subcategories
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (category["subcategories"] as List).take(3).map((sub) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$sub",
                          style: TextStyle(
                            fontSize: 9,
                            color: disabledBoldColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  Row(
                    children: [
                      Text(
                        "${category["itemCount"]} items",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      Spacer(),
                      if ((category["newItems"] as int) > 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "+${category["newItems"]} new",
                            style: TextStyle(
                              fontSize: 9,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
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

  Widget _buildCategoryListItem(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        //navigateTo('MarketplaceView', arguments: {'category': category["name"]})
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${category["image"]}",
                height: 60,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            
            SizedBox(width: spSm),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (category["color"] as Color).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          category["icon"],
                          size: 16,
                          color: category["color"],
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${category["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      if (category["trending"] == true)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Hot",
                            style: TextStyle(
                              fontSize: 9,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  Text(
                    "${category["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Row(
                    children: [
                      Text(
                        "${category["itemCount"]} items",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      if ((category["newItems"] as int) > 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "+${category["newItems"]} new",
                            style: TextStyle(
                              fontSize: 9,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
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
}
