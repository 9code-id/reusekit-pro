import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaDiscountManagementView extends StatefulWidget {
  const FmaDiscountManagementView({super.key});

  @override
  State<FmaDiscountManagementView> createState() => _FmaDiscountManagementViewState();
}

class _FmaDiscountManagementViewState extends State<FmaDiscountManagementView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  bool isCreatingDiscount = false;
  
  // Create Discount Form
  String discountName = "";
  String discountCode = "";
  String discountType = "Percentage";
  String discountValue = "";
  String minimumOrder = "";
  String maxUses = "";
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 30));
  bool isActive = true;
  String description = "";
  List<String> applicableCategories = [];
  
  List<Map<String, dynamic>> discounts = [
    {
      "id": "1",
      "name": "Weekend Special",
      "code": "WEEKEND20",
      "type": "Percentage",
      "value": 20.0,
      "minimumOrder": 25.0,
      "maxUses": 100,
      "currentUses": 45,
      "startDate": "2024-12-15",
      "endDate": "2024-12-31",
      "isActive": true,
      "description": "20% off on weekend orders",
      "applicableCategories": ["Main Course", "Dessert"],
      "createdBy": "Admin",
      "totalSavings": 450.75,
    },
    {
      "id": "2",
      "name": "First Time Customer",
      "code": "WELCOME15",
      "type": "Percentage",
      "value": 15.0,
      "minimumOrder": 15.0,
      "maxUses": 500,
      "currentUses": 234,
      "startDate": "2024-12-01",
      "endDate": "2025-01-31",
      "isActive": true,
      "description": "Welcome discount for new customers",
      "applicableCategories": ["All"],
      "createdBy": "Admin",
      "totalSavings": 876.50,
    },
    {
      "id": "3",
      "name": "Free Delivery",
      "code": "FREEDELIVERY",
      "type": "Fixed Amount",
      "value": 5.0,
      "minimumOrder": 30.0,
      "maxUses": 200,
      "currentUses": 156,
      "startDate": "2024-12-10",
      "endDate": "2024-12-25",
      "isActive": true,
      "description": "Free delivery on orders over \$30",
      "applicableCategories": ["All"],
      "createdBy": "Manager",
      "totalSavings": 780.0,
    },
    {
      "id": "4",
      "name": "Summer Sale",
      "code": "SUMMER25",
      "type": "Percentage",
      "value": 25.0,
      "minimumOrder": 50.0,
      "maxUses": 50,
      "currentUses": 50,
      "startDate": "2024-06-01",
      "endDate": "2024-08-31",
      "isActive": false,
      "description": "Summer season discount",
      "applicableCategories": ["Beverage", "Dessert"],
      "createdBy": "Admin",
      "totalSavings": 1250.00,
    },
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Expired", "value": "Expired"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": "All"},
    {"label": "Percentage", "value": "Percentage"},
    {"label": "Fixed Amount", "value": "Fixed Amount"},
  ];

  List<Map<String, dynamic>> discountTypeItems = [
    {"label": "Percentage", "value": "Percentage"},
    {"label": "Fixed Amount", "value": "Fixed Amount"},
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "All"},
    {"label": "Main Course", "value": "Main Course"},
    {"label": "Appetizer", "value": "Appetizer"},
    {"label": "Dessert", "value": "Dessert"},
    {"label": "Beverage", "value": "Beverage"},
  ];

  List<Map<String, dynamic>> get filteredDiscounts {
    return discounts.where((discount) {
      bool matchesSearch = discount["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          discount["code"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" ||
                          (selectedStatus == "Active" && discount["isActive"] == true) ||
                          (selectedStatus == "Inactive" && discount["isActive"] == false) ||
                          (selectedStatus == "Expired" && DateTime.parse(discount["endDate"]).isBefore(DateTime.now()));
      
      bool matchesType = selectedType == "All" || discount["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  String getDiscountStatus(Map<String, dynamic> discount) {
    if (!discount["isActive"]) return "Inactive";
    if (DateTime.parse(discount["endDate"]).isBefore(DateTime.now())) return "Expired";
    if (DateTime.parse(discount["startDate"]).isAfter(DateTime.now())) return "Scheduled";
    return "Active";
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Active": return successColor;
      case "Inactive": return disabledBoldColor;
      case "Expired": return dangerColor;
      case "Scheduled": return warningColor;
      default: return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discount Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              isCreatingDiscount = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search Discounts",
                    value: searchQuery,
                    hint: "Search by name or code",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusItems,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: typeItems,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Create Discount Form
            if (isCreatingDiscount)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.add_circle, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Create New Discount",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            isCreatingDiscount = false;
                            // Reset form
                            discountName = "";
                            discountCode = "";
                            discountType = "Percentage";
                            discountValue = "";
                            minimumOrder = "";
                            maxUses = "";
                            startDate = DateTime.now();
                            endDate = DateTime.now().add(Duration(days: 30));
                            isActive = true;
                            description = "";
                            applicableCategories = [];
                            setState(() {});
                          },
                          child: Icon(Icons.close, color: disabledBoldColor, size: 20),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Discount Name",
                            value: discountName,
                            validator: Validator.required,
                            onChanged: (value) {
                              discountName = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QTextField(
                            label: "Discount Code",
                            value: discountCode,
                            hint: "e.g., SAVE20",
                            validator: Validator.required,
                            onChanged: (value) {
                              discountCode = value.toUpperCase();
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Discount Type",
                            items: discountTypeItems,
                            value: discountType,
                            onChanged: (value, label) {
                              discountType = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QNumberField(
                            label: discountType == "Percentage" ? "Percentage (%)" : "Amount (\$)",
                            value: discountValue,
                            validator: Validator.required,
                            onChanged: (value) {
                              discountValue = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Minimum Order (\$)",
                            value: minimumOrder,
                            hint: "0 for no minimum",
                            onChanged: (value) {
                              minimumOrder = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QNumberField(
                            label: "Max Uses",
                            value: maxUses,
                            hint: "0 for unlimited",
                            onChanged: (value) {
                              maxUses = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Start Date",
                            value: startDate,
                            onChanged: (value) {
                              startDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDatePicker(
                            label: "End Date",
                            value: endDate,
                            onChanged: (value) {
                              endDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Describe the discount offer",
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Active Discount",
                          "value": true,
                          "checked": isActive,
                        }
                      ],
                      value: [if (isActive) {"label": "Active Discount", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        isActive = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Create Discount",
                            onPressed: () {
                              if (discountName.isNotEmpty && discountCode.isNotEmpty && discountValue.isNotEmpty) {
                                discounts.add({
                                  "id": DateTime.now().millisecondsSinceEpoch.toString(),
                                  "name": discountName,
                                  "code": discountCode,
                                  "type": discountType,
                                  "value": double.tryParse(discountValue) ?? 0.0,
                                  "minimumOrder": double.tryParse(minimumOrder) ?? 0.0,
                                  "maxUses": int.tryParse(maxUses) ?? 0,
                                  "currentUses": 0,
                                  "startDate": startDate.toIso8601String().split('T')[0],
                                  "endDate": endDate.toIso8601String().split('T')[0],
                                  "isActive": isActive,
                                  "description": description,
                                  "applicableCategories": applicableCategories,
                                  "createdBy": "Admin",
                                  "totalSavings": 0.0,
                                });
                                isCreatingDiscount = false;
                                ss("Discount created successfully");
                                setState(() {});
                              }
                            },
                          ),
                        ),
                        QButton(
                          label: "Cancel",
                          color: disabledBoldColor,
                          size: bs.sm,
                          onPressed: () {
                            isCreatingDiscount = false;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Discount Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Discount Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${discounts.where((d) => d["isActive"] == true).length}",
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
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${discounts.fold(0, (sum, d) => sum + (d["currentUses"] as int))}",
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
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "\$${discounts.fold(0.0, (sum, d) => sum + (d["totalSavings"] as double)).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Total Savings",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Discounts List
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_offer, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Discounts (${filteredDiscounts.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...filteredDiscounts.map((discount) {
                    String status = getDiscountStatus(discount);
                    Color statusColor = getStatusColor(status);
                    double usagePercentage = discount["maxUses"] > 0 
                        ? ((discount["currentUses"] as int) / (discount["maxUses"] as int)) * 100 
                        : 0;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: statusColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  Icons.local_offer,
                                  color: statusColor,
                                  size: 18,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${discount["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: statusColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            status,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: statusColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Code: ${discount["code"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (discount["description"].toString().isNotEmpty)
                                      Text(
                                        "${discount["description"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    discount["type"] == "Percentage" 
                                        ? "${(discount["value"] as double).toStringAsFixed(0)}% OFF"
                                        : "\$${(discount["value"] as double).toStringAsFixed(2)} OFF",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                  if (discount["minimumOrder"] > 0)
                                    Text(
                                      "Min: \$${(discount["minimumOrder"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                ],
                              ),
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
                                      "Usage: ${discount["currentUses"]}${discount["maxUses"] > 0 ? '/${discount["maxUses"]}' : ''} (${usagePercentage.toStringAsFixed(0)}%)",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    if (discount["maxUses"] > 0)
                                      Container(
                                        height: 4,
                                        margin: EdgeInsets.only(top: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: (usagePercentage / 100).clamp(0.0, 1.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: usagePercentage > 80 ? dangerColor : primaryColor,
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${DateTime.parse(discount["startDate"]).dMMMy} - ${DateTime.parse(discount["endDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () {
                                  // navigateTo(FmaDiscountEditView(discountId: discount["id"]));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              GestureDetector(
                                onTap: () async {
                                  bool isConfirmed = await confirm("Are you sure you want to delete this discount?");
                                  if (isConfirmed) {
                                    discounts.removeWhere((d) => d["id"] == discount["id"]);
                                    ss("Discount deleted successfully");
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: dangerColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
