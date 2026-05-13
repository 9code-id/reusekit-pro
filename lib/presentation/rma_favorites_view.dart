import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaFavoritesView extends StatefulWidget {
  const RmaFavoritesView({super.key});

  @override
  State<RmaFavoritesView> createState() => _RmaFavoritesViewState();
}

class _RmaFavoritesViewState extends State<RmaFavoritesView> {
  String selectedCategory = "all";
  String sortBy = "date_added";
  bool isGridView = false;
  
  List<Map<String, dynamic>> favoriteProperties = [
    {
      "id": "fav001",
      "title": "Modern Downtown Apartment",
      "address": "123 Main Street, Downtown District",
      "price": 450000,
      "originalPrice": 485000,
      "bedrooms": 2,
      "bathrooms": 2,
      "area": 1200,
      "type": "apartment",
      "status": "active",
      "dateAdded": "2024-01-20",
      "priceChanged": true,
      "priceChangePercent": -7.2,
      "images": [
        "https://picsum.photos/400/300?random=1&keyword=apartment",
        "https://picsum.photos/400/300?random=2&keyword=modern",
      ],
      "agent": "Sarah Johnson",
      "daysOnMarket": 25,
      "views": 245,
      "notes": "Great location near metro station",
    },
    {
      "id": "fav002",
      "title": "Luxury Family Villa",
      "address": "456 Oak Avenue, Hillside Estates",
      "price": 850000,
      "originalPrice": 850000,
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 2800,
      "type": "house",
      "status": "pending",
      "dateAdded": "2024-01-18",
      "priceChanged": false,
      "priceChangePercent": 0,
      "images": [
        "https://picsum.photos/400/300?random=3&keyword=villa",
        "https://picsum.photos/400/300?random=4&keyword=luxury",
      ],
      "agent": "Michael Chen",
      "daysOnMarket": 15,
      "views": 189,
      "notes": "Perfect for large family, excellent school district",
    },
    {
      "id": "fav003",
      "title": "Beachfront Condo",
      "address": "321 Ocean Drive, Coastal Bay",
      "price": 720000,
      "originalPrice": 740000,
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 1800,
      "type": "condo",
      "status": "active",
      "dateAdded": "2024-01-15",
      "priceChanged": true,
      "priceChangePercent": -2.7,
      "images": [
        "https://picsum.photos/400/300?random=5&keyword=beach",
        "https://picsum.photos/400/300?random=6&keyword=ocean",
      ],
      "agent": "Emma Wilson",
      "daysOnMarket": 42,
      "views": 312,
      "notes": "Amazing ocean views, investment potential",
    },
    {
      "id": "fav004",
      "title": "Urban Penthouse",
      "address": "555 High Street, City Center",
      "price": 1200000,
      "originalPrice": 1150000,
      "bedrooms": 3,
      "bathrooms": 3,
      "area": 2200,
      "type": "apartment",
      "status": "active",
      "dateAdded": "2024-01-12",
      "priceChanged": true,
      "priceChangePercent": 4.3,
      "images": [
        "https://picsum.photos/400/300?random=7&keyword=penthouse",
        "https://picsum.photos/400/300?random=8&keyword=luxury",
      ],
      "agent": "David Park",
      "daysOnMarket": 8,
      "views": 156,
      "notes": "Luxury living with city skyline views",
    },
    {
      "id": "fav005",
      "title": "Cozy Studio Loft",
      "address": "789 Pine Road, Arts District",
      "price": 280000,
      "originalPrice": 295000,
      "bedrooms": 1,
      "bathrooms": 1,
      "area": 650,
      "type": "studio",
      "status": "active",
      "dateAdded": "2024-01-10",
      "priceChanged": true,
      "priceChangePercent": -5.1,
      "images": [
        "https://picsum.photos/400/300?random=9&keyword=loft",
        "https://picsum.photos/400/300?random=10&keyword=studio",
      ],
      "agent": "Lisa Wong",
      "daysOnMarket": 18,
      "views": 98,
      "notes": "Perfect starter home, great for young professionals",
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Properties", "value": "all"},
    {"label": "Houses", "value": "house"},
    {"label": "Apartments", "value": "apartment"},
    {"label": "Condos", "value": "condo"},
    {"label": "Studios", "value": "studio"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Date Added", "value": "date_added"},
    {"label": "Price: Low to High", "value": "price_low"},
    {"label": "Price: High to Low", "value": "price_high"},
    {"label": "Recently Updated", "value": "updated"},
  ];

  List<Map<String, dynamic>> get filteredFavorites {
    List<Map<String, dynamic>> filtered = favoriteProperties;
    
    if (selectedCategory != "all") {
      filtered = filtered.where((property) => property["type"] == selectedCategory).toList();
    }
    
    // Sort
    switch (sortBy) {
      case "price_low":
        filtered.sort((a, b) => (a["price"] as int).compareTo(b["price"] as int));
        break;
      case "price_high":
        filtered.sort((a, b) => (b["price"] as int).compareTo(a["price"] as int));
        break;
      case "updated":
        filtered.sort((a, b) => (b["priceChanged"] as bool ? 1 : 0).compareTo(a["priceChanged"] as bool ? 1 : 0));
        break;
      default:
        // date_added - keep original order
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareFavorites,
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Stats and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              spacing: spSm,
              children: [
                // Stats Row
                Row(
                  children: [
                    _buildStatCard("Total", "${favoriteProperties.length}", primaryColor),
                    SizedBox(width: spSm),
                    _buildStatCard("Active", "${favoriteProperties.where((p) => p["status"] == "active").length}", successColor),
                    SizedBox(width: spSm),
                    _buildStatCard("Price Drops", "${favoriteProperties.where((p) => (p["priceChanged"] as bool) && (p["priceChangePercent"] as double) < 0).length}", dangerColor),
                  ],
                ),
                
                // Filters Row
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryOptions,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Sort By",
                        items: sortOptions,
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Results Count
          if (filteredFavorites.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              color: Colors.grey[50],
              child: Row(
                children: [
                  Text(
                    "${filteredFavorites.length} favorite${filteredFavorites.length != 1 ? 's' : ''}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  if (favoriteProperties.any((p) => p["priceChanged"] as bool))
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.trending_down, size: 14, color: infoColor),
                          SizedBox(width: spXs),
                          Text(
                            "Price updates available",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          
          // Favorites List/Grid
          Expanded(
            child: filteredFavorites.isEmpty 
                ? _buildEmptyState()
                : isGridView 
                    ? _buildGridView()
                    : _buildListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          //navigateTo('PropertySearchView')
        },
        child: Icon(Icons.search, color: Colors.white),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64,
              color: disabledBoldColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No Favorites Yet",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Start browsing properties and add them to your favorites to see them here.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: spLg),
            QButton(
              label: "Browse Properties",
              icon: Icons.search,
              size: bs.md,
              onPressed: () {
                //navigateTo('PropertySearchView')
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredFavorites.length,
      itemBuilder: (context, index) {
        final property = filteredFavorites[index];
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              // Property Content
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Image
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusMd)),
                        child: Image.network(
                          "${(property["images"] as List)[0]}",
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      
                      // Price Change Badge
                      if (property["priceChanged"] as bool)
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: (property["priceChangePercent"] as double) < 0 
                                  ? successColor 
                                  : dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${(property["priceChangePercent"] as double) > 0 ? '+' : ''}${(property["priceChangePercent"] as double).toStringAsFixed(1)}%",
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
                  
                  // Property Details
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          // Price and Status
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "\$${((property["price"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (property["originalPrice"] != property["price"])
                                      Text(
                                        "\$${((property["originalPrice"] as int).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(property["status"]),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${property["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          // Title
                          Text(
                            "${property["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          // Address
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${property["address"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          
                          // Property Stats
                          Row(
                            children: [
                              _buildStatItem(Icons.bed, "${property["bedrooms"]}"),
                              SizedBox(width: spSm),
                              _buildStatItem(Icons.bathtub, "${property["bathrooms"]}"),
                              SizedBox(width: spSm),
                              _buildStatItem(Icons.square_foot, "${property["area"]}"),
                              Spacer(),
                              Text(
                                "Added ${property["dateAdded"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          // Notes (if any)
                          if (property["notes"] != null && (property["notes"] as String).isNotEmpty)
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.yellow[50],
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(color: Colors.yellow[200]!),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.note, size: 14, color: Colors.orange[600]),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${property["notes"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.orange[800],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
              // Action Buttons
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: disabledOutlineBorderColor),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('PropertyDetailsView')
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.edit_note,
                      size: bs.sm,
                      onPressed: () => _editNotes(property),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.favorite,
                      size: bs.sm,
                      onPressed: () => _removeFromFavorites(property),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 200,
      children: filteredFavorites.map((property) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    child: Image.network(
                      "${(property["images"] as List)[0]}",
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  // Price Change Badge
                  if (property["priceChanged"] as bool)
                    Positioned(
                      top: spSm,
                      left: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: (property["priceChangePercent"] as double) < 0 
                              ? successColor 
                              : dangerColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${(property["priceChangePercent"] as double) > 0 ? '+' : ''}${(property["priceChangePercent"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  
                  // Favorite Button
                  Positioned(
                    top: spSm,
                    right: spSm,
                    child: GestureDetector(
                      onTap: () => _removeFromFavorites(property),
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(200),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: dangerColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Property Details
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    // Price
                    Text(
                      "\$${((property["price"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    // Title
                    Text(
                      "${property["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    // Stats
                    Row(
                      children: [
                        _buildStatItem(Icons.bed, "${property["bedrooms"]}"),
                        SizedBox(width: spSm),
                        _buildStatItem(Icons.bathtub, "${property["bathrooms"]}"),
                        Spacer(),
                        Icon(Icons.square_foot, size: 12, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${property["area"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    // View Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "View",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('PropertyDetailsView')
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: disabledBoldColor),
        SizedBox(width: spXs),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "pending":
        return warningColor;
      case "sold":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _removeFromFavorites(Map<String, dynamic> property) async {
    bool isConfirmed = await confirm("Remove this property from your favorites?");
    if (isConfirmed) {
      favoriteProperties.removeWhere((p) => p["id"] == property["id"]);
      setState(() {});
      ss("Property removed from favorites");
    }
  }

  void _editNotes(Map<String, dynamic> property) {
    String currentNotes = property["notes"] ?? "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Notes"),
        content: QMemoField(
          label: "Property Notes",
          value: currentNotes,
          hint: "Add your personal notes about this property...",
          onChanged: (value) {
            currentNotes = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              property["notes"] = currentNotes;
              setState(() {});
              Navigator.pop(context);
              ss("Notes updated");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _shareFavorites() {
    // Share favorites functionality
    ss("Favorites list shared");
  }
}
