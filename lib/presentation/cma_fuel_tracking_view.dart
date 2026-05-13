import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaFuelTrackingView extends StatefulWidget {
  const CmaFuelTrackingView({super.key});

  @override
  State<CmaFuelTrackingView> createState() => _CmaFuelTrackingViewState();
}

class _CmaFuelTrackingViewState extends State<CmaFuelTrackingView> {
  int currentTab = 0;
  
  // Fuel tracking data
  List<Map<String, dynamic>> fuelRecords = [
    {
      "date": "2024-06-20",
      "odometer": 52800,
      "liters": 45.2,
      "cost": 67.80,
      "station": "Shell Station",
      "fuel_type": "Regular",
      "full_tank": true,
      "notes": "Road trip fill-up"
    },
    {
      "date": "2024-06-18",
      "odometer": 52500,
      "liters": 38.5,
      "cost": 57.75,
      "station": "BP Station",
      "fuel_type": "Regular",
      "full_tank": true,
      "notes": "Regular commute"
    },
    {
      "date": "2024-06-15",
      "odometer": 52200,
      "liters": 40.1,
      "cost": 60.15,
      "station": "Chevron",
      "fuel_type": "Premium",
      "full_tank": true,
      "notes": "Premium for highway driving"
    },
    {
      "date": "2024-06-12",
      "odometer": 51900,
      "liters": 42.8,
      "cost": 64.20,
      "station": "Exxon Mobil",
      "fuel_type": "Regular",
      "full_tank": true,
      "notes": "Weekly fill-up"
    },
    {
      "date": "2024-06-08",
      "odometer": 51600,
      "liters": 39.6,
      "cost": 59.40,
      "station": "Shell Station",
      "fuel_type": "Regular",
      "full_tank": false,
      "notes": "Partial fill due to low funds"
    }
  ];

  List<Map<String, dynamic>> fuelStations = [
    {"name": "Shell Station", "address": "123 Main St"},
    {"name": "BP Station", "address": "456 Oak Ave"},
    {"name": "Chevron", "address": "789 Pine Rd"},
    {"name": "Exxon Mobil", "address": "321 Elm St"},
    {"name": "Other", "address": "Custom location"}
  ];

  List<Map<String, dynamic>> fuelTypes = [
    {"label": "Regular", "value": "Regular"},
    {"label": "Premium", "value": "Premium"},
    {"label": "Diesel", "value": "Diesel"},
    {"label": "E85", "value": "E85"}
  ];

