import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosBulkDiscountsView extends StatefulWidget {
  const PosBulkDiscountsView({super.key});

  @override
  State<PosBulkDiscountsView> createState() => _PosBulkDiscountsViewState();
}

class _PosBulkDiscountsViewState extends State<PosBulkDiscountsView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedStatus = "all";
  String selectedDiscountType = "all";

  List<Map<String, dynamic>> bulkDiscounts = [
    {
      "id": "BULK001",
      "name": "Electronics Bundle Deal",
      "description": "Progressive discount on electronics purchases",
      "category": "Electronics",
      "status": "active",
      "discountType": "progressive",
      "tiers": [
        {"minQuantity": 2, "maxQuantity": 4, "discount": {"type": "percentage", "value": 10}},
        {"minQuantity": 5, "maxQuantity": 9, "discount": {"type": "percentage", "value": 15}},
        {"minQuantity": 10, "maxQuantity": null, "discount": {"type": "percentage", "value": 25}}
      ],
      "applicableItems": ["Smartphones", "Tablets", "Accessories", "Chargers"],
      "excludedItems": ["Premium iPhones", "Gaming Consoles"],
      "minAmount": 100,
      "maxDiscount": 500,
      "validFrom": "2024-06-01",
      "validTo": "2024-12-31",
      "customerRestrictions": "none",
      "locationRestrictions": [],
      "usageCount": 145,
      "totalSavings": 15600,
      "averageOrderValue": 340,
      "createdBy": "Electronics Manager",
      "createdAt": "2024-05-15",
      "lastModified": "2024-06-10"
    },
    {
      "id": "BULK002",
      "name": "Office Supplies Bulk Purchase",
      "description": "Fixed discount tiers for office supply bulk orders",
      "category": "Office Supplies",
      "status": "active",
      "discountType": "tiered",
      "tiers": [
        {"minAmount": 250, "maxAmount": 499, "discount": {"type": "fixed", "value": 25}},
        {"minAmount": 500, "maxAmount": 999, "discount": {"type": "fixed", "value": 75}},
        {"minAmount": 1000, "maxAmount": null, "discount": {"type": "fixed", "value": 150}}
      ],
      "applicableItems": ["Stationery", "Paper", "Ink Cartridges", "Filing Supplies"],
      "excludedItems": ["Furniture", "Electronics"],
      "minAmount": 250,
      "maxDiscount": 150,
      "validFrom": "2024-03-01",
      "validTo": "2024-12-31",
      "customerRestrictions": "business_only",
      "locationRestrictions": ["Business Center", "Warehouse"],
      "usageCount": 78,
      "totalSavings": 8900,
      "averageOrderValue": 650,
      "createdBy": "B2B Sales Team",
      "createdAt": "2024-02-20",
      "lastModified": "2024-05-01"
    },
    {
      "id": "BULK003",
      "name": "Fashion Wholesale Pricing",
      "description": "Volume-based discounts for fashion retailers",
      "category": "Fashion",
      "status": "scheduled",
      "discountType": "volume",
      "tiers": [
        {"minQuantity": 20, "maxQuantity": 49, "discount": {"type": "percentage", "value": 20}},
        {"minQuantity": 50, "maxQuantity": 99, "discount": {"type": "percentage", "value": 30}},
        {"minQuantity": 100, "maxQuantity": null, "discount": {"type": "percentage", "value": 40}}
      ],
      "applicableItems": ["Clothing", "Shoes", "Accessories", "Bags"],
      "excludedItems": ["Designer Items", "Limited Edition"],
      "minAmount": 500,
      "maxDiscount": 2000,
      "validFrom": "2024-07-01",
      "validTo": "2024-09-30",
      "customerRestrictions": "wholesale_only",
      "locationRestrictions": ["Wholesale Center"],
      "usageCount": 0,
      "totalSavings": 0,
      "averageOrderValue": 0,
      "createdBy": "Wholesale Manager",
      "createdAt": "2024-06-15",
      "lastModified": "2024-06-15"
    },
    {
      "id": "BULK004",
      "name": "Restaurant Supply Discount",
      "description": "Bulk discounts for restaurant and catering supplies",
      "category": "Food & Beverage",
      "status": "active",
      "discountType": "mixed",
      "tiers": [
        {"minAmount": 300, "maxAmount": 599, "discount": {"type": "percentage", "value": 12}},
        {"minAmount": 600, "maxAmount": 1199, "discount": {"type": "fixed", "value": 100}},
        {"minAmount": 1200, "maxAmount": null, "discount": {"type": "percentage", "value": 18}}
      ],
      "applicableItems": ["Kitchen Equipment", "Disposables", "Ingredients", "Cleaning Supplies"],
      "excludedItems": ["Alcohol", "Specialty Equipment"],
      "minAmount": 300,
      "maxDiscount": 400,
      "validFrom": "2024-04-01",
      "validTo": "2024-12-31",
      "customerRestrictions": "commercial_only",
      "locationRestrictions": ["Commercial Sales"],
      "usageCount": 234,
      "totalSavings": 28900,
      "averageOrderValue": 890,
      "createdBy": "Commercial Sales Team",
      "createdAt": "2024-03-15",
      "lastModified": "2024-06-01"
    },
    {
      "id": "BULK005",
      "name": "School Supply Bulk Order",
      "description": "Educational institution bulk purchase discounts",
      "category": "Education",
      "status": "paused",
      "discountType": "educational",
      "tiers": [
        {"minQuantity": 50, "maxQuantity": 149, "discount": {"type": "percentage", "value": 15}},
        {"minQuantity": 150, "maxQuantity": 299, "discount": {"type": "percentage", "value": 22}},
        {"minQuantity": 300, "maxQuantity": null, "discount": {"type": "percentage", "value": 30}}
      ],
      "applicableItems": ["Books", "Stationery", "Art Supplies", "Sports Equipment"],
      "excludedItems": ["Electronics", "Furniture"],
      "minAmount": 200,
      "maxDiscount": 1000,
      "validFrom": "2024-01-01",
      "validTo": "2024-12-31",
      "customerRestrictions": "educational_only",
      "locationRestrictions": ["Education Center"],
      "usageCount": 45,
      "totalSavings": 6700,
      "averageOrderValue": 450,
      "createdBy": "Education Sales Team",
      "createdAt": "2024-01-10",
      "lastModified": "2024-05-20"
    }
  ];

  List<Map<String, dynamic>> get filteredDiscounts {
    return bulkDiscounts.where((discount) {
      bool matchesSearch = "${discount["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${discount["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "all" || discount["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "all" || discount["status"] == selectedStatus;
      bool matchesType = selectedDiscountType == "all" || discount["discountType"] == selectedDiscountType;
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

  String getDiscountTypeLabel(String type) {
    switch (type) {
      case "progressive":
        return "Progressive";
      case "tiered":
        return "Tiered";
      case "volume":
        return "Volume";
      case "mixed":
        return "Mixed";
      case "educational":
        return "Educational";
      default:
        return type;
    }
  }

  Widget _buildDiscountCard(Map<String, dynamic> discount) {
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
          // Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.inventory,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${discount["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${discount["id"]} • ${discount["category"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: getStatusColor(discount["status"]).withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${discount["status"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: getStatusColor(discount["status"]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${discount["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                // Discount type badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    getDiscountTypeLabel(discount["discountType"]),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                ),
                SizedBox(height: spSm),
                
                // Discount tiers
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.layers,
                            size: 16,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Discount Tiers",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      ...(discount["tiers"] as List).map((tier) {
                        String condition = "";
                        if (tier["minQuantity"] != null) {
                          condition = tier["maxQuantity"] != null 
                              ? "${tier["minQuantity"]}-${tier["maxQuantity"]} items"
                              : "${tier["minQuantity"]}+ items";
                        } else if (tier["minAmount"] != null) {
                          condition = tier["maxAmount"] != null 
                              ? "\$${tier["minAmount"]}-\$${tier["maxAmount"]}"
                              : "\$${tier["minAmount"]}+";
                        }
                        
                        String discountText = tier["discount"]["type"] == "percentage"
                            ? "${tier["discount"]["value"]}% OFF"
                            : "\$${tier["discount"]["value"]} OFF";
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: successColor.withAlpha(50)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  condition,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  discountText,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                // Performance metrics
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${discount["usageCount"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Orders",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: disabledColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${((discount["totalSavings"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Savings",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: disabledColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              discount["averageOrderValue"] > 0 
                                  ? "\$${((discount["averageOrderValue"] as int).toDouble()).currency}"
                                  : "-",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Avg Order",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                // Restrictions and conditions
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Min: \$${discount["minAmount"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Max Discount: \$${discount["maxDiscount"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                // Customer restrictions
                if (discount["customerRestrictions"] != "none") ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${discount["customerRestrictions"]}".replaceAll("_", " ").toUpperCase(),
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                ],
                
                // Location restrictions
                if ((discount["locationRestrictions"] as List).isNotEmpty) ...[
                  Text(
                    "Locations: ${(discount["locationRestrictions"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                ],
                
                // Validity period
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${discount["validFrom"]} - ${discount["validTo"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
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
                          // Edit bulk discount logic
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: discount["status"] == "active" ? "Pause" : "Activate",
                        size: bs.sm,
                        onPressed: () {
                          // Toggle discount status
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
                      "${bulkDiscounts.where((d) => d["status"] == "active").length}",
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
                      "${bulkDiscounts.fold(0, (sum, d) => sum + (d["usageCount"] as int))}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Orders",
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
                      "\$${((bulkDiscounts.fold(0, (sum, d) => sum + (d["totalSavings"] as int))).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Total Savings",
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
        title: Text("Bulk Discounts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new bulk discount
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
                    label: "Search bulk discounts...",
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
                    label: "Category",
                    items: [
                      {"label": "All Categories", "value": "all"},
                      {"label": "Electronics", "value": "Electronics"},
                      {"label": "Office Supplies", "value": "Office Supplies"},
                      {"label": "Fashion", "value": "Fashion"},
                      {"label": "Food & Beverage", "value": "Food & Beverage"},
                      {"label": "Education", "value": "Education"},
                    ],
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
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
            
            // Bulk discounts list
            Text(
              "Bulk Discounts (${filteredDiscounts.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            if (filteredDiscounts.isEmpty)
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
                      Icons.inventory_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No bulk discounts found",
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
              ...filteredDiscounts.map((discount) => _buildDiscountCard(discount)),
          ],
        ),
      ),
    );
  }
}
