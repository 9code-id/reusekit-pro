import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosPromotionsView extends StatefulWidget {
  const PosPromotionsView({super.key});

  @override
  State<PosPromotionsView> createState() => _PosPromotionsViewState();
}

class _PosPromotionsViewState extends State<PosPromotionsView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  int currentTab = 0;

  List<Map<String, dynamic>> promotions = [
    {
      "id": "PROMO001",
      "title": "Summer Sale 2024",
      "description": "Get 30% off on all summer items",
      "type": "percentage",
      "value": 30,
      "status": "active",
      "startDate": "2024-06-01",
      "endDate": "2024-08-31",
      "usageCount": 145,
      "usageLimit": 500,
      "conditions": "Minimum purchase \$50",
      "applicableItems": "Summer Collection",
      "createdBy": "John Doe",
      "createdAt": "2024-05-15"
    },
    {
      "id": "PROMO002",
      "title": "Buy 2 Get 1 Free",
      "description": "Special offer on electronics",
      "type": "bogo",
      "value": 0,
      "status": "active",
      "startDate": "2024-06-15",
      "endDate": "2024-07-15",
      "usageCount": 89,
      "usageLimit": 200,
      "conditions": "Electronics category only",
      "applicableItems": "Electronics",
      "createdBy": "Sarah Wilson",
      "createdAt": "2024-06-10"
    },
    {
      "id": "PROMO003",
      "title": "Fixed \$20 Off",
      "description": "Flat discount on orders above \$100",
      "type": "fixed",
      "value": 20,
      "status": "scheduled",
      "startDate": "2024-07-01",
      "endDate": "2024-07-31",
      "usageCount": 0,
      "usageLimit": 300,
      "conditions": "Order value > \$100",
      "applicableItems": "All Items",
      "createdBy": "Mike Johnson",
      "createdAt": "2024-06-20"
    },
    {
      "id": "PROMO004",
      "title": "New Customer Welcome",
      "description": "15% off for first-time customers",
      "type": "percentage",
      "value": 15,
      "status": "expired",
      "startDate": "2024-01-01",
      "endDate": "2024-05-31",
      "usageCount": 78,
      "usageLimit": 100,
      "conditions": "First purchase only",
      "applicableItems": "All Items",
      "createdBy": "Emily Davis",
      "createdAt": "2023-12-20"
    },
    {
      "id": "PROMO005",
      "title": "Flash Sale - 50% Off",
      "description": "Limited time flash sale",
      "type": "percentage",
      "value": 50,
      "status": "active",
      "startDate": "2024-06-25",
      "endDate": "2024-06-27",
      "usageCount": 234,
      "usageLimit": 500,
      "conditions": "Valid for 3 days only",
      "applicableItems": "Selected Items",
      "createdBy": "Alex Brown",
      "createdAt": "2024-06-24"
    }
  ];

  List<Map<String, dynamic>> get filteredPromotions {
    return promotions.where((promo) {
      bool matchesSearch = "${promo["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${promo["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "all" || promo["status"] == selectedStatus;
      bool matchesType = selectedType == "all" || promo["type"] == selectedType;
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "scheduled":
        return infoColor;
      case "expired":
        return disabledBoldColor;
      case "paused":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  String getTypeLabel(String type) {
    switch (type) {
      case "percentage":
        return "Percentage";
      case "fixed":
        return "Fixed Amount";
      case "bogo":
        return "BOGO";
      default:
        return type;
    }
  }

  Widget _buildPromotionCard(Map<String, dynamic> promotion) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${promotion["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${promotion["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: getStatusColor(promotion["status"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${promotion["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: getStatusColor(promotion["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${promotion["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.local_offer,
                size: 16,
                color: primaryColor,
              ),
              SizedBox(width: spXs),
              Text(
                getTypeLabel(promotion["type"]),
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: spSm),
              if (promotion["type"] != "bogo") ...[
                Text(
                  promotion["type"] == "percentage" 
                      ? "${promotion["value"]}%" 
                      : "\$${promotion["value"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${promotion["startDate"]} - ${promotion["endDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.people,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Used: ${promotion["usageCount"]}/${promotion["usageLimit"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                width: 100,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (promotion["usageCount"] as int) / (promotion["usageLimit"] as int),
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () {
                    // Edit promotion logic
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: promotion["status"] == "active" ? "Pause" : "Activate",
                  size: bs.sm,
                  onPressed: () {
                    // Toggle promotion status
                  },
                ),
              ),
              SizedBox(width: spSm),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "${promotions.where((p) => p["status"] == "active").length}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Active",
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
                  "${promotions.where((p) => p["status"] == "scheduled").length}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Scheduled",
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
                  "${promotions.fold(0, (sum, p) => sum + (p["usageCount"] as int))}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Uses",
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Promotions"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new promotion
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
                    label: "Search promotions...",
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
                    label: "Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Active", "value": "active"},
                      {"label": "Scheduled", "value": "scheduled"},
                      {"label": "Expired", "value": "expired"},
                      {"label": "Paused", "value": "paused"},
                    ],
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: [
                      {"label": "All Types", "value": "all"},
                      {"label": "Percentage", "value": "percentage"},
                      {"label": "Fixed Amount", "value": "fixed"},
                      {"label": "BOGO", "value": "bogo"},
                    ],
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            // Promotions list
            Text(
              "Promotions (${filteredPromotions.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            if (filteredPromotions.isEmpty)
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
                      Icons.local_offer_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No promotions found",
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
              ...filteredPromotions.map((promotion) => _buildPromotionCard(promotion)),
          ],
        ),
      ),
    );
  }
}
