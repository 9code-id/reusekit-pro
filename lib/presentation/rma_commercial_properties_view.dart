import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaCommercialPropertiesView extends StatefulWidget {
  const RmaCommercialPropertiesView({super.key});

  @override
  State<RmaCommercialPropertiesView> createState() => _RmaCommercialPropertiesViewState();
}

class _RmaCommercialPropertiesViewState extends State<RmaCommercialPropertiesView> {
  String searchQuery = "";
  String selectedPropertyType = "all";
  String selectedPriceRange = "all";
  String selectedLocation = "all";
  String sortBy = "price_low";
  int currentTab = 0;

  List<Map<String, dynamic>> propertyTypeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Office Building", "value": "office"},
    {"label": "Retail Space", "value": "retail"},
    {"label": "Warehouse", "value": "warehouse"},
    {"label": "Industrial", "value": "industrial"},
    {"label": "Mixed Use", "value": "mixed"},
  ];

  List<Map<String, dynamic>> priceRangeOptions = [
    {"label": "All Prices", "value": "all"},
    {"label": "Under \$500K", "value": "under_500k"},
    {"label": "\$500K - \$1M", "value": "500k_1m"},
    {"label": "\$1M - \$5M", "value": "1m_5m"},
    {"label": "Over \$5M", "value": "over_5m"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": "all"},
    {"label": "Downtown", "value": "downtown"},
    {"label": "Business District", "value": "business"},
    {"label": "Industrial Zone", "value": "industrial_zone"},
    {"label": "Suburban", "value": "suburban"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Price: Low to High", "value": "price_low"},
    {"label": "Price: High to Low", "value": "price_high"},
    {"label": "Cap Rate", "value": "cap_rate"},
    {"label": "Square Footage", "value": "sqft"},
  ];

  List<Map<String, dynamic>> commercialProperties = [
    {
      "id": "COM001",
      "title": "Premium Office Tower",
      "address": "1500 Corporate Plaza",
      "city": "Los Angeles",
      "state": "CA",
      "zip": "90067",
      "price": 2850000,
      "price_per_sqft": 285,
      "sqft": 10000,
      "property_type": "office",
      "property_type_label": "Office Building",
      "location": "downtown",
      "cap_rate": 6.8,
      "annual_income": 194000,
      "expenses": 85000,
      "noi": 109000,
      "occupancy_rate": 95,
      "lease_term": "Long-term",
      "parking_spaces": 45,
      "year_built": 2018,
      "floors": 8,
      "units": 12,
      "images": ["https://picsum.photos/300/200?random=20", "https://picsum.photos/300/200?random=21"],
      "description": "Modern office tower in prime downtown location with high-end finishes and amenities.",
      "features": ["High-speed elevators", "On-site parking", "Modern HVAC", "24/7 security"],
      "agent": "Commercial Realty Group",
      "agent_phone": "(555) 123-9876",
      "listing_date": "2024-05-15",
      "investment_rating": 9.1
    },
    {
      "id": "COM002",
      "title": "Retail Shopping Complex",
      "address": "2200 Main Street",
      "city": "Santa Monica",
      "state": "CA",
      "zip": "90401",
      "price": 1750000,
      "price_per_sqft": 350,
      "sqft": 5000,
      "property_type": "retail",
      "property_type_label": "Retail Space",
      "location": "business",
      "cap_rate": 7.5,
      "annual_income": 131250,
      "expenses": 35000,
      "noi": 96250,
      "occupancy_rate": 100,
      "lease_term": "Triple net",
      "parking_spaces": 25,
      "year_built": 2015,
      "floors": 2,
      "units": 6,
      "images": ["https://picsum.photos/300/200?random=22", "https://picsum.photos/300/200?random=23"],
      "description": "High-traffic retail center with established tenants and excellent visibility.",
      "features": ["Street frontage", "Ample parking", "Multiple entrances", "Modern storefronts"],
      "agent": "Retail Properties Inc",
      "agent_phone": "(555) 456-7890",
      "listing_date": "2024-05-20",
      "investment_rating": 8.7
    },
    {
      "id": "COM003",
      "title": "Industrial Warehouse",
      "address": "3800 Industrial Blvd",
      "city": "Long Beach",
      "state": "CA",
      "zip": "90805",
      "price": 1200000,
      "price_per_sqft": 80,
      "sqft": 15000,
      "property_type": "warehouse",
      "property_type_label": "Warehouse",
      "location": "industrial_zone",
      "cap_rate": 8.2,
      "annual_income": 98400,
      "expenses": 28000,
      "noi": 70400,
      "occupancy_rate": 85,
      "lease_term": "Modified gross",
      "parking_spaces": 15,
      "year_built": 2010,
      "floors": 1,
      "units": 3,
      "images": ["https://picsum.photos/300/200?random=24", "https://picsum.photos/300/200?random=25"],
      "description": "Large warehouse facility with loading docks and flexible space configuration.",
      "features": ["Loading docks", "High ceilings", "Drive-in access", "Truck parking"],
      "agent": "Industrial Properties LLC",
      "agent_phone": "(555) 789-0123",
      "listing_date": "2024-05-10",
      "investment_rating": 7.9
    },
    {
      "id": "COM004",
      "title": "Mixed-Use Development",
      "address": "750 Metropolitan Ave",
      "city": "Pasadena",
      "state": "CA",
      "zip": "91101",
      "price": 4250000,
      "price_per_sqft": 340,
      "sqft": 12500,
      "property_type": "mixed",
      "property_type_label": "Mixed Use",
      "location": "suburban",
      "cap_rate": 6.5,
      "annual_income": 276250,
      "expenses": 95000,
      "noi": 181250,
      "occupancy_rate": 92,
      "lease_term": "Mixed",
      "parking_spaces": 60,
      "year_built": 2020,
      "floors": 4,
      "units": 18,
      "images": ["https://picsum.photos/300/200?random=26", "https://picsum.photos/300/200?random=27"],
      "description": "Contemporary mixed-use building with retail ground floor and office spaces above.",
      "features": ["Ground floor retail", "Office spaces", "Underground parking", "Modern design"],
      "agent": "Metro Commercial Real Estate",
      "agent_phone": "(555) 234-5678",
      "listing_date": "2024-06-01",
      "investment_rating": 8.9
    },
  ];

  List<Map<String, dynamic>> get filteredProperties {
    return commercialProperties.where((property) {
      if (searchQuery.isNotEmpty && 
          !property["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) &&
          !property["address"].toString().toLowerCase().contains(searchQuery.toLowerCase()) &&
          !property["city"].toString().toLowerCase().contains(searchQuery.toLowerCase())) {
        return false;
      }
      
      if (selectedPropertyType != "all" && property["property_type"] != selectedPropertyType) {
        return false;
      }
      
      if (selectedLocation != "all" && property["location"] != selectedLocation) {
        return false;
      }
      
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Commercial Properties",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Listings", icon: Icon(Icons.business)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Portfolio", icon: Icon(Icons.folder)),
      ],
      tabChildren: [
        _buildListingsTab(),
        _buildAnalyticsTab(),
        _buildPortfolioTab(),
      ],
    );
  }

  Widget _buildListingsTab() {
    return Column(
      children: [
        _buildSearchAndFilters(),
        _buildStatsBar(),
        Expanded(
          child: _buildPropertiesGrid(),
        ),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildMarketOverview(),
          _buildPerformanceMetrics(),
          _buildMarketTrends(),
        ],
      ),
    );
  }

  Widget _buildPortfolioTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPortfolioSummary(),
          _buildPortfolioPerformance(),
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
        spacing: spSm,
        children: [
          Row(
            spacing: spMd,
            children: [
              Expanded(
                child: QTextField(
                  label: "Search properties",
                  value: searchQuery,
                  hint: "Property name, address, or city",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Property Type",
                  items: propertyTypeOptions,
                  value: selectedPropertyType,
                  onChanged: (value, label) {
                    selectedPropertyType = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Location",
                  items: locationOptions,
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
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

  Widget _buildStatsBar() {
    int totalListings = filteredProperties.length;
    double avgPrice = filteredProperties.isEmpty ? 0 : 
        filteredProperties.fold(0.0, (sum, item) => sum + (item["price"] as int).toDouble()) / totalListings;
    double avgCapRate = filteredProperties.isEmpty ? 0 :
        filteredProperties.fold(0.0, (sum, item) => sum + (item["cap_rate"] as double)) / totalListings;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$totalListings Properties Available",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Avg Price: ${avgPrice.currency}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Avg Cap Rate: ${avgCapRate.toStringAsFixed(1)}%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesGrid() {
    if (filteredProperties.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.business_center,
              size: 64,
              color: disabledBoldColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No Properties Found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Try adjusting your search criteria",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: ResponsiveGridView(
        minItemWidth: 200,
        children: filteredProperties.map((property) => _buildPropertyCard(property)).toList(),
      ),
    );
  }

  Widget _buildPropertyCard(Map<String, dynamic> property) {
    Color typeColor = _getPropertyTypeColor(property["property_type"]);
    double roi = ((property["noi"] as int).toDouble() / (property["price"] as int).toDouble()) * 100;
    
    return Container(
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
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                  image: DecorationImage(
                    image: NetworkImage("${(property["images"] as List)[0]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: typeColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${property["property_type_label"]}",
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
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(120),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 12,
                        color: warningColor,
                      ),
                      SizedBox(width: 2),
                      Text(
                        "${(property["investment_rating"] as double).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${(property["cap_rate"] as double).toStringAsFixed(1)}% Cap Rate",
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
                Text(
                  "${property["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${property["address"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${property["city"]}, ${property["state"]} ${property["zip"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${((property["price"] as int).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${(property["price_per_sqft"] as int).toDouble().currency}/sqft",
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
                    _buildPropertyDetail(Icons.square_foot, "${property["sqft"]} sqft"),
                    SizedBox(width: spMd),
                    _buildPropertyDetail(Icons.layers, "${property["floors"]} floors"),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    _buildPropertyDetail(Icons.meeting_room, "${property["units"]} units"),
                    SizedBox(width: spMd),
                    _buildPropertyDetail(Icons.local_parking, "${property["parking_spaces"]} spaces"),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Annual NOI",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${((property["noi"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Occupancy",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${property["occupancy_rate"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: (property["occupancy_rate"] as int) > 90 ? successColor : warningColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () => _showPropertyDetails(property),
                      ),
                    ),
                    QButton(
                      icon: Icons.favorite_border,
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

  Widget _buildPropertyDetail(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
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

  Color _getPropertyTypeColor(String type) {
    switch (type) {
      case "office":
        return primaryColor;
      case "retail":
        return successColor;
      case "warehouse":
        return warningColor;
      case "industrial":
        return infoColor;
      case "mixed":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildMarketOverview() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildOverviewCard("Total Listings", "4", "Properties", Icons.business),
        _buildOverviewCard("Avg Cap Rate", "7.2%", "Market average", Icons.trending_up),
        _buildOverviewCard("Market Value", "\$10.1M", "Combined total", Icons.attach_money),
        _buildOverviewCard("Avg Occupancy", "93%", "Current rate", Icons.people),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, String subtitle, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: successColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bar_chart,
                  size: 56,
                  color: primaryColor.withAlpha(60),
                ),
                SizedBox(height: spMd),
                Text(
                  "Performance Analytics Chart",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Cap rates, NOI, and occupancy trends",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketTrends() {
    List<Map<String, dynamic>> trends = [
      {"metric": "Cap Rates", "current": 7.2, "change": -0.3, "trend": "down"},
      {"metric": "Occupancy Rates", "current": 93.0, "change": 2.1, "trend": "up"},
      {"metric": "Rental Growth", "current": 4.8, "change": 1.2, "trend": "up"},
      {"metric": "Property Values", "current": 12.5, "change": 8.3, "trend": "up"},
    ];

    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Market Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          ...trends.map((trend) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${trend["metric"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(trend["current"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      trend["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                      color: trend["trend"] == "up" ? successColor : dangerColor,
                      size: 20,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${trend["change"] >= 0 ? '+' : ''}${(trend["change"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: trend["trend"] == "up" ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPortfolioSummary() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildPortfolioCard("Portfolio Value", "\$8.2M", "+12.5%", successColor),
        _buildPortfolioCard("Monthly Income", "\$42.8K", "+8.2%", primaryColor),
        _buildPortfolioCard("Properties Owned", "6", "+2", infoColor),
        _buildPortfolioCard("Avg Cap Rate", "7.8%", "+0.5%", warningColor),
      ],
    );
  }

  Widget _buildPortfolioCard(String title, String value, String change, Color color) {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioPerformance() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Portfolio Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.donut_large,
                  size: 56,
                  color: primaryColor.withAlpha(60),
                ),
                SizedBox(height: spMd),
                Text(
                  "Portfolio Performance Chart",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Property distribution and returns",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPropertyDetails(Map<String, dynamic> property) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${property["title"]}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${(property["images"] as List)[0]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                "${property["description"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${((property["price"] as int).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cap Rate",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(property["cap_rate"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Features",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...(property["features"] as List).map((feature) => Text(
                    "• $feature",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  )),
                ],
              ),
              Text(
                "Agent: ${property["agent"]} - ${property["agent_phone"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Contact Agent",
            size: bs.sm,
            onPressed: () {},
          ),
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
