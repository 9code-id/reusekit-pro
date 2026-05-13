import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaServiceQuotesView extends StatefulWidget {
  const CmaServiceQuotesView({super.key});

  @override
  State<CmaServiceQuotesView> createState() => _CmaServiceQuotesViewState();
}

class _CmaServiceQuotesViewState extends State<CmaServiceQuotesView> {
  int currentTab = 0;
  String selectedFilter = "All";
  String sortBy = "date";

  List<Map<String, dynamic>> quotes = [
    {
      "id": "QT-001",
      "shopName": "Downtown Auto Repair",
      "shopRating": 4.8,
      "shopAddress": "123 Main St, Downtown",
      "shopPhone": "(555) 123-4567",
      "serviceType": "Brake Repair",
      "vehicleInfo": "2018 Honda Civic",
      "description": "Complete brake pad replacement, rotor resurfacing, brake fluid flush",
      "estimatedCost": 450.00,
      "laborCost": 200.00,
      "partsCost": 185.00,
      "additionalFees": 65.00,
      "totalCost": 450.00,
      "estimatedDuration": "4-5 hours",
      "warranty": "12 months / 12,000 miles",
      "status": "Active",
      "validUntil": "2024-12-30",
      "dateReceived": "2024-12-15",
      "urgency": "Medium",
      "breakdown": [
        {"item": "Front brake pads", "cost": 85.00},
        {"item": "Rear brake pads", "cost": 75.00},
        {"item": "Brake fluid", "cost": 25.00},
        {"item": "Labor (4 hours)", "cost": 200.00},
        {"item": "Shop fees", "cost": 45.00},
        {"item": "Environmental fee", "cost": 20.00},
      ],
      "notes": "Recommend replacing brake fluid due to contamination. Front rotors are within spec but rear may need attention soon.",
    },
    {
      "id": "QT-002",
      "shopName": "North Side Auto Care",
      "shopRating": 4.6,
      "shopAddress": "456 North Ave, Northside",
      "shopPhone": "(555) 234-5678",
      "serviceType": "Engine Diagnostic",
      "vehicleInfo": "2020 Toyota Camry",
      "description": "Check engine light diagnostic, oxygen sensor replacement",
      "estimatedCost": 285.00,
      "laborCost": 150.00,
      "partsCost": 120.00,
      "additionalFees": 15.00,
      "totalCost": 285.00,
      "estimatedDuration": "2-3 hours",
      "warranty": "6 months / 6,000 miles",
      "status": "Expired",
      "validUntil": "2024-12-10",
      "dateReceived": "2024-12-05",
      "urgency": "High",
      "breakdown": [
        {"item": "Oxygen sensor", "cost": 120.00},
        {"item": "Diagnostic fee", "cost": 50.00},
        {"item": "Labor (2 hours)", "cost": 100.00},
        {"item": "Shop supplies", "cost": 15.00},
      ],
      "notes": "Bank 1 oxygen sensor showing fault code. Recommend addressing soon to prevent catalytic converter damage.",
    },
    {
      "id": "QT-003",
      "shopName": "South End Garage",
      "shopRating": 4.7,
      "shopAddress": "789 South Blvd, Southend",
      "shopPhone": "(555) 345-6789",
      "serviceType": "A/C Service",
      "vehicleInfo": "2019 Ford F-150",
      "description": "A/C system diagnosis, compressor replacement, refrigerant recharge",
      "estimatedCost": 675.00,
      "laborCost": 350.00,
      "partsCost": 280.00,
      "additionalFees": 45.00,
      "totalCost": 675.00,
      "estimatedDuration": "6-8 hours",
      "warranty": "24 months / 24,000 miles",
      "status": "Under Review",
      "validUntil": "2024-12-25",
      "dateReceived": "2024-12-12",
      "urgency": "Low",
      "breakdown": [
        {"item": "A/C compressor", "cost": 240.00},
        {"item": "Refrigerant", "cost": 40.00},
        {"item": "Labor (7 hours)", "cost": 350.00},
        {"item": "System flush", "cost": 30.00},
        {"item": "Environmental fees", "cost": 15.00},
      ],
      "notes": "Compressor clutch not engaging. System pressure test shows internal damage. Full replacement recommended.",
    },
    {
      "id": "QT-004",
      "shopName": "Express Oil & Lube",
      "shopRating": 4.3,
      "shopAddress": "321 Quick St, Midtown",
      "shopPhone": "(555) 456-7890",
      "serviceType": "Oil Change",
      "vehicleInfo": "2021 Nissan Altima",
      "description": "Full synthetic oil change, filter replacement, multi-point inspection",
      "estimatedCost": 89.99,
      "laborCost": 25.00,
      "partsCost": 55.00,
      "additionalFees": 9.99,
      "totalCost": 89.99,
      "estimatedDuration": "30-45 minutes",
      "warranty": "3 months / 3,000 miles",
      "status": "Accepted",
      "validUntil": "2024-12-20",
      "dateReceived": "2024-12-14",
      "urgency": "Low",
      "breakdown": [
        {"item": "Full synthetic oil (5 qts)", "cost": 45.00},
        {"item": "Oil filter", "cost": 10.00},
        {"item": "Labor", "cost": 25.00},
        {"item": "Shop supplies", "cost": 9.99},
      ],
      "notes": "Includes complimentary 21-point inspection. Next service due in 3 months or 3,000 miles.",
    },
  ];

