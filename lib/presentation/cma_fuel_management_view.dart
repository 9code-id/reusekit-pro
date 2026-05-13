import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaFuelManagementView extends StatefulWidget {
  const CmaFuelManagementView({super.key});

  @override
  State<CmaFuelManagementView> createState() => _CmaFuelManagementViewState();
}

class _CmaFuelManagementViewState extends State<CmaFuelManagementView> {
  int currentTab = 0;
  String selectedVehicle = "";
  String selectedDriver = "";
  String selectedPeriod = "this_week";
  String fuelAmount = "";
  String fuelCost = "";
  String mileage = "";
  String fuelStation = "";
  
  List<Map<String, dynamic>> fuelRecords = [
    {
      "id": "FR001",
      "vehicle": "TRK-001",
      "driver": "John Smith",
      "date": "2025-06-18",
      "time": "08:30",
      "station": "Shell Station Downtown",
      "amount": 45.2,
      "cost": 68.75,
      "pricePerLiter": 1.52,
      "mileage": 45250,
      "efficiency": 8.2,
      "fuelType": "Diesel",
      "receipt": "R12345",
      "location": "Downtown",
      "approved": true
    },
    {
      "id": "FR002",
      "vehicle": "VAN-002", 
      "driver": "Maria Garcia",
      "date": "2025-06-17",
      "time": "14:15",
      "station": "BP Gas Station",
      "amount": 38.8,
      "cost": 56.20,
      "pricePerLiter": 1.45,
      "mileage": 28750,
      "efficiency": 7.8,
      "fuelType": "Gasoline",
      "receipt": "R12346",
      "location": "Suburban",
      "approved": true
    },
    {
      "id": "FR003",
      "vehicle": "TRK-003",
      "driver": "David Chen",
      "date": "2025-06-16",
      "time": "11:45",
      "station": "Texaco Express",
      "amount": 52.1,
      "cost": 78.30,
      "pricePerLiter": 1.50,
      "mileage": 52100,
      "efficiency": 8.5,
      "fuelType": "Diesel",
      "receipt": "R12347",
      "location": "Industrial",
      "approved": false
    }
  ];

  List<Map<String, dynamic>> vehicles = [
    {"label": "TRK-001 - Delivery Truck", "value": "TRK-001"},
    {"label": "VAN-002 - Cargo Van", "value": "VAN-002"},
    {"label": "TRK-003 - Heavy Truck", "value": "TRK-003"},
    {"label": "CAR-004 - Service Car", "value": "CAR-004"}
  ];

