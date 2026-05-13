import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaTripLogView extends StatefulWidget {
  const CmaTripLogView({super.key});

  @override
  State<CmaTripLogView> createState() => _CmaTripLogViewState();
}

class _CmaTripLogViewState extends State<CmaTripLogView> {
  String selectedVehicle = "All Vehicles";
  String dateFilter = "This Month";
  String statusFilter = "All Status";

  List<Map<String, dynamic>> tripLogs = [
    {
      "id": 1,
      "tripName": "Business Trip to Toronto",
      "vehicle": "Honda Civic",
      "startDate": "2025-06-18",
      "endDate": "2025-06-20",
      "status": "Completed",
      "startLocation": "Ottawa, ON",
      "endLocation": "Toronto, ON",
      "totalDistance": 453,
      "fuelCost": 67.50,
      "tollCost": 25.00,
      "parkingCost": 45.00,
      "totalExpenses": 137.50,
      "purpose": "Client Meeting",
      "passengers": 1,
      "weather": "Sunny",
      "notes": "Successful client presentation",
    },
    {
      "id": 2,
      "tripName": "Weekend Getaway",
      "vehicle": "Toyota Camry",
      "startDate": "2025-06-15",
      "endDate": "2025-06-16",
      "status": "Completed",
      "startLocation": "Montreal, QC",
      "endLocation": "Quebec City, QC",
      "totalDistance": 256,
      "fuelCost": 45.25,
      "tollCost": 0.00,
      "parkingCost": 20.00,
      "totalExpenses": 65.25,
      "purpose": "Personal",
      "passengers": 3,
      "weather": "Cloudy",
      "notes": "Great family trip",
    },
    {
      "id": 3,
      "tripName": "Medical Appointment",
      "vehicle": "Honda Civic",
      "startDate": "2025-06-12",
      "endDate": "2025-06-12",
      "status": "Completed",
      "startLocation": "Home",
      "endLocation": "Hospital",
      "totalDistance": 78,
      "fuelCost": 12.50,
      "tollCost": 0.00,
      "parkingCost": 8.00,
      "totalExpenses": 20.50,
      "purpose": "Medical",
      "passengers": 1,
      "weather": "Rainy",
      "notes": "Routine checkup",
    },
    {
      "id": 4,
      "tripName": "Conference in Vancouver",
      "vehicle": "Toyota Camry", 
      "startDate": "2025-06-22",
      "endDate": "2025-06-25",
      "status": "Planned",
      "startLocation": "Calgary, AB",
      "endLocation": "Vancouver, BC",
      "totalDistance": 605,
      "fuelCost": 89.75,
      "tollCost": 15.00,
      "parkingCost": 60.00,
      "totalExpenses": 164.75,
      "purpose": "Business",
      "passengers": 2,
      "weather": "Unknown",
      "notes": "Tech conference",
    },
  ];

  List<Map<String, dynamic>> get filteredTrips {
    return tripLogs.where((trip) {
      bool vehicleMatch = selectedVehicle == "All Vehicles" || 
        trip["vehicle"] == selectedVehicle;
      bool statusMatch = statusFilter == "All Status" || 
        trip["status"] == statusFilter;
      return vehicleMatch && statusMatch;
    }).toList();
  }

  double get totalDistance {
    return filteredTrips.fold(0.0, (sum, trip) => 
      sum + (trip["totalDistance"] as int).toDouble()
    );
  }

  double get totalExpenses {
    return filteredTrips.fold(0.0, (sum, trip) => 
      sum + (trip["totalExpenses"] as double)
    );
  }

  int get completedTrips {
    return filteredTrips
      .where((trip) => trip["status"] == "Completed")
      .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Log"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add trip
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              // View map
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
                      Icon(Icons.tune, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Filter Trips",
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
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": "All Status"},
                            {"label": "Planned", "value": "Planned"},
                            {"label": "In Progress", "value": "In Progress"},
                            {"label": "Completed", "value": "Completed"},
                            {"label": "Cancelled", "value": "Cancelled"},
                          ],
                          value: statusFilter,
                          onChanged: (value, label) {
                            statusFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

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
                            "Total Distance",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${totalDistance.toStringAsFixed(0)} km",
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
                            Icons.attach_money,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Expenses",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${totalExpenses.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
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
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$completedTrips trips",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Trip List
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
                        Icon(Icons.trip_origin, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Trip History",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredTrips.length} trips",
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
                    itemCount: filteredTrips.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: disabledColor,
                    ),
                    itemBuilder: (context, index) {
                      final trip = filteredTrips[index];
                      
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
                                    color: _getStatusColor(trip["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${trip["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getStatusColor(trip["status"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getPurposeColor(trip["purpose"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${trip["purpose"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getPurposeColor(trip["purpose"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${trip["startDate"]} - ${trip["endDate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            Text(
                              "${trip["tripName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            Row(
                              children: [
                                Icon(
                                  Icons.directions_car,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${trip["vehicle"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.people,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${trip["passengers"]} passenger${(trip["passengers"] as int) > 1 ? 's' : ''}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              children: [
                                Icon(
                                  Icons.my_location,
                                  size: 14,
                                  color: successColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${trip["startLocation"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
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
                                    "${trip["endLocation"]}",
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
                                        "Distance",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${trip["totalDistance"]} km",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
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
                                        "Fuel Cost",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(trip["fuelCost"] as double).toStringAsFixed(2)}",
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
                                        "Total Cost",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(trip["totalExpenses"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: dangerColor,
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
                                        "Weather",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            _getWeatherIcon(trip["weather"]),
                                            size: 12,
                                            color: _getWeatherColor(trip["weather"]),
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "${trip["weather"]}",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: _getWeatherColor(trip["weather"]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            if (trip["notes"] != null && (trip["notes"] as String).isNotEmpty)
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: disabledColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.note,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "${trip["notes"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
          // Navigate to add trip
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return infoColor;
      case "Planned":
        return warningColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPurposeColor(String purpose) {
    switch (purpose) {
      case "Business":
        return primaryColor;
      case "Personal":
        return disabledBoldColor;
      case "Medical":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getWeatherIcon(String weather) {
    switch (weather) {
      case "Sunny":
        return Icons.wb_sunny;
      case "Cloudy":
        return Icons.cloud;
      case "Rainy":
        return Icons.grain;
      case "Snowy":
        return Icons.ac_unit;
      default:
        return Icons.help_outline;
    }
  }

  Color _getWeatherColor(String weather) {
    switch (weather) {
      case "Sunny":
        return warningColor;
      case "Cloudy":
        return disabledBoldColor;
      case "Rainy":
        return infoColor;
      case "Snowy":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }
}
