import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsBrandListView extends StatefulWidget {
  const EcsBrandListView({super.key});

  @override
  State<EcsBrandListView> createState() => _EcsBrandListViewState();
}

class _EcsBrandListViewState extends State<EcsBrandListView> {
  String searchQuery = "";
  String selectedCategory = "All";
  
  List<String> categories = [
    "All",
    "Electronics",
    "Fashion",
    "Home & Garden",
    "Sports",
    "Beauty",
    "Automotive",
    "Books",
    "Health",
  ];

  List<Map<String, dynamic>> brands = [
    {
      "id": "1",
      "name": "Apple",
      "logo": "https://picsum.photos/80/80?random=1&keyword=apple",
      "category": "Electronics",
      "productCount": 156,
      "rating": 4.8,
      "description": "Innovative technology products",
      "isVerified": true,
      "isFavorite": true,
      "isNew": false,
    },
    {
      "id": "2", 
      "name": "Nike",
      "logo": "https://picsum.photos/80/80?random=2&keyword=nike",
      "category": "Sports",
      "productCount": 324,
      "rating": 4.7,
      "description": "Athletic footwear and apparel",
      "isVerified": true,
      "isFavorite": false,
      "isNew": false,
    },
    {
      "id": "3",
      "name": "Samsung",
      "logo": "https://picsum.photos/80/80?random=3&keyword=samsung",
      "category": "Electronics",
      "productCount": 289,
      "rating": 4.6,
      "description": "Consumer electronics and smartphones",
      "isVerified": true,
      "isFavorite": true,
      "isNew": false,
    },
    {
      "id": "4",
      "name": "Zara",
      "logo": "https://picsum.photos/80/80?random=4&keyword=fashion",
      "category": "Fashion",
      "productCount": 567,
      "rating": 4.5,
      "description": "Fashion and lifestyle clothing",
      "isVerified": true,
      "isFavorite": false,
      "isNew": true,
    },
    {
      "id": "5",
      "name": "IKEA",
      "logo": "https://picsum.photos/80/80?random=5&keyword=furniture",
      "category": "Home & Garden",
      "productCount": 412,
      "rating": 4.4,
      "description": "Furniture and home accessories",
      "isVerified": true,
      "isFavorite": false,
      "isNew": false,
    },
    {
      "id": "6",
      "name": "L'Oréal",
      "logo": "https://picsum.photos/80/80?random=6&keyword=beauty",
      "category": "Beauty",
      "productCount": 198,
      "rating": 4.6,
      "description": "Beauty and cosmetics products",
      "isVerified": true,
      "isFavorite": true,
      "isNew": false,
    },
    {
      "id": "7",
      "name": "Sony",
      "logo": "https://picsum.photos/80/80?random=7&keyword=electronics",
      "category": "Electronics",
      "productCount": 234,
      "rating": 4.7,
      "description": "Electronics and entertainment",
      "isVerified": true,
      "isFavorite": false,
      "isNew": false,
    },
    {
      "id": "8",
      "name": "Adidas",
      "logo": "https://picsum.photos/80/80?random=8&keyword=sports",
      "category": "Sports",
      "productCount": 298,
      "rating": 4.6,
      "description": "Sports apparel and equipment",
      "isVerified": true,
      "isFavorite": false,
      "isNew": false,
    },
  ];

  List<Map<String, dynamic>> get filteredBrands {
    return brands.where((brand) {
      bool matchesSearch = brand["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          brand["description"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || brand["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _toggleFavorite(String brandId) {
    setState(() {
      int index = brands.indexWhere((brand) => brand["id"] == brandId);
      if (index != -1) {
        brands[index]["isFavorite"] = !brands[index]["isFavorite"];
        String message = brands[index]["isFavorite"] 
            ? "Added to favorites" 
            : "Removed from favorites";
        ss(message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brands"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Navigate to favorite brands
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              // Show sort options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            QTextField(
              label: "Search Brands",
              value: searchQuery,
              hint: "Search by brand name or category",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Category Filter
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            QHorizontalScroll(
              children: categories.map((category) {
                bool isSelected = selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Results Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredBrands.length} Brands Found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Sorted by Popularity",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Featured Brands Banner
            if (searchQuery.isEmpty && selectedCategory == "All")
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Featured Brands",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Discover top-rated brands with exclusive deals",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

            // Brands Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredBrands.map((brand) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Brand Header
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              boxShadow: [shadowSm],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${brand["logo"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${brand["name"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    if (brand["isVerified"])
                                      Icon(
                                        Icons.verified,
                                        color: successColor,
                                        size: 16,
                                      ),
                                    if (brand["isNew"])
                                      Container(
                                        margin: EdgeInsets.only(left: spXs),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: warningColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "NEW",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${brand["category"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _toggleFavorite("${brand["id"]}"),
                            child: Icon(
                              brand["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                              color: brand["isFavorite"] ? dangerColor : disabledBoldColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Brand Description
                      Text(
                        "${brand["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: spSm),

                      // Brand Stats
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${brand["rating"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            Icons.inventory,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${brand["productCount"]} products",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // View Brand Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "View Brand",
                          size: bs.sm,
                          onPressed: () {
                            // Navigate to brand detail page
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Load More Section
            if (filteredBrands.length >= 8)
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: spMd),
                child: QButton(
                  label: "Load More Brands",
                  size: bs.sm,
                  onPressed: () {
                    // Load more brands
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
