import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaMileageView extends StatefulWidget {
  const DlaMileageView({super.key});

  @override
  State<DlaMileageView> createState() => _DlaMileageViewState();
}

class _DlaMileageViewState extends State<DlaMileageView> {
  int currentTab = 0;
  String selectedVehicle = "";
  String startMileage = "";
  String endMileage = "";
  String tripPurpose = "delivery";
  String destination = "";
  String driverName = "";
  String notes = "";

  final List<Map<String, dynamic>> vehicles = [
    {"label": "DLA-001 (Toyota Hiace)", "value": "DLA-001"},
    {"label": "DLA-002 (Isuzu Elf)", "value": "DLA-002"},
    {"label": "DLA-003 (Honda Beat)", "value": "DLA-003"},
    {"label": "DLA-004 (Toyota Avanza)", "value": "DLA-004"},
  ];

  final List<Map<String, dynamic>> tripPurposes = [
    {"label": "Delivery", "value": "delivery"},
    {"label": "Pickup", "value": "pickup"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Personal", "value": "personal"},
    {"label": "Other", "value": "other"},
  ];

  final List<Map<String, dynamic>> mileageRecords = [
    {
      "id": "MILE-001",
      "vehicleId": "DLA-001",
      "date": "2024-01-15",
      "startMileage": 15380,
      "endMileage": 15420,
      "distance": 40,
      "purpose": "delivery",
      "destination": "Bandung Distribution Center",
      "driver": "John Smith",
      "fuelUsed": 3.2,
      "efficiency": 12.5,
      "duration": "3h 30m",
    },
    {
      "id": "MILE-002",
      "vehicleId": "DLA-002",
      "date": "2024-01-14",
      "startMileage": 28700,
      "endMileage": 28750,
      "distance": 50,
      "purpose": "pickup",
      "destination": "Jakarta Warehouse",
      "driver": "Sarah Johnson",
      "fuelUsed": 4.2,
      "efficiency": 11.9,
      "duration": "2h 15m",
    },
    {
      "id": "MILE-003",
      "vehicleId": "DLA-003",
      "date": "2024-01-13",
      "startMileage": 8485,
      "endMileage": 8500,
      "distance": 15,
      "purpose": "delivery",
      "destination": "Customer Location",
      "driver": "Mike Wilson",
      "fuelUsed": 0.5,
      "efficiency": 30.0,
      "duration": "45m",
    },
    {
      "id": "MILE-004",
      "vehicleId": "DLA-004",
      "date": "2024-01-12",
      "startMileage": 45550,
      "endMileage": 45600,
      "distance": 50,
      "purpose": "maintenance",
      "destination": "Service Center",
      "driver": "Lisa Brown",
      "fuelUsed": 3.8,
      "efficiency": 13.2,
      "duration": "2h 45m",
    },
  ];

  Widget _buildMileageEntryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
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
              spacing: spSm,
              children: [
                Text(
                  "Record Mileage",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Select Vehicle",
                  items: vehicles,
                  value: selectedVehicle,
                  onChanged: (value, label) {
                    selectedVehicle = value;
                    setState(() {});
                  },
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Start Mileage (km)",
                        value: startMileage,
                        onChanged: (value) {
                          startMileage = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QNumberField(
                        label: "End Mileage (km)",
                        value: endMileage,
                        onChanged: (value) {
                          endMileage = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Trip Purpose",
                  items: tripPurposes,
                  value: tripPurpose,
                  onChanged: (value, label) {
                    tripPurpose = value;
                    setState(() {});
                  },
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Destination",
                        value: destination,
                        hint: "Where did the vehicle go",
                        onChanged: (value) {
                          destination = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QTextField(
                        label: "Driver Name",
                        value: driverName,
                        hint: "Who drove the vehicle",
                        onChanged: (value) {
                          driverName = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QMemoField(
                  label: "Trip Notes",
                  value: notes,
                  hint: "Additional details about the trip",
                  onChanged: (value) {
                    notes = value;
                    setState(() {});
                  },
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Save Draft",
                        color: disabledBoldColor,
                        size: bs.md,
                        onPressed: () {
                          ss("Mileage entry draft saved");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Record Mileage",
                        size: bs.md,
                        onPressed: () {
                          ss("Mileage recorded successfully");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (startMileage.isNotEmpty && endMileage.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Trip Calculation",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Distance Traveled:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${((int.tryParse(endMileage) ?? 0) - (int.tryParse(startMileage) ?? 0))} km",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
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

  Widget _buildMileageHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.speed, color: primaryColor, size: 24),
                SizedBox(width: spSm),
                Text(
                  "Mileage History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    si("Filter mileage records");
                  },
                ),
              ],
            ),
          ),
          ...mileageRecords.map((record) {
            Color purposeColor = record["purpose"] == "delivery" ? successColor :
                                record["purpose"] == "pickup" ? infoColor :
                                record["purpose"] == "maintenance" ? warningColor : disabledBoldColor;
            
            Color efficiencyColor = (record["efficiency"] as double) > 20 ? successColor :
                                   (record["efficiency"] as double) > 15 ? warningColor : dangerColor;
            
            return Container(
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
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(Icons.local_shipping, color: primaryColor, size: 20),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${record["vehicleId"]} - ${record["id"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${record["driver"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: purposeColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${record["purpose"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: purposeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${record["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${record["duration"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${record["destination"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: disabledColor),
                  Row(
                    spacing: spMd,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${record["distance"]} km",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Distance",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${record["startMileage"]} → ${record["endMileage"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Odometer",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${record["fuelUsed"]} L",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Fuel Used",
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
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: efficiencyColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.eco, color: efficiencyColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Fuel Efficiency: ${record["efficiency"]} km/L",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: efficiencyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      si("View mileage details: ${record["id"]}");
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    int totalTrips = mileageRecords.length;
    int totalDistance = mileageRecords.fold(0, (sum, item) => sum + (item["distance"] as int));
    double totalFuelUsed = mileageRecords.fold(0.0, (sum, item) => sum + (item["fuelUsed"] as double));
    double avgEfficiency = mileageRecords.fold(0.0, (sum, item) => sum + (item["efficiency"] as double)) / mileageRecords.length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
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
              spacing: spSm,
              children: [
                Text(
                  "Mileage Analytics Overview",
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
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.trip_origin, color: primaryColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "$totalTrips",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Trips",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.straighten, color: infoColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "$totalDistance km",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Total Distance",
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
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.local_gas_station, color: warningColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "${totalFuelUsed.toStringAsFixed(1)} L",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Total Fuel",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.eco, color: successColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "${avgEfficiency.toStringAsFixed(1)} km/L",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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
                  "Vehicle Performance Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...vehicles.map((vehicle) {
                  List<Map<String, dynamic>> vehicleRecords = mileageRecords
                      .where((r) => r["vehicleId"] == vehicle["value"])
                      .toList();
                  
                  if (vehicleRecords.isEmpty) return SizedBox.shrink();
                  
                  int vehicleTrips = vehicleRecords.length;
                  int vehicleDistance = vehicleRecords.fold(0, (sum, item) => sum + (item["distance"] as int));
                  double vehicleFuel = vehicleRecords.fold(0.0, (sum, item) => sum + (item["fuelUsed"] as double));
                  double vehicleEfficiency = vehicleRecords.fold(0.0, (sum, item) => sum + (item["efficiency"] as double)) / vehicleRecords.length;
                  
                  Color efficiencyColor = vehicleEfficiency > 20 ? successColor :
                                         vehicleEfficiency > 15 ? warningColor : dangerColor;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.local_shipping, color: primaryColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              vehicle["value"],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: efficiencyColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${vehicleEfficiency.toStringAsFixed(1)} km/L",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: efficiencyColor,
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
                                children: [
                                  Text(
                                    "$vehicleTrips",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Trips",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "$vehicleDistance km",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                  Text(
                                    "Distance",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${vehicleFuel.toStringAsFixed(1)} L",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                  Text(
                                    "Fuel Used",
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
                }).toList(),
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
              spacing: spSm,
              children: [
                Text(
                  "Trip Purpose Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...tripPurposes.take(4).map((purpose) {
                  int purposeCount = mileageRecords.where((r) => r["purpose"] == purpose["value"]).length;
                  if (purposeCount == 0) return SizedBox.shrink();
                  
                  double percentage = (purposeCount / totalTrips) * 100;
                  Color purposeColor = purpose["value"] == "delivery" ? successColor :
                                      purpose["value"] == "pickup" ? infoColor :
                                      purpose["value"] == "maintenance" ? warningColor : disabledBoldColor;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: purposeColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 30,
                          decoration: BoxDecoration(
                            color: purposeColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                purpose["label"],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "$purposeCount trips (${percentage.toStringAsFixed(1)}%)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: purposeColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$purposeCount",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: purposeColor,
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
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Export Report",
                  size: bs.md,
                  onPressed: () {
                    ss("Mileage report exported successfully");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Print Summary",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () {
                    si("Printing mileage summary");
                  },
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
    return QTabBar(
      title: "Mileage Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Add Entry", icon: Icon(Icons.add_road)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildMileageEntryTab(),
        _buildMileageHistoryTab(),
        _buildAnalyticsTab(),
      ],
    );
  }
}
