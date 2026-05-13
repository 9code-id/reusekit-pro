import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaWishlistView extends StatefulWidget {
  const SpaWishlistView({super.key});

  @override
  State<SpaWishlistView> createState() => _SpaWishlistViewState();
}

class _SpaWishlistViewState extends State<SpaWishlistView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "newest";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Facial", "value": "Facial"},
    {"label": "Massage", "value": "Massage"},
    {"label": "Body", "value": "Body"},
    {"label": "Hair", "value": "Hair"},
    {"label": "Skincare", "value": "Skincare"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recently Added", "value": "newest"},
    {"label": "Price: Low to High", "value": "price_asc"},
    {"label": "Price: High to Low", "value": "price_desc"},
    {"label": "Name A-Z", "value": "name_asc"},
    {"label": "Rating", "value": "rating"},
  ];

  List<Map<String, dynamic>> wishlistItems = [
    {
      "id": 1,
      "name": "Luxury Facial Treatment",
      "category": "Facial",
      "price": 120.0,
      "originalPrice": 150.0,
      "image": "https://picsum.photos/300/200?random=1&keyword=spa",
      "rating": 4.8,
      "reviews": 234,
      "duration": "90 min",
      "description": "Deep cleansing and rejuvenating facial treatment",
      "dateAdded": "2024-03-20",
      "discount": 20,
      "availability": "Available",
    },
    {
      "id": 2,
      "name": "Hot Stone Massage",
      "category": "Massage",
      "price": 180.0,
      "originalPrice": 200.0,
      "image": "https://picsum.photos/300/200?random=2&keyword=massage",
      "rating": 4.9,
      "reviews": 189,
      "duration": "75 min",
      "description": "Relaxing hot stone massage therapy",
      "dateAdded": "2024-03-18",
      "discount": 10,
      "availability": "Available",
    },
    {
      "id": 3,
      "name": "Aromatherapy Body Wrap",
      "category": "Body",
      "price": 95.0,
      "originalPrice": 110.0,
      "image": "https://picsum.photos/300/200?random=3&keyword=aromatherapy",
      "rating": 4.6,
      "reviews": 156,
      "duration": "60 min",
      "description": "Detoxifying body wrap with essential oils",
      "dateAdded": "2024-03-15",
      "discount": 15,
      "availability": "Limited",
    },
    {
      "id": 4,
      "name": "Anti-Aging Skincare",
      "category": "Skincare",
      "price": 160.0,
      "originalPrice": 190.0,
      "image": "https://picsum.photos/300/200?random=4&keyword=skincare",
      "rating": 4.8,
      "reviews": 167,
      "duration": "120 min",
      "description": "Advanced anti-aging skincare treatment",
      "dateAdded": "2024-03-12",
      "discount": 16,
      "availability": "Available",
    },
    {
      "id": 5,
      "name": "Hair Spa Treatment",
      "category": "Hair",
      "price": 85.0,
      "originalPrice": 100.0,
      "image": "https://picsum.photos/300/200?random=5&keyword=hair",
      "rating": 4.7,
      "reviews": 201,
      "duration": "45 min",
      "description": "Nourishing hair treatment and styling",
      "dateAdded": "2024-03-10",
      "discount": 15,
      "availability": "Fully Booked",
    },
    {
      "id": 6,
      "name": "Deep Tissue Massage",
      "category": "Massage",
      "price": 140.0,
      "originalPrice": 160.0,
      "image": "https://picsum.photos/300/200?random=6&keyword=massage",
      "rating": 4.5,
      "reviews": 143,
      "duration": "60 min",
      "description": "Therapeutic deep tissue massage",
      "dateAdded": "2024-03-08",
      "discount": 12,
      "availability": "Available",
    },
  ];

  List<Map<String, dynamic>> get filteredWishlist {
    List<Map<String, dynamic>> filtered = wishlistItems;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((item) => item["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) => 
        item["name"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    filtered.sort((a, b) {
      switch (sortBy) {
        case "newest":
          return b["dateAdded"].toString().compareTo(a["dateAdded"].toString());
        case "price_asc":
          return (a["price"] as double).compareTo(b["price"] as double);
        case "price_desc":
          return (b["price"] as double).compareTo(a["price"] as double);
        case "name_asc":
          return a["name"].toString().compareTo(b["name"].toString());
        case "rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        default:
          return 0;
      }
    });
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Wishlist"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showOptionsMenu();
            },
          ),
        ],
      ),
      body: wishlistItems.isEmpty ? _buildEmptyWishlist() : _buildWishlistContent(),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 120,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "Your wishlist is empty",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Save your favorite spa services to book them later",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spLg),
            QButton(
              label: "Browse Services",
              size: bs.md,
              onPressed: () {
                // Navigate to service list
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wishlist Stats
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "${wishlistItems.length}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Services",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                Column(
                  children: [
                    Text(
                      "\$${_calculateTotalValue().currency}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Value",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                Column(
                  children: [
                    Text(
                      "\$${_calculateSavings().currency}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "You Save",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Search Bar
          QTextField(
            label: "Search wishlist...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          // Filter Categories
          QCategoryPicker(
            items: categories,
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          // Sort and Actions
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Sort by",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add All to Cart",
                size: bs.sm,
                onPressed: () {
                  _addAllToCart();
                },
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Results Count
          Text(
            "${filteredWishlist.length} services found",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Wishlist Items
          ResponsiveGridView(
            minItemWidth: 200,
            children: filteredWishlist.map((item) {
              return _buildWishlistItem(item);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistItem(Map<String, dynamic> item) {
    String availability = item["availability"];
    Color availabilityColor;
    
    switch (availability) {
      case "Available":
        availabilityColor = successColor;
        break;
      case "Limited":
        availabilityColor = warningColor;
        break;
      case "Fully Booked":
        availabilityColor = dangerColor;
        break;
      default:
        availabilityColor = disabledBoldColor;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Image
          Stack(
            children: [
              Container(
                height: 160,
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
                    "${item["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // Discount Badge
              if ((item["discount"] as int) > 0)
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
                      "${item["discount"]}% OFF",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              
              // Remove from Wishlist
              Positioned(
                top: spSm,
                right: spSm,
                child: GestureDetector(
                  onTap: () {
                    _removeFromWishlist(item);
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(200),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: dangerColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
              
              // Availability Badge
              Positioned(
                bottom: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: availabilityColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    availability,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Service Info
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spXs),
                
                Text(
                  "${item["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${item["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.star,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${item["rating"]} (${item["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    if ((item["originalPrice"] as double) > (item["price"] as double))
                      Text(
                        "\$${(item["originalPrice"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    if ((item["originalPrice"] as double) > (item["price"] as double))
                      SizedBox(width: spXs),
                    Text(
                      "\$${(item["price"] as double).currency}",
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
                  "Added ${item["dateAdded"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Add to Cart",
                        size: bs.sm,
                        onPressed: availability == "Fully Booked" ? null : () {
                          _addToCart(item);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        _viewDetails(item);
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.visibility,
                          color: primaryColor,
                          size: 16,
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

  double _calculateTotalValue() {
    return wishlistItems.fold(0.0, (sum, item) => sum + (item["price"] as double));
  }

  double _calculateSavings() {
    return wishlistItems.fold(0.0, (sum, item) {
      final originalPrice = item["originalPrice"] as double;
      final currentPrice = item["price"] as double;
      return sum + (originalPrice - currentPrice);
    });
  }

  void _removeFromWishlist(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Remove ${item["name"]} from your wishlist?");
    if (isConfirmed) {
      setState(() {
        wishlistItems.removeWhere((wishlistItem) => wishlistItem["id"] == item["id"]);
      });
      ss("Removed from wishlist");
    }
  }

  void _addToCart(Map<String, dynamic> item) {
    ss("${item["name"]} added to cart");
  }

  void _addAllToCart() async {
    final availableItems = filteredWishlist.where((item) => 
        item["availability"] != "Fully Booked").length;
    
    if (availableItems == 0) {
      se("No available services to add to cart");
      return;
    }

    bool isConfirmed = await confirm("Add $availableItems available services to cart?");
    if (isConfirmed) {
      ss("$availableItems services added to cart");
    }
  }

  void _viewDetails(Map<String, dynamic> item) {
    // Navigate to service details
    ss("Viewing details for ${item["name"]}");
  }

  void _showOptionsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusXl),
              topRight: Radius.circular(radiusXl),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Text(
                  "Wishlist Options",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                GestureDetector(
                  onTap: () {
                    back();
                    _shareWishlist();
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Icon(Icons.share, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Share Wishlist",
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                GestureDetector(
                  onTap: () {
                    back();
                    _clearWishlist();
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Icon(Icons.clear_all, color: dangerColor),
                        SizedBox(width: spSm),
                        Text(
                          "Clear Wishlist",
                          style: TextStyle(
                            fontSize: 16,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                GestureDetector(
                  onTap: () {
                    back();
                    _exportWishlist();
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Icon(Icons.download, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Export Wishlist",
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _shareWishlist() {
    ss("Sharing wishlist...");
  }

  void _clearWishlist() async {
    bool isConfirmed = await confirm("Are you sure you want to clear your entire wishlist?");
    if (isConfirmed) {
      setState(() {
        wishlistItems.clear();
      });
      ss("Wishlist cleared");
    }
  }

  void _exportWishlist() {
    ss("Exporting wishlist...");
  }
}
