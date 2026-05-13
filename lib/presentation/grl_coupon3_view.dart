import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCoupon3View extends StatefulWidget {
  @override
  State<GrlCoupon3View> createState() => _GrlCoupon3ViewState();
}

class _GrlCoupon3ViewState extends State<GrlCoupon3View> {
  String selectedCategory = 'all';
  String searchQuery = '';
  bool showFavorites = false;

  List<Map<String, dynamic>> stores = [
    {
      "id": 1,
      "name": "Target",
      "logo": "https://picsum.photos/80/80?random=1&keyword=store",
      "category": "retail",
      "rating": 4.5,
      "totalCoupons": 45,
      "activeCoupons": 12,
      "maxDiscount": 50,
      "isFavorite": true,
      "backgroundColor": "#CC0000",
      "description": "Everything you need, all in one place",
      "tags": ["fashion", "home", "electronics"],
    },
    {
      "id": 2,
      "name": "McDonald's",
      "logo": "https://picsum.photos/80/80?random=2&keyword=restaurant",
      "category": "food",
      "rating": 4.2,
      "totalCoupons": 28,
      "activeCoupons": 8,
      "maxDiscount": 25,
      "isFavorite": false,
      "backgroundColor": "#FFC72C",
      "description": "I'm lovin' it - Fast food favorites",
      "tags": ["burgers", "breakfast", "drinks"],
    },
    {
      "id": 3,
      "name": "Starbucks",
      "logo": "https://picsum.photos/80/80?random=3&keyword=coffee",
      "category": "food",
      "rating": 4.4,
      "totalCoupons": 35,
      "activeCoupons": 15,
      "maxDiscount": 30,
      "isFavorite": true,
      "backgroundColor": "#00704A",
      "description": "Premium coffee and more",
      "tags": ["coffee", "pastries", "tea"],
    },
    {
      "id": 4,
      "name": "Nike",
      "logo": "https://picsum.photos/80/80?random=4&keyword=shoes",
      "category": "fashion",
      "rating": 4.6,
      "totalCoupons": 52,
      "activeCoupons": 18,
      "maxDiscount": 40,
      "isFavorite": false,
      "backgroundColor": "#111111",
      "description": "Just Do It - Athletic wear & shoes",
      "tags": ["shoes", "sportswear", "accessories"],
    },
    {
      "id": 5,
      "name": "Amazon",
      "logo": "https://picsum.photos/80/80?random=5&keyword=shopping",
      "category": "retail",
      "rating": 4.3,
      "totalCoupons": 120,
      "activeCoupons": 45,
      "maxDiscount": 60,
      "isFavorite": true,
      "backgroundColor": "#FF9900",
      "description": "Everything store - Online shopping",
      "tags": ["electronics", "books", "home"],
    },
    {
      "id": 6,
      "name": "Walmart",
      "logo": "https://picsum.photos/80/80?random=6&keyword=market",
      "category": "retail",
      "rating": 4.1,
      "totalCoupons": 85,
      "activeCoupons": 32,
      "maxDiscount": 35,
      "isFavorite": false,
      "backgroundColor": "#0071CE",
      "description": "Save money. Live better.",
      "tags": ["groceries", "home", "electronics"],
    },
    {
      "id": 7,
      "name": "Pizza Hut",
      "logo": "https://picsum.photos/80/80?random=7&keyword=pizza",
      "category": "food",
      "rating": 4.0,
      "totalCoupons": 22,
      "activeCoupons": 6,
      "maxDiscount": 45,
      "isFavorite": false,
      "backgroundColor": "#EE3124",
      "description": "No one outpizzas the Hut",
      "tags": ["pizza", "wings", "pasta"],
    },
    {
      "id": 8,
      "name": "Best Buy",
      "logo": "https://picsum.photos/80/80?random=8&keyword=electronics",
      "category": "electronics",
      "rating": 4.2,
      "totalCoupons": 38,
      "activeCoupons": 14,
      "maxDiscount": 25,
      "isFavorite": true,
      "backgroundColor": "#003DA6",
      "description": "Tech made simple",
      "tags": ["computers", "phones", "gaming"],
    },
  ];

