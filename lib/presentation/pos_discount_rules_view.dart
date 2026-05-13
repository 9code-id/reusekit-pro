import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosDiscountRulesView extends StatefulWidget {
  const PosDiscountRulesView({super.key});

  @override
  State<PosDiscountRulesView> createState() => _PosDiscountRulesViewState();
}

class _PosDiscountRulesViewState extends State<PosDiscountRulesView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedStatus = "all";
  String selectedRuleType = "all";

  List<Map<String, dynamic>> discountRules = [
    {
      "id": "RULE001",
      "name": "Volume Discount - Electronics",
      "description": "10% off when buying 3 or more electronics items",
      "type": "quantity",
      "category": "Electronics",
      "status": "active",
      "condition": "quantity >= 3",
      "discount": {"type": "percentage", "value": 10},
      "priority": 1,
      "stackable": true,
      "validFrom": "2024-01-01",
      "validTo": "2024-12-31",
      "usageCount": 87,
      "createdBy": "John Smith",
      "createdAt": "2024-01-15",
      "lastModified": "2024-06-10"
    },
    {
      "id": "RULE002",
      "name": "Bulk Purchase Discount",
      "description": "Fixed \$50 off for orders above \$500",
      "type": "amount",
      "category": "All Categories",
      "status": "active",
      "condition": "total >= 500",
      "discount": {"type": "fixed", "value": 50},
      "priority": 2,
      "stackable": false,
      "validFrom": "2024-03-01",
      "validTo": "2024-08-31",
      "usageCount": 145,
      "createdBy": "Sarah Johnson",
      "createdAt": "2024-02-20",
      "lastModified": "2024-05-15"
    },
    {
      "id": "RULE003",
      "name": "Category Specific - Clothing",
      "description": "15% off on all clothing items",
      "type": "category",
      "category": "Clothing",
      "status": "scheduled",
      "condition": "category = clothing",
      "discount": {"type": "percentage", "value": 15},
      "priority": 3,
      "stackable": true,
      "validFrom": "2024-07-01",
      "validTo": "2024-09-30",
      "usageCount": 0,
      "createdBy": "Mike Wilson",
      "createdAt": "2024-06-20",
      "lastModified": "2024-06-20"
    },
    {
      "id": "RULE004",
      "name": "First Time Customer",
      "description": "20% discount for new customers",
      "type": "customer",
      "category": "All Categories",
      "status": "active",
      "condition": "customer_type = new",
      "discount": {"type": "percentage", "value": 20},
      "priority": 1,
      "stackable": false,
      "validFrom": "2024-01-01",
      "validTo": "2024-12-31",
      "usageCount": 234,
      "createdBy": "Emily Brown",
      "createdAt": "2024-01-05",
      "lastModified": "2024-03-10"
    },
    {
      "id": "RULE005",
      "name": "Loyalty Member Discount",
      "description": "5% additional discount for VIP members",
      "type": "membership",
      "category": "All Categories",
      "status": "paused",
      "condition": "membership = vip",
      "discount": {"type": "percentage", "value": 5},
      "priority": 4,
      "stackable": true,
      "validFrom": "2024-02-01",
      "validTo": "2024-12-31",
      "usageCount": 67,
      "createdBy": "Alex Davis",
      "createdAt": "2024-01-25",
      "lastModified": "2024-06-05"
    }
  ];

  List<Map<String, dynamic>> get filteredRules {
    return discountRules.where((rule) {
      bool matchesSearch = "${rule["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${rule["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "all" || rule["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "all" || rule["status"] == selectedStatus;
      bool matchesType = selectedRuleType == "all" || rule["type"] == selectedRuleType;
      return matchesSearch && matchesCategory && matchesStatus && matchesType;
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

  String getRuleTypeLabel(String type) {
    switch (type) {
      case "quantity":
        return "Quantity Based";
      case "amount":
        return "Amount Based";
      case "category":
        return "Category Based";
      case "customer":
        return "Customer Based";
      case "membership":
        return "Membership Based";
      default:
        return type;
    }
  }

  Widget _buildRuleCard(Map<String, dynamic> rule) {
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
                      "${rule["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${rule["id"]}",
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
                  color: getStatusColor(rule["status"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${rule["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: getStatusColor(rule["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${rule["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          
          // Rule details
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.rule,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      getRuleTypeLabel(rule["type"]),
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Priority: ${rule["priority"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "Condition: ${rule["condition"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Discount: ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      rule["discount"]["type"] == "percentage" 
                          ? "${rule["discount"]["value"]}%" 
                          : "\$${rule["discount"]["value"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Spacer(),
                    if (rule["stackable"] == true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "STACKABLE",
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.category,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${rule["category"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.schedule,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${rule["validFrom"]} - ${rule["validTo"]}",
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
                Icons.analytics,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Used ${rule["usageCount"]} times",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Modified: ${rule["lastModified"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
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
                    // Edit rule logic
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: rule["status"] == "active" ? "Pause" : "Activate",
                  size: bs.sm,
                  onPressed: () {
                    // Toggle rule status
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.copy,
                size: bs.sm,
                onPressed: () {
                  // Duplicate rule
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
                      "${discountRules.where((r) => r["status"] == "active").length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Active Rules",
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
                      "${discountRules.where((r) => r["stackable"] == true).length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Stackable",
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
                      "${discountRules.fold(0, (sum, r) => sum + (r["usageCount"] as int))}",
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
        title: Text("Discount Rules"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new discount rule
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
            
            // Search
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search discount rules...",
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
            
            // Filters
            Row(
              children: [
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
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Rule Type",
                    items: [
                      {"label": "All Types", "value": "all"},
                      {"label": "Quantity Based", "value": "quantity"},
                      {"label": "Amount Based", "value": "amount"},
                      {"label": "Category Based", "value": "category"},
                      {"label": "Customer Based", "value": "customer"},
                      {"label": "Membership Based", "value": "membership"},
                    ],
                    value: selectedRuleType,
                    onChanged: (value, label) {
                      selectedRuleType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            // Rules list
            Text(
              "Discount Rules (${filteredRules.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            if (filteredRules.isEmpty)
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
                      Icons.rule_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No discount rules found",
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
              ...filteredRules.map((rule) => _buildRuleCard(rule)),
          ],
        ),
      ),
    );
  }
}
