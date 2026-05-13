import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaMileageTrackingView extends StatefulWidget {
  const LtaMileageTrackingView({super.key});

  @override
  State<LtaMileageTrackingView> createState() => _LtaMileageTrackingViewState();
}

class _LtaMileageTrackingViewState extends State<LtaMileageTrackingView> {
  String selectedVehicle = "all";
  String selectedPeriod = "month";
  String searchQuery = "";

  List<Map<String, dynamic>> vehicleOptions = [
    {"label": "All Vehicles", "value": "all"},
    {"label": "Truck-001", "value": "truck001"},
    {"label": "Van-003", "value": "van003"},
    {"label": "Truck-005", "value": "truck005"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "month"},
    {"label": "This Week", "value": "week"},
    {"label": "Today", "value": "today"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> mileageData = [
    {
      "vehicle": "Truck-001",
      "driver": "John Smith",
      "currentMileage": 145680,
      "lastReading": 145234,
      "todayDistance": 446,
      "weekDistance": 2847,
      "monthDistance": 12450,
      "avgFuelEfficiency": 8.5,
      "lastUpdate": "2024-06-16 09:30",
      "status": "Active",
      "maintenanceDue": 154320,
      "image": "https://picsum.photos/60/60?random=1&keyword=truck"
    },
    {
      "vehicle": "Van-003",
      "driver": "Mike Johnson",
      "currentMileage": 98750,
      "lastReading": 98540,
      "todayDistance": 210,
      "weekDistance": 1560,
      "monthDistance": 8940,
      "avgFuelEfficiency": 12.3,
      "lastUpdate": "2024-06-16 08:15",
      "status": "Active",
      "maintenanceDue": 105000,
      "image": "https://picsum.photos/60/60?random=2&keyword=van"
    },
    {
      "vehicle": "Truck-005",
      "driver": "Sarah Wilson",
      "currentMileage": 203450,
      "lastReading": 202890,
      "todayDistance": 560,
      "weekDistance": 3240,
      "monthDistance": 15780,
      "avgFuelEfficiency": 7.8,
      "lastUpdate": "2024-06-16 10:45",
      "status": "Active",
      "maintenanceDue": 210000,
      "image": "https://picsum.photos/60/60?random=3&keyword=truck"
    },
    {
      "vehicle": "Van-007",
      "driver": "David Brown",
      "currentMileage": 76890,
      "lastReading": 76710,
      "todayDistance": 180,
      "weekDistance": 1120,
      "monthDistance": 6780,
      "avgFuelEfficiency": 11.8,
      "lastUpdate": "2024-06-16 07:20",
      "status": "Maintenance",
      "maintenanceDue": 80000,
      "image": "https://picsum.photos/60/60?random=4&keyword=van"
    },
  ];

  List<Map<String, dynamic>> dailyMileage = [
    {"date": "2024-06-10", "mileage": 2450, "vehicles": 4},
    {"date": "2024-06-11", "mileage": 2780, "vehicles": 4},
    {"date": "2024-06-12", "mileage": 3120, "vehicles": 3},
    {"date": "2024-06-13", "mileage": 2890, "vehicles": 4},
    {"date": "2024-06-14", "mileage": 3450, "vehicles": 4},
    {"date": "2024-06-15", "mileage": 2680, "vehicles": 3},
    {"date": "2024-06-16", "mileage": 1396, "vehicles": 4},
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'maintenance':
        return warningColor;
      case 'inactive':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  int _getTotalMileage() {
    return mileageData.fold(0, (sum, vehicle) => sum + (vehicle["todayDistance"] as int));
  }

  double _getAvgFuelEfficiency() {
    if (mileageData.isEmpty) return 0.0;
    double total = mileageData.fold(0.0, (sum, vehicle) => sum + (vehicle["avgFuelEfficiency"] as num));
    return total / mileageData.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mileage Tracking"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              _showAddMileageDialog();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSummaryCards(),
            _buildFilters(),
            _buildMileageChart(),
            _buildVehicleMileageList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Today's Total",
          "${_getTotalMileage()} km",
          Icons.today,
          primaryColor,
          "+12% from yesterday",
        ),
        _buildSummaryCard(
          "Active Vehicles",
          "${mileageData.where((v) => v["status"] == "Active").length}",
          Icons.directions_car,
          successColor,
          "Out of ${mileageData.length} total",
        ),
        _buildSummaryCard(
          "Avg Efficiency",
          "${_getAvgFuelEfficiency().toStringAsFixed(1)} km/L",
          Icons.local_gas_station,
          infoColor,
          "Fleet average",
        ),
        _buildSummaryCard(
          "Maintenance Due",
          "${mileageData.where((v) => (v["currentMileage"] as int) > (v["maintenanceDue"] as int) - 5000).length}",
          Icons.build,
          warningColor,
          "Vehicles need service",
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                size: 16,
                color: successColor,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
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
              Expanded(
                child: QTextField(
                  label: "Search vehicle or driver...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Vehicle",
                  items: vehicleOptions,
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
                  label: "Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMileageChart() {
    return Container(
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
              Icon(Icons.bar_chart, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Daily Mileage Trend",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  ss("Refreshing chart data...");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: dailyMileage.map((day) {
                  double maxMileage = dailyMileage
                      .map((d) => d["mileage"] as int)
                      .reduce((a, b) => a > b ? a : b)
                      .toDouble();
                  double height = ((day["mileage"] as int) / maxMileage) * 150;
                  
                  return Container(
                    width: 40,
                    margin: EdgeInsets.only(right: spXs),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${day["mileage"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          width: 30,
                          height: height,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(day["date"] as String).substring(8)}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleMileageList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.directions_car, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Vehicle Mileage Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {
                    ss("Exporting mileage report...");
                  },
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: mileageData.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final vehicle = mileageData[index];
              int maintenanceKm = (vehicle["maintenanceDue"] as int) - (vehicle["currentMileage"] as int);
              bool maintenanceDue = maintenanceKm <= 5000;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${vehicle["image"]}"),
                          fit: BoxFit.cover,
                        ),
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
                                "${vehicle["vehicle"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${vehicle["status"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${vehicle["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getStatusColor("${vehicle["status"]}"),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (maintenanceDue) ...[
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Service Due",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Driver: ${vehicle["driver"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Current: ${(vehicle["currentMileage"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} km",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Today: ${vehicle["todayDistance"]} km",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
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
                                      "Week: ${vehicle["weekDistance"]} km",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Month: ${vehicle["monthDistance"]} km",
                                      style: TextStyle(
                                        fontSize: 11,
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
                                    "${vehicle["avgFuelEfficiency"]} km/L",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Efficiency",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Column(
                      children: [
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            _showEditMileageDialog(vehicle);
                          },
                        ),
                        SizedBox(height: spXs),
                        QButton(
                          icon: Icons.bar_chart,
                          size: bs.sm,
                          onPressed: () {
                            ss("Viewing ${vehicle["vehicle"]} detailed report");
                          },
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
    );
  }

  void _showAddMileageDialog() {
    String selectedVehicleDialog = "";
    String currentMileage = "";
    String fuelAmount = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Mileage Reading"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Select Vehicle",
              items: vehicleOptions.where((v) => v["value"] != "all").toList(),
              value: selectedVehicleDialog,
              onChanged: (value, label) {
                selectedVehicleDialog = value;
              },
            ),
            SizedBox(height: spSm),
            QNumberField(
              label: "Current Mileage (km)",
              value: currentMileage,
              onChanged: (value) {
                currentMileage = value;
              },
            ),
            SizedBox(height: spSm),
            QNumberField(
              label: "Fuel Amount (L)",
              value: fuelAmount,
              onChanged: (value) {
                fuelAmount = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Mileage reading saved successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showEditMileageDialog(Map<String, dynamic> vehicle) {
    String currentMileage = "${vehicle["currentMileage"]}";
    String fuelEfficiency = "${vehicle["avgFuelEfficiency"]}";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit ${vehicle["vehicle"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QNumberField(
              label: "Current Mileage (km)",
              value: currentMileage,
              onChanged: (value) {
                currentMileage = value;
              },
            ),
            SizedBox(height: spSm),
            QNumberField(
              label: "Fuel Efficiency (km/L)",
              value: fuelEfficiency,
              onChanged: (value) {
                fuelEfficiency = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Update",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Vehicle data updated successfully");
            },
          ),
        ],
      ),
    );
  }
}
