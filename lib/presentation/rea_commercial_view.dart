import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaCommercialView extends StatefulWidget {
  const ReaCommercialView({super.key});

  @override
  State<ReaCommercialView> createState() => _ReaCommercialViewState();
}

class _ReaCommercialViewState extends State<ReaCommercialView> {
  String selectedCategory = "all";
  String sortBy = "price_low";
  String selectedSize = "all";

  List<Map<String, dynamic>> categories = [
    {"id": "all", "label": "All Commercial", "count": 200, "icon": Icons.business},
    {"id": "office", "label": "Office Space", "count": 80, "icon": Icons.business_center},
    {"id": "retail", "label": "Retail", "count": 60, "icon": Icons.storefront},
    {"id": "warehouse", "label": "Warehouse", "count": 40, "icon": Icons.warehouse},
    {"id": "restaurant", "label": "Restaurant", "count": 20, "icon": Icons.restaurant},
  ];

  List<Map<String, dynamic>> sizeFilters = [
    {"id": "all", "label": "All Sizes"},
    {"id": "small", "label": "Small (< 2,000 sqft)"},
    {"id": "medium", "label": "Medium (2,000 - 10,000 sqft)"},
    {"id": "large", "label": "Large (> 10,000 sqft)"},
  ];

  List<Map<String, dynamic>> properties = [
    {
      "id": "1",
      "title": "Modern Office Building",
      "category": "office",
      "price": 2500000,
      "sqft": 15000,
      "floors": 3,
      "parking": 50,
      "location": "Financial District, Manhattan",
      "image": "https://picsum.photos/400/300?random=1&keyword=office",
      "isNew": true,
      "isFeatured": false,
      "rating": 4.8,
      "yearBuilt": 2019,
      "zoning": "Commercial",
      "occupancy": 85,
      "amenities": ["Elevator", "Security", "HVAC", "Fiber Internet"],
      "agent": "James Parker",
      "roi": 8.5,
    },
    {
      "id": "2",
      "title": "Prime Retail Storefront",
      "category": "retail",
      "price": 1200000,
      "sqft": 3500,
      "floors": 1,
      "parking": 15,
      "location": "SoHo, Manhattan",
      "image": "https://picsum.photos/400/300?random=2&keyword=retail",
      "isNew": false,
      "isFeatured": true,
      "rating": 4.9,
      "yearBuilt": 2015,
      "zoning": "Mixed Use",
      "occupancy": 100,
      "amenities": ["Display Windows", "Storage", "Street Access"],
      "agent": "Maria Rodriguez",
      "roi": 12.3,
    },
    {
      "id": "3",
      "title": "Large Distribution Warehouse",
      "category": "warehouse",
      "price": 3200000,
      "sqft": 50000,
      "floors": 1,
      "parking": 100,
      "location": "Queens Industrial Zone",
      "image": "https://picsum.photos/400/300?random=3&keyword=warehouse",
      "isNew": false,
      "isFeatured": false,
      "rating": 4.6,
      "yearBuilt": 2012,
      "zoning": "Industrial",
      "occupancy": 90,
      "amenities": ["Loading Docks", "High Ceilings", "Rail Access"],
      "agent": "Robert Kim",
      "roi": 7.8,
    },
    {
      "id": "4",
      "title": "Restaurant Space with Kitchen",
      "category": "restaurant",
      "price": 850000,
      "sqft": 2800,
      "floors": 1,
      "parking": 8,
      "location": "Little Italy, Manhattan",
      "image": "https://picsum.photos/400/300?random=4&keyword=restaurant",
      "isNew": true,
      "isFeatured": false,
      "rating": 4.7,
      "yearBuilt": 2020,
      "zoning": "Commercial",
      "occupancy": 0,
      "amenities": ["Commercial Kitchen", "Dining Area", "Liquor License"],
      "agent": "Sophie Chen",
      "roi": 15.2,
    },
    {
      "id": "5",
      "title": "Corporate Headquarters",
      "category": "office",
      "price": 4500000,
      "sqft": 25000,
      "floors": 5,
      "parking": 80,
      "location": "Midtown, Manhattan",
      "image": "https://picsum.photos/400/300?random=5&keyword=corporate",
      "isNew": false,
      "isFeatured": true,
      "rating": 4.9,
      "yearBuilt": 2018,
      "zoning": "Commercial",
      "occupancy": 95,
      "amenities": ["Conference Rooms", "Executive Suites", "Cafeteria"],
      "agent": "David Thompson",
      "roi": 9.1,
    },
    {
      "id": "6",
      "title": "Shopping Center Anchor",
      "category": "retail",
      "price": 1800000,
      "sqft": 8000,
      "floors": 2,
      "parking": 200,
      "location": "Brooklyn Mall District",
      "image": "https://picsum.photos/400/300?random=6&keyword=shopping",
      "isNew": false,
      "isFeatured": false,
      "rating": 4.5,
      "yearBuilt": 2010,
      "zoning": "Commercial",
      "occupancy": 100,
      "amenities": ["Escalators", "Multiple Entrances", "Food Court Access"],
      "agent": "Lisa Wang",
      "roi": 10.7,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Commercial Properties"),
        actions: [
          QButton(
            icon: Icons.map,
            size: bs.sm,
            onPressed: () => si("Opening map view"),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCategoryTabs(),
            _buildFiltersAndSort(),
            _buildMarketSummary(),
            _buildPropertiesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Commercial Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: categories.map((category) {
              return _buildCategoryTab(category);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(Map<String, dynamic> category) {
    bool isSelected = selectedCategory == category["id"];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category["id"];
        });
      },
      child: Container(
        width: 140,
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              category["icon"],
              color: isSelected ? Colors.white : primaryColor,
              size: 24,
            ),
            SizedBox(height: spSm),
            Text(
              category["label"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "${category["count"]} available",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? Colors.white.withAlpha(180) : disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersAndSort() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.square_foot,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Size",
                    value: selectedSize,
                    items: sizeFilters,
                    onChanged: (value, label) {
                      selectedSize = value;
                      setState(() {});
                    },
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
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.sort,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    value: sortBy,
                    items: [
                      {"label": "Price: Low to High", "value": "price_low"},
                      {"label": "Price: High to Low", "value": "price_high"},
                      {"label": "Size: Large to Small", "value": "size_large"},
                      {"label": "ROI: High to Low", "value": "roi_high"},
                      {"label": "Newest First", "value": "newest"},
                    ],
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketSummary() {
    List<Map<String, dynamic>> filteredProperties = _getFilteredProperties();
    int totalProperties = filteredProperties.length;
    double avgPrice = totalProperties > 0 
        ? filteredProperties.map((p) => p["price"] as int).reduce((a, b) => a + b) / totalProperties
        : 0;
    double avgROI = totalProperties > 0 
        ? filteredProperties.map((p) => p["roi"] as double).reduce((a, b) => a + b) / totalProperties
        : 0;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Market Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  icon: Icons.business,
                  label: "Properties",
                  value: "$totalProperties",
                  color: primaryColor,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  icon: Icons.attach_money,
                  label: "Avg Price",
                  value: "\$${(avgPrice / 1000000).toStringAsFixed(1)}M",
                  color: successColor,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  icon: Icons.trending_up,
                  label: "Avg ROI",
                  value: "${avgROI.toStringAsFixed(1)}%",
                  color: warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        SizedBox(height: spSm),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPropertiesList() {
    List<Map<String, dynamic>> filteredProperties = _getFilteredProperties();

    if (filteredProperties.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              Icons.business_center,
              size: 64,
              color: disabledBoldColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No commercial properties found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Try adjusting your filters or browse all categories",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: filteredProperties.map((property) {
        return _buildPropertyCard(property);
      }).toList(),
    );
  }

  Widget _buildPropertyCard(Map<String, dynamic> property) {
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
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(property["image"]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Row(
                  children: [
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
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    if (property["isFeatured"])
                      Container(
                        margin: EdgeInsets.only(left: spXs),
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "FEATURED",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "ROI ${property["roi"]}%",
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
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        property["title"],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        property["zoning"],
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
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
                        property["location"],
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    _buildPropertySpec(Icons.square_foot, "${property["sqft"]} sqft"),
                    SizedBox(width: spMd),
                    _buildPropertySpec(Icons.layers, "${property["floors"]} floors"),
                    SizedBox(width: spMd),
                    _buildPropertySpec(Icons.local_parking, "${property["parking"]} spaces"),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    _buildOccupancyIndicator(property["occupancy"]),
                    Spacer(),
                    Text(
                      "Built ${property["yearBuilt"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "Amenities:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  (property["amenities"] as List).join(" • "),
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$${((property["price"] as int) / 1000000).toStringAsFixed(1)}M",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Agent: ${property["agent"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () => _viewPropertyDetails(property),
                        ),
                        SizedBox(height: spXs),
                        QButton(
                          label: "Schedule Tour",
                          size: bs.sm,
                          color: primaryColor,
                          onPressed: () => _scheduleTour(property),
                        ),
                      ],
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

  Widget _buildPropertySpec(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 16,
        ),
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

  Widget _buildOccupancyIndicator(int occupancy) {
    Color occupancyColor = occupancy >= 90 
        ? successColor 
        : occupancy >= 70 
            ? warningColor 
            : dangerColor;

    return Row(
      children: [
        Icon(
          Icons.people,
          color: occupancyColor,
          size: 16,
        ),
        SizedBox(width: spXs),
        Text(
          "$occupancy% occupied",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: occupancyColor,
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getFilteredProperties() {
    List<Map<String, dynamic>> filtered = properties;

    if (selectedCategory != "all") {
      filtered = filtered.where((p) => p["category"] == selectedCategory).toList();
    }

    if (selectedSize != "all") {
      switch (selectedSize) {
        case "small":
          filtered = filtered.where((p) => (p["sqft"] as int) < 2000).toList();
          break;
        case "medium":
          filtered = filtered.where((p) => 
            (p["sqft"] as int) >= 2000 && (p["sqft"] as int) <= 10000).toList();
          break;
        case "large":
          filtered = filtered.where((p) => (p["sqft"] as int) > 10000).toList();
          break;
      }
    }

    // Sort properties
    switch (sortBy) {
      case "price_low":
        filtered.sort((a, b) => (a["price"] as int).compareTo(b["price"] as int));
        break;
      case "price_high":
        filtered.sort((a, b) => (b["price"] as int).compareTo(a["price"] as int));
        break;
      case "size_large":
        filtered.sort((a, b) => (b["sqft"] as int).compareTo(a["sqft"] as int));
        break;
      case "roi_high":
        filtered.sort((a, b) => (b["roi"] as double).compareTo(a["roi"] as double));
        break;
      case "newest":
        filtered.sort((a, b) => (b["yearBuilt"] as int).compareTo(a["yearBuilt"] as int));
        break;
    }

    return filtered;
  }

  void _viewPropertyDetails(Map<String, dynamic> property) {
    si("Viewing details for ${property["title"]}");
  }

  void _scheduleTour(Map<String, dynamic> property) {
    si("Scheduling tour for ${property["title"]}");
  }
}
