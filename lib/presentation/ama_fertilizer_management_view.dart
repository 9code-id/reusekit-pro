import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaFertilizerManagementView extends StatefulWidget {
  const AmaFertilizerManagementView({super.key});

  @override
  State<AmaFertilizerManagementView> createState() => _AmaFertilizerManagementViewState();
}

class _AmaFertilizerManagementViewState extends State<AmaFertilizerManagementView> {
  int currentTab = 0;
  String selectedField = "";
  String selectedCrop = "";
  String searchQuery = "";
  
  List<Map<String, dynamic>> fieldOptions = [
    {"label": "Field A - North Plot", "value": "field_a"},
    {"label": "Field B - South Plot", "value": "field_b"},
    {"label": "Field C - East Plot", "value": "field_c"},
    {"label": "Field D - West Plot", "value": "field_d"},
  ];

  List<Map<String, dynamic>> cropOptions = [
    {"label": "Rice", "value": "rice"},
    {"label": "Wheat", "value": "wheat"},
    {"label": "Corn", "value": "corn"},
    {"label": "Tomato", "value": "tomato"},
    {"label": "Soybean", "value": "soybean"},
  ];

  List<Map<String, dynamic>> currentApplications = [
    {
      "id": "1",
      "field": "Field A - North Plot",
      "crop": "Rice",
      "fertilizer": "NPK 16-16-16",
      "type": "Chemical",
      "applicationDate": "2025-06-15",
      "nextDue": "2025-06-29",
      "amount": 50.0,
      "unit": "kg/ha",
      "status": "Applied",
      "cost": 1200.0,
      "notes": "Applied during vegetative stage"
    },
    {
      "id": "2",
      "field": "Field B - South Plot",
      "crop": "Wheat",
      "fertilizer": "Urea",
      "type": "Chemical",
      "applicationDate": "2025-06-10",
      "nextDue": "2025-06-24",
      "amount": 40.0,
      "unit": "kg/ha",
      "status": "Pending",
      "cost": 800.0,
      "notes": "Second application needed"
    },
    {
      "id": "3",
      "field": "Field C - East Plot",
      "crop": "Tomato",
      "fertilizer": "Compost",
      "type": "Organic",
      "applicationDate": "2025-06-08",
      "nextDue": "2025-07-08",
      "amount": 2.0,
      "unit": "ton/ha",
      "status": "Applied",
      "cost": 600.0,
      "notes": "Base application before planting"
    },
    {
      "id": "4",
      "field": "Field D - West Plot",
      "crop": "Corn",
      "fertilizer": "DAP",
      "type": "Chemical",
      "applicationDate": "2025-06-12",
      "nextDue": "2025-06-26",
      "amount": 35.0,
      "unit": "kg/ha",
      "status": "Overdue",
      "cost": 900.0,
      "notes": "Delayed due to weather"
    },
  ];

  List<Map<String, dynamic>> fertilizerInventory = [
    {
      "id": "1",
      "name": "NPK 16-16-16",
      "type": "Chemical",
      "category": "Complete",
      "currentStock": 850.0,
      "unit": "kg",
      "minStock": 200.0,
      "maxStock": 1000.0,
      "costPerUnit": 24.0,
      "supplier": "AgriCorp Ltd",
      "expiryDate": "2026-03-15",
      "location": "Warehouse A",
      "nutrients": {"N": 16, "P": 16, "K": 16}
    },
    {
      "id": "2",
      "name": "Urea",
      "type": "Chemical",
      "category": "Nitrogen",
      "currentStock": 450.0,
      "unit": "kg",
      "minStock": 100.0,
      "maxStock": 500.0,
      "costPerUnit": 20.0,
      "supplier": "FertilizerCo",
      "expiryDate": "2025-12-30",
      "location": "Warehouse A",
      "nutrients": {"N": 46, "P": 0, "K": 0}
    },
    {
      "id": "3",
      "name": "DAP",
      "type": "Chemical",
      "category": "Phosphorus",
      "currentStock": 320.0,
      "unit": "kg",
      "minStock": 150.0,
      "maxStock": 400.0,
      "costPerUnit": 28.0,
      "supplier": "AgriCorp Ltd",
      "expiryDate": "2025-11-20",
      "location": "Warehouse B",
      "nutrients": {"N": 18, "P": 46, "K": 0}
    },
    {
      "id": "4",
      "name": "Compost",
      "type": "Organic",
      "category": "Organic Matter",
      "currentStock": 15.0,
      "unit": "ton",
      "minStock": 5.0,
      "maxStock": 20.0,
      "costPerUnit": 300.0,
      "supplier": "Local Farm",
      "expiryDate": "2025-08-30",
      "location": "Compost Area",
      "nutrients": {"N": 2, "P": 1, "K": 2}
    },
    {
      "id": "5",
      "name": "Bone Meal",
      "type": "Organic",
      "category": "Phosphorus",
      "currentStock": 80.0,
      "unit": "kg",
      "minStock": 25.0,
      "maxStock": 100.0,
      "costPerUnit": 35.0,
      "supplier": "OrganicSupply",
      "expiryDate": "2026-01-15",
      "location": "Warehouse C",
      "nutrients": {"N": 3, "P": 15, "K": 0}
    },
  ];

