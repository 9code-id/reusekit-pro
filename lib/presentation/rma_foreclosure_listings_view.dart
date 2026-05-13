import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaForeclosureListingsView extends StatefulWidget {
  const RmaForeclosureListingsView({super.key});

  @override
  State<RmaForeclosureListingsView> createState() => _RmaForeclosureListingsViewState();
}

class _RmaForeclosureListingsViewState extends State<RmaForeclosureListingsView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedPriceRange = "all";
  String selectedPropertyType = "all";
  String sortBy = "price_low";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pre-Foreclosure", "value": "pre"},
    {"label": "Auction", "value": "auction"},
    {"label": "Bank Owned", "value": "reo"},
    {"label": "Short Sale", "value": "short"},
  ];

  List<Map<String, dynamic>> priceRangeOptions = [
    {"label": "All Prices", "value": "all"},
    {"label": "Under \$100K", "value": "under_100k"},
    {"label": "\$100K - \$300K", "value": "100k_300k"},
    {"label": "\$300K - \$500K", "value": "300k_500k"},
    {"label": "Over \$500K", "value": "over_500k"},
  ];

  List<Map<String, dynamic>> propertyTypeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Single Family", "value": "single"},
    {"label": "Multi Family", "value": "multi"},
    {"label": "Condo", "value": "condo"},
    {"label": "Townhouse", "value": "townhouse"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Price: Low to High", "value": "price_low"},
    {"label": "Price: High to Low", "value": "price_high"},
    {"label": "Date Added", "value": "date_added"},
    {"label": "Auction Date", "value": "auction_date"},
  ];

  List<Map<String, dynamic>> foreclosureListings = [
    {
      "id": "FC001",
      "address": "1234 Maple Street",
      "city": "Springfield",
      "state": "CA",
      "zip": "90210",
      "price": 285000,
      "estimated_value": 425000,
      "bedrooms": 3,
      "bathrooms": 2,
      "sqft": 1850,
      "lot_size": 0.25,
      "property_type": "Single Family",
      "status": "pre",
      "status_label": "Pre-Foreclosure",
      "auction_date": "2024-07-15",
      "days_remaining": 45,
      "default_amount": 285000,
      "images": ["https://picsum.photos/300/200?random=1", "https://picsum.photos/300/200?random=2"],
      "description": "Beautiful 3-bedroom home in desirable neighborhood. Needs minor repairs.",
      "agent": "Sarah Johnson",
      "agent_phone": "(555) 123-4567",
      "added_date": "2024-06-01",
      "equity": 140000,
      "investment_score": 8.5
    },
    {
      "id": "FC002",
      "address": "5678 Oak Avenue",
      "city": "Riverside",
      "state": "CA",
      "zip": "92501",
      "price": 175000,
      "estimated_value": 290000,
      "bedrooms": 2,
      "bathrooms": 2,
      "sqft": 1200,
      "lot_size": 0.18,
      "property_type": "Condo",
      "status": "auction",
      "status_label": "Auction",
      "auction_date": "2024-06-25",
      "days_remaining": 15,
      "default_amount": 175000,
      "images": ["https://picsum.photos/300/200?random=3", "https://picsum.photos/300/200?random=4"],
      "description": "Well-maintained condo with modern amenities. Great investment opportunity.",
      "agent": "Mike Chen",
      "agent_phone": "(555) 987-6543",
      "added_date": "2024-05-20",
      "equity": 115000,
      "investment_score": 9.2
    },
    {
      "id": "FC003",
      "address": "9012 Pine Street",
      "city": "Bakersfield",
      "state": "CA",
      "zip": "93301",
      "price": 95000,
      "estimated_value": 165000,
      "bedrooms": 4,
      "bathrooms": 2,
      "sqft": 2100,
      "property_type": "Single Family",
      "status": "reo",
      "status_label": "Bank Owned",
      "auction_date": null,
      "days_remaining": null,
      "default_amount": 95000,
      "images": ["https://picsum.photos/300/200?random=5", "https://picsum.photos/300/200?random=6"],
      "description": "Spacious 4-bedroom home with potential. Needs renovation but great bones.",
      "agent": "Lisa Rodriguez",
      "agent_phone": "(555) 246-8135",
      "added_date": "2024-05-10",
      "equity": 70000,
      "investment_score": 7.8
    },
    {
      "id": "FC004",
      "address": "3456 Cedar Lane",
      "city": "Fresno",
      "state": "CA",
      "zip": "93720",
      "price": 320000,
      "estimated_value": 485000,
      "bedrooms": 5,
      "bathrooms": 3,
      "sqft": 2850,
      "lot_size": 0.35,
      "property_type": "Single Family",
      "status": "short",
      "status_label": "Short Sale",
      "auction_date": null,
      "days_remaining": null,
      "default_amount": 320000,
      "images": ["https://picsum.photos/300/200?random=7", "https://picsum.photos/300/200?random=8"],
      "description": "Large family home in prime location. Seller motivated, bank approved price.",
      "agent": "David Wilson",
      "agent_phone": "(555) 369-2580",
      "added_date": "2024-06-10",
      "equity": 165000,
      "investment_score": 8.9
    },
  ];

  List<Map<String, dynamic>> get filteredListings {
    return foreclosureListings.where((listing) {
      if (searchQuery.isNotEmpty && 
          !listing["address"].toString().toLowerCase().contains(searchQuery.toLowerCase()) &&
          !listing["city"].toString().toLowerCase().contains(searchQuery.toLowerCase())) {
        return false;
      }
      
      if (selectedStatus != "all" && listing["status"] != selectedStatus) {
        return false;
      }
      
      if (selectedPropertyType != "all" && listing["property_type"] != selectedPropertyType) {
        return false;
      }
      
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Foreclosure Listings"),
        actions: [
          QButton(
            icon: Icons.map,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildStatsBar(),
          Expanded(
            child: _buildListingsGrid(),
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
        spacing: spSm,
        children: [
          Row(
            spacing: spMd,
            children: [
              Expanded(
                child: QTextField(
                  label: "Search address or city",
                  value: searchQuery,
                  hint: "Enter location...",
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
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
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
    );
  }

  Widget _buildStatsBar() {
    int totalListings = filteredListings.length;
    double avgPrice = filteredListings.isEmpty ? 0 : 
        filteredListings.fold(0.0, (sum, item) => sum + (item["price"] as int).toDouble()) / totalListings;
    double avgEquity = filteredListings.isEmpty ? 0 :
        filteredListings.fold(0.0, (sum, item) => sum + (item["equity"] as int).toDouble()) / totalListings;

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
                  "$totalListings Properties",
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
            "Avg Equity: ${avgEquity.currency}",
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

  Widget _buildListingsGrid() {
    if (filteredListings.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
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
        children: filteredListings.map((listing) => _buildListingCard(listing)).toList(),
      ),
    );
  }

  Widget _buildListingCard(Map<String, dynamic> listing) {
    double equityPercent = ((listing["equity"] as int).toDouble() / (listing["estimated_value"] as int).toDouble()) * 100;
    Color statusColor = _getStatusColor(listing["status"]);
    
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
                    image: NetworkImage("${(listing["images"] as List)[0]}"),
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
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${listing["status_label"]}",
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
                        "${(listing["investment_score"] as double).toStringAsFixed(1)}",
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
              if (listing["days_remaining"] != null)
                Positioned(
                  bottom: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${listing["days_remaining"]} days left",
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
                  "${((listing["price"] as int).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${listing["address"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${listing["city"]}, ${listing["state"]} ${listing["zip"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildPropertyDetail(Icons.bed, "${listing["bedrooms"]}"),
                    SizedBox(width: spSm),
                    _buildPropertyDetail(Icons.bathtub, "${listing["bathrooms"]}"),
                    SizedBox(width: spSm),
                    _buildPropertyDetail(Icons.square_foot, "${listing["sqft"]}"),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Est. Value",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${((listing["estimated_value"] as int).toDouble()).currency}",
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
                          "Equity",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${equityPercent.toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                        onPressed: () => _showPropertyDetails(listing),
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "pre":
        return warningColor;
      case "auction":
        return dangerColor;
      case "reo":
        return infoColor;
      case "short":
        return successColor;
      default:
        return primaryColor;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Properties"),
        content: SingleChildScrollView(
          child: Column(
            spacing: spMd,
            children: [
              QDropdownField(
                label: "Price Range",
                items: priceRangeOptions,
                value: selectedPriceRange,
                onChanged: (value, label) {
                  selectedPriceRange = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Property Type",
                items: propertyTypeOptions,
                value: selectedPropertyType,
                onChanged: (value, label) {
                  selectedPropertyType = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Clear",
            size: bs.sm,
            onPressed: () {
              selectedPriceRange = "all";
              selectedPropertyType = "all";
              setState(() {});
              Navigator.pop(context);
            },
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showPropertyDetails(Map<String, dynamic> listing) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${listing["address"]}"),
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
                    image: NetworkImage("${(listing["images"] as List)[0]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                "${listing["description"]}",
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
                          "${((listing["price"] as int).toDouble()).currency}",
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
                          "Est. Value",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${((listing["estimated_value"] as int).toDouble()).currency}",
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
              Text(
                "Agent: ${listing["agent"]} - ${listing["agent_phone"]}",
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
