import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaInvestmentPropertiesView extends StatefulWidget {
  const ReaInvestmentPropertiesView({super.key});

  @override
  State<ReaInvestmentPropertiesView> createState() => _ReaInvestmentPropertiesViewState();
}

class _ReaInvestmentPropertiesViewState extends State<ReaInvestmentPropertiesView> {
  String selectedFilter = "All";
  String priceRange = "Any";
  String locationFilter = "All";
  String sortBy = "Newest";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Commercial", "value": "Commercial"},
    {"label": "Residential", "value": "Residential"},
    {"label": "Industrial", "value": "Industrial"},
    {"label": "Retail", "value": "Retail"},
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "Any", "value": "Any"},
    {"label": "Under \$500K", "value": "Under 500000"},
    {"label": "\$500K - \$1M", "value": "500000-1000000"},
    {"label": "\$1M - \$2M", "value": "1000000-2000000"},
    {"label": "\$2M - \$5M", "value": "2000000-5000000"},
    {"label": "Above \$5M", "value": "Above 5000000"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All", "value": "All"},
    {"label": "Downtown", "value": "Downtown"},
    {"label": "Business District", "value": "Business District"},
    {"label": "Suburban", "value": "Suburban"},
    {"label": "Waterfront", "value": "Waterfront"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest", "value": "Newest"},
    {"label": "Price: Low to High", "value": "Price Low"},
    {"label": "Price: High to Low", "value": "Price High"},
    {"label": "ROI: High to Low", "value": "ROI High"},
    {"label": "Cap Rate: High to Low", "value": "Cap Rate High"},
  ];

  List<Map<String, dynamic>> properties = [
    {
      "id": "1",
      "title": "Downtown Office Complex",
      "type": "Commercial",
      "address": "123 Business Street, Downtown",
      "price": 2800000,
      "images": [
        "https://picsum.photos/400/300?random=101&keyword=office",
        "https://picsum.photos/400/300?random=102&keyword=building",
        "https://picsum.photos/400/300?random=103&keyword=commercial",
      ],
      "area": 15000,
      "units": 25,
      "floors": 8,
      "parking_spaces": 50,
      "roi": 8.5,
      "cap_rate": 6.2,
      "rental_income": 25000,
      "occupancy_rate": 92,
      "lease_terms": "5-10 years",
      "property_management": "Included",
      "year_built": 2018,
      "amenities": ["Elevator", "Security", "HVAC", "Parking"],
      "investment_highlights": [
        "Prime downtown location",
        "High occupancy rate",
        "Long-term leases",
        "Professional property management",
      ],
    },
    {
      "id": "2",
      "title": "Luxury Apartment Complex",
      "type": "Residential",
      "address": "456 Residential Ave, Uptown",
      "price": 4200000,
      "images": [
        "https://picsum.photos/400/300?random=104&keyword=apartment",
        "https://picsum.photos/400/300?random=105&keyword=residential",
        "https://picsum.photos/400/300?random=106&keyword=luxury",
      ],
      "area": 35000,
      "units": 45,
      "floors": 12,
      "parking_spaces": 60,
      "roi": 9.2,
      "cap_rate": 5.8,
      "rental_income": 35000,
      "occupancy_rate": 96,
      "lease_terms": "1-2 years",
      "property_management": "Available",
      "year_built": 2020,
      "amenities": ["Pool", "Gym", "Concierge", "Rooftop"],
      "investment_highlights": [
        "New construction",
        "High-end finishes",
        "Excellent location",
        "Strong rental demand",
      ],
    },
    {
      "id": "3",
      "title": "Retail Shopping Center",
      "type": "Retail",
      "address": "789 Commerce Blvd, Shopping District",
      "price": 1850000,
      "images": [
        "https://picsum.photos/400/300?random=107&keyword=retail",
        "https://picsum.photos/400/300?random=108&keyword=shopping",
        "https://picsum.photos/400/300?random=109&keyword=store",
      ],
      "area": 22000,
      "units": 15,
      "floors": 2,
      "parking_spaces": 80,
      "roi": 7.8,
      "cap_rate": 6.5,
      "rental_income": 18000,
      "occupancy_rate": 88,
      "lease_terms": "3-5 years",
      "property_management": "Required",
      "year_built": 2015,
      "amenities": ["Food Court", "Parking", "Security", "Loading Dock"],
      "investment_highlights": [
        "Established retail center",
        "Diverse tenant mix",
        "High traffic location",
        "Expansion potential",
      ],
    },
    {
      "id": "4",
      "title": "Industrial Warehouse",
      "type": "Industrial",
      "address": "321 Industrial Way, Industrial Zone",
      "price": 3500000,
      "images": [
        "https://picsum.photos/400/300?random=110&keyword=warehouse",
        "https://picsum.photos/400/300?random=111&keyword=industrial",
        "https://picsum.photos/400/300?random=112&keyword=logistics",
      ],
      "area": 45000,
      "units": 8,
      "floors": 1,
      "parking_spaces": 30,
      "roi": 10.1,
      "cap_rate": 7.2,
      "rental_income": 28000,
      "occupancy_rate": 100,
      "lease_terms": "5-15 years",
      "property_management": "Optional",
      "year_built": 2016,
      "amenities": ["Loading Bays", "Office Space", "Security", "Rail Access"],
      "investment_highlights": [
        "Strategic location",
        "Triple net leases",
        "Stable tenants",
        "Low maintenance",
      ],
    },
    {
      "id": "5",
      "title": "Mixed-Use Development",
      "type": "Commercial",
      "address": "555 Main Street, City Center",
      "price": 6800000,
      "images": [
        "https://picsum.photos/400/300?random=113&keyword=mixed",
        "https://picsum.photos/400/300?random=114&keyword=development",
        "https://picsum.photos/400/300?random=115&keyword=urban",
      ],
      "area": 65000,
      "units": 35,
      "floors": 15,
      "parking_spaces": 100,
      "roi": 8.8,
      "cap_rate": 5.9,
      "rental_income": 45000,
      "occupancy_rate": 94,
      "lease_terms": "2-10 years",
      "property_management": "Included",
      "year_built": 2019,
      "amenities": ["Retail Space", "Office Space", "Apartments", "Parking"],
      "investment_highlights": [
        "Diversified income streams",
        "Prime city location",
        "Modern amenities",
        "Growth potential",
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredProperties {
    List<Map<String, dynamic>> result = properties;
    
    if (selectedFilter != "All") {
      result = result.where((property) => property["type"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      result = result.where((property) => 
        (property["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (property["address"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (property["type"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Sort results
    switch (sortBy) {
      case "Price Low":
        result.sort((a, b) => (a["price"] as int).compareTo(b["price"] as int));
        break;
      case "Price High":
        result.sort((a, b) => (b["price"] as int).compareTo(a["price"] as int));
        break;
      case "ROI High":
        result.sort((a, b) => (b["roi"] as num).compareTo(a["roi"] as num));
        break;
      case "Cap Rate High":
        result.sort((a, b) => (b["cap_rate"] as num).compareTo(a["cap_rate"] as num));
        break;
    }
    
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Investment Properties"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                _buildSearchAndFilters(),
                _buildInvestmentMetrics(),
                _buildPropertiesList(),
              ],
            ),
          ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          QTextField(
            label: "Search investment properties",
            value: searchQuery,
            hint: "Property name, location, or type",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QCategoryPicker(
            items: filterOptions,
            value: selectedFilter,
            onChanged: (index, label, value, item) {
              selectedFilter = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentMetrics() {
    double avgROI = properties.map((p) => p["roi"] as num).reduce((a, b) => a + b) / properties.length;
    double avgCapRate = properties.map((p) => p["cap_rate"] as num).reduce((a, b) => a + b) / properties.length;
    int totalProperties = properties.length;
    double totalValue = properties.map((p) => (p["price"] as int).toDouble()).reduce((a, b) => a + b);

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
            "Market Overview",
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
                child: _buildMetricCard(
                  "Properties",
                  totalProperties.toString(),
                  Icons.business,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard(
                  "Avg ROI",
                  "${avgROI.toStringAsFixed(1)}%",
                  Icons.trending_up,
                  successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  "Avg Cap Rate",
                  "${avgCapRate.toStringAsFixed(1)}%",
                  Icons.bar_chart,
                  warningColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard(
                  "Total Value",
                  "\$${(totalValue / 1000000).toStringAsFixed(1)}M",
                  Icons.account_balance,
                  infoColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: color),
          SizedBox(height: spXs),
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
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesList() {
    if (filteredProperties.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(Icons.search_off, size: 64, color: disabledColor),
            SizedBox(height: spMd),
            Text(
              "No properties found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your search or filter criteria",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: filteredProperties.map((property) => _buildPropertyCard(property)).toList(),
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
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${(property["images"] as List)[0]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Text(
                    "${property["type"]}",
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
                right: spSm,
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [shadowSm],
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
                        "${property["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "\$${((property["price"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${property["address"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                _buildPropertyMetrics(property),
                SizedBox(height: spMd),
                _buildPropertyDetails(property),
                SizedBox(height: spMd),
                _buildPropertyActions(property),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyMetrics(Map<String, dynamic> property) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "${(property["roi"] as num).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "ROI",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${(property["cap_rate"] as num).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Cap Rate",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "\$${((property["rental_income"] as int).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Monthly Income",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${property["occupancy_rate"]}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Occupancy",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyDetails(Map<String, dynamic> property) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildDetailItem(
                Icons.square_foot,
                "${((property["area"] as int).toDouble() / 1000).toStringAsFixed(1)}K sq ft",
              ),
            ),
            Expanded(
              child: _buildDetailItem(
                Icons.business,
                "${property["units"]} units",
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: _buildDetailItem(
                Icons.layers,
                "${property["floors"]} floors",
              ),
            ),
            Expanded(
              child: _buildDetailItem(
                Icons.local_parking,
                "${property["parking_spaces"]} spaces",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: disabledBoldColor),
        SizedBox(width: spXs),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyActions(Map<String, dynamic> property) {
    return Row(
      children: [
        Expanded(
          child: QButton(
            label: "View Details",
            size: bs.sm,
            onPressed: () => _viewPropertyDetails(property),
          ),
        ),
        SizedBox(width: spSm),
        QButton(
          icon: Icons.phone,
          size: bs.sm,
          onPressed: () => _contactAgent(property),
        ),
        SizedBox(width: spSm),
        QButton(
          icon: Icons.share,
          size: bs.sm,
          onPressed: () => _shareProperty(property),
        ),
      ],
    );
  }

  void _showFilterSheet() {
    ss("Opening filter options...");
  }

  void _viewPropertyDetails(Map<String, dynamic> property) {
    ss("Opening ${property["title"]} details...");
  }

  void _contactAgent(Map<String, dynamic> property) {
    ss("Contacting agent for ${property["title"]}...");
  }

  void _shareProperty(Map<String, dynamic> property) {
    ss("Sharing ${property["title"]}...");
  }
}
