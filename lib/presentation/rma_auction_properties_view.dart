import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaAuctionPropertiesView extends StatefulWidget {
  const RmaAuctionPropertiesView({super.key});

  @override
  State<RmaAuctionPropertiesView> createState() => _RmaAuctionPropertiesViewState();
}

class _RmaAuctionPropertiesViewState extends State<RmaAuctionPropertiesView> {
  String searchQuery = "";
  String selectedAuctionType = "all";
  String selectedTimeframe = "upcoming";
  String selectedPriceRange = "all";
  int currentTab = 0;

  List<Map<String, dynamic>> auctionTypeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Online Auction", "value": "online"},
    {"label": "Live Auction", "value": "live"},
    {"label": "Sealed Bid", "value": "sealed"},
    {"label": "Trustee Sale", "value": "trustee"},
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Upcoming", "value": "upcoming"},
    {"label": "This Week", "value": "this_week"},
    {"label": "Next 30 Days", "value": "next_30"},
    {"label": "Past Auctions", "value": "past"},
  ];

  List<Map<String, dynamic>> priceRangeOptions = [
    {"label": "All Prices", "value": "all"},
    {"label": "Under \$200K", "value": "under_200k"},
    {"label": "\$200K - \$500K", "value": "200k_500k"},
    {"label": "\$500K - \$1M", "value": "500k_1m"},
    {"label": "Over \$1M", "value": "over_1m"},
  ];

  List<Map<String, dynamic>> auctionProperties = [
    {
      "id": "AUC001",
      "address": "2468 Summit Drive",
      "city": "Los Angeles",
      "state": "CA",
      "zip": "90210",
      "starting_bid": 450000,
      "estimated_value": 675000,
      "current_bid": 485000,
      "bid_count": 12,
      "bedrooms": 4,
      "bathrooms": 3,
      "sqft": 2400,
      "lot_size": 0.3,
      "property_type": "Single Family",
      "auction_type": "online",
      "auction_date": "2024-06-28",
      "auction_time": "10:00 AM",
      "days_remaining": 8,
      "reserve_met": false,
      "images": ["https://picsum.photos/300/200?random=10", "https://picsum.photos/300/200?random=11"],
      "description": "Stunning single-family home with mountain views and modern updates.",
      "auctioneer": "Premier Auction House",
      "registration_required": true,
      "deposit_required": 25000,
      "inspection_dates": ["2024-06-25 2:00 PM", "2024-06-26 10:00 AM"],
      "status": "active",
      "investment_rating": 8.7
    },
    {
      "id": "AUC002",
      "address": "1357 Ocean Boulevard",
      "city": "Santa Monica",
      "state": "CA",
      "zip": "90401",
      "starting_bid": 850000,
      "estimated_value": 1200000,
      "current_bid": 920000,
      "bid_count": 18,
      "bedrooms": 5,
      "bathrooms": 4,
      "sqft": 3200,
      "lot_size": 0.25,
      "property_type": "Single Family",
      "auction_type": "live",
      "auction_date": "2024-07-02",
      "auction_time": "2:00 PM",
      "days_remaining": 12,
      "reserve_met": true,
      "images": ["https://picsum.photos/300/200?random=12", "https://picsum.photos/300/200?random=13"],
      "description": "Luxury beachfront property with panoramic ocean views and premium finishes.",
      "auctioneer": "Coastal Auctions",
      "registration_required": true,
      "deposit_required": 50000,
      "inspection_dates": ["2024-06-29 1:00 PM", "2024-06-30 3:00 PM"],
      "status": "active",
      "investment_rating": 9.4
    },
    {
      "id": "AUC003",
      "address": "9876 Valley Road",
      "city": "San Fernando",
      "state": "CA",
      "zip": "91340",
      "starting_bid": 275000,
      "estimated_value": 395000,
      "current_bid": 310000,
      "bid_count": 8,
      "bedrooms": 3,
      "bathrooms": 2,
      "sqft": 1650,
      "lot_size": 0.2,
      "property_type": "Townhouse",
      "auction_type": "sealed",
      "auction_date": "2024-06-30",
      "auction_time": "5:00 PM",
      "days_remaining": 10,
      "reserve_met": false,
      "images": ["https://picsum.photos/300/200?random=14", "https://picsum.photos/300/200?random=15"],
      "description": "Well-maintained townhouse in family-friendly neighborhood. Move-in ready.",
      "auctioneer": "Valley Auction Services",
      "registration_required": false,
      "deposit_required": 15000,
      "inspection_dates": ["2024-06-27 4:00 PM"],
      "status": "active",
      "investment_rating": 7.2
    },
    {
      "id": "AUC004",
      "address": "4321 Highland Avenue",
      "city": "Pasadena",
      "state": "CA",
      "zip": "91101",
      "starting_bid": 620000,
      "estimated_value": 820000,
      "current_bid": 680000,
      "bid_count": 15,
      "bedrooms": 4,
      "bathrooms": 3,
      "sqft": 2800,
      "lot_size": 0.4,
      "property_type": "Single Family",
      "auction_type": "trustee",
      "auction_date": "2024-07-05",
      "auction_time": "11:00 AM",
      "days_remaining": 15,
      "reserve_met": true,
      "images": ["https://picsum.photos/300/200?random=16", "https://picsum.photos/300/200?random=17"],
      "description": "Historic home with original character and modern amenities. Large lot.",
      "auctioneer": "Heritage Auctions",
      "registration_required": true,
      "deposit_required": 35000,
      "inspection_dates": ["2024-07-01 10:00 AM", "2024-07-03 2:00 PM"],
      "status": "active",
      "investment_rating": 8.9
    },
  ];

  List<Map<String, dynamic>> get filteredProperties {
    return auctionProperties.where((property) {
      if (searchQuery.isNotEmpty && 
          !property["address"].toString().toLowerCase().contains(searchQuery.toLowerCase()) &&
          !property["city"].toString().toLowerCase().contains(searchQuery.toLowerCase())) {
        return false;
      }
      
      if (selectedAuctionType != "all" && property["auction_type"] != selectedAuctionType) {
        return false;
      }
      
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Auction Properties",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Active", icon: Icon(Icons.gavel)),
        Tab(text: "Watchlist", icon: Icon(Icons.favorite)),
        Tab(text: "Results", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildActiveTab(),
        _buildWatchlistTab(),
        _buildResultsTab(),
      ],
    );
  }

  Widget _buildActiveTab() {
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

  Widget _buildWatchlistTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildWatchlistSummary(),
          _buildWatchlistItems(),
        ],
      ),
    );
  }

  Widget _buildResultsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildResultsSummary(),
          _buildRecentResults(),
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
                  hint: "Address, city, or auction ID",
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
                  label: "Auction Type",
                  items: auctionTypeOptions,
                  value: selectedAuctionType,
                  onChanged: (value, label) {
                    selectedAuctionType = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Timeframe",
                  items: timeframeOptions,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
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
    int totalProperties = filteredProperties.length;
    double avgCurrentBid = filteredProperties.isEmpty ? 0 : 
        filteredProperties.fold(0.0, (sum, item) => sum + (item["current_bid"] as int).toDouble()) / totalProperties;
    int totalBids = filteredProperties.fold(0, (sum, item) => sum + (item["bid_count"] as int));

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
                  "$totalProperties Active Auctions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Bids: $totalBids",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Avg Bid: ${avgCurrentBid.currency}",
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
              Icons.gavel,
              size: 64,
              color: disabledBoldColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No Active Auctions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Check back soon for new auction listings",
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
        children: filteredProperties.map((property) => _buildAuctionCard(property)).toList(),
      ),
    );
  }

  Widget _buildAuctionCard(Map<String, dynamic> property) {
    Color auctionTypeColor = _getAuctionTypeColor(property["auction_type"]);
    double potentialEquity = (property["estimated_value"] as int).toDouble() - (property["current_bid"] as int).toDouble();
    bool isUrgent = (property["days_remaining"] as int) <= 3;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isUrgent ? Border.all(color: dangerColor, width: 2) : null,
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
                    color: auctionTypeColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${property["auction_type"].toString().toUpperCase()}",
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
                    color: isUrgent ? dangerColor : warningColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${property["days_remaining"]} days left",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (property["reserve_met"] == true)
                Positioned(
                  bottom: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "RESERVE MET",
                      style: TextStyle(
                        fontSize: 8,
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
                        "Current Bid",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Text(
                      "${property["bid_count"]} bids",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${((property["current_bid"] as int).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${property["address"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
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
                    _buildPropertyDetail(Icons.bed, "${property["bedrooms"]}"),
                    SizedBox(width: spSm),
                    _buildPropertyDetail(Icons.bathtub, "${property["bathrooms"]}"),
                    SizedBox(width: spSm),
                    _buildPropertyDetail(Icons.square_foot, "${property["sqft"]}"),
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
                            "${((property["estimated_value"] as int).toDouble()).currency}",
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
                          "Potential Equity",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${potentialEquity.currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: potentialEquity > 0 ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${property["auction_date"]} at ${property["auction_time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Place Bid",
                        size: bs.sm,
                        onPressed: () => _showBidDialog(property),
                      ),
                    ),
                    QButton(
                      icon: Icons.favorite_border,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    QButton(
                      icon: Icons.info_outline,
                      size: bs.sm,
                      onPressed: () => _showPropertyDetails(property),
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

  Color _getAuctionTypeColor(String type) {
    switch (type) {
      case "online":
        return primaryColor;
      case "live":
        return dangerColor;
      case "sealed":
        return warningColor;
      case "trustee":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildWatchlistSummary() {
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
            "Watchlist Summary",
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
                child: _buildWatchlistStat("Properties Watched", "12", Icons.favorite),
              ),
              Expanded(
                child: _buildWatchlistStat("Ending Soon", "3", Icons.timer),
              ),
              Expanded(
                child: _buildWatchlistStat("New Bids", "5", Icons.notifications),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWatchlistStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 24,
        ),
        SizedBox(height: spSm),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
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

  Widget _buildWatchlistItems() {
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
            "Watched Properties",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 48,
                  color: primaryColor.withAlpha(60),
                ),
                SizedBox(height: spSm),
                Text(
                  "Your Watchlist is Empty",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Add properties to track their auction progress",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSummary() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildResultsCard("Auctions Won", "3", "\$1.2M", successColor),
        _buildResultsCard("Auctions Lost", "8", "\$2.1M", dangerColor),
        _buildResultsCard("Success Rate", "27%", "11 total", infoColor),
        _buildResultsCard("Avg Savings", "15%", "Below market", warningColor),
      ],
    );
  }

  Widget _buildResultsCard(String title, String value, String subtitle, Color color) {
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
                  Icons.gavel,
                  color: color,
                  size: 20,
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
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentResults() {
    List<Map<String, dynamic>> recentResults = [
      {"address": "123 Oak Street", "final_bid": 325000, "status": "won", "date": "2024-06-01"},
      {"address": "456 Pine Avenue", "final_bid": 485000, "status": "lost", "date": "2024-05-28"},
      {"address": "789 Elm Drive", "final_bid": 210000, "status": "won", "date": "2024-05-20"},
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
            "Recent Results",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          ...recentResults.map((result) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: (result["status"] == "won" ? successColor : dangerColor).withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: result["status"] == "won" ? successColor : dangerColor,
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
                        "${result["address"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Final Bid: ${((result["final_bid"] as int).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: (result["status"] == "won" ? successColor : dangerColor).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${result["status"].toString().toUpperCase()}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: result["status"] == "won" ? successColor : dangerColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  void _showBidDialog(Map<String, dynamic> property) {
    String bidAmount = "";
    int minBid = (property["current_bid"] as int) + 5000;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Place Bid"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${property["address"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Current Bid: ${((property["current_bid"] as int).toDouble()).currency}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Minimum Bid: ${minBid.toDouble().currency}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: warningColor,
              ),
            ),
            SizedBox(height: spMd),
            QNumberField(
              label: "Your Bid (\$)",
              value: bidAmount,
              onChanged: (value) {
                bidAmount = value;
              },
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Place Bid",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Bid placed successfully!");
            },
          ),
        ],
      ),
    );
  }

  void _showPropertyDetails(Map<String, dynamic> property) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${property["address"]}"),
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
                          "Current Bid",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${((property["current_bid"] as int).toDouble()).currency}",
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
                          "${((property["estimated_value"] as int).toDouble()).currency}",
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
                "Auctioneer: ${property["auctioneer"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (property["registration_required"] == true)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Registration required - Deposit: ${((property["deposit_required"] as int).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Add to Watchlist",
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