  // Form fields for new fuel record
  String fillDate = DateTime.now().toString().split(' ')[0];
  String odometer = "";
  String liters = "";
  String cost = "";
  String selectedStation = "Shell Station";
  String selectedFuelType = "Regular";
  bool fullTank = true;
  String notes = "";

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Fuel Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.local_gas_station)),
        Tab(text: "Records", icon: Icon(Icons.receipt)),
        Tab(text: "Add Fill", icon: Icon(Icons.add)),
        Tab(text: "Statistics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildRecordsTab(),
        _buildAddFillTab(),
        _buildStatisticsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    // Calculate fuel economy and costs
    double totalCost = fuelRecords.map((r) => r["cost"] as double).reduce((a, b) => a + b);
    double totalLiters = fuelRecords.map((r) => r["liters"] as double).reduce((a, b) => a + b);
    double avgCostPerLiter = totalCost / totalLiters;
    
    // Calculate fuel economy (simplified)
    var lastRecord = fuelRecords.first;
    var firstRecord = fuelRecords.last;
    int totalKm = (lastRecord["odometer"] as int) - (firstRecord["odometer"] as int);
    double fuelEconomy = totalKm / totalLiters;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Current Status
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.local_gas_station, color: Colors.white, size: 32),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Fuel Economy",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${fuelEconomy.toStringAsFixed(1)} km/L",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Last Fill",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "${DateTime.parse("${lastRecord["date"]}").dMMMy}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
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

          // Quick Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Total Spent",
                  "\$${totalCost.toStringAsFixed(2)}",
                  Icons.payments,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Avg Price/L",
                  "\$${avgCostPerLiter.toStringAsFixed(2)}",
                  Icons.trending_up,
                  successColor,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Total Fuel",
                  "${totalLiters.toStringAsFixed(1)}L",
                  Icons.local_gas_station,
                  infoColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Fill-ups",
                  "${fuelRecords.length}",
                  Icons.format_list_numbered,
                  warningColor,
                ),
              ),
            ],
          ),

          // Recent Fills
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
              children: [
                Row(
                  children: [
                    Text(
                      "Recent Fill-ups",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      color: secondaryColor,
                      onPressed: () {
                        setState(() {
                          currentTab = 1;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...fuelRecords.take(3).map((record) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.local_gas_station,
                          color: primaryColor,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${DateTime.parse("${record["date"]}").dMMMy}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${record["liters"]}L • ${record["station"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${(record["cost"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),

          // Quick Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Add Fill-up",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: () {
                    setState(() {
                      currentTab = 2;
                    });
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View Statistics",
                  icon: Icons.analytics,
                  size: bs.md,
                  color: secondaryColor,
                  onPressed: () {
                    setState(() {
                      currentTab = 3;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecordsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Records Header
          Row(
            children: [
              Icon(Icons.receipt, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fuel Records",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${fuelRecords.length} fill-up records",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Export",
                icon: Icons.download,
                size: bs.sm,
                color: secondaryColor,
                onPressed: () {
                  ss("Fuel records exported");
                },
              ),
            ],
          ),

          // Records List
          ...fuelRecords.map((record) => Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: (record["full_tank"] as bool) ? successColor : warningColor,
                ),
              ),
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
                            "${DateTime.parse("${record["date"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${record["station"]} • ${record["fuel_type"]}",
                            style: TextStyle(
                              fontSize: 14,
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
                          "\$${(record["cost"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (record["full_tank"] as bool) ? successColor : warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            (record["full_tank"] as bool) ? "Full" : "Partial",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(child: _buildRecordDetail("Odometer", "${record["odometer"]} km")),
                    Expanded(child: _buildRecordDetail("Fuel", "${record["liters"]}L")),
                    Expanded(child: _buildRecordDetail("Price/L", "\$${((record["cost"] as double) / (record["liters"] as double)).toStringAsFixed(2)}")),
                  ],
                ),
                if ("${record["notes"]}".isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${record["notes"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildAddFillTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Add Fill Header
          Row(
            children: [
              Icon(Icons.add, color: successColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Add New Fill-up",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Fill-up Form
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
              spacing: spMd,
              children: [
                Text(
                  "Fill-up Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                QDatePicker(
                  label: "Fill-up Date",
                  value: DateTime.parse(fillDate),
                  onChanged: (value) {
                    fillDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),

                QNumberField(
                  label: "Odometer Reading (km)",
                  value: odometer,
                  hint: "Enter current odometer reading",
                  onChanged: (value) {
                    odometer = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Fuel Amount (L)",
                        value: liters,
                        hint: "Liters filled",
                        onChanged: (value) {
                          liters = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Total Cost (\$)",
                        value: cost,
                        hint: "Amount paid",
                        onChanged: (value) {
                          cost = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QDropdownField(
                  label: "Gas Station",
                  items: fuelStations,
                  value: selectedStation,
                  onChanged: (value, label) {
                    selectedStation = value;
                    setState(() {});
                  },
                ),

                QDropdownField(
                  label: "Fuel Type",
                  items: fuelTypes,
                  value: selectedFuelType,
                  onChanged: (value, label) {
                    selectedFuelType = value;
                    setState(() {});
                  },
                ),

                QSwitch(
                  label: "Fill-up Type",
                  items: [
                    {
                      "label": "Full Tank",
                      "value": true,
                      "checked": fullTank,
                    }
                  ],
                  value: [if (fullTank) {"label": "Full Tank", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    fullTank = values.isNotEmpty;
                    setState(() {});
                  },
                ),

                QMemoField(
                  label: "Notes (Optional)",
                  value: notes,
                  hint: "Any additional notes about this fill-up",
                  onChanged: (value) {
                    notes = value;
                    setState(() {});
                  },
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Save Fill-up Record",
                    icon: Icons.save,
                    size: bs.md,
                    onPressed: () {
                      if (odometer.isEmpty || liters.isEmpty || cost.isEmpty) {
                        se("Please fill in all required fields");
                        return;
                      }

                      fuelRecords.insert(0, {
                        "date": fillDate,
                        "odometer": int.tryParse(odometer) ?? 0,
                        "liters": double.tryParse(liters) ?? 0.0,
                        "cost": double.tryParse(cost) ?? 0.0,
                        "station": selectedStation,
                        "fuel_type": selectedFuelType,
                        "full_tank": fullTank,
                        "notes": notes.isEmpty ? "No additional notes" : notes
                      });

                      setState(() {
                        currentTab = 0;
                        odometer = "";
                        liters = "";
                        cost = "";
                        notes = "";
                      });
                      ss("Fill-up record saved successfully");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Quick Tips
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.tips_and_updates, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Fill-up Tips",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "• Record odometer reading before filling\n• Fill tank completely for accurate tracking\n• Keep receipts for expense records\n• Note any unusual circumstances\n• Check tire pressure while at station",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsTab() {
    // Calculate comprehensive statistics
    double totalCost = fuelRecords.map((r) => r["cost"] as double).reduce((a, b) => a + b);
    double totalLiters = fuelRecords.map((r) => r["liters"] as double).reduce((a, b) => a + b);
    double avgCostPerLiter = totalCost / totalLiters;
    double avgCostPerFillup = totalCost / fuelRecords.length;
    
    // Calculate distance and fuel economy
    var sortedRecords = List.from(fuelRecords)..sort((a, b) => (a["odometer"] as int).compareTo(b["odometer"] as int));
    int totalDistance = (sortedRecords.last["odometer"] as int) - (sortedRecords.first["odometer"] as int);
    double fuelEconomy = totalDistance / totalLiters;
    
    // Monthly statistics
    Map<String, double> monthlyCosts = {};
    for (var record in fuelRecords) {
      String month = "${record["date"]}".substring(0, 7);
      monthlyCosts[month] = (monthlyCosts[month] ?? 0) + (record["cost"] as double);
    }
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Statistics Header
          Row(
            children: [
              Icon(Icons.analytics, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Fuel Statistics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Overall Statistics
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
              children: [
                Text(
                  "Overall Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(child: _buildStatisticItem("Fuel Economy", "${fuelEconomy.toStringAsFixed(1)} km/L", Icons.speed)),
                    Expanded(child: _buildStatisticItem("Total Distance", "${totalDistance} km", Icons.straighten)),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(child: _buildStatisticItem("Total Spent", "\$${totalCost.toStringAsFixed(2)}", Icons.payments)),
                    Expanded(child: _buildStatisticItem("Avg per Fill", "\$${avgCostPerFillup.toStringAsFixed(2)}", Icons.local_gas_station)),
                  ],
                ),
              ],
            ),
          ),

          // Fuel Analysis
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
              children: [
                Text(
                  "Fuel Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(child: _buildStatisticItem("Avg Price/L", "\$${avgCostPerLiter.toStringAsFixed(2)}", Icons.trending_up)),
                    Expanded(child: _buildStatisticItem("Total Fuel", "${totalLiters.toStringAsFixed(1)}L", Icons.local_gas_station)),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(child: _buildStatisticItem("Fill-ups", "${fuelRecords.length}", Icons.format_list_numbered)),
                    Expanded(child: _buildStatisticItem("Full Tanks", "${fuelRecords.where((r) => r["full_tank"] as bool).length}", Icons.battery_full)),
                  ],
                ),
              ],
            ),
          ),

          // Monthly Breakdown
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
              children: [
                Text(
                  "Monthly Spending",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ...monthlyCosts.entries.map((entry) => Container(
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  child: Row(
                    children: [
                      Text(
                        "${DateTime.parse("${entry.key}-01").dMMMy.split(' ').take(2).join(' ')}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${entry.value.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),

          // Fuel Station Analysis
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
              children: [
                Text(
                  "Favorite Stations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                ...(() {
                  Map<String, int> stationCounts = {};
                  for (var record in fuelRecords) {
                    String station = "${record["station"]}";
                    stationCounts[station] = (stationCounts[station] ?? 0) + 1;
                  }
                  var sortedStations = stationCounts.entries.toList()
                    ..sort((a, b) => b.value.compareTo(a.value));
                  
                  return sortedStations.map((entry) => Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.local_gas_station,
                            color: primaryColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${entry.value}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )).toList();
                })(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordDetail(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