  List<Map<String, dynamic>> applicationHistory = [
    {
      "date": "2025-06-01",
      "field": "Field A",
      "crop": "Rice",
      "fertilizer": "NPK 16-16-16",
      "amount": 50.0,
      "cost": 1200.0,
      "growth_stage": "Vegetative",
      "weather": "Sunny"
    },
    {
      "date": "2025-05-25",
      "field": "Field B",
      "crop": "Wheat",
      "fertilizer": "Urea",
      "amount": 40.0,
      "cost": 800.0,
      "growth_stage": "Tillering",
      "weather": "Cloudy"
    },
    {
      "date": "2025-05-20",
      "field": "Field C",
      "crop": "Tomato",
      "fertilizer": "Compost",
      "amount": 2.0,
      "cost": 600.0,
      "growth_stage": "Pre-planting",
      "weather": "Rainy"
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'applied':
        return successColor;
      case 'pending':
        return warningColor;
      case 'overdue':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStockLevelColor(double current, double min, double max) {
    double percentage = current / max;
    if (current <= min) return dangerColor;
    if (percentage <= 0.3) return warningColor;
    return successColor;
  }

  String _getStockStatus(double current, double min, double max) {
    if (current <= min) return "Low Stock";
    if (current / max <= 0.3) return "Running Low";
    return "Good Stock";
  }

  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        // Quick Stats
        ResponsiveGridView(
          padding: EdgeInsets.all(spSm),
          minItemWidth: 200,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.schedule,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Pending Applications",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${currentApplications.where((app) => app["status"] == "Pending").length}",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                  Text(
                    "Fields need fertilizer",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.warning,
                        color: dangerColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Overdue Applications",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${currentApplications.where((app) => app["status"] == "Overdue").length}",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  Text(
                    "Urgent attention needed",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.inventory,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Fertilizer Types",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${fertilizerInventory.length}",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Different fertilizers",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Icon(
                        Icons.attach_money,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Monthly Cost",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "\$${((currentApplications.map((app) => app["cost"] as double).fold(0.0, (sum, cost) => sum + cost)).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "Total fertilizer cost",
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

        // Current Applications
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
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
                  Icon(
                    Icons.calendar_today,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Current Applications",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Add New",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              ...currentApplications.map((application) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${application["field"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(application["status"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${application["status"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${application["crop"]} • ${application["fertilizer"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            "\$${((application["cost"] as double).toDouble()).currency}",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Amount: ${(application["amount"] as double).toStringAsFixed(1)} ${application["unit"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Next: ${application["nextDue"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      if (application["notes"] != null)
                        Text(
                          "${application["notes"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),

        // Low Stock Alert
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: warningColor.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Low Stock Alert",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
              ...fertilizerInventory.where((item) => 
                (item["currentStock"] as double) <= (item["minStock"] as double)
              ).map((item) {
                return Text(
                  "• ${item["name"]}: ${(item["currentStock"] as double).toStringAsFixed(1)} ${item["unit"]} (Min: ${(item["minStock"] as double).toStringAsFixed(1)})",
                  style: TextStyle(
                    color: warningColor,
                    fontSize: 12,
                  ),
                );
              }).toList(),
              if (fertilizerInventory.where((item) => 
                (item["currentStock"] as double) <= (item["minStock"] as double)
              ).isEmpty)
                Text(
                  "All fertilizers are adequately stocked",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInventoryTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        // Search and Filter
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
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
                  Icon(
                    Icons.inventory_2,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Fertilizer Inventory",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search fertilizers...",
                      value: searchQuery,
                      hint: "Enter fertilizer name or type",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.search,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),

        // Inventory Cards
        ResponsiveGridView(
          padding: EdgeInsets.all(spSm),
          minItemWidth: 200,
          children: fertilizerInventory.map((fertilizer) {
            return Container(
              padding: EdgeInsets.all(spMd),
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
                      Expanded(
                        child: Text(
                          "${fertilizer["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: fertilizer["type"] == "Organic" ? successColor : primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${fertilizer["type"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${fertilizer["category"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                  
                  // Stock Level
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Stock: ${(fertilizer["currentStock"] as double).toStringAsFixed(1)} ${fertilizer["unit"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getStockLevelColor(
                                fertilizer["currentStock"] as double,
                                fertilizer["minStock"] as double,
                                fertilizer["maxStock"] as double,
                              ),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              _getStockStatus(
                                fertilizer["currentStock"] as double,
                                fertilizer["minStock"] as double,
                                fertilizer["maxStock"] as double,
                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: ((fertilizer["currentStock"] as double) / (fertilizer["maxStock"] as double)).clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _getStockLevelColor(
                                fertilizer["currentStock"] as double,
                                fertilizer["minStock"] as double,
                                fertilizer["maxStock"] as double,
                              ),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Min: ${(fertilizer["minStock"] as double).toStringAsFixed(1)} • Max: ${(fertilizer["maxStock"] as double).toStringAsFixed(1)}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),

                  // Nutrients
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "N",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              "${(fertilizer["nutrients"] as Map)["N"]}%",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "P",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.orange,
                              ),
                            ),
                            Text(
                              "${(fertilizer["nutrients"] as Map)["P"]}%",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "K",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              "${(fertilizer["nutrients"] as Map)["K"]}%",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Cost and Supplier
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Cost: \$${((fertilizer["costPerUnit"] as double).toDouble()).currency}/${fertilizer["unit"]}",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Supplier: ${fertilizer["supplier"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        "Expires: ${fertilizer["expiryDate"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        "Location: ${fertilizer["location"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),

                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Restock",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Use",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildHistoryTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        // Filters
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
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
                  Icon(
                    Icons.history,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Application History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Filter by Field",
                      items: [
                        {"label": "All Fields", "value": "all"},
                        ...fieldOptions,
                      ],
                      value: selectedField,
                      onChanged: (value, label) {
                        selectedField = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Filter by Crop",
                      items: [
                        {"label": "All Crops", "value": "all"},
                        ...cropOptions,
                      ],
                      value: selectedCrop,
                      onChanged: (value, label) {
                        selectedCrop = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // History List
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
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
                "Recent Applications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ...applicationHistory.map((history) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${history["date"]} - ${history["field"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            "\$${((history["cost"] as double).toDouble()).currency}",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${history["crop"]} • ${history["fertilizer"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${(history["amount"] as double).toStringAsFixed(1)} kg/ha",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Stage: ${history["growth_stage"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Weather: ${history["weather"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
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

        // Summary Statistics
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: primaryColor.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.analytics,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Summary Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Applications",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "${applicationHistory.length}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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
                          "Total Cost",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "\$${((applicationHistory.map((h) => h["cost"] as double).fold(0.0, (sum, cost) => sum + cost)).toDouble()).currency}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Fertilizer Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Inventory", icon: Icon(Icons.inventory_2)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildOverviewTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildInventoryTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildHistoryTab(),
        ),
      ],
    );
  }
}
