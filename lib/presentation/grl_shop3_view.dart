import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShop3View extends StatefulWidget {
  @override
  State<GrlShop3View> createState() => _GrlShop3ViewState();
}

class _GrlShop3ViewState extends State<GrlShop3View> {
  int currentTab = 0;
  String selectedCategory = "trending";
  List<String> favoriteStores = [];
  
  List<Map<String, dynamic>> trendingDeals = [
    {
      "id": "1",
      "title": "Flash Sale - Electronics",
      "subtitle": "Up to 70% Off",
      "timeLeft": "23:45:12",
      "products": 145,
      "image": "https://picsum.photos/400/200?random=1&keyword=electronics",
      "category": "electronics",
      "discount": 70,
    },
    {
      "id": "2",
      "title": "Fashion Week Special",
      "subtitle": "Designer Collection",
      "timeLeft": "48:12:35",
      "products": 89,
      "image": "https://picsum.photos/400/200?random=2&keyword=fashion",
      "category": "fashion",
      "discount": 50,
    },
    {
      "id": "3",
      "title": "Home & Garden Sale",
      "subtitle": "Spring Collection",
      "timeLeft": "72:08:22",
      "products": 234,
      "image": "https://picsum.photos/400/200?random=3&keyword=home",
      "category": "home",
      "discount": 45,
    },
  ];

  List<Map<String, dynamic>> featuredStores = [
    {
      "id": "1",
      "name": "TechMart Pro",
      "rating": 4.8,
      "reviews": 12500,
      "logo": "https://picsum.photos/80/80?random=11&keyword=tech",
      "category": "Electronics",
      "products": 2340,
      "followers": 45000,
      "verified": true,
      "freeShipping": true,
      "description": "Premium electronics and gadgets",
    },
    {
      "id": "2",
      "name": "StyleHub Fashion",
      "rating": 4.7,
      "reviews": 8900,
      "logo": "https://picsum.photos/80/80?random=12&keyword=fashion",
      "category": "Fashion",
      "products": 1890,
      "followers": 32000,
      "verified": true,
      "freeShipping": false,
      "description": "Trendy fashion for all occasions",
    },
    {
      "id": "3",
      "name": "HomeDecor Plus",
      "rating": 4.6,
      "reviews": 6700,
      "logo": "https://picsum.photos/80/80?random=13&keyword=home",
      "category": "Home & Garden",
      "products": 1234,
      "followers": 28000,
      "verified": true,
      "freeShipping": true,
      "description": "Beautiful home decor and furniture",
    },
    {
      "id": "4",
      "name": "SportZone Elite",
      "rating": 4.9,
      "reviews": 15600,
      "logo": "https://picsum.photos/80/80?random=14&keyword=sports",
      "category": "Sports",
      "products": 987,
      "followers": 52000,
      "verified": true,
      "freeShipping": true,
      "description": "Professional sports equipment",
    },
  ];

  List<Map<String, dynamic>> categories = [
    {
      "name": "Electronics",
      "icon": Icons.devices,
      "color": primaryColor,
      "deals": 234,
      "stores": 45,
    },
    {
      "name": "Fashion",
      "icon": Icons.checkroom,
      "color": successColor,
      "deals": 189,
      "stores": 67,
    },
    {
      "name": "Home",
      "icon": Icons.home,
      "color": warningColor,
      "deals": 156,
      "stores": 34,
    },
    {
      "name": "Sports",
      "icon": Icons.sports,
      "color": infoColor,
      "deals": 123,
      "stores": 29,
    },
    {
      "name": "Books",
      "icon": Icons.menu_book,
      "color": dangerColor,
      "deals": 98,
      "stores": 18,
    },
    {
      "name": "Beauty",
      "icon": Icons.spa,
      "color": secondaryColor,
      "deals": 167,
      "stores": 41,
    },
  ];