  List<Map<String, dynamic>> drivers = [
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Maria Garcia", "value": "maria_garcia"},
    {"label": "David Chen", "value": "david_chen"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"}
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "this_week"},
    {"label": "This Month", "value": "this_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Custom Range", "value": "custom"}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Fuel Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Fuel Records", icon: Icon(Icons.local_gas_station)),
        Tab(text: "Add Record", icon: Icon(Icons.add)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildFuelRecordsTab(),
        _buildAddRecordTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFuelSummaryCards(),
          _buildTodaysFuelActivity(),
          _buildFuelEfficiencyOverview(),
        ],
      ),
    );
  }

  Widget _buildFuelSummaryCards() {
    double totalCost = fuelRecords.fold(0.0, (sum, record) => sum + (record["cost"] as double));
    double totalAmount = fuelRecords.fold(0.0, (sum, record) => sum + (record["amount"] as double));
    double avgEfficiency = fuelRecords.fold(0.0, (sum, record) => sum + (record["efficiency"] as double)) / fuelRecords.length;
    
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard("Total Fuel Cost", "\$${totalCost.toStringAsFixed(2)}", Icons.attach_money, dangerColor, "+8.5%"),
        _buildSummaryCard("Total Fuel Used", "${totalAmount.toStringAsFixed(1)} L", Icons.local_gas_station, primaryColor, "-2.3%"),
        _buildSummaryCard("Avg Efficiency", "${avgEfficiency.toStringAsFixed(1)} L/100km", Icons.eco, successColor, "+5.2%"),
        _buildSummaryCard("Active Vehicles", "${vehicles.length}", Icons.directions_car, infoColor, "100%"),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color, String change) {
    bool isPositive = change.startsWith('+');
    Color changeColor = isPositive ? successColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: changeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    color: changeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysFuelActivity() {
    List<Map<String, dynamic>> todaysRecords = fuelRecords.where((record) => 
      record["date"] == "2025-06-18").toList();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Today's Fuel Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${todaysRecords.length} Records",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          if (todaysRecords.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.local_gas_station, color: disabledBoldColor, size: 48),
                    SizedBox(height: spSm),
                    Text(
                      "No fuel records for today",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...todaysRecords.map((record) => _buildTodayActivityItem(record)).toList(),
        ],
      ),
    );
  }

  Widget _buildTodayActivityItem(Map<String, dynamic> record) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(20)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(Icons.local_gas_station, color: primaryColor, size: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${record["vehicle"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${record["time"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${(record["amount"] as double).toStringAsFixed(1)}L",
                      style: TextStyle(
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(" • ", style: TextStyle(color: disabledBoldColor)),
                    Text(
                      "\$${(record["cost"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(" • ", style: TextStyle(color: disabledBoldColor)),
                    Text(
                      "${record["driver"]}",
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
        ],
      ),
    );
  }

  Widget _buildFuelEfficiencyOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Fleet Fuel Efficiency",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...vehicles.take(3).map((vehicle) {
            String vehicleId = vehicle["value"];
            List<Map<String, dynamic>> vehicleRecords = fuelRecords.where((r) => r["vehicle"] == vehicleId).toList();
            double avgEfficiency = vehicleRecords.isNotEmpty 
              ? vehicleRecords.fold(0.0, (sum, r) => sum + (r["efficiency"] as double)) / vehicleRecords.length
              : 0.0;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
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
                    child: Icon(Icons.local_shipping, color: primaryColor, size: 16),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${vehicle["label"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${avgEfficiency.toStringAsFixed(1)} L/100km",
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFuelRecordsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFuelRecordsFilters(),
          _buildFuelRecordsList(),
        ],
      ),
    );
  }

  Widget _buildFuelRecordsFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Filter Records",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Vehicle",
                  items: vehicles,
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
                  label: "Driver",
                  items: drivers,
                  value: selectedDriver,
                  onChanged: (value, label) {
                    selectedDriver = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          QDropdownField(
            label: "Time Period",
            items: periodOptions,
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFuelRecordsList() {
    return Column(
      spacing: spSm,
      children: fuelRecords.map((record) => _buildFuelRecordCard(record)).toList(),
    );
  }

  Widget _buildFuelRecordCard(Map<String, dynamic> record) {
    Color statusColor = record["approved"] ? successColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(Icons.local_gas_station, color: primaryColor, size: 24),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${record["vehicle"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            record["approved"] ? "Approved" : "Pending",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${record["driver"]} • ${record["date"]} ${record["time"]}",
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

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${record["station"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Icon(Icons.receipt, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Receipt: ${record["receipt"]}",
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

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildRecordMetric("Amount", "${(record["amount"] as double).toStringAsFixed(1)} L", Icons.local_gas_station),
              _buildRecordMetric("Cost", "\$${(record["cost"] as double).toStringAsFixed(2)}", Icons.attach_money),
              _buildRecordMetric("Price/L", "\$${(record["pricePerLiter"] as double).toStringAsFixed(2)}", Icons.receipt_long),
              _buildRecordMetric("Efficiency", "${(record["efficiency"] as double).toStringAsFixed(1)} L/100km", Icons.eco),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              if (!record["approved"])
                QButton(
                  icon: Icons.check,
                  size: bs.sm,
                  onPressed: () {
                    ss("Fuel record approved!");
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecordMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: disabledBoldColor, size: 16),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
              fontSize: 12,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddRecordTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Add Fuel Record",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                QDropdownField(
                  label: "Vehicle",
                  items: vehicles,
                  value: selectedVehicle,
                  onChanged: (value, label) {
                    selectedVehicle = value;
                    setState(() {});
                  },
                ),

                QDropdownField(
                  label: "Driver",
                  items: drivers,
                  value: selectedDriver,
                  onChanged: (value, label) {
                    selectedDriver = value;
                    setState(() {});
                  },
                ),

                QTextField(
                  label: "Fuel Station",
                  value: fuelStation,
                  hint: "Enter fuel station name",
                  onChanged: (value) {
                    fuelStation = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Fuel Amount (L)",
                        value: fuelAmount,
                        onChanged: (value) {
                          fuelAmount = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Total Cost (\$)",
                        value: fuelCost,
                        onChanged: (value) {
                          fuelCost = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QNumberField(
                  label: "Current Mileage (km)",
                  value: mileage,
                  onChanged: (value) {
                    mileage = value;
                    setState(() {});
                  },
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Add Fuel Record",
                    size: bs.md,
                    onPressed: () {
                      ss("Fuel record added successfully!");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFuelTrends(),
          _buildVehicleComparison(),
          _buildCostAnalysis(),
        ],
      ),
    );
  }

  Widget _buildFuelTrends() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Fuel Consumption Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            height: 200,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.trending_down, color: successColor, size: 48),
                  SizedBox(height: spSm),
                  Text(
                    "Fuel Consumption Down 12%",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Compared to last month",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleComparison() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Vehicle Fuel Efficiency Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...vehicles.map((vehicle) {
            String vehicleId = vehicle["value"];
            List<Map<String, dynamic>> vehicleRecords = fuelRecords.where((r) => r["vehicle"] == vehicleId).toList();
            double avgEfficiency = vehicleRecords.isNotEmpty 
              ? vehicleRecords.fold(0.0, (sum, r) => sum + (r["efficiency"] as double)) / vehicleRecords.length
              : 0.0;
            double totalCost = vehicleRecords.fold(0.0, (sum, r) => sum + (r["cost"] as double));
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(20)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(Icons.local_shipping, color: primaryColor, size: 20),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${vehicle["label"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${avgEfficiency.toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "L/100km",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 10,
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
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "\$${totalCost.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Total Cost",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 10,
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
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCostAnalysis() {
    double totalMonthlyCost = fuelRecords.fold(0.0, (sum, record) => sum + (record["cost"] as double));
    double avgCostPerDay = totalMonthlyCost / 30;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Cost Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildAnalysisMetric("Monthly Cost", "\$${totalMonthlyCost.toStringAsFixed(2)}", Icons.calculate, dangerColor),
              _buildAnalysisMetric("Daily Average", "\$${avgCostPerDay.toStringAsFixed(2)}", Icons.today, warningColor),
              _buildAnalysisMetric("Cost per Liter", "\$1.49", Icons.local_gas_station, infoColor),
              _buildAnalysisMetric("Budget Status", "85% Used", Icons.account_balance_wallet, successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
