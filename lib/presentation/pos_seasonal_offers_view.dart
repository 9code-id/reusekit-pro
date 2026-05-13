import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosSeasonalOffersView extends StatefulWidget {
  const PosSeasonalOffersView({super.key});

  @override
  State<PosSeasonalOffersView> createState() => _PosSeasonalOffersViewState();
}

class _PosSeasonalOffersViewState extends State<PosSeasonalOffersView> {
  String searchQuery = "";
  String selectedSeason = "all";
  String selectedStatus = "all";
  int currentTab = 0;

  List<Map<String, dynamic>> seasonalOffers = [
    {
      "id": "SEASON001",
      "title": "Summer Beach Collection",
      "description": "25% off on all beachwear and summer accessories",
      "season": "Summer",
      "theme": "Beach & Sun",
      "status": "active",
      "discount": {"type": "percentage", "value": 25},
      "bannerImage": "https://picsum.photos/800/400?random=1&keyword=summer",
      "validFrom": "2024-06-01",
      "validTo": "2024-08-31",
      "targetAudience": "All Customers",
      "applicableCategories": ["Swimwear", "Beach Accessories", "Sunglasses", "Summer Clothing"],
      "excludedItems": ["Designer Sunglasses", "Premium Swimwear"],
      "minAmount": 50,
      "maxDiscount": 150,
      "usageCount": 567,
      "revenueGenerated": 45600,
      "expectedRevenue": 75000,
      "locations": ["Beach Store", "Main Store", "Online"],
      "marketingChannels": ["Social Media", "Email", "In-Store Display"],
      "createdBy": "Marketing Team",
      "createdAt": "2024-05-10",
      "lastModified": "2024-06-15"
    },
    {
      "id": "SEASON002",
      "title": "Back to School Special",
      "description": "20% off on school supplies and study materials",
      "season": "Fall",
      "theme": "Education & Learning",
      "status": "scheduled",
      "discount": {"type": "percentage", "value": 20},
      "bannerImage": "https://picsum.photos/800/400?random=2&keyword=school",
      "validFrom": "2024-08-15",
      "validTo": "2024-09-30",
      "targetAudience": "Students & Parents",
      "applicableCategories": ["Stationery", "Backpacks", "Electronics", "Books"],
      "excludedItems": ["Luxury Pens", "Gaming Laptops"],
      "minAmount": 30,
      "maxDiscount": 100,
      "usageCount": 0,
      "revenueGenerated": 0,
      "expectedRevenue": 25000,
      "locations": ["Education Store", "Online"],
      "marketingChannels": ["School Partnerships", "Parent Groups", "Online Ads"],
      "createdBy": "Education Sales Team",
      "createdAt": "2024-07-01",
      "lastModified": "2024-07-01"
    },
    {
      "id": "SEASON003",
      "title": "Winter Wonderland Sale",
      "description": "30% off on winter clothing and holiday decorations",
      "season": "Winter",
      "theme": "Holiday & Warmth",
      "status": "active",
      "discount": {"type": "percentage", "value": 30},
      "bannerImage": "https://picsum.photos/800/400?random=3&keyword=winter",
      "validFrom": "2024-12-01",
      "validTo": "2024-12-31",
      "targetAudience": "Holiday Shoppers",
      "applicableCategories": ["Winter Clothing", "Holiday Decorations", "Gifts", "Warm Accessories"],
      "excludedItems": [],
      "minAmount": 75,
      "maxDiscount": 200,
      "usageCount": 234,
      "revenueGenerated": 32100,
      "expectedRevenue": 85000,
      "locations": ["All Stores", "Online", "Pop-up Shops"],
      "marketingChannels": ["TV Ads", "Social Media", "Email Campaign", "Influencer Marketing"],
      "createdBy": "Holiday Marketing Team",
      "createdAt": "2024-11-01",
      "lastModified": "2024-12-10"
    },
    {
      "id": "SEASON004",
      "title": "Spring Fresh Start",
      "description": "Buy 2 get 1 free on home cleaning and organization products",
      "season": "Spring",
      "theme": "Cleaning & Organization",
      "status": "expired",
      "discount": {"type": "bogo", "value": 0},
      "bannerImage": "https://picsum.photos/800/400?random=4&keyword=spring",
      "validFrom": "2024-03-01",
      "validTo": "2024-05-31",
      "targetAudience": "Homeowners",
      "applicableCategories": ["Cleaning Supplies", "Organization", "Home Improvement"],
      "excludedItems": ["Professional Equipment"],
      "minAmount": 40,
      "maxDiscount": 80,
      "usageCount": 456,
      "revenueGenerated": 18900,
      "expectedRevenue": 35000,
      "locations": ["Home Store", "Online"],
      "marketingChannels": ["Home & Garden Magazine", "Local Radio", "Social Media"],
      "createdBy": "Home Products Team",
      "createdAt": "2024-02-10",
      "lastModified": "2024-05-31"
    },
    {
      "id": "SEASON005",
      "title": "Halloween Spooktacular",
      "description": "Fixed \$15 off on Halloween costumes and decorations",
      "season": "Fall",
      "theme": "Halloween & Spooky",
      "status": "paused",
      "discount": {"type": "fixed", "value": 15},
      "bannerImage": "https://picsum.photos/800/400?random=5&keyword=halloween",
      "validFrom": "2024-10-01",
      "validTo": "2024-10-31",
      "targetAudience": "Families & Party Planners",
      "applicableCategories": ["Costumes", "Halloween Decorations", "Party Supplies"],
      "excludedItems": ["Professional Costumes"],
      "minAmount": 50,
      "maxDiscount": 15,
      "usageCount": 89,
      "revenueGenerated": 3400,
      "expectedRevenue": 15000,
      "locations": ["Seasonal Store", "Pop-up Shops"],
      "marketingChannels": ["Social Media", "Local Events", "School Partnerships"],
      "createdBy": "Seasonal Events Team",
      "createdAt": "2024-09-01",
      "lastModified": "2024-10-15"
    }
  ];

