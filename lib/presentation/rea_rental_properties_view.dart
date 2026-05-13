import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaRentalPropertiesView extends StatefulWidget {
  const ReaRentalPropertiesView({super.key});

  @override
  State<ReaRentalPropertiesView> createState() => _ReaRentalPropertiesViewState();
}

class _ReaRentalPropertiesViewState extends State<ReaRentalPropertiesView> {
  String selectedTab = "available";
  String selectedPropertyType = "all";
  String sortBy = "rent_low";

  List<Map<String, dynamic>> tabOptions = [
    {"id": "available", "label": "Available", "count": 125},
    {"id": "rented", "label": "Rented", "count": 89},
    {"id": "maintenance", "label": "Maintenance", "count": 7},
  ];

  List<Map<String, dynamic>> propertyTypes = [
    {"id": "all", "label": "All Types", "count": 221},
    {"id": "apartment", "label": "Apartments", "count": 95},
    {"id": "house", "label": "Houses", "count": 78},
    {"id": "condo", "label": "Condos", "count": 32},
    {"id": "studio", "label": "Studios", "count": 16},
  ];

  List<Map<String, dynamic>> rentalProperties = [
    {
      "id": "1",
      "title": "Luxury 2BR Apartment",
      "type": "apartment",
      "rent": 2800,
      "deposit": 5600,
      "bedrooms": 2,
      "bathrooms": 2,
      "sqft": 1200,
      "location": "Upper East Side, Manhattan",
      "image": "https://picsum.photos/400/300?random=1&keyword=apartment",
      "status": "available",
      "availableDate": "2025-01-15",
      "furnished": true,
      "petsAllowed": false,
      "rating": 4.8,
      "amenities": ["Gym", "Doorman", "Rooftop", "Laundry"],
      "landlord": "Premier Properties",
      "yieldPercent": 6.5,
      "totalTenants": 0,
      "leaseType": "Long-term",
    },
    {
      "id": "2",
      "title": "Cozy Studio Downtown",
      "type": "studio",
      "rent": 1800,
      "deposit": 3600,
      "bedrooms": 0,
      "bathrooms": 1,
      "sqft": 500,
      "location": "Financial District, Manhattan",
      "image": "https://picsum.photos/400/300?random=2&keyword=studio",
      "status": "rented",
      "availableDate": "2025-03-01",
      "furnished": false,
      "petsAllowed": true,
      "rating": 4.6,
      "amenities": ["Concierge", "Pool", "Business Center"],
      "landlord": "City Living LLC",
      "yieldPercent": 8.2,
      "totalTenants": 1,
      "leaseType": "Short-term",
    },
    {
      "id": "3",
      "title": "Family House with Garden",
      "type": "house",
      "rent": 4200,
      "deposit": 8400,
      "bedrooms": 4,
      "bathrooms": 3,
      "sqft": 2400,
      "location": "Park Slope, Brooklyn",
      "image": "https://picsum.photos/400/300?random=3&keyword=house",
      "status": "available",
      "availableDate": "2025-01-01",
      "furnished": false,
      "petsAllowed": true,
      "rating": 4.9,
      "amenities": ["Garden", "Garage", "Basement", "Deck"],
      "landlord": "Brooklyn Homes Inc",
      "yieldPercent": 7.8,
      "totalTenants": 0,
      "leaseType": "Long-term",
    },
    {
      "id": "4",
      "title": "Modern Condo with Views",
      "type": "condo",
      "rent": 3500,
      "deposit": 7000,
      "bedrooms": 3,
      "bathrooms": 2,
      "sqft": 1600,
      "location": "Long Island City, Queens",
      "image": "https://picsum.photos/400/300?random=4&keyword=condo",
      "status": "maintenance",
      "availableDate": "2025-02-15",
      "furnished": true,
      "petsAllowed": false,
      "rating": 4.7,
      "amenities": ["Balcony", "Parking", "Elevator", "Storage"],
      "landlord": "Queens Luxury Living",
      "yieldPercent": 5.9,
      "totalTenants": 0,
      "leaseType": "Long-term",
    },
    {
      "id": "5",
      "title": "Penthouse Apartment",
      "type": "apartment",
      "rent": 6500,
      "deposit": 13000,
      "bedrooms": 3,
      "bathrooms": 3,
      "sqft": 2000,
      "location": "Tribeca, Manhattan",
      "image": "https://picsum.photos/400/300?random=5&keyword=penthouse",
      "status": "rented",
      "availableDate": "2025-06-01",
      "furnished": true,
      "petsAllowed": true,
      "rating": 4.9,
      "amenities": ["Terrace", "Private Elevator", "Wine Cellar"],
      "landlord": "Elite Properties",
      "yieldPercent": 4.8,
      "totalTenants": 2,
      "leaseType": "Long-term",
    },
    {
      "id": "6",
      "title": "Charming Brownstone Apartment",
      "type": "apartment",
      "rent": 3200,
      "deposit": 6400,
      "bedrooms": 2,
      "bathrooms": 1,
      "sqft": 1100,
      "location": "Williamsburg, Brooklyn",
      "image": "https://picsum.photos/400/300?random=6&keyword=brownstone",
      "status": "available",
      "availableDate": "2025-01-10",
      "furnished": false,
      "petsAllowed": true,
      "rating": 4.5,
      "amenities": ["Exposed Brick", "High Ceilings", "Hardwood"],
      "landlord": "Historic Brooklyn Rentals",
      "yieldPercent": 7.2,
      "totalTenants": 0,
      "leaseType": "Long-term",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rental Properties"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => si("Adding new rental property"),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildStatusTabs(),
            _buildFiltersAndSort(),
            _buildRentalSummary(),
            _buildPropertiesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTabs() {
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
            "Property Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: tabOptions.map((tab) {
              return Expanded(
                child: _buildStatusTab(tab),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTab(Map<String, dynamic> tab) {
    bool isSelected = selectedTab == tab["id"];
    Color tabColor = _getStatusColor(tab["id"]);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = tab["id"];
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: spXs),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? tabColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: tabColor,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              "${tab["count"]}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : tabColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              tab["label"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : tabColor,
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
                  Icons.home_work,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Property Type",
                    value: selectedPropertyType,
                    items: propertyTypes.map((type) => {
                      "label": type["label"],
                      "value": type["id"],
                    }).toList(),
                    onChanged: (value, label) {
                      selectedPropertyType = value;
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
                      {"label": "Rent: Low to High", "value": "rent_low"},
                      {"label": "Rent: High to Low", "value": "rent_high"},
                      {"label": "Yield: High to Low", "value": "yield_high"},
                      {"label": "Available Date", "value": "available_date"},
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
      ],
    );
  }

  Widget _buildRentalSummary() {
    List<Map<String, dynamic>> filteredProperties = _getFilteredProperties();
    int totalProperties = filteredProperties.length;
    double avgRent = totalProperties > 0 
        ? filteredProperties.map((p) => p["rent"] as int).reduce((a, b) => a + b) / totalProperties
        : 0;
    double avgYield = totalProperties > 0 
        ? filteredProperties.map((p) => p["yieldPercent"] as double).reduce((a, b) => a + b) / totalProperties
        : 0;
    int occupiedCount = filteredProperties.where((p) => p["status"] == "rented").length;

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
            "Portfolio Summary",
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
                child: _buildSummaryCard(
                  icon: Icons.home,
                  label: "Properties",
                  value: "$totalProperties",
                  color: primaryColor,
                ),
              ),
              Expanded(
                child: _buildSummaryCard(
                  icon: Icons.attach_money,
                  label: "Avg Rent",
                  value: "\$${avgRent.toStringAsFixed(0)}",
                  color: successColor,
                ),
              ),
              Expanded(
                child: _buildSummaryCard(
                  icon: Icons.trending_up,
                  label: "Avg Yield",
                  value: "${avgYield.toStringAsFixed(1)}%",
                  color: warningColor,
                ),
              ),
              Expanded(
                child: _buildSummaryCard(
                  icon: Icons.people,
                  label: "Occupied",
                  value: "$occupiedCount",
                  color: infoColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          textAlign: TextAlign.center,
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
              "Try adjusting your filters or add new rental properties",
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
    Color statusColor = _getStatusColor(property["status"]);

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
                height: 180,
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
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    property["status"].toString().toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
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
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${property["yieldPercent"]}% Yield",
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
                    if (property["bedrooms"] > 0)
                      _buildPropertyFeature(Icons.bed, "${property["bedrooms"]} beds"),
                    if (property["bedrooms"] > 0) SizedBox(width: spMd),
                    _buildPropertyFeature(Icons.bathtub, "${property["bathrooms"]} baths"),
                    SizedBox(width: spMd),
                    _buildPropertyFeature(Icons.square_foot, "${property["sqft"]} sqft"),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    _buildTag(
                      property["furnished"] ? "Furnished" : "Unfurnished",
                      property["furnished"] ? successColor : disabledBoldColor,
                    ),
                    SizedBox(width: spSm),
                    _buildTag(
                      property["petsAllowed"] ? "Pet Friendly" : "No Pets",
                      property["petsAllowed"] ? primaryColor : disabledBoldColor,
                    ),
                    SizedBox(width: spSm),
                    _buildTag(
                      property["leaseType"],
                      infoColor,
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
                            "\$${(property["rent"] as int).currency}/month",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Deposit: \$${(property["deposit"] as int).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Available: ${property["availableDate"]}",
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
                        if (property["status"] == "available")
                          QButton(
                            label: "Contact Owner",
                            size: bs.sm,
                            color: primaryColor,
                            onPressed: () => _contactOwner(property),
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

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spSm,
        vertical: spXs,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(
          color: color.withAlpha(50),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "available":
        return successColor;
      case "rented":
        return primaryColor;
      case "maintenance":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> _getFilteredProperties() {
    List<Map<String, dynamic>> filtered = rentalProperties;

    // Filter by status
    filtered = filtered.where((p) => p["status"] == selectedTab).toList();

    // Filter by property type
    if (selectedPropertyType != "all") {
      filtered = filtered.where((p) => p["type"] == selectedPropertyType).toList();
    }

    // Sort properties
    switch (sortBy) {
      case "rent_low":
        filtered.sort((a, b) => (a["rent"] as int).compareTo(b["rent"] as int));
        break;
      case "rent_high":
        filtered.sort((a, b) => (b["rent"] as int).compareTo(a["rent"] as int));
        break;
      case "yield_high":
        filtered.sort((a, b) => (b["yieldPercent"] as double).compareTo(a["yieldPercent"] as double));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "available_date":
        filtered.sort((a, b) => a["availableDate"].compareTo(b["availableDate"]));
        break;
    }

    return filtered;
  }

  void _viewPropertyDetails(Map<String, dynamic> property) {
    si("Viewing details for ${property["title"]}");
  }

  void _contactOwner(Map<String, dynamic> property) {
    si("Contacting owner for ${property["title"]}");
  }
}
