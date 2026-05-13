import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWishlist10View extends StatefulWidget {
  @override
  State<GrlWishlist10View> createState() => _GrlWishlist10ViewState();
}

class _GrlWishlist10ViewState extends State<GrlWishlist10View> {
  bool loading = false;
  String searchQuery = "";
  String selectedFilter = "all";
  String selectedTimeRange = "week";
  int currentTab = 0;
  
  List<Map<String, dynamic>> filterItems = [
    {"label": "All Activities", "value": "all"},
    {"label": "Purchases", "value": "purchases"},
    {"label": "Wishlist Adds", "value": "wishlist_adds"},
    {"label": "Price Drops", "value": "price_drops"},
    {"label": "Reviews", "value": "reviews"},
    {"label": "Shares", "value": "shares"},
  ];

  List<Map<String, dynamic>> timeRangeItems = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "3months"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> activities = [
    {
      "id": 1,
      "type": "purchase",
      "user": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
        "isFollowing": true
      },
      "product": {
        "name": "iPhone 15 Pro Max",
        "brand": "Apple",
        "price": 1199.99,
        "image": "https://picsum.photos/200/200?random=1&keyword=iphone",
        "rating": 4.8
      },
      "timestamp": "2 hours ago",
      "action": "purchased",
      "details": "Finally got the iPhone I've been wanting! The camera quality is amazing.",
      "likes": 24,
      "comments": 8,
      "isLiked": false,
      "isInMyWishlist": true
    },
    {
      "id": 2,
      "type": "wishlist_add",
      "user": {
        "name": "Mike Chen",
        "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
        "isFollowing": true
      },
      "product": {
        "name": "Sony WH-1000XM5 Headphones",
        "brand": "Sony",
        "price": 349.99,
        "image": "https://picsum.photos/200/200?random=2&keyword=headphones",
        "rating": 4.7
      },
      "timestamp": "4 hours ago",
      "action": "added to wishlist",
      "details": "Perfect for my daily commute and work from home setup.",
      "likes": 12,
      "comments": 3,
      "isLiked": true,
      "isInMyWishlist": false
    },
    {
      "id": 3,
      "type": "price_drop",
      "user": {
        "name": "Emma Wilson",
        "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
        "isFollowing": false
      },
      "product": {
        "name": "MacBook Pro 16-inch M3",
        "brand": "Apple",
        "price": 2299.99,
        "originalPrice": 2499.99,
        "image": "https://picsum.photos/200/200?random=3&keyword=macbook",
        "rating": 4.9
      },
      "timestamp": "6 hours ago",
      "action": "shared a price drop",
      "details": "Great deal! Just saved \$200 on this beast. Perfect timing for my design work.",
      "likes": 45,
      "comments": 15,
      "isLiked": false,
      "isInMyWishlist": true,
      "discount": 8
    },
    {
      "id": 4,
      "type": "review",
      "user": {
        "name": "David Park",
        "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
        "isFollowing": true
      },
      "product": {
        "name": "Nike Air Jordan 1 Retro",
        "brand": "Nike",
        "price": 170.00,
        "image": "https://picsum.photos/200/200?random=4&keyword=sneakers",
        "rating": 4.6
      },
      "timestamp": "8 hours ago",
      "action": "reviewed",
      "details": "Quality is top-notch! True to size and super comfortable. Worth every penny.",
      "likes": 18,
      "comments": 7,
      "isLiked": true,
      "isInMyWishlist": false,
      "userRating": 5
    },
    {
      "id": 5,
      "type": "wishlist_add",
      "user": {
        "name": "Lisa Rodriguez",
        "avatar": "https://picsum.photos/100/100?random=5&keyword=woman",
        "isFollowing": false
      },
      "product": {
        "name": "Dyson V15 Detect Absolute",
        "brand": "Dyson",
        "price": 649.99,
        "image": "https://picsum.photos/200/200?random=5&keyword=vacuum",
        "rating": 4.5
      },
      "timestamp": "12 hours ago",
      "action": "added to wishlist",
      "details": "Need this for my new apartment. The laser detection feature looks incredible!",
      "likes": 9,
      "comments": 2,
      "isLiked": false,
      "isInMyWishlist": true
    },
    {
      "id": 6,
      "type": "purchase",
      "user": {
        "name": "Alex Thompson",
        "avatar": "https://picsum.photos/100/100?random=6&keyword=person",
        "isFollowing": true
      },
      "product": {
        "name": "iPad Air 5th Gen",
        "brand": "Apple",
        "price": 599.99,
        "image": "https://picsum.photos/200/200?random=6&keyword=ipad",
        "rating": 4.8
      },
      "timestamp": "1 day ago",
      "action": "purchased",
      "details": "Perfect for digital art and note-taking. The M1 chip makes everything so smooth!",
      "likes": 31,
      "comments": 12,
      "isLiked": true,
      "isInMyWishlist": false
    }
  ];

  List<Map<String, dynamic>> trendingProducts = [
    {
      "id": 1,
      "name": "AirPods Pro (2nd Gen)",
      "brand": "Apple",
      "price": 249.99,
      "image": "https://picsum.photos/150/150?random=10&keyword=airpods",
      "trending": "📈 +156% this week",
      "wishlistCount": 2547
    },
    {
      "id": 2,
      "name": "Steam Deck OLED",
      "brand": "Valve",
      "price": 549.99,
      "image": "https://picsum.photos/150/150?random=11&keyword=gaming",
      "trending": "🔥 Hot Item",
      "wishlistCount": 1834
    },
    {
      "id": 3,
      "name": "Nothing Phone (2)",
      "brand": "Nothing",
      "price": 699.99,
      "image": "https://picsum.photos/150/150?random=12&keyword=phone",
      "trending": "⭐ Rising Star",
      "wishlistCount": 1256
    }
  ];

  List<Map<String, dynamic>> followingSuggestions = [
    {
      "id": 1,
      "name": "TechReviewer_23",
      "avatar": "https://picsum.photos/100/100?random=20&keyword=tech",
      "followers": 15420,
      "category": "Electronics",
      "recentActivity": "Reviewed 5 gadgets this week",
      "isFollowing": false
    },
    {
      "id": 2,
      "name": "FashionFinds_Sarah",
      "avatar": "https://picsum.photos/100/100?random=21&keyword=fashion",
      "followers": 8934,
      "category": "Fashion",
      "recentActivity": "Found 12 great deals",
      "isFollowing": false
    },
    {
      "id": 3,
      "name": "HomeDesign_Mike",
      "avatar": "https://picsum.photos/100/100?random=22&keyword=home",
      "followers": 12567,
      "category": "Home & Garden",
      "recentActivity": "Shared 8 home essentials",
      "isFollowing": false
    }
  ];

  List<Map<String, dynamic>> myFollowing = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "lastActive": "2 hours ago",
      "recentPurchases": 3,
      "sharedItems": 7
    },
    {
      "id": 2,
      "name": "Mike Chen",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "lastActive": "5 hours ago",
      "recentPurchases": 1,
      "sharedItems": 4
    },
    {
      "id": 3,
      "name": "David Park",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
      "lastActive": "1 day ago",
      "recentPurchases": 2,
      "sharedItems": 9
    }
  ];

  List<Map<String, dynamic>> communityStats = [
    {"label": "Following", "value": 47, "icon": Icons.people},
    {"label": "Followers", "value": 23, "icon": Icons.person_add},
    {"label": "Shared Items", "value": 156, "icon": Icons.share},
    {"label": "Total Likes", "value": 892, "icon": Icons.favorite},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Community Wishlist",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Feed", icon: Icon(Icons.dynamic_feed)),
        Tab(text: "Trending", icon: Icon(Icons.trending_up)),
        Tab(text: "Following", icon: Icon(Icons.people)),
        Tab(text: "Discover", icon: Icon(Icons.explore)),
      ],
      tabChildren: [
        _buildFeedTab(),
        _buildTrendingTab(),
        _buildFollowingTab(),
        _buildDiscoverTab(),
      ],
    );
  }

  Widget _buildFeedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFilterSection(),
          _buildCommunityStats(),
          _buildActivityFeed(),
        ],
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTrendingSection(),
          _buildPopularCategories(),
          _buildTopInfluencers(),
        ],
      ),
    );
  }

  Widget _buildFollowingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFollowingStats(),
          _buildMyFollowing(),
          _buildFollowingActivity(),
        ],
      ),
    );
  }

  Widget _buildDiscoverTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDiscoverHeader(),
          _buildSuggestedUsers(),
          _buildFeaturedCommunities(),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search activities...",
            value: searchQuery,
            hint: "Search by user, product, or activity",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Activity Type",
                  items: filterItems,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Range",
                  items: timeRangeItems,
                  value: selectedTimeRange,
                  onChanged: (value, label) {
                    selectedTimeRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityStats() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Your Community Stats",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: communityStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(
                      stat["icon"] as IconData,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${stat["value"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stat["label"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityFeed() {
    return Column(
      children: activities.map((activity) {
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage("${activity["user"]["avatar"]}"),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${activity["user"]["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            if (activity["user"]["isFollowing"])
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Following",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Text(
                          "${activity["action"]} • ${activity["timestamp"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!activity["user"]["isFollowing"])
                    QButton(
                      label: "Follow",
                      size: bs.sm,
                      onPressed: () {
                        setState(() {
                          activity["user"]["isFollowing"] = true;
                        });
                        ss("Now following ${activity["user"]["name"]}!");
                      },
                    ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${activity["product"]["image"]}",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${activity["product"]["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${activity["product"]["brand"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            if (activity["type"] == "price_drop" && activity["originalPrice"] != null)
                              Text(
                                "\$${(activity["product"]["originalPrice"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            if (activity["type"] == "price_drop" && activity["originalPrice"] != null)
                              SizedBox(width: spXs),
                            Text(
                              "\$${(activity["product"]["price"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: activity["type"] == "price_drop" ? successColor : primaryColor,
                              ),
                            ),
                            if (activity["discount"] != null)
                              Padding(
                                padding: EdgeInsets.only(left: spXs),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "-${activity["discount"]}%",
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
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: warningColor),
                            SizedBox(width: 2),
                            Text(
                              "${activity["product"]["rating"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (activity["userRating"] != null)
                              Padding(
                                padding: EdgeInsets.only(left: spSm),
                                child: Row(
                                  children: [
                                    Text(
                                      "Rated:",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    ...List.generate(5, (index) {
                                      return Icon(
                                        index < (activity["userRating"] as int) ? Icons.star : Icons.star_border,
                                        size: 12,
                                        color: warningColor,
                                      );
                                    }),
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
              if (activity["details"].toString().isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  child: Text(
                    "${activity["details"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: primaryColor,
                    ),
                  ),
                ),
              Row(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            activity["isLiked"] = !activity["isLiked"];
                            activity["likes"] += activity["isLiked"] ? 1 : -1;
                          });
                        },
                        child: Icon(
                          activity["isLiked"] ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: activity["isLiked"] ? dangerColor : disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${activity["likes"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: spMd),
                  Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 18,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${activity["comments"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: spMd),
                  GestureDetector(
                    onTap: () {
                      ss("Activity shared!");
                    },
                    child: Icon(
                      Icons.share,
                      size: 18,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  if (activity["isInMyWishlist"])
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "In Wishlist",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    )
                  else
                    QButton(
                      label: "Add to Wishlist",
                      size: bs.sm,
                      onPressed: () {
                        setState(() {
                          activity["isInMyWishlist"] = true;
                        });
                        ss("Added to your wishlist!");
                      },
                    ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTrendingSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Trending Products",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...trendingProducts.map((product) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusXs),
                    child: Image.network(
                      "${product["image"]}",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "\$${(product["price"] as double).currency}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${product["trending"]}",
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${product["wishlistCount"]} people want this",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.favorite_border,
                    size: bs.sm,
                    onPressed: () {
                      ss("Added to wishlist!");
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPopularCategories() {
    final categories = [
      {"name": "Electronics", "growth": "+23%", "color": primaryColor},
      {"name": "Fashion", "growth": "+18%", "color": successColor},
      {"name": "Home & Garden", "growth": "+15%", "color": infoColor},
      {"name": "Sports", "growth": "+12%", "color": warningColor},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.category, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Popular Categories",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: categories.map((category) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (category["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: category["color"] as Color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: category["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${category["growth"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopInfluencers() {
    final influencers = [
      {"name": "TechGuru_Alex", "followers": "45.2K", "specialty": "Electronics"},
      {"name": "StyleQueen_Emma", "followers": "32.8K", "specialty": "Fashion"},
      {"name": "HomeChef_Mike", "followers": "28.1K", "specialty": "Kitchen"},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.stars, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Top Influencers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...influencers.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> influencer = entry.value;
            return Container(
              margin: EdgeInsets.only(bottom: index < influencers.length - 1 ? spSm : 0),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: index == 0 ? warningColor : 
                            index == 1 ? disabledBoldColor : 
                            secondaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${influencer["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${influencer["followers"]} followers • ${influencer["specialty"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Follow",
                    size: bs.sm,
                    onPressed: () {
                      ss("Now following ${influencer["name"]}!");
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFollowingStats() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.groups, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Following Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "47",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Following",
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
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "23",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Followers",
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
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "12",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Active Today",
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
    );
  }

  Widget _buildMyFollowing() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.people, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "People You Follow",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Manage",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...myFollowing.map((user) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage("${user["avatar"]}"),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Last active: ${user["lastActive"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.shopping_bag, size: 14, color: successColor),
                            SizedBox(width: 2),
                            Text(
                              "${user["recentPurchases"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.share, size: 14, color: infoColor),
                            SizedBox(width: 2),
                            Text(
                              "${user["sharedItems"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.message,
                    size: bs.sm,
                    onPressed: () {
                      ss("Opening chat with ${user["name"]}");
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFollowingActivity() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notifications_active, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...[
            "Sarah Johnson purchased iPhone 15 Pro Max",
            "Mike Chen added Sony headphones to wishlist",
            "David Park shared a great deal on sneakers",
            "3 people you follow are interested in MacBook Pro"
          ].map((activity) {
            return Container(
              margin: EdgeInsets.only(bottom: spXs),
              padding: EdgeInsets.symmetric(vertical: spXs),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      activity,
                      style: TextStyle(
                        fontSize: 13,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDiscoverHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.explore, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Discover New People",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Connect with people who share similar interests and discover amazing products together.",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedUsers() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_add, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Suggested for You",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...followingSuggestions.map((user) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage("${user["avatar"]}"),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${user["followers"]} followers • ${user["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${user["recentActivity"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: user["isFollowing"] ? "Following" : "Follow",
                    size: bs.sm,
                    onPressed: () {
                      setState(() {
                        user["isFollowing"] = !user["isFollowing"];
                      });
                      if (user["isFollowing"]) {
                        ss("Now following ${user["name"]}!");
                      } else {
                        ss("Unfollowed ${user["name"]}");
                      }
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFeaturedCommunities() {
    final communities = [
      {"name": "Tech Enthusiasts", "members": "12.5K", "description": "Latest gadgets and tech reviews"},
      {"name": "Fashion Forward", "members": "8.2K", "description": "Trending styles and fashion deals"},
      {"name": "Home & Garden", "members": "6.8K", "description": "Home improvement and decoration ideas"},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.groups, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Featured Communities",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...communities.map((community) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.group,
                      color: infoColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${community["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${community["members"]} members",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${community["description"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Join",
                    size: bs.sm,
                    onPressed: () {
                      ss("Joined ${community["name"]} community!");
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
