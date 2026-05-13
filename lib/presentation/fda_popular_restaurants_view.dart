import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaPopularRestaurantsView extends StatefulWidget {
  const FdaPopularRestaurantsView({super.key});

  @override
  State<FdaPopularRestaurantsView> createState() => _FdaPopularRestaurantsViewState();
}

class _FdaPopularRestaurantsViewState extends State<FdaPopularRestaurantsView> {
  String selectedCategory = "All Cuisines";
  String searchQuery = "";
  String sortBy = "Popularity";
  bool isGridView = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all"},
    {"label": "Fast Food", "value": "fast_food"},
    {"label": "Asian", "value": "asian"},
    {"label": "Italian", "value": "italian"},
    {"label": "Mexican", "value": "mexican"},
    {"label": "Desserts", "value": "desserts"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Most Popular", "value": "popularity"},
    {"label": "Highest Rated", "value": "rating"},
    {"label": "Fastest Delivery", "value": "delivery_time"},
    {"label": "Lowest Delivery Fee", "value": "delivery_fee"},
  ];

  List<Map<String, dynamic>> restaurants = [
    {
      "id": "1",
      "name": "Burger Palace",
      "category": "fast_food",
      "image": "https://picsum.photos/300/200?random=1&keyword=burger",
      "rating": 4.8,
      "reviews": 2456,
      "deliveryTime": "20-30 min",
      "deliveryFee": 2.99,
      "distance": 1.2,
      "isPromoted": true,
      "tags": ["Popular", "Fast Delivery"],
      "popularityScore": 95,
      "cuisines": ["American", "Burgers"],
      "priceRange": "\$\$",
      "offers": ["Free delivery on orders over \$25"]
    },
    {
      "id": "2",
      "name": "Dragon House",
      "category": "asian",
      "image": "https://picsum.photos/300/200?random=2&keyword=chinese",
      "rating": 4.7,
      "reviews": 1832,
      "deliveryTime": "25-35 min",
      "deliveryFee": 3.49,
      "distance": 2.1,
      "isPromoted": false,
      "tags": ["Trending", "Authentic"],
      "popularityScore": 92,
      "cuisines": ["Chinese", "Asian"],
      "priceRange": "\$\$\$",
      "offers": ["20% off on orders over \$30"]
    },
    {
      "id": "3",
      "name": "Pizza Corner",
      "category": "italian",
      "image": "https://picsum.photos/300/200?random=3&keyword=pizza",
      "rating": 4.6,
      "reviews": 3124,
      "deliveryTime": "30-40 min",
      "deliveryFee": 2.49,
      "distance": 1.8,
      "isPromoted": true,
      "tags": ["Most Ordered", "Great Value"],
      "popularityScore": 89,
      "cuisines": ["Italian", "Pizza"],
      "priceRange": "\$\$",
      "offers": ["Buy 1 Get 1 Free on selected items"]
    },
    {
      "id": "4",
      "name": "Taco Fiesta",
      "category": "mexican",
      "image": "https://picsum.photos/300/200?random=4&keyword=tacos",
      "rating": 4.5,
      "reviews": 987,
      "deliveryTime": "25-35 min",
      "deliveryFee": 3.99,
      "distance": 2.5,
      "isPromoted": false,
      "tags": ["Spicy", "Authentic"],
      "popularityScore": 86,
      "cuisines": ["Mexican", "Latin"],
      "priceRange": "\$\$",
      "offers": ["Free nachos with any order"]
    },
    {
      "id": "5",
      "name": "Sweet Dreams Bakery",
      "category": "desserts",
      "image": "https://picsum.photos/300/200?random=5&keyword=dessert",
      "rating": 4.9,
      "reviews": 1567,
      "deliveryTime": "15-25 min",
      "deliveryFee": 1.99,
      "distance": 0.8,
      "isPromoted": false,
      "tags": ["Best Rated", "Quick Delivery"],
      "popularityScore": 94,
      "cuisines": ["Desserts", "Bakery"],
      "priceRange": "\$",
      "offers": ["Free cake slice on orders over \$20"]
    },
    {
      "id": "6",
      "name": "Sushi Zen",
      "category": "asian",
      "image": "https://picsum.photos/300/200?random=6&keyword=sushi",
      "rating": 4.8,
      "reviews": 2198,
      "deliveryTime": "35-45 min",
      "deliveryFee": 4.99,
      "distance": 3.2,
      "isPromoted": true,
      "tags": ["Premium", "Fresh"],
      "popularityScore": 91,
      "cuisines": ["Japanese", "Sushi"],
      "priceRange": "\$\$\$\$",
      "offers": ["15% off first order"]
    }
  ];

  List<Map<String, dynamic>> get filteredRestaurants {
    var filtered = restaurants.where((restaurant) {
      bool matchesCategory = selectedCategory == "All" || restaurant["category"] == selectedCategory.toLowerCase().replaceAll(" ", "_");
      bool matchesSearch = searchQuery.isEmpty || 
        "${restaurant["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        (restaurant["cuisines"] as List).any((cuisine) => 
          "$cuisine".toLowerCase().contains(searchQuery.toLowerCase()));
      return matchesCategory && matchesSearch;
    }).toList();
    
    // Sort restaurants
    filtered.sort((a, b) {
      switch (sortBy) {
        case "rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "delivery_time":
          String aTime = "${a["deliveryTime"]}".split("-")[0];
          String bTime = "${b["deliveryTime"]}".split("-")[0];
          return int.parse(aTime).compareTo(int.parse(bTime));
        case "delivery_fee":
          return (a["deliveryFee"] as double).compareTo(b["deliveryFee"] as double);
        default: // popularity
          return (b["popularityScore"] as int).compareTo(a["popularityScore"] as int);
      }
    });
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Restaurants"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
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
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search restaurants",
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
            
            SizedBox(height: spLg),
            
            // Category Filter
            QCategoryPicker(
              label: "Categories",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = label;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Results Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredRestaurants.length} Popular Restaurants",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: _showSortBottomSheet,
                  child: Row(
                    children: [
                      Icon(
                        Icons.sort,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "Sort",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Restaurant List
            ...filteredRestaurants.map((restaurant) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Restaurant Image
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(radiusMd),
                          ),
                          child: Image.network(
                            "${restaurant["image"]}",
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (restaurant["isPromoted"] as bool)
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "PROMOTED",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [shadowSm],
                            ),
                            child: Icon(
                              Icons.favorite_border,
                              size: 20,
                              color: dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Restaurant Info
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${restaurant["name"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${restaurant["rating"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Text(
                            (restaurant["cuisines"] as List).join(" • "),
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Row(
                            children: [
                              Text(
                                "${restaurant["priceRange"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${restaurant["deliveryTime"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.delivery_dining,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "\$${(restaurant["deliveryFee"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          // Tags
                          QHorizontalScroll(
                            children: (restaurant["tags"] as List).map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$tag",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          
                          if ((restaurant["offers"] as List).isNotEmpty) ...[
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.local_offer,
                                    size: 14,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${(restaurant["offers"] as List)[0]}",
                                      style: TextStyle(
                                        color: successColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Menu",
                                  size: bs.sm,
                                  onPressed: () {},
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
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    // Implementation for filter bottom sheet
  }

  void _showSortBottomSheet() {
    // Implementation for sort bottom sheet
  }
}
