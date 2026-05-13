import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaSearchResultsView extends StatefulWidget {
  const ReaSearchResultsView({super.key});

  @override
  State<ReaSearchResultsView> createState() => _ReaSearchResultsViewState();
}

class _ReaSearchResultsViewState extends State<ReaSearchResultsView> {
  String searchQuery = "3 BHK Apartment in Downtown";
  String sortBy = "Relevance";
  String viewMode = "list"; // list, grid, map
  bool showFilters = false;
  
  final List<String> sortOptions = [
    "Relevance",
    "Price: Low to High",
    "Price: High to Low",
    "Newest First",
    "Size: Large to Small",
    "Distance",
  ];

  final List<Map<String, dynamic>> properties = [
    {
      "id": 1,
      "title": "Modern 3BHK Apartment",
      "location": "Downtown Central",
      "price": 450000,
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 1200,
      "images": [
        "https://picsum.photos/300/200?random=1&keyword=apartment",
        "https://picsum.photos/300/200?random=2&keyword=apartment",
      ],
      "type": "Apartment",
      "isNew": true,
      "isFeatured": true,
      "agent": "Sarah Johnson",
      "rating": 4.8,
      "views": 245,
      "amenities": ["Parking", "Gym", "Pool"],
      "distance": "0.5 km",
    },
    {
      "id": 2,
      "title": "Luxury Downtown Penthouse",
      "location": "Downtown Heights",
      "price": 890000,
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 2100,
      "images": [
        "https://picsum.photos/300/200?random=3&keyword=penthouse",
        "https://picsum.photos/300/200?random=4&keyword=penthouse",
      ],
      "type": "Penthouse",
      "isNew": false,
      "isFeatured": true,
      "agent": "Michael Chen",
      "rating": 4.9,
      "views": 189,
      "amenities": ["Parking", "Concierge", "Terrace"],
      "distance": "1.2 km",
    },
    {
      "id": 3,
      "title": "Cozy 2BHK with Garden View",
      "location": "Downtown Garden District",
      "price": 320000,
      "bedrooms": 2,
      "bathrooms": 2,
      "area": 950,
      "images": [
        "https://picsum.photos/300/200?random=5&keyword=apartment",
        "https://picsum.photos/300/200?random=6&keyword=apartment",
      ],
      "type": "Apartment",
      "isNew": false,
      "isFeatured": false,
      "agent": "Emily Davis",
      "rating": 4.6,
      "views": 156,
      "amenities": ["Garden", "Parking"],
      "distance": "2.1 km",
    },
    {
      "id": 4,
      "title": "Spacious Family Townhouse",
      "location": "Downtown Suburbs",
      "price": 650000,
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 1800,
      "images": [
        "https://picsum.photos/300/200?random=7&keyword=townhouse",
        "https://picsum.photos/300/200?random=8&keyword=townhouse",
      ],
      "type": "Townhouse",
      "isNew": true,
      "isFeatured": false,
      "agent": "Robert Kim",
      "rating": 4.7,
      "views": 198,
      "amenities": ["Garden", "Garage", "Patio"],
      "distance": "3.5 km",
    },
    {
      "id": 5,
      "title": "Executive Studio Loft",
      "location": "Downtown Business District",
      "price": 280000,
      "bedrooms": 1,
      "bathrooms": 1,
      "area": 650,
      "images": [
        "https://picsum.photos/300/200?random=9&keyword=studio",
        "https://picsum.photos/300/200?random=10&keyword=studio",
      ],
      "type": "Studio",
      "isNew": false,
      "isFeatured": false,
      "agent": "Lisa Martinez",
      "rating": 4.4,
      "views": 134,
      "amenities": ["Gym", "Concierge"],
      "distance": "0.8 km",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search Results",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "${properties.length} properties found",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: _toggleMapView,
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: _toggleFilters,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search query and controls
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Search query display
                Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        searchQuery,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _editSearch,
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                // Sort and view controls
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _showSortOptions,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: disabledOutlineBorderColor),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.sort,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Sort: $sortBy",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    // View mode toggles
                    Row(
                      children: [
                        _buildViewToggle(Icons.view_list, "list"),
                        SizedBox(width: spXs),
                        _buildViewToggle(Icons.grid_view, "grid"),
                        SizedBox(width: spXs),
                        _buildViewToggle(Icons.map, "map"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Filter bar (if visible)
          if (showFilters)
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                border: Border(
                  bottom: BorderSide(color: disabledOutlineBorderColor),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Filters:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildFilterChip("3+ Bedrooms", true),
                        _buildFilterChip("Under \$500K", true),
                        _buildFilterChip("With Parking", false),
                        _buildFilterChip("Near School", false),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _clearFilters,
                    child: Text(
                      "Clear",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Results list
          Expanded(
            child: viewMode == "list"
                ? _buildListView()
                : viewMode == "grid"
                    ? _buildGridView()
                    : _buildMapView(),
          ),
        ],
      ),
    );
  }

  Widget _buildViewToggle(IconData icon, String mode) {
    final isActive = viewMode == mode;
    return GestureDetector(
      onTap: () {
        setState(() {
          viewMode = mode;
        });
      },
      child: Container(
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusXs),
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.white : disabledBoldColor,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isActive) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.symmetric(
        horizontal: spSm,
        vertical: spXs,
      ),
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isActive ? primaryColor : disabledOutlineBorderColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isActive ? Colors.white : disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isActive) ...[
            SizedBox(width: spXs),
            Icon(
              Icons.close,
              color: Colors.white,
              size: 12,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: properties.length,
      itemBuilder: (context, index) {
        final property = properties[index];
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              // Property image
              Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(radiusMd),
                      ),
                      image: DecorationImage(
                        image: NetworkImage("${(property["images"] as List)[0]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Badges
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Row(
                      children: [
                        if (property["isNew"] as bool)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "NEW",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        if (property["isFeatured"] as bool) ...[
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "FEATURED",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    top: spSm,
                    right: spSm,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [shadowSm],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: primaryColor,
                          size: 20,
                        ),
                        onPressed: () => _toggleFavorite(property),
                      ),
                    ),
                  ),
                ],
              ),

              // Property details
              Container(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${property["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${(property["price"] as int).currency}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${property["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "${property["distance"]}",
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
                        _buildPropertySpec(
                          Icons.bed,
                          "${property["bedrooms"]} bed",
                        ),
                        SizedBox(width: spSm),
                        _buildPropertySpec(
                          Icons.bathtub,
                          "${property["bathrooms"]} bath",
                        ),
                        SizedBox(width: spSm),
                        _buildPropertySpec(
                          Icons.square_foot,
                          "${property["area"]} sqft",
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 14,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${property["rating"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    // Amenities
                    Wrap(
                      spacing: spXs,
                      children: (property["amenities"] as List).take(3).map((amenity) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$amenity",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Text(
                          "Agent: ${property["agent"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${property["views"]} views",
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
        );
      },
    );
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 200,
      children: properties.map((property) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property image
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(radiusMd),
                  ),
                  image: DecorationImage(
                    image: NetworkImage("${(property["images"] as List)[0]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${property["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(property["price"] as int).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        _buildPropertySpec(
                          Icons.bed,
                          "${property["bedrooms"]}",
                        ),
                        SizedBox(width: spXs),
                        _buildPropertySpec(
                          Icons.bathtub,
                          "${property["bathrooms"]}",
                        ),
                        Spacer(),
                        Icon(
                          Icons.favorite_border,
                          color: primaryColor,
                          size: 16,
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
    );
  }

  Widget _buildMapView() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map,
              size: 64,
              color: disabledBoldColor,
            ),
            SizedBox(height: spSm),
            Text(
              "Map View",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Interactive map with property locations",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertySpec(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: disabledBoldColor,
          size: 14,
        ),
        SizedBox(width: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  void _toggleMapView() {
    setState(() {
      viewMode = viewMode == "map" ? "list" : "map";
    });
  }

  void _toggleFilters() {
    setState(() {
      showFilters = !showFilters;
    });
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sort Results",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              ...sortOptions.map((option) {
                return ListTile(
                  title: Text(option),
                  trailing: sortBy == option ? Icon(Icons.check, color: primaryColor) : null,
                  onTap: () {
                    setState(() {
                      sortBy = option;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _editSearch() {
    back();
  }

  void _toggleFavorite(Map<String, dynamic> property) {
    ss("Added to favorites: ${property["title"]}");
  }

  void _clearFilters() {
    setState(() {
      showFilters = false;
    });
    ss("Filters cleared");
  }
}
