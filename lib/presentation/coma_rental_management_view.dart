import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaRentalManagementView extends StatefulWidget {
  const ComaRentalManagementView({super.key});

  @override
  State<ComaRentalManagementView> createState() => _ComaRentalManagementViewState();
}

class _ComaRentalManagementViewState extends State<ComaRentalManagementView> {
  String searchQuery = "";
  String selectedStatus = "";
  String selectedCategory = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "active"},
    {"label": "Pending Return", "value": "pending_return"},
    {"label": "Returned", "value": "returned"},
    {"label": "Overdue", "value": "overdue"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": ""},
    {"label": "Heavy Machinery", "value": "heavy_machinery"},
    {"label": "Power Tools", "value": "power_tools"},
    {"label": "Safety Equipment", "value": "safety_equipment"},
    {"label": "Material Handling", "value": "material_handling"},
  ];

  List<Map<String, dynamic>> rentalData = [
    {
      "id": "RNT-001",
      "equipment": "Excavator CAT 320",
      "category": "heavy_machinery",
      "supplier": "Heavy Equipment Solutions",
      "status": "active",
      "startDate": "2024-01-15",
      "endDate": "2024-02-15",
      "dailyRate": 1200.0,
      "totalCost": 36000.0,
      "location": "Construction Site A",
      "operator": "John Smith",
      "fuelIncluded": true,
      "insurance": "Comprehensive",
      "condition": "Excellent",
      "hoursUsed": 180,
      "efficiency": 95.2
    },
    {
      "id": "RNT-002",
      "equipment": "Tower Crane Liebherr",
      "category": "heavy_machinery",
      "supplier": "Crane Rentals Pro",
      "status": "pending_return",
      "startDate": "2024-01-10",
      "endDate": "2024-01-25",
      "dailyRate": 2500.0,
      "totalCost": 37500.0,
      "location": "Downtown Project",
      "operator": "Mike Johnson",
      "fuelIncluded": false,
      "insurance": "Third Party",
      "condition": "Good",
      "hoursUsed": 240,
      "efficiency": 88.7
    },
    {
      "id": "RNT-003",
      "equipment": "Concrete Mixer",
      "category": "material_handling",
      "supplier": "BuildMix Equipment",
      "status": "returned",
      "startDate": "2024-01-08",
      "endDate": "2024-01-20",
      "dailyRate": 150.0,
      "totalCost": 1800.0,
      "location": "Residential Complex",
      "operator": "David Wilson",
      "fuelIncluded": true,
      "insurance": "Basic",
      "condition": "Fair",
      "hoursUsed": 96,
      "efficiency": 92.1
    },
    {
      "id": "RNT-004",
      "equipment": "Safety Harness Set",
      "category": "safety_equipment",
      "supplier": "SafeWork Supplies",
      "status": "overdue",
      "startDate": "2024-01-05",
      "endDate": "2024-01-19",
      "dailyRate": 25.0,
      "totalCost": 350.0,
      "location": "Bridge Construction",
      "operator": "Sarah Brown",
      "fuelIncluded": false,
      "insurance": "Basic",
      "condition": "Good",
      "hoursUsed": 112,
      "efficiency": 98.5
    },
    {
      "id": "RNT-005",
      "equipment": "Pneumatic Drill",
      "category": "power_tools",
      "supplier": "Power Tools Direct",
      "status": "active",
      "startDate": "2024-01-12",
      "endDate": "2024-02-12",
      "dailyRate": 75.0,
      "totalCost": 2325.0,
      "location": "Road Maintenance",
      "operator": "Tom Garcia",
      "fuelIncluded": false,
      "insurance": "Comprehensive",
      "condition": "Excellent",
      "hoursUsed": 145,
      "efficiency": 96.8
    },
  ];

  List<Map<String, dynamic>> get filteredRentals {
    return rentalData.where((rental) {
      bool matchesSearch = rental["equipment"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          rental["supplier"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus.isEmpty || rental["status"] == selectedStatus;
      bool matchesCategory = selectedCategory.isEmpty || rental["category"] == selectedCategory;
      return matchesSearch && matchesStatus && matchesCategory;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "pending_return":
        return warningColor;
      case "returned":
        return infoColor;
      case "overdue":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String getStatusLabel(String status) {
    switch (status) {
      case "active":
        return "Active";
      case "pending_return":
        return "Pending Return";
      case "returned":
        return "Returned";
      case "overdue":
        return "Overdue";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalCost = filteredRentals.fold(0.0, (sum, rental) => sum + (rental["totalCost"] as double));
    int activeRentals = filteredRentals.where((r) => r["status"] == "active").length;
    int overdueRentals = filteredRentals.where((r) => r["status"] == "overdue").length;
    double avgEfficiency = filteredRentals.isNotEmpty 
        ? filteredRentals.fold(0.0, (sum, rental) => sum + (rental["efficiency"] as double)) / filteredRentals.length
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Rental Management"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
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
                    label: "Search Equipment or Supplier",
                    value: searchQuery,
                    hint: "Enter equipment name or supplier...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
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
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categoryOptions,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Statistics Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "Rental Summary",
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
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "\$${totalCost.currency}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Cost",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
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
                                "$activeRentals",
                                style: TextStyle(
                                  fontSize: fsH5,
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
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "$overdueRentals",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Overdue",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${avgEfficiency.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Avg Efficiency",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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

            // Rentals Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredRentals.map((rental) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: getStatusColor(rental["status"]),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${rental["equipment"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: getStatusColor(rental["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              getStatusLabel(rental["status"]),
                              style: TextStyle(
                                fontSize: 10,
                                color: getStatusColor(rental["status"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${rental["supplier"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${rental["location"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.person, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${rental["operator"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
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
                                  "Daily Rate",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${(rental["dailyRate"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
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
                                  "Total Cost",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${(rental["totalCost"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
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
                                  "Efficiency",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(rental["efficiency"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
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
                                  "Hours Used",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${rental["hoursUsed"]}h",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      
                      Row(
                        children: [
                          Text(
                            "Start: ${DateTime.parse(rental["startDate"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "End: ${DateTime.parse(rental["endDate"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