  List<Map<String, dynamic>> recentlyViewed = [
    {
      "id": "1",
      "name": "Wireless Earbuds Pro",
      "price": 149.99,
      "image": "https://picsum.photos/120/120?random=21&keyword=earbuds",
      "store": "TechMart Pro",
      "rating": 4.5,
    },
    {
      "id": "2",
      "name": "Smart Watch Series 5",
      "price": 299.99,
      "image": "https://picsum.photos/120/120?random=22&keyword=smartwatch",
      "store": "TechMart Pro",
      "rating": 4.7,
    },
    {
      "id": "3", 
      "name": "Designer Backpack",
      "price": 89.99,
      "image": "https://picsum.photos/120/120?random=23&keyword=backpack",
      "store": "StyleHub Fashion",
      "rating": 4.4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Shopping Hub",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Discover", icon: Icon(Icons.explore)),
        Tab(text: "Stores", icon: Icon(Icons.store)),
        Tab(text: "Deals", icon: Icon(Icons.local_offer)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
      ],
      tabChildren: [
        _buildDiscoverTab(),
        _buildStoresTab(),
        _buildDealsTab(),
        _buildCategoriesTab(),
      ],
    );
  }

  Widget _buildDiscoverTab() {
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
                  "Welcome to Shopping Hub",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Discover amazing deals and trending products",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Explore Deals",
                        size: bs.sm,
                        onPressed: () {
                          setState(() => currentTab = 2);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: Colors.white.withAlpha(100)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search, color: Colors.white, size: 18),
                            SizedBox(width: spXs),
                            Text(
                              "Search",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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

          SizedBox(height: spMd),

          // Quick Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "1.2M+",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Products",
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
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "15K+",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "500+",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Daily Deals",
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

          SizedBox(height: spMd),

          // Recently Viewed
          if (recentlyViewed.isNotEmpty) ...[
            Text(
              "Recently Viewed",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: recentlyViewed.map((product) => Container(
                width: 140,
                margin: EdgeInsets.only(right: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
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
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${product["name"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "\$${((product["price"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, size: 12, color: warningColor),
                              SizedBox(width: 2),
                              Text(
                                "${product["rating"]}",
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
            SizedBox(height: spMd),
          ],

          // Trending Categories
          Text(
            "Trending Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: categories.take(4).map((category) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: (category["color"] as Color).withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      category["icon"],
                      size: 32,
                      color: category["color"],
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${category["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${category["deals"]} deals",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStoresTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Featured Stores",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: featuredStores.map((store) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  // Store Logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      "${store["logo"]}",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spMd),
                  
                  // Store Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${store["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: spXs),
                            if (store["verified"] as bool)
                              Icon(
                                Icons.verified,
                                size: 16,
                                color: primaryColor,
                              ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          "${store["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: warningColor),
                            SizedBox(width: 2),
                            Text(
                              "${store["rating"]} (${store["reviews"]})",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.inventory, size: 14, color: disabledBoldColor),
                            SizedBox(width: 2),
                            Text(
                              "${store["products"]}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${store["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            if (store["freeShipping"] as bool)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Free Shipping",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Follow Button
                  Column(
                    children: [
                      QButton(
                        icon: favoriteStores.contains(store["id"]) 
                          ? Icons.favorite 
                          : Icons.favorite_border,
                        size: bs.sm,
                        onPressed: () {
                          String storeId = store["id"];
                          if (favoriteStores.contains(storeId)) {
                            favoriteStores.remove(storeId);
                            ss("Unfollowed store");
                          } else {
                            favoriteStores.add(storeId);
                            ss("Following store");
                          }
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${((store["followers"] as int) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDealsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hot Deals",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: trendingDeals.map((deal) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Deal Image
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                        child: Image.network(
                          "${deal["image"]}",
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: spSm,
                        left: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: dangerColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "UP TO ${deal["discount"]}% OFF",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Deal Info
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${deal["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${deal["subtitle"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 16, color: dangerColor),
                            SizedBox(width: spXs),
                            Text(
                              "Ends in ${deal["timeLeft"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${deal["products"]} products",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spMd),
                        
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Shop Now",
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo(DealDetailsView(deal: deal));
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
          Text(
            "Shop by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: categories.map((category) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    (category["color"] as Color).withAlpha(40),
                    (category["color"] as Color).withAlpha(20),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    category["icon"],
                    size: 40,
                    color: category["color"],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${category["name"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${category["deals"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: category["color"],
                            ),
                          ),
                          Text(
                            "Deals",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${category["stores"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: category["color"],
                            ),
                          ),
                          Text(
                            "Stores",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Browse",
                      size: bs.sm,
                      onPressed: () {
                        // navigateTo(CategoryView(category: category));
                      },
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
