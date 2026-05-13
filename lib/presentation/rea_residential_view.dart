import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaResidentialView extends StatefulWidget {
  const ReaResidentialView({super.key});

  @override
  State<ReaResidentialView> createState() => _ReaResidentialViewState();
}

class _ReaResidentialViewState extends State<ReaResidentialView> {
  String selectedFilter = "all";
  String sortBy = "price_low";
  String selectedLocation = "all";

  List<Map<String, dynamic>> filterOptions = [
    {"id": "all", "label": "All", "count": 850},
    {"id": "apartment", "label": "Apartments", "count": 320},
    {"id": "house", "label": "Houses", "count": 280},
    {"id": "condo", "label": "Condos", "count": 150},
    {"id": "townhouse", "label": "Townhouses", "count": 100},
  ];

  List<Map<String, dynamic>> locations = [
    {"id": "all", "label": "All Locations"},
    {"id": "manhattan", "label": "Manhattan"},
    {"id": "brooklyn", "label": "Brooklyn"},
    {"id": "queens", "label": "Queens"},
    {"id": "bronx", "label": "The Bronx"},
    {"id": "staten", "label": "Staten Island"},
  ];

  List<Map<String, dynamic>> properties = [
    {
      "id": "1",
      "title": "Modern Downtown Apartment",
      "type": "apartment",
      "price": 450000,
      "bedrooms": 2,
      "bathrooms": 2,
      "sqft": 1200,
      "location": "Manhattan, NY",
      "image": "https://picsum.photos/400/300?random=1&keyword=apartment",
      "isNew": true,
      "isFeatured": false,
      "rating": 4.8,
      "amenities": ["Gym", "Pool", "Parking"],
      "agent": "Sarah Johnson",
      "yearBuilt": 2020,
    },
    {
      "id": "2",
      "title": "Luxury Single Family Home",
      "type": "house",
      "price": 750000,
      "bedrooms": 4,
      "bathrooms": 3,
      "sqft": 2500,
      "location": "Brooklyn, NY",
      "image": "https://picsum.photos/400/300?random=2&keyword=house",
      "isNew": false,
      "isFeatured": true,
      "rating": 4.9,
      "amenities": ["Garden", "Garage", "Fireplace"],
      "agent": "Michael Chen",
      "yearBuilt": 2018,
    },
    {
      "id": "3",
      "title": "Stylish Condo with City Views",
      "type": "condo",
      "price": 320000,
      "bedrooms": 1,
      "bathrooms": 1,
      "sqft": 800,
      "location": "Queens, NY",
      "image": "https://picsum.photos/400/300?random=3&keyword=condo",
      "isNew": false,
      "isFeatured": false,
      "rating": 4.6,
      "amenities": ["Balcony", "Concierge", "Rooftop"],
      "agent": "Emily Davis",
      "yearBuilt": 2019,
    },
    {
      "id": "4",
      "title": "Family Townhouse",
      "type": "townhouse",
      "price": 550000,
      "bedrooms": 3,
      "bathrooms": 2,
      "sqft": 1800,
      "location": "Brooklyn, NY",
      "image": "https://picsum.photos/400/300?random=4&keyword=townhouse",
      "isNew": true,
      "isFeatured": false,
      "rating": 4.7,
      "amenities": ["Patio", "Storage", "Laundry"],
      "agent": "David Wilson",
      "yearBuilt": 2021,
    },
    {
      "id": "5",
      "title": "Penthouse Apartment",
      "type": "apartment",
      "price": 950000,
      "bedrooms": 3,
      "bathrooms": 2,
      "sqft": 1600,
      "location": "Manhattan, NY",
      "image": "https://picsum.photos/400/300?random=5&keyword=penthouse",
      "isNew": false,
      "isFeatured": true,
      "rating": 4.9,
      "amenities": ["Terrace", "Elevator", "Doorman"],
      "agent": "Lisa Anderson",
      "yearBuilt": 2017,
    },
    {
      "id": "6",
      "title": "Cozy Suburban House",
      "type": "house",
      "price": 425000,
      "bedrooms": 3,
      "bathrooms": 2,
      "sqft": 1900,
      "location": "Queens, NY",
      "image": "https://picsum.photos/400/300?random=6&keyword=suburban",
      "isNew": false,
      "isFeatured": false,
      "rating": 4.5,
      "amenities": ["Yard", "Garage", "Basement"],
      "agent": "Robert Taylor",
      "yearBuilt": 2015,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Residential Properties"),
        actions: [
          QButton(
            icon: Icons.tune,
            size: bs.sm,
            onPressed: _showFilterModal,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildQuickFilters(),
            _buildSortAndLocation(),
            _buildPropertyStats(),
            _buildPropertyList(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickFilters() {
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
            "Property Types",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: filterOptions.map((filter) {
              return _buildFilterChip(filter);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(Map<String, dynamic> filter) {
    bool isSelected = selectedFilter == filter["id"];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = filter["id"];
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.symmetric(
          horizontal: spMd,
          vertical: spSm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              filter["label"],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : primaryColor,
              ),
            ),
            SizedBox(width: spXs),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: spXs,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withAlpha(30) : primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${filter["count"]}",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortAndLocation() {
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
                      {"label": "Newest First", "value": "newest"},
                      {"label": "Oldest First", "value": "oldest"},
                      {"label": "Rating", "value": "rating"},
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
                  Icons.location_on,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Location",
                    value: selectedLocation,
                    items: locations,
                    onChanged: (value, label) {
                      selectedLocation = value;
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

  Widget _buildPropertyStats() {
    List<Map<String, dynamic>> filteredProperties = _getFilteredProperties();
    int totalProperties = filteredProperties.length;
    double avgPrice = totalProperties > 0 
        ? filteredProperties.map((p) => p["price"] as int).reduce((a, b) => a + b) / totalProperties
        : 0;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              icon: Icons.home,
              label: "Properties",
              value: "$totalProperties",
              color: primaryColor,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.attach_money,
              label: "Avg Price",
              value: "\$${(avgPrice / 1000).toStringAsFixed(0)}K",
              color: successColor,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: disabledOutlineBorderColor,
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.star,
              label: "Featured",
              value: "${filteredProperties.where((p) => p["isFeatured"]).length}",
              color: warningColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
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
        SizedBox(height: spXs),
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

  Widget _buildPropertyList() {
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
              Icons.search_off,
              size: 64,
              color: disabledBoldColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No properties found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Try adjusting your filters or search criteria",
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
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: primaryColor,
                    size: 20,
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
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${property["rating"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
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
                    Text(
                      property["location"],
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    _buildPropertyFeature(Icons.bed, "${property["bedrooms"]} beds"),
                    SizedBox(width: spMd),
                    _buildPropertyFeature(Icons.bathtub, "${property["bathrooms"]} baths"),
                    SizedBox(width: spMd),
                    _buildPropertyFeature(Icons.square_foot, "${property["sqft"]} sqft"),
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
                            "\$${(property["price"] as int).currency}",
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
                    QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () => _viewPropertyDetails(property),
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

  Widget _buildPropertyFeature(IconData icon, String text) {
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

  List<Map<String, dynamic>> _getFilteredProperties() {
    List<Map<String, dynamic>> filtered = properties;

    if (selectedFilter != "all") {
      filtered = filtered.where((p) => p["type"] == selectedFilter).toList();
    }

    // Sort properties
    switch (sortBy) {
      case "price_low":
        filtered.sort((a, b) => (a["price"] as int).compareTo(b["price"] as int));
        break;
      case "price_high":
        filtered.sort((a, b) => (b["price"] as int).compareTo(a["price"] as int));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "newest":
        filtered.sort((a, b) => (b["yearBuilt"] as int).compareTo(a["yearBuilt"] as int));
        break;
      case "oldest":
        filtered.sort((a, b) => (a["yearBuilt"] as int).compareTo(b["yearBuilt"] as int));
        break;
    }

    return filtered;
  }

  void _showFilterModal() {
    si("Opening advanced filters");
  }

  void _viewPropertyDetails(Map<String, dynamic> property) {
    si("Viewing details for ${property["title"]}");
  }
}
