import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaFeaturedPropertiesView extends StatefulWidget {
  const ReaFeaturedPropertiesView({super.key});

  @override
  State<ReaFeaturedPropertiesView> createState() => _ReaFeaturedPropertiesViewState();
}

class _ReaFeaturedPropertiesViewState extends State<ReaFeaturedPropertiesView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedPriceRange = "All";
  String sortBy = "Featured";
  bool showMap = false;
  
  List<String> categories = ["All", "Villa", "Condo", "Townhouse", "Penthouse", "Mansion"];
  List<String> priceRanges = ["All", "Under \$500K", "\$500K - \$1M", "\$1M - \$2M", "\$2M - \$5M", "Above \$5M"];
  List<String> sortOptions = ["Featured", "Price: Low to High", "Price: High to Low", "Newest", "Largest", "Most Popular"];

  List<Map<String, dynamic>> featuredProperties = [
    {
      "id": 1,
      "title": "Oceanfront Villa Paradise",
      "address": "123 Ocean Drive, Miami Beach, FL",
      "price": 3500000,
      "originalPrice": 3750000,
      "type": "Villa",
      "bedrooms": 5,
      "bathrooms": 4,
      "area": 4200,
      "yearBuilt": 2021,
      "isFeatured": true,
      "isNew": false,
      "discount": 7,
      "rating": 4.9,
      "views": 1250,
      "saves": 89,
      "daysOnMarket": 15,
      "image": "https://picsum.photos/400/300?random=1&keyword=villa",
      "gallery": [
        "https://picsum.photos/400/300?random=1&keyword=villa",
        "https://picsum.photos/400/300?random=2&keyword=luxury",
        "https://picsum.photos/400/300?random=3&keyword=pool",
      ],
      "agent": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/50/50?random=10&keyword=agent",
        "rating": 4.8,
      },
      "features": ["Ocean View", "Private Pool", "Smart Home", "Garage"],
      "description": "Stunning oceanfront villa with panoramic water views and luxury amenities.",
    },
    {
      "id": 2,
      "title": "Downtown Luxury Penthouse",
      "address": "456 City Center, Miami, FL",
      "price": 2200000,
      "originalPrice": 2200000,
      "type": "Penthouse",
      "bedrooms": 3,
      "bathrooms": 3,
      "area": 2800,
      "yearBuilt": 2022,
      "isFeatured": true,
      "isNew": true,
      "discount": 0,
      "rating": 4.7,
      "views": 980,
      "saves": 67,
      "daysOnMarket": 8,
      "image": "https://picsum.photos/400/300?random=4&keyword=penthouse",
      "gallery": [
        "https://picsum.photos/400/300?random=4&keyword=penthouse",
        "https://picsum.photos/400/300?random=5&keyword=modern",
        "https://picsum.photos/400/300?random=6&keyword=city",
      ],
      "agent": {
        "name": "Michael Chen",
        "avatar": "https://picsum.photos/50/50?random=11&keyword=agent",
        "rating": 4.9,
      },
      "features": ["City View", "Rooftop Terrace", "Concierge", "Valet"],
      "description": "Ultra-modern penthouse in the heart of downtown with premium finishes.",
    },
    {
      "id": 3,
      "title": "Waterfront Mansion Estate",
      "address": "789 Bay Shore, Coral Gables, FL",
      "price": 5750000,
      "originalPrice": 6000000,
      "type": "Mansion",
      "bedrooms": 7,
      "bathrooms": 6,
      "area": 8500,
      "yearBuilt": 2020,
      "isFeatured": true,
      "isNew": false,
      "discount": 4,
      "rating": 4.8,
      "views": 2100,
      "saves": 156,
      "daysOnMarket": 22,
      "image": "https://picsum.photos/400/300?random=7&keyword=mansion",
      "gallery": [
        "https://picsum.photos/400/300?random=7&keyword=mansion",
        "https://picsum.photos/400/300?random=8&keyword=estate",
        "https://picsum.photos/400/300?random=9&keyword=garden",
      ],
      "agent": {
        "name": "Elena Rodriguez",
        "avatar": "https://picsum.photos/50/50?random=12&keyword=agent",
        "rating": 4.9,
      },
      "features": ["Waterfront", "Private Dock", "Wine Cellar", "Guest House"],
      "description": "Magnificent waterfront estate with private dock and expansive grounds.",
    },
    {
      "id": 4,
      "title": "Modern Luxury Condo",
      "address": "321 Biscayne Blvd, Miami, FL",
      "price": 850000,
      "originalPrice": 850000,
      "type": "Condo",
      "bedrooms": 2,
      "bathrooms": 2,
      "area": 1400,
      "yearBuilt": 2023,
      "isFeatured": true,
      "isNew": true,
      "discount": 0,
      "rating": 4.6,
      "views": 650,
      "saves": 45,
      "daysOnMarket": 5,
      "image": "https://picsum.photos/400/300?random=13&keyword=condo",
      "gallery": [
        "https://picsum.photos/400/300?random=13&keyword=condo",
        "https://picsum.photos/400/300?random=14&keyword=apartment",
        "https://picsum.photos/400/300?random=15&keyword=balcony",
      ],
      "agent": {
        "name": "David Kim",
        "avatar": "https://picsum.photos/50/50?random=13&keyword=agent",
        "rating": 4.7,
      },
      "features": ["Bay View", "Balcony", "Gym Access", "Pool"],
      "description": "Contemporary condo with stunning bay views and modern amenities.",
    },
    {
      "id": 5,
      "title": "Elegant Townhouse",
      "address": "654 Grove Street, Coconut Grove, FL",
      "price": 1350000,
      "originalPrice": 1420000,
      "type": "Townhouse",
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 2600,
      "yearBuilt": 2021,
      "isFeatured": true,
      "isNew": false,
      "discount": 5,
      "rating": 4.5,
      "views": 780,
      "saves": 52,
      "daysOnMarket": 18,
      "image": "https://picsum.photos/400/300?random=16&keyword=townhouse",
      "gallery": [
        "https://picsum.photos/400/300?random=16&keyword=townhouse",
        "https://picsum.photos/400/300?random=17&keyword=courtyard",
        "https://picsum.photos/400/300?random=18&keyword=terrace",
      ],
      "agent": {
        "name": "Amanda Foster",
        "avatar": "https://picsum.photos/50/50?random=14&keyword=agent",
        "rating": 4.6,
      },
      "features": ["Private Courtyard", "Roof Deck", "Parking", "Storage"],
      "description": "Beautifully designed townhouse with private courtyard and roof deck.",
    },
    {
      "id": 6,
      "title": "Luxury Beach Condo",
      "address": "987 Collins Ave, South Beach, FL",
      "price": 1950000,
      "originalPrice": 1950000,
      "type": "Condo",
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 1950,
      "yearBuilt": 2022,
      "isFeatured": true,
      "isNew": false,
      "discount": 0,
      "rating": 4.8,
      "views": 1450,
      "saves": 98,
      "daysOnMarket": 12,
      "image": "https://picsum.photos/400/300?random=19&keyword=beach",
      "gallery": [
        "https://picsum.photos/400/300?random=19&keyword=beach",
        "https://picsum.photos/400/300?random=20&keyword=oceanview",
        "https://picsum.photos/400/300?random=21&keyword=interior",
      ],
      "agent": {
        "name": "Carlos Mendez",
        "avatar": "https://picsum.photos/50/50?random=15&keyword=agent",
        "rating": 4.8,
      },
      "features": ["Beach Access", "Ocean View", "Spa", "Restaurant"],
      "description": "Sophisticated beach condo with direct ocean access and resort amenities.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProperties = _getFilteredProperties();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Featured Properties"),
        actions: [
          IconButton(
            icon: Icon(showMap ? Icons.list : Icons.map),
            onPressed: () {
              showMap = !showMap;
              setState(() {});
              ss(showMap ? "Map view enabled" : "List view enabled");
            },
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildStatsBar(filteredProperties.length),
          Expanded(
            child: showMap ? _buildMapView() : _buildListView(filteredProperties),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Icon(
                          Icons.search,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search properties...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: disabledBoldColor),
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
              GestureDetector(
                onTap: () {
                  _showSortDialog();
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor),
                  ),
                  child: Icon(
                    Icons.sort,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          QHorizontalScroll(
            children: [
              _buildFilterChip("Category", selectedCategory, categories),
              _buildFilterChip("Price", selectedPriceRange, priceRanges),
              _buildFilterChip("Sort", sortBy, sortOptions),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String selected, List<String> options) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      child: GestureDetector(
        onTap: () {
          _showFilterOptions(label, options);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: spMd,
            vertical: spSm,
          ),
          decoration: BoxDecoration(
            color: selected != options.first ? primaryColor : Colors.grey.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: selected != options.first ? primaryColor : disabledOutlineBorderColor,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$label: $selected",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: selected != options.first ? Colors.white : disabledBoldColor,
                ),
              ),
              SizedBox(width: spXs),
              Icon(
                Icons.keyboard_arrow_down,
                color: selected != options.first ? Colors.white : disabledBoldColor,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsBar(int count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
      ),
      child: Row(
        children: [
          Text(
            "$count Featured Properties",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Spacer(),
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Avg +12% value",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> properties) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          if (properties.isEmpty) _buildEmptyState(),
          if (properties.isNotEmpty) ...[
            _buildFeaturedHighlight(),
            SizedBox(height: spLg),
            ResponsiveGridView(
              minItemWidth: 300,
              children: properties.map((property) {
                return _buildPropertyCard(property);
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFeaturedHighlight() {
    final topProperty = featuredProperties.first;
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusLg),
            child: Image.network(
              "${topProperty["image"]}",
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withAlpha(200),
                ],
              ),
            ),
          ),
          Positioned(
            top: spMd,
            left: spMd,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: spXs,
              ),
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 12,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "TOP FEATURED",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: spLg,
            left: spLg,
            right: spLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "${topProperty["title"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${topProperty["address"]}",
                  style: TextStyle(
                    color: Colors.white.withAlpha(200),
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "\$${((topProperty["price"] as int).toDouble()).currency}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${topProperty["bedrooms"]} bed • ${topProperty["bathrooms"]} bath",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
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

  Widget _buildPropertyCard(Map<String, dynamic> property) {
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
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${property["image"]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    if (property["isFeatured"])
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "FEATURED",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (property["isNew"])
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "NEW",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if ((property["discount"] as int) > 0)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${property["discount"]}% OFF",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(100),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.photo_library,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${(property["gallery"] as List).length}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${property["type"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: disabledBoldColor,
                      size: 14,
                    ),
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
                Row(
                  children: [
                    if ((property["discount"] as int) > 0)
                      Text(
                        "\$${((property["originalPrice"] as int).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    if ((property["discount"] as int) > 0) SizedBox(width: spSm),
                    Text(
                      "\$${((property["price"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 12,
                        ),
                        SizedBox(width: 2),
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
                _buildPropertySpecs(property),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage("${property["agent"]["avatar"]}"),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${property["agent"]["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          color: disabledBoldColor,
                          size: 12,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${property["views"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.favorite,
                          color: dangerColor,
                          size: 12,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${property["saves"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      _viewPropertyDetails(property);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertySpecs(Map<String, dynamic> property) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSpecItem("${property["bedrooms"]}", "Beds", Icons.bed),
          _buildSpecItem("${property["bathrooms"]}", "Baths", Icons.bathtub),
          _buildSpecItem("${property["area"]}", "SqFt", Icons.square_foot),
          _buildSpecItem("${property["yearBuilt"]}", "Built", Icons.calendar_today),
        ],
      ),
    );
  }

  Widget _buildSpecItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 14,
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMapView() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    color: primaryColor,
                    size: 64,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Interactive Map View",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Properties plotted on interactive map",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: spMd),
          Expanded(
            child: ListView.builder(
              itemCount: _getFilteredProperties().length,
              itemBuilder: (context, index) {
                final property = _getFilteredProperties()[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${property["image"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
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
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "\$${((property["price"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: disabledBoldColor,
                        size: 16,
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

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(spXl),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            color: disabledColor,
            size: 64,
          ),
          SizedBox(height: spMd),
          Text(
            "No Properties Found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Try adjusting your search criteria",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Clear Filters",
            size: bs.sm,
            onPressed: () {
              _clearFilters();
            },
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredProperties() {
    List<Map<String, dynamic>> filtered = List.from(featuredProperties);

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((property) {
        return property["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               property["address"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               property["type"].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((property) => property["type"] == selectedCategory).toList();
    }

    // Filter by price range
    if (selectedPriceRange != "All") {
      filtered = filtered.where((property) {
        final price = property["price"] as int;
        switch (selectedPriceRange) {
          case "Under \$500K":
            return price < 500000;
          case "\$500K - \$1M":
            return price >= 500000 && price < 1000000;
          case "\$1M - \$2M":
            return price >= 1000000 && price < 2000000;
          case "\$2M - \$5M":
            return price >= 2000000 && price < 5000000;
          case "Above \$5M":
            return price >= 5000000;
          default:
            return true;
        }
      }).toList();
    }

    // Sort properties
    switch (sortBy) {
      case "Price: Low to High":
        filtered.sort((a, b) => (a["price"] as int).compareTo(b["price"] as int));
        break;
      case "Price: High to Low":
        filtered.sort((a, b) => (b["price"] as int).compareTo(a["price"] as int));
        break;
      case "Newest":
        filtered.sort((a, b) => (b["yearBuilt"] as int).compareTo(a["yearBuilt"] as int));
        break;
      case "Largest":
        filtered.sort((a, b) => (b["area"] as int).compareTo(a["area"] as int));
        break;
      case "Most Popular":
        filtered.sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
        break;
      default:
        // Featured sorting (default)
        break;
    }

    return filtered;
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(spLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Advanced Filters",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spLg),
            // Add more filter options here
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset",
                    size: bs.md,
                    color: disabledColor,
                    onPressed: () {
                      back();
                      _clearFilters();
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Apply Filters",
                    size: bs.md,
                    onPressed: () {
                      back();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSortDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sort Properties",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...sortOptions.map((option) {
              return GestureDetector(
                onTap: () {
                  sortBy = option;
                  back();
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: spMd),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: option,
                        groupValue: sortBy,
                        onChanged: (value) {
                          sortBy = value!;
                          back();
                          setState(() {});
                        },
                      ),
                      Text(option),
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

  void _showFilterOptions(String filterType, List<String> options) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select $filterType",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...options.map((option) {
              return GestureDetector(
                onTap: () {
                  switch (filterType) {
                    case "Category":
                      selectedCategory = option;
                      break;
                    case "Price":
                      selectedPriceRange = option;
                      break;
                    case "Sort":
                      sortBy = option;
                      break;
                  }
                  back();
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: spMd),
                  child: Text(option),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _clearFilters() {
    selectedCategory = "All";
    selectedPriceRange = "All";
    sortBy = "Featured";
    searchQuery = "";
    setState(() {});
    ss("Filters cleared");
  }

  void _viewPropertyDetails(Map<String, dynamic> property) {
    ss("Opening details for ${property["title"]}");
  }
}
