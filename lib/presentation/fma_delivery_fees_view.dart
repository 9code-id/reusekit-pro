import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaDeliveryFeesView extends StatefulWidget {
  const FmaDeliveryFeesView({super.key});

  @override
  State<FmaDeliveryFeesView> createState() => _FmaDeliveryFeesViewState();
}

class _FmaDeliveryFeesViewState extends State<FmaDeliveryFeesView> {
  List<Map<String, dynamic>> feeStructures = [
    {
      "id": "FEE001",
      "name": "Standard Delivery",
      "description": "Regular delivery for orders during business hours",
      "type": "Distance Based",
      "status": "Active",
      "base_fee": 2.99,
      "per_km_rate": 0.75,
      "min_order": 15.00,
      "free_delivery_threshold": 50.00,
      "max_distance": 10.0,
      "estimated_time": "30-45 min",
      "peak_hour_multiplier": 1.2,
      "weekend_multiplier": 1.1,
      "zones": ["Zone A", "Zone B"],
      "conditions": [
        "Available 9 AM - 9 PM",
        "Standard processing time",
        "Weather conditions apply",
      ],
    },
    {
      "id": "FEE002",
      "name": "Express Delivery",
      "description": "Fast delivery for urgent orders",
      "type": "Fixed Rate",
      "status": "Active",
      "base_fee": 5.99,
      "per_km_rate": 1.25,
      "min_order": 25.00,
      "free_delivery_threshold": 75.00,
      "max_distance": 8.0,
      "estimated_time": "15-25 min",
      "peak_hour_multiplier": 1.5,
      "weekend_multiplier": 1.3,
      "zones": ["Zone A", "Zone C"],
      "conditions": [
        "Available 10 AM - 8 PM",
        "Priority processing",
        "Limited to premium areas",
      ],
    },
    {
      "id": "FEE003",
      "name": "Budget Delivery",
      "description": "Economical delivery option with longer wait times",
      "type": "Distance Based",
      "status": "Active",
      "base_fee": 1.99,
      "per_km_rate": 0.50,
      "min_order": 10.00,
      "free_delivery_threshold": 35.00,
      "max_distance": 12.0,
      "estimated_time": "45-60 min",
      "peak_hour_multiplier": 1.0,
      "weekend_multiplier": 1.0,
      "zones": ["Zone B", "Zone D"],
      "conditions": [
        "Available 8 AM - 10 PM",
        "Extended delivery window",
        "All weather conditions",
      ],
    },
    {
      "id": "FEE004",
      "name": "Premium Delivery",
      "description": "White-glove delivery service with premium features",
      "type": "Fixed Rate",
      "status": "Inactive",
      "base_fee": 9.99,
      "per_km_rate": 2.00,
      "min_order": 50.00,
      "free_delivery_threshold": 100.00,
      "max_distance": 15.0,
      "estimated_time": "20-30 min",
      "peak_hour_multiplier": 1.3,
      "weekend_multiplier": 1.2,
      "zones": ["Zone A"],
      "conditions": [
        "Available 11 AM - 7 PM",
        "White-glove service",
        "Premium packaging",
      ],
    },
  ];

  // Fee calculator variables
  double orderValue = 0.0;
  double distance = 0.0;
  String selectedFeeStructure = "FEE001";
  bool isPeakHour = false;
  bool isWeekend = false;