  List<Map<String, dynamic>> filters = [
    {"label": "All Quotes", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Under Review", "value": "Under Review"},
    {"label": "Accepted", "value": "Accepted"},
    {"label": "Expired", "value": "Expired"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Date Received", "value": "date"},
    {"label": "Price (Low to High)", "value": "price_asc"},
    {"label": "Price (High to Low)", "value": "price_desc"},
    {"label": "Shop Rating", "value": "rating"},
    {"label": "Urgency", "value": "urgency"},
  ];

  List<Map<String, dynamic>> get filteredQuotes {
    List<Map<String, dynamic>> filtered = quotes;
    
    if (selectedFilter != "All") {
      filtered = filtered.where((quote) => quote["status"] == selectedFilter).toList();
    }
    
    // Sort quotes
    switch (sortBy) {
      case "price_asc":
        filtered.sort((a, b) => (a["totalCost"] as double).compareTo(b["totalCost"] as double));
        break;
      case "price_desc":
        filtered.sort((a, b) => (b["totalCost"] as double).compareTo(a["totalCost"] as double));
        break;
      case "rating":
        filtered.sort((a, b) => (b["shopRating"] as double).compareTo(a["shopRating"] as double));
        break;
      case "urgency":
        filtered.sort((a, b) {
          Map<String, int> urgencyOrder = {"High": 3, "Medium": 2, "Low": 1};
          return (urgencyOrder[b["urgency"]] ?? 0).compareTo(urgencyOrder[a["urgency"]] ?? 0);
        });
        break;
      default: // date
        filtered.sort((a, b) => b["dateReceived"].compareTo(a["dateReceived"]));
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Service Quotes",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Quotes", icon: Icon(Icons.receipt_long)),
        Tab(text: "Compare", icon: Icon(Icons.compare)),
        Tab(text: "Saved", icon: Icon(Icons.bookmark)),
      ],
      tabChildren: [
        _buildAllQuotesTab(),
        _buildCompareTab(),
        _buildSavedTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildAllQuotesTab() {
    return Column(
      children: [
        // Filters and Sort
        Container(
          padding: EdgeInsets.all(spMd),
          color: Colors.grey.shade50,
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Filter by Status",
                      items: filters,
                      value: selectedFilter,
                      onChanged: (value, label) {
                        selectedFilter = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Sort by",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${filteredQuotes.length} quotes found",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (filteredQuotes.isNotEmpty)
                    Text(
                      "Total range: \$${filteredQuotes.map((q) => q["totalCost"] as double).reduce((a, b) => a < b ? a : b).toStringAsFixed(2)} - \$${filteredQuotes.map((q) => q["totalCost"] as double).reduce((a, b) => a > b ? a : b).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),

        // Quotes List
        Expanded(
          child: filteredQuotes.isEmpty
              ? Center(
                  child: Column(
                    spacing: spMd,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long,
                        size: 80,
                        color: disabledBoldColor,
                      ),
                      Text(
                        "No quotes found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Try adjusting your filters",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(spMd),
                  itemCount: filteredQuotes.length,
                  itemBuilder: (context, index) {
                    final quote = filteredQuotes[index];
                    return _buildQuoteCard(quote);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildQuoteCard(Map<String, dynamic> quote) {
    Color statusColor = _getStatusColor(quote["status"] as String);
    Color urgencyColor = _getUrgencyColor(quote["urgency"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${quote["id"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: urgencyColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${quote["urgency"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: urgencyColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${quote["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Shop Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${quote["shopName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${quote["shopRating"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${quote["shopAddress"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
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

          // Service Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${quote["serviceType"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${quote["vehicleInfo"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${quote["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Cost Breakdown
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Labor: \$${(quote["laborCost"] as double).toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Parts: \$${(quote["partsCost"] as double).toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Fees: \$${(quote["additionalFees"] as double).toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Total Cost",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${(quote["totalCost"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Additional Info
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${quote["estimatedDuration"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.shield, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${quote["warranty"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Text(
                "Valid until: ${quote["validUntil"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Received: ${quote["dateReceived"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _showQuoteDetails(quote),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () => _contactShop(quote),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.compare,
                size: bs.sm,
                onPressed: () => _addToCompare(quote),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.bookmark_border,
                size: bs.sm,
                onPressed: () => _saveQuote(quote),
              ),
            ],
          ),

          if (quote["status"] == "Active")
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Accept Quote",
                    size: bs.sm,
                    onPressed: () => _acceptQuote(quote),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Decline",
                    size: bs.sm,
                    onPressed: () => _declineQuote(quote),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCompareTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Compare Quotes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Quote Comparison",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Select quotes from the 'All Quotes' tab to compare them side by side. You can compare up to 3 quotes at once.",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Comparison Table (placeholder)
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Center(
              child: Column(
                spacing: spMd,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.compare,
                    size: 80,
                    color: disabledBoldColor,
                  ),
                  Text(
                    "No quotes selected for comparison",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Go to 'All Quotes' and tap the compare icon",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  QButton(
                    label: "View All Quotes",
                    size: bs.sm,
                    onPressed: () {
                      currentTab = 0;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Saved Quotes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Center(
            child: Column(
              spacing: spMd,
              children: [
                SizedBox(height: 100),
                Icon(
                  Icons.bookmark_border,
                  size: 80,
                  color: disabledBoldColor,
                ),
                Text(
                  "No saved quotes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Save quotes for quick access later",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                QButton(
                  label: "Browse Quotes",
                  size: bs.sm,
                  onPressed: () {
                    currentTab = 0;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Under Review":
        return warningColor;
      case "Accepted":
        return primaryColor;
      case "Expired":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showQuoteDetails(Map<String, dynamic> quote) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quote Details - ${quote["id"]}"),
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${quote["shopName"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text("Service: ${quote["serviceType"]}"),
                Text("Vehicle: ${quote["vehicleInfo"]}"),
                Text("Status: ${quote["status"]}"),
                SizedBox(height: spSm),
                Text(
                  "Cost Breakdown:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...(quote["breakdown"] as List).map((item) => Padding(
                  padding: EdgeInsets.only(left: spSm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${item["item"]}"),
                      Text("\$${(item["cost"] as double).toStringAsFixed(2)}"),
                    ],
                  ),
                )),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$${(quote["totalCost"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                if (quote["notes"] != null && (quote["notes"] as String).isNotEmpty) ...[
                  Text(
                    "Notes:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${quote["notes"]}"),
                ],
              ],
            ),
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _contactShop(Map<String, dynamic> quote) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Contact Shop"),
        content: Text("Contact ${quote["shopName"]} about quote ${quote["id"]}?"),
        actions: [
          QButton(
            label: "Call ${quote["shopPhone"]}",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              si("Calling ${quote["shopPhone"]}");
            },
          ),
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _addToCompare(Map<String, dynamic> quote) {
    si("Added ${quote["id"]} to comparison");
  }

  void _saveQuote(Map<String, dynamic> quote) {
    ss("Quote ${quote["id"]} saved successfully");
  }

  void _acceptQuote(Map<String, dynamic> quote) async {
    bool isConfirmed = await confirm("Accept quote ${quote["id"]} from ${quote["shopName"]}?");
    if (isConfirmed) {
      ss("Quote accepted! Shop will be notified.");
      quote["status"] = "Accepted";
      setState(() {});
    }
  }

  void _declineQuote(Map<String, dynamic> quote) async {
    bool isConfirmed = await confirm("Decline quote ${quote["id"]}?");
    if (isConfirmed) {
      se("Quote declined");
      quote["status"] = "Declined";
      setState(() {});
    }
  }
}
