import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReview3View extends StatefulWidget {
  @override
  State<GrlReview3View> createState() => _GrlReview3ViewState();
}

class _GrlReview3ViewState extends State<GrlReview3View> {
  int currentTab = 0;
  
  List<Map<String, dynamic>> businessReviews = [
    {
      "id": 1,
      "business": "Sunset Café",
      "category": "Restaurant",
      "rating": 4.5,
      "totalReviews": 247,
      "image": "https://picsum.photos/120/120?random=1&keyword=restaurant",
      "address": "123 Main Street, Downtown",
      "phone": "+1 (555) 123-4567",
      "hours": "8:00 AM - 10:00 PM",
      "priceRange": "\$\$",
      "features": ["Outdoor Seating", "WiFi", "Parking"],
      "recentReviews": [
        {
          "user": "Alice Smith",
          "rating": 5,
          "comment": "Amazing coffee and pastries! The atmosphere is perfect for work.",
          "date": DateTime.now().subtract(Duration(days: 1)),
        },
        {
          "user": "Bob Johnson",
          "rating": 4,
          "comment": "Good food but service can be slow during peak hours.",
          "date": DateTime.now().subtract(Duration(days: 3)),
        },
      ],
    },
    {
      "id": 2,
      "business": "Tech Solutions Inc",
      "category": "IT Services",
      "rating": 4.8,
      "totalReviews": 156,
      "image": "https://picsum.photos/120/120?random=2&keyword=office",
      "address": "456 Business Ave, Tech District",
      "phone": "+1 (555) 987-6543",
      "hours": "9:00 AM - 6:00 PM",
      "priceRange": "\$\$\$",
      "features": ["24/7 Support", "Cloud Services", "Free Consultation"],
      "recentReviews": [
        {
          "user": "Sarah Wilson",
          "rating": 5,
          "comment": "Excellent technical support and very professional team.",
          "date": DateTime.now().subtract(Duration(hours: 6)),
        },
        {
          "user": "Mike Davis",
          "rating": 5,
          "comment": "They solved our IT problems quickly and efficiently.",
          "date": DateTime.now().subtract(Duration(days: 2)),
        },
      ],
    },
    {
      "id": 3,
      "business": "Fitness First Gym",
      "category": "Fitness",
      "rating": 4.2,
      "totalReviews": 892,
      "image": "https://picsum.photos/120/120?random=3&keyword=gym",
      "address": "789 Health Blvd, Fitness Plaza",
      "phone": "+1 (555) 456-7890",
      "hours": "5:00 AM - 11:00 PM",
      "priceRange": "\$\$",
      "features": ["Personal Training", "Group Classes", "Pool"],
      "recentReviews": [
        {
          "user": "Emma Brown",
          "rating": 4,
          "comment": "Great equipment and clean facilities. Membership is worth it.",
          "date": DateTime.now().subtract(Duration(days: 1)),
        },
        {
          "user": "John Martinez",
          "rating": 4,
          "comment": "Good variety of classes but can get crowded in evenings.",
          "date": DateTime.now().subtract(Duration(days: 4)),
        },
      ],
    },
  ];
  