  String selectedStatus = "All Status";
  String selectedType = "All Types";
  String searchQuery = "";

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Distance Based", "value": "Distance Based"},
    {"label": "Fixed Rate", "value": "Fixed Rate"},
  ];

  // Form fields for adding/editing fee structures
  String feeName = "";
  String feeDescription = "";
  String feeType = "Distance Based";
  double baseFee = 0.0;
  double perKmRate = 0.0;
  double minOrder = 0.0;
  double freeDeliveryThreshold = 0.0;
  double maxDistance = 0.0;
  String estimatedTime = "";
  double peakHourMultiplier = 1.0;
  double weekendMultiplier = 1.0;

  List<Map<String, dynamic>> feeTypeItems = [
    {"label": "Distance Based", "value": "Distance Based"},
    {"label": "Fixed Rate", "value": "Fixed Rate"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Distance Based":
        return primaryColor;
      case "Fixed Rate":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> get filteredFeeStructures {
    return feeStructures.where((fee) {
      bool matchesStatus = selectedStatus == "All Status" || fee["status"] == selectedStatus;
      bool matchesType = selectedType == "All Types" || fee["type"] == selectedType;
      bool matchesSearch = searchQuery.isEmpty || 
          (fee["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (fee["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesType && matchesSearch;
    }).toList();
  }

  double _calculateDeliveryFee() {
    final selectedFee = feeStructures.firstWhere(
      (fee) => fee["id"] == selectedFeeStructure,
      orElse: () => feeStructures.first,
    );

    if (orderValue >= (selectedFee["free_delivery_threshold"] as double)) {
      return 0.0;
    }

    double fee = 0.0;
    
    if (selectedFee["type"] == "Distance Based") {
      fee = (selectedFee["base_fee"] as double) + 
            ((selectedFee["per_km_rate"] as double) * distance);
    } else {
      fee = selectedFee["base_fee"] as double;
    }

    if (isPeakHour) {
      fee *= selectedFee["peak_hour_multiplier"] as double;
    }

    if (isWeekend) {
      fee *= selectedFee["weekend_multiplier"] as double;
    }

    return fee;
  }

  void _showAddFeeStructureDialog() {
    // Reset form
    feeName = "";
    feeDescription = "";
    feeType = "Distance Based";
    baseFee = 0.0;
    perKmRate = 0.0;
    minOrder = 0.0;
    freeDeliveryThreshold = 0.0;
    maxDistance = 0.0;
    estimatedTime = "";
    peakHourMultiplier = 1.0;
    weekendMultiplier = 1.0;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Fee Structure"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Name",
                value: feeName,
                hint: "Enter fee structure name",
                onChanged: (value) {
                  feeName = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Description",
                value: feeDescription,
                hint: "Enter description",
                onChanged: (value) {
                  feeDescription = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Type",
                items: feeTypeItems,
                value: feeType,
                onChanged: (value, label) {
                  feeType = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Base Fee (\$)",
                      value: baseFee.toString(),
                      onChanged: (value) {
                        baseFee = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Per KM Rate (\$)",
                      value: perKmRate.toString(),
                      onChanged: (value) {
                        perKmRate = double.tryParse(value) ?? 0.0;
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
                    child: QNumberField(
                      label: "Min Order (\$)",
                      value: minOrder.toString(),
                      onChanged: (value) {
                        minOrder = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Free Delivery (\$)",
                      value: freeDeliveryThreshold.toString(),
                      onChanged: (value) {
                        freeDeliveryThreshold = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Add",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              _addFeeStructure();
            },
          ),
        ],
      ),
    );
  }

  void _addFeeStructure() {
    ss("New fee structure added successfully");
  }

  void _editFeeStructure(Map<String, dynamic> fee) {
    feeName = fee["name"];
    feeDescription = fee["description"];
    feeType = fee["type"];
    baseFee = fee["base_fee"];
    perKmRate = fee["per_km_rate"];
    minOrder = fee["min_order"];
    freeDeliveryThreshold = fee["free_delivery_threshold"];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Fee Structure"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Name",
                value: feeName,
                onChanged: (value) {
                  feeName = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Description",
                value: feeDescription,
                onChanged: (value) {
                  feeDescription = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Base Fee (\$)",
                      value: baseFee.toString(),
                      onChanged: (value) {
                        baseFee = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Per KM Rate (\$)",
                      value: perKmRate.toString(),
                      onChanged: (value) {
                        perKmRate = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Update",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Fee structure updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _toggleFeeStatus(Map<String, dynamic> fee) {
    String newStatus = fee["status"] == "Active" ? "Inactive" : "Active";
    ss("Fee structure ${fee["name"]} is now ${newStatus}");
  }

  void _deleteFeeStructure(Map<String, dynamic> fee) async {
    bool isConfirmed = await confirm("Are you sure you want to delete ${fee["name"]}?");
    if (isConfirmed) {
      ss("Fee structure ${fee["name"]} deleted successfully");
    }
  }

  void _viewFeeDetails(Map<String, dynamic> fee) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: disabledOutlineBorderColor),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${fee["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor("${fee["status"]}"),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${fee["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Fee Structure Info
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getTypeColor("${fee["type"]}").withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: _getTypeColor("${fee["type"]}").withAlpha(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${fee["description"]}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getTypeColor("${fee["type"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${fee["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _getTypeColor("${fee["type"]}"),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "ID: ${fee["id"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Pricing Details
                    Text(
                      "Pricing Structure",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
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
                              Text("Base Fee:"),
                              Spacer(),
                              Text(
                                "\$${(fee["base_fee"] as double).currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text("Per KM Rate:"),
                              Spacer(),
                              Text(
                                "\$${(fee["per_km_rate"] as double).currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text("Minimum Order:"),
                              Spacer(),
                              Text(
                                "\$${(fee["min_order"] as double).currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text("Free Delivery Above:"),
                              Spacer(),
                              Text(
                                "\$${(fee["free_delivery_threshold"] as double).currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Service Details
                    Text(
                      "Service Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
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
                              Text("Max Distance:"),
                              Spacer(),
                              Text(
                                "${fee["max_distance"]} km",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text("Estimated Time:"),
                              Spacer(),
                              Text(
                                "${fee["estimated_time"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text("Peak Hour Multiplier:"),
                              Spacer(),
                              Text(
                                "${fee["peak_hour_multiplier"]}x",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text("Weekend Multiplier:"),
                              Spacer(),
                              Text(
                                "${fee["weekend_multiplier"]}x",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Available Zones
                    Text(
                      "Available Zones",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (fee["zones"] as List).map((zone) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$zone",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Conditions
                    Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: (fee["conditions"] as List).map((condition) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: spXs),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  margin: EdgeInsets.only(top: 6),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "$condition",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Edit",
                            icon: Icons.edit,
                            size: bs.md,
                            onPressed: () {
                              Navigator.pop(context);
                              _editFeeStructure(fee);
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: fee["status"] == "Active" ? "Deactivate" : "Activate",
                            icon: fee["status"] == "Active" ? Icons.pause : Icons.play_arrow,
                            size: bs.md,
                            onPressed: () {
                              Navigator.pop(context);
                              _toggleFeeStatus(fee);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Fees"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddFeeStructureDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fee Calculator
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Fee Calculator",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Order Value (\$)",
                          value: orderValue.toString(),
                          onChanged: (value) {
                            orderValue = double.tryParse(value) ?? 0.0;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Distance (km)",
                          value: distance.toString(),
                          onChanged: (value) {
                            distance = double.tryParse(value) ?? 0.0;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Fee Structure",
                    items: feeStructures.where((fee) => fee["status"] == "Active").map((fee) => {
                      "label": fee["name"],
                      "value": fee["id"],
                    }).toList(),
                    value: selectedFeeStructure,
                    onChanged: (value, label) {
                      selectedFeeStructure = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Peak Hours",
                              "value": true,
                              "checked": isPeakHour,
                            }
                          ],
                          value: [if (isPeakHour) {"label": "Peak Hours", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            isPeakHour = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Weekend",
                              "value": true,
                              "checked": isWeekend,
                            }
                          ],
                          value: [if (isWeekend) {"label": "Weekend", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            isWeekend = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Calculated Delivery Fee:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          _calculateDeliveryFee() == 0.0 
                              ? "FREE"
                              : "\$${_calculateDeliveryFee().currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: _calculateDeliveryFee() == 0.0 ? successColor : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
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
                          Icon(
                            Icons.local_offer,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Fee Structures",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${feeStructures.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Active",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${feeStructures.where((f) => f["status"] == "Active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(
                            Icons.trending_down,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Lowest Fee",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${feeStructures.map((f) => f["base_fee"] as double).reduce((a, b) => a < b ? a : b).currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(
                            Icons.trending_up,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Highest Fee",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${feeStructures.map((f) => f["base_fee"] as double).reduce((a, b) => a > b ? a : b).currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Fee Structures",
                    value: searchQuery,
                    hint: "Search by name or ID",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
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
                SizedBox(width: spSm),
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
              ],
            ),

            SizedBox(height: spLg),

            // Fee Structures List
            Text(
              "Fee Structures (${filteredFeeStructures.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(filteredFeeStructures.length, (index) {
                  final fee = filteredFeeStructures[index];
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getTypeColor("${fee["type"]}"),
                        ),
                        bottom: BorderSide(
                          color: index < filteredFeeStructures.length - 1 ? disabledOutlineBorderColor : Colors.transparent,
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
                              Row(
                                children: [
                                  Text(
                                    "${fee["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${fee["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${fee["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _getStatusColor("${fee["status"]}"),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getTypeColor("${fee["type"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${fee["type"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _getTypeColor("${fee["type"]}"),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${fee["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "Base: \$${(fee["base_fee"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Per KM: \$${(fee["per_km_rate"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Free above: \$${(fee["free_delivery_threshold"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            QButton(
                              icon: Icons.info,
                              size: bs.sm,
                              onPressed: () => _viewFeeDetails(fee),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () => _editFeeStructure(fee),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.delete,
                              size: bs.sm,
                              onPressed: () => _deleteFeeStructure(fee),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
