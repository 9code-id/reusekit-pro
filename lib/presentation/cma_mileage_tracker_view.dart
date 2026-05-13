import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaMileageTrackerView extends StatefulWidget {
  const CmaMileageTrackerView({super.key});

  @override
  State<CmaMileageTrackerView> createState() => _CmaMileageTrackerViewState();
}

class _CmaMileageTrackerViewState extends State<CmaMileageTrackerView> {
  String selectedVehicle = "All Vehicles";
  String dateFilter = "This Month";
  String tripTypeFilter = "All Types";

  List<Map<String, dynamic>> mileageRecords = [
    {
      "id": 1,
      "date": "2025-06-19",
      "vehicle": "Honda Civic",
      "startOdometer": 45234,
      "endOdometer": 45678,
      "distance": 444,
      "tripType": "Business",
      "purpose": "Client Meeting",
      "startLocation": "Home",
      "endLocation": "Downtown Office",
      "deductible": true,
      "rate": 0.68,
      "amount": 301.92,
    },
    {
      "id": 2,
      "date": "2025-06-18",
      "vehicle": "Honda Civic",
      "startOdometer": 44891,
      "endOdometer": 45234,
      "distance": 343,
      "tripType": "Personal",
      "purpose": "Grocery Shopping",
      "startLocation": "Home",
      "endLocation": "Mall",
      "deductible": false,
      "rate": 0.0,
      "amount": 0.0,
    },
    {
      "id": 3,
      "date": "2025-06-17",
      "vehicle": "Toyota Camry",
      "startOdometer": 67456,
      "endOdometer": 67890,
      "distance": 434,
      "tripType": "Business",
      "purpose": "Conference",
      "startLocation": "Office",
      "endLocation": "Convention Center",
      "deductible": true,
      "rate": 0.68,
      "amount": 295.12,
    },
    {
      "id": 4,
      "date": "2025-06-16",
      "vehicle": "Honda Civic",
      "startOdometer": 44523,
      "endOdometer": 44891,
      "distance": 368,
      "tripType": "Medical",
      "purpose": "Doctor Appointment",
      "startLocation": "Home",
      "endLocation": "Medical Center",
      "deductible": true,
      "rate": 0.22,
      "amount": 80.96,
    },
  ];

  List<Map<String, dynamic>> get filteredRecords {
    return mileageRecords.where((record) {
      bool vehicleMatch = selectedVehicle == "All Vehicles" || 
        record["vehicle"] == selectedVehicle;
      bool typeMatch = tripTypeFilter == "All Types" || 
        record["tripType"] == tripTypeFilter;
      return vehicleMatch && typeMatch;
    }).toList();
  }

  double get totalMiles {
    return filteredRecords.fold(0.0, (sum, record) => 
      sum + (record["distance"] as int).toDouble()
    );
  }

  double get totalDeductible {
    return filteredRecords
      .where((record) => record["deductible"] as bool)
      .fold(0.0, (sum, record) => sum + (record["amount"] as double));
  }

  int get businessTrips {
    return filteredRecords
      .where((record) => record["tripType"] == "Business")
      .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mileage Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add mileage
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              // Export mileage report
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters Section
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
                  Row(
                    children: [
                      Icon(Icons.filter_alt, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Filter Records",
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
                          label: "Vehicle",
                          items: [
                            {"label": "All Vehicles", "value": "All Vehicles"},
                            {"label": "Honda Civic", "value": "Honda Civic"},
                            {"label": "Toyota Camry", "value": "Toyota Camry"},
                          ],
                          value: selectedVehicle,
                          onChanged: (value, label) {
                            selectedVehicle = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Trip Type",
                          items: [
                            {"label": "All Types", "value": "All Types"},
                            {"label": "Business", "value": "Business"},
                            {"label": "Personal", "value": "Personal"},
                            {"label": "Medical", "value": "Medical"},
                            {"label": "Charity", "value": "Charity"},
                          ],
                          value: tripTypeFilter,
                          onChanged: (value, label) {
                            tripTypeFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Date Range",
                    items: [
                      {"label": "This Week", "value": "This Week"},
                      {"label": "This Month", "value": "This Month"},
                      {"label": "Last 3 Months", "value": "Last 3 Months"},
                      {"label": "This Year", "value": "This Year"},
                      {"label": "Custom Range", "value": "Custom Range"},
                    ],
                    value: dateFilter,
                    onChanged: (value, label) {
                      dateFilter = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Summary Stats
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
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.straighten,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Miles",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${totalMiles.toStringAsFixed(0)} km",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
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
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Deductible Amount",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${totalDeductible.toStringAsFixed(2)}",
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
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.business_center,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Business Trips",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$businessTrips trips",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Mileage Records List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Icon(Icons.directions_car, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Mileage Records",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredRecords.length} records",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredRecords.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledColor,
                    ),
                    itemBuilder: (context, index) {
                      final record = filteredRecords[index];
                      final isDeductible = record["deductible"] as bool;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getTripTypeColor(record["tripType"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${record["tripType"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getTripTypeColor(record["tripType"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (isDeductible) ...[
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "DEDUCTIBLE",
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: successColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                                Spacer(),
                                Text(
                                  "${record["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            Text(
                              "${record["vehicle"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            Text(
                              "${record["purpose"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            
                            Row(
                              children: [
                                Icon(
                                  Icons.my_location,
                                  size: 14,
                                  color: successColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${record["startLocation"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 12,
                                  color: disabledColor,
                                ),
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: dangerColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${record["endLocation"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              spacing: spMd,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Start Odometer",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${(record["startOdometer"] as int).toString().replaceAllMapped(
                                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]},'
                                        )} km",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
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
                                        "End Odometer",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${(record["endOdometer"] as int).toString().replaceAllMapped(
                                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]},'
                                        )} km",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
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
                                        "Distance",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${record["distance"]} km",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isDeductible)
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Deduction",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${(record["amount"] as double).toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: successColor,
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
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add mileage record
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Color _getTripTypeColor(String tripType) {
    switch (tripType) {
      case "Business":
        return primaryColor;
      case "Personal":
        return disabledBoldColor;
      case "Medical":
        return successColor;
      case "Charity":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
}