  List<Map<String, dynamic>> productReviews = [
    {
      "id": 1,
      "product": "Wireless Bluetooth Headphones",
      "brand": "AudioTech",
      "rating": 4.3,
      "totalReviews": 1247,
      "price": 99.99,
      "image": "https://picsum.photos/120/120?random=4&keyword=headphones",
      "features": ["Noise Cancellation", "30hr Battery", "Quick Charge"],
      "pros": ["Excellent sound quality", "Comfortable fit", "Long battery life"],
      "cons": ["Expensive", "Bulky design", "No wireless charging"],
      "recentReviews": [
        {
          "user": "Lisa Chen",
          "rating": 5,
          "comment": "Best headphones I've ever owned. Sound quality is incredible!",
          "date": DateTime.now().subtract(Duration(hours: 12)),
        },
        {
          "user": "Tom Anderson",
          "rating": 4,
          "comment": "Good headphones but a bit pricey for the features offered.",
          "date": DateTime.now().subtract(Duration(days: 2)),
        },
      ],
    },
    {
      "id": 2,
      "product": "Smart Home Security Camera",
      "brand": "SecureHome",
      "rating": 4.6,
      "totalReviews": 678,
      "price": 149.99,
      "image": "https://picsum.photos/120/120?random=5&keyword=camera",
      "features": ["1080p HD", "Night Vision", "Motion Detection"],
      "pros": ["Easy setup", "Clear video quality", "Reliable app"],
      "cons": ["Requires subscription", "Limited storage", "WiFi dependent"],
      "recentReviews": [
        {
          "user": "Jessica Taylor",
          "rating": 5,
          "comment": "Perfect for home security. Easy to install and great quality.",
          "date": DateTime.now().subtract(Duration(days: 1)),
        },
        {
          "user": "Robert Lee",
          "rating": 4,
          "comment": "Good camera but monthly fees for cloud storage add up.",
          "date": DateTime.now().subtract(Duration(days: 3)),
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Reviews & Ratings",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Businesses", icon: Icon(Icons.business)),
        Tab(text: "Products", icon: Icon(Icons.shopping_bag)),
        Tab(text: "My Reviews", icon: Icon(Icons.rate_review)),
      ],
      tabChildren: [
        _buildBusinessesTab(),
        _buildProductsTab(),
        _buildMyReviewsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }

  Widget _buildBusinessesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search businesses...",
                  value: "",
                  hint: "Restaurant, service, location",
                  onChanged: (value) {},
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
          
          SizedBox(height: spMd),
          
          // Categories
          QHorizontalScroll(
            children: [
              'All', 'Restaurants', 'Services', 'Retail', 'Healthcare', 'Entertainment'
            ].map((category) => Container(
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.symmetric(
                horizontal: spMd,
                vertical: spSm,
              ),
              decoration: BoxDecoration(
                color: category == 'All' ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: category == 'All' ? Colors.white : primaryColor,
                ),
              ),
            )).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // Business List
          ...businessReviews.map((business) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Business Header
                Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Image.network(
                          "${business["image"]}",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${business["business"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${business["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (index) => Icon(
                                    index < (business["rating"] as double).floor() ? Icons.star : Icons.star_border,
                                    size: 16,
                                    color: warningColor,
                                  )),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${business["rating"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "(${business["totalReviews"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
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
                
                // Business Info
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(radiusLg),
                      bottomRight: Radius.circular(radiusLg),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: primaryColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${business["address"]}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 16, color: primaryColor),
                          SizedBox(width: spXs),
                          Text(
                            "${business["phone"]}",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(width: spMd),
                          Icon(Icons.schedule, size: 16, color: primaryColor),
                          SizedBox(width: spXs),
                          Text(
                            "${business["hours"]}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spXs,
                        children: (business["features"] as List).map((feature) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$feature",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )).toList(),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Reviews",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Write Review",
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
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildProductsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search products...",
                  value: "",
                  hint: "Brand, model, category",
                  onChanged: (value) {},
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
          
          SizedBox(height: spMd),
          
          // Product List
          ...productReviews.map((product) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Header
                Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Image.network(
                          "${product["image"]}",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product["product"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${product["brand"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (index) => Icon(
                                    index < (product["rating"] as double).floor() ? Icons.star : Icons.star_border,
                                    size: 16,
                                    color: warningColor,
                                  )),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${product["rating"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "(${product["totalReviews"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "\$${((product["price"] as double).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Product Features
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Key Features",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (product["features"] as List).map((feature) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$feature",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
                
                // Pros & Cons
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(radiusLg),
                      bottomRight: Radius.circular(radiusLg),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.thumb_up, size: 16, color: successColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Pros",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spSm),
                                ...(product["pros"] as List).map((pro) => Padding(
                                  padding: EdgeInsets.only(bottom: spXs),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add, size: 12, color: successColor),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "$pro",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                )).toList(),
                              ],
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.thumb_down, size: 16, color: dangerColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Cons",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: dangerColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spSm),
                                ...(product["cons"] as List).map((con) => Padding(
                                  padding: EdgeInsets.only(bottom: spXs),
                                  child: Row(
                                    children: [
                                      Icon(Icons.remove, size: 12, color: dangerColor),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "$con",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                )).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Read Reviews",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Write Review",
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
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildMyReviewsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats
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
                        "12",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Reviews",
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
                        "4.3",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Avg Rating",
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
                        "89",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Helpful Votes",
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
          
          // Recent Activity
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Container(
            width: double.infinity,
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
                  "Write more reviews to help others!",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Share your experiences with products and services you've used. Your reviews help other customers make informed decisions.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                QButton(
                  label: "Write Review",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