  List<Map<String, dynamic>> get filteredStores {
    return stores.where((store) {
      bool matchesCategory = selectedCategory == 'all' || store["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          (store["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (store["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesFavorites = !showFavorites || (store["isFavorite"] as bool);
      
      return matchesCategory && matchesSearch && matchesFavorites;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Directory"),
        actions: [
          IconButton(
            icon: Icon(
              showFavorites ? Icons.favorite : Icons.favorite_border,
              color: showFavorites ? dangerColor : null,
            ),
            onPressed: () {
              showFavorites = !showFavorites;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Stats Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search stores...",
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                onChanged: (value) {
                                  searchQuery = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.tune,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Quick Stats
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${filteredStores.length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Stores",
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
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${filteredStores.fold(0, (sum, store) => sum + (store["activeCoupons"] as int))}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Active Coupons",
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
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${filteredStores.where((s) => s["isFavorite"] as bool).length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Favorites",
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
              ],
            ),
          ),
          
          // Category Filter
          Container(
            height: 60,
            child: QHorizontalScroll(
              children: [
                'all', 'retail', 'food', 'fashion', 'electronics'
              ].map((category) => GestureDetector(
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
                    color: selectedCategory == category ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: selectedCategory == category ? primaryColor : disabledColor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getCategoryIcon(category),
                        size: 16,
                        color: selectedCategory == category ? Colors.white : primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedCategory == category ? Colors.white : primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ),
          ),
          
          // Store List
          Expanded(
            child: filteredStores.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.store,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No stores found",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Try adjusting your search or filters",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredStores.length,
                    itemBuilder: (context, index) {
                      final store = filteredStores[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          children: [
                            // Store Header
                            Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(int.parse(store["backgroundColor"].toString().replaceFirst('#', '0xFF'))),
                                    Color(int.parse(store["backgroundColor"].toString().replaceFirst('#', '0xFF'))).withAlpha(180),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusLg),
                                  topRight: Radius.circular(radiusLg),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(radiusLg),
                                      boxShadow: [shadowSm],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(radiusLg),
                                      child: Image.network(
                                        "${store["logo"]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${store["name"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${store["description"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        SizedBox(height: spSm),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 14,
                                              color: Colors.yellow,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${store["rating"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      store["isFavorite"] = !(store["isFavorite"] as bool);
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(51),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Icon(
                                        store["isFavorite"] as bool 
                                            ? Icons.favorite 
                                            : Icons.favorite_border,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Store Stats
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "${store["totalCoupons"]}",
                                              style: TextStyle(
                                                fontSize: fsH6,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "Total Coupons",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 30,
                                        color: disabledColor,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "${store["activeCoupons"]}",
                                              style: TextStyle(
                                                fontSize: fsH6,
                                                fontWeight: FontWeight.bold,
                                                color: successColor,
                                              ),
                                            ),
                                            Text(
                                              "Active Now",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 30,
                                        color: disabledColor,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "${store["maxDiscount"]}%",
                                              style: TextStyle(
                                                fontSize: fsH6,
                                                fontWeight: FontWeight.bold,
                                                color: warningColor,
                                              ),
                                            ),
                                            Text(
                                              "Max Discount",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Tags
                                  Wrap(
                                    spacing: spXs,
                                    runSpacing: spXs,
                                    children: (store["tags"] as List).map((tag) => Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "$tag",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )).toList(),
                                  ),
                                  
                                  SizedBox(height: spMd),
                                  
                                  // Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "View Coupons",
                                          size: bs.sm,
                                          onPressed: () {
                                            // navigateTo(StoreCouponsView(store: store));
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: primaryColor),
                                          borderRadius: BorderRadius.circular(radiusLg),
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.info_outline,
                                            color: primaryColor,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            // navigateTo(StoreDetailsView(store: store));
                                          },
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
                    },
                  ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'all':
        return Icons.apps;
      case 'retail':
        return Icons.shopping_bag;
      case 'food':
        return Icons.restaurant;
      case 'fashion':
        return Icons.checkroom;
      case 'electronics':
        return Icons.devices;
      default:
        return Icons.store;
    }
  }
}
