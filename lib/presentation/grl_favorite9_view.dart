import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFavorite9View extends StatefulWidget {
  @override
  State<GrlFavorite9View> createState() => _GrlFavorite9ViewState();
}

class _GrlFavorite9ViewState extends State<GrlFavorite9View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Recently Added";

  List<String> categories = ["All", "Restaurants", "Shopping", "Travel", "Entertainment"];
  List<String> sortOptions = ["Recently Added", "Alphabetical", "Rating", "Distance"];

  List<Map<String, dynamic>> favoriteItems = [
    {
      "id": "1",
      "name": "The Italian Corner",
      "category": "Restaurants",
      "type": "Restaurant",
      "rating": 4.8,
      "distance": 0.8,
      "image": "https://picsum.photos/300/200?random=1&keyword=restaurant",
      "address": "123 Main St, Downtown",
      "phone": "+1 555-0123",
      "priceRange": "\$\$",
      "isOpen": true,
      "closingTime": "11:00 PM",
      "tags": ["Italian", "Pizza", "Pasta"],
      "added_date": "2024-01-15",
    },
    {
      "id": "2",
      "name": "Fashion Forward",
      "category": "Shopping",
      "type": "Clothing Store",
      "rating": 4.6,
      "distance": 1.2,
      "image": "https://picsum.photos/300/200?random=2&keyword=fashion",
      "address": "456 Fashion Ave",
      "phone": "+1 555-0124",
      "priceRange": "\$\$\$",
      "isOpen": true,
      "closingTime": "9:00 PM",
      "tags": ["Fashion", "Designer", "Trendy"],
      "added_date": "2024-01-14",
    },
    {
      "id": "3",
      "name": "Grand Plaza Hotel",
      "category": "Travel",
      "type": "Hotel",
      "rating": 4.9,
      "distance": 2.5,
      "image": "https://picsum.photos/300/200?random=3&keyword=hotel",
      "address": "789 Luxury Blvd",
      "phone": "+1 555-0125",
      "priceRange": "\$\$\$\$",
      "isOpen": true,
      "closingTime": "24/7",
      "tags": ["Luxury", "Business", "Spa"],
      "added_date": "2024-01-12",
    },
    {
      "id": "4",
      "name": "Cinema Max",
      "category": "Entertainment",
      "type": "Movie Theater",
      "rating": 4.4,
      "distance": 1.8,
      "image": "https://picsum.photos/300/200?random=4&keyword=cinema",
      "address": "321 Entertainment St",
      "phone": "+1 555-0126",
      "priceRange": "\$\$",
      "isOpen": true,
      "closingTime": "12:00 AM",
      "tags": ["Movies", "IMAX", "3D"],
      "added_date": "2024-01-10",
    },
    {
      "id": "5",
      "name": "Ocean View Cafe",
      "category": "Restaurants",
      "type": "Cafe",
      "rating": 4.7,
      "distance": 0.5,
      "image": "https://picsum.photos/300/200?random=5&keyword=cafe",
      "address": "567 Beach Rd",
      "phone": "+1 555-0127",
      "priceRange": "\$",
      "isOpen": false,
      "closingTime": "Closed",
      "tags": ["Coffee", "Breakfast", "Ocean View"],
      "added_date": "2024-01-08",
    },
    {
      "id": "6",
      "name": "Tech Gadgets Store",
      "category": "Shopping",
      "type": "Electronics",
      "rating": 4.5,
      "distance": 3.1,
      "image": "https://picsum.photos/300/200?random=6&keyword=electronics",
      "address": "890 Tech Plaza",
      "phone": "+1 555-0128",
      "priceRange": "\$\$\$",
      "isOpen": true,
      "closingTime": "8:00 PM",
      "tags": ["Electronics", "Gadgets", "Phones"],
      "added_date": "2024-01-06",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    List<Map<String, dynamic>> filtered = favoriteItems;

    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((item) => "${item["category"]}" == selectedCategory).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((item) =>
        "${item["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${item["type"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        (item["tags"] as List).any((tag) => "$tag".toLowerCase().contains(searchQuery.toLowerCase()))
      ).toList();
    }

    // Sort items
    switch (sortBy) {
      case "Alphabetical":
        filtered.sort((a, b) => "${a["name"]}".compareTo("${b["name"]}"));
        break;
      case "Rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "Distance":
        filtered.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
        break;
      default: // Recently Added
        filtered.sort((a, b) => "${b["added_date"]}".compareTo("${a["added_date"]}"));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favorites"),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () => _showSortModal(),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showOptionsModal(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search favorites...",
                        value: searchQuery,
                        hint: "Search by name, type, or tags",
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
                SizedBox(height: spSm),

                // Category Filter
                QHorizontalScroll(
                  children: categories.map((category) {
                    bool isSelected = category == selectedCategory;
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
                          color: isSelected ? primaryColor : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Results Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: Colors.grey[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredItems.length} favorite${filteredItems.length != 1 ? 's' : ''}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => _showSortModal(),
                  child: Row(
                    children: [
                      Text(
                        "Sort: $sortBy",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Icon(
                        Icons.arrow_drop_down,
                        color: primaryColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Favorites List
          Expanded(
            child: filteredItems.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: EdgeInsets.all(spMd),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return _buildFavoriteCard(item, index);
                  },
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> item, int index) {
    bool isOpen = item["isOpen"] as bool;
    List<String> tags = (item["tags"] as List).cast<String>();

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Status
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${item["image"]}",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: isOpen ? successColor : dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    isOpen ? "Open" : "Closed",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: GestureDetector(
                  onTap: () => _removeFavorite(item),
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(200),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: dangerColor,
                      size: 20,
                    ),
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
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${item["priceRange"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${item["type"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),

                // Rating and Distance
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: warningColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${item["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.location_on,
                      color: primaryColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${(item["distance"] as double).toStringAsFixed(1)} km",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    if (isOpen)
                      Text(
                        "Closes ${item["closingTime"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spSm),

                // Address
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${item["address"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                // Tags
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: tags.take(3).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spSm),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.phone,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.directions,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {},
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: disabledColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No favorites found",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            searchQuery.isNotEmpty
              ? "Try adjusting your search terms"
              : "Start adding places you love to see them here",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: searchQuery.isNotEmpty ? "Clear Search" : "Explore Places",
            size: bs.md,
            onPressed: () {
              if (searchQuery.isNotEmpty) {
                searchQuery = "";
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  void _showSortModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sort By",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spSm),
            ...sortOptions.map((option) {
              bool isSelected = option == sortBy;
              return GestureDetector(
                onTap: () {
                  sortBy = option;
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  child: Row(
                    children: [
                      Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        color: isSelected ? primaryColor : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        option,
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected ? primaryColor : disabledBoldColor,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showOptionsModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            _buildOptionItem(Icons.clear_all, "Clear All Favorites", () {
              Navigator.pop(context);
              _clearAllFavorites();
            }),
            _buildOptionItem(Icons.file_download, "Export Favorites", () {
              Navigator.pop(context);
            }),
            _buildOptionItem(Icons.sync, "Sync with Cloud", () {
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
            SizedBox(width: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeFavorite(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Remove '${item["name"]}' from favorites?");
    if (isConfirmed) {
      favoriteItems.removeWhere((fav) => fav["id"] == item["id"]);
      setState(() {});
      ss("Removed from favorites");
    }
  }

  void _clearAllFavorites() async {
    bool isConfirmed = await confirm("Are you sure you want to clear all favorites?");
    if (isConfirmed) {
      favoriteItems.clear();
      setState(() {});
      ss("All favorites cleared");
    }
  }
}