  List<Map<String, dynamic>> get filteredOffers {
    return seasonalOffers.where((offer) {
      bool matchesSearch = "${offer["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${offer["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${offer["theme"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesSeason = selectedSeason == "all" || offer["season"] == selectedSeason;
      bool matchesStatus = selectedStatus == "all" || offer["status"] == selectedStatus;
      return matchesSearch && matchesSeason && matchesStatus;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "scheduled":
        return infoColor;
      case "paused":
        return warningColor;
      case "expired":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getSeasonColor(String season) {
    switch (season) {
      case "Spring":
        return Colors.green;
      case "Summer":
        return Colors.orange;
      case "Fall":
        return Colors.brown;
      case "Winter":
        return Colors.blue;
      default:
        return primaryColor;
    }
  }

  String getDiscountText(Map<String, dynamic> discount) {
    switch (discount["type"]) {
      case "percentage":
        return "${discount["value"]}% OFF";
      case "fixed":
        return "\$${discount["value"]} OFF";
      case "bogo":
        return "BUY 2 GET 1 FREE";
      default:
        return "SPECIAL OFFER";
    }
  }

  Widget _buildOfferCard(Map<String, dynamic> offer) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner image
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
              image: DecorationImage(
                image: NetworkImage("${offer["bannerImage"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  topRight: Radius.circular(radiusMd),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withAlpha(100),
                    Colors.transparent,
                    Colors.black.withAlpha(150),
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: getSeasonColor(offer["season"]),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${offer["season"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: getStatusColor(offer["status"]),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${offer["status"]}".toUpperCase(),
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
                  Spacer(),
                  // Discount badge
                  Container(
                    margin: EdgeInsets.all(spSm),
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      getDiscountText(offer["discount"]),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${offer["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${offer["theme"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: getSeasonColor(offer["season"]),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${offer["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                // Target audience
                Row(
                  children: [
                    Icon(
                      Icons.group,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${offer["targetAudience"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Validity period
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${offer["validFrom"]} - ${offer["validTo"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                // Performance metrics
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Usage",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${offer["usageCount"]}",
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
                                  "Revenue",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((offer["revenueGenerated"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
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
                                  "Target",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((offer["expectedRevenue"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (offer["revenueGenerated"] as int) / (offer["expectedRevenue"] as int),
                          child: Container(
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                // Conditions
                Row(
                  children: [
                    Text(
                      "Min Amount: \$${offer["minAmount"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Max Discount: \$${offer["maxDiscount"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                // Locations
                Text(
                  "Locations: ${(offer["locations"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                
                // Marketing channels
                Text(
                  "Marketing: ${(offer["marketingChannels"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                // Actions
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Edit",
                        size: bs.sm,
                        onPressed: () {
                          // Edit offer logic
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: offer["status"] == "active" ? "Pause" : "Activate",
                        size: bs.sm,
                        onPressed: () {
                          // Toggle offer status
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.analytics,
                      size: bs.sm,
                      onPressed: () {
                        // View analytics
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        // Show more options
                      },
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

  Widget _buildStatsCard() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${seasonalOffers.where((o) => o["status"] == "active").length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Active Offers",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: disabledColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${seasonalOffers.fold(0, (sum, o) => sum + (o["usageCount"] as int))}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Usage",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: disabledColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${((seasonalOffers.fold(0, (sum, o) => sum + (o["revenueGenerated"] as int))).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Revenue",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seasonal Offers"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new seasonal offer
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCard(),
            
            // Search and filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search seasonal offers...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Season",
                    items: [
                      {"label": "All Seasons", "value": "all"},
                      {"label": "Spring", "value": "Spring"},
                      {"label": "Summer", "value": "Summer"},
                      {"label": "Fall", "value": "Fall"},
                      {"label": "Winter", "value": "Winter"},
                    ],
                    value: selectedSeason,
                    onChanged: (value, label) {
                      selectedSeason = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Active", "value": "active"},
                      {"label": "Scheduled", "value": "scheduled"},
                      {"label": "Paused", "value": "paused"},
                      {"label": "Expired", "value": "expired"},
                    ],
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            // Offers list
            Text(
              "Seasonal Offers (${filteredOffers.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            if (filteredOffers.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No seasonal offers found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredOffers.map((offer) => _buildOfferCard(offer)),
          ],
        ),
      ),
    );
  }
}
