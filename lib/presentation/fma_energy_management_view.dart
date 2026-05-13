import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaEnergyManagementView extends StatefulWidget {
  const FmaEnergyManagementView({super.key});

  @override
  State<FmaEnergyManagementView> createState() => _FmaEnergyManagementViewState();
}

class _FmaEnergyManagementViewState extends State<FmaEnergyManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedPeriod = "this_month";
  String selectedMeter = "all";

  List<Map<String, dynamic>> energyData = [
    {
      "id": "1",
      "date": "2024-06-19",
      "electricity_usage": 2450.5,
      "electricity_cost": 245.05,
      "gas_usage": 180.2,
      "gas_cost": 162.18,
      "water_usage": 1200.0,
      "water_cost": 48.00,
      "total_cost": 455.23,
      "efficiency_score": 85,
      "peak_demand": 15.8,
      "off_peak_usage": 1800.3,
      "renewable_percentage": 25.0,
    },
    {
      "id": "2", 
      "date": "2024-06-18",
      "electricity_usage": 2380.2,
      "electricity_cost": 238.02,
      "gas_usage": 175.5,
      "gas_cost": 157.95,
      "water_usage": 1150.0,
      "water_cost": 46.00,
      "total_cost": 441.97,
      "efficiency_score": 88,
      "peak_demand": 14.9,
      "off_peak_usage": 1750.8,
      "renewable_percentage": 28.0,
    },
    {
      "id": "3",
      "date": "2024-06-17",
      "electricity_usage": 2520.8,
      "electricity_cost": 252.08,
      "gas_usage": 185.0,
      "gas_cost": 166.50,
      "water_usage": 1280.0,
      "water_cost": 51.20,
      "total_cost": 469.78,
      "efficiency_score": 82,
      "peak_demand": 16.2,
      "off_peak_usage": 1820.5,
      "renewable_percentage": 22.0,
    },
  ];

  List<Map<String, dynamic>> meterReadings = [
    {
      "id": "1",
      "meter_type": "Electricity",
      "location": "Main Building",
      "current_reading": 125480.5,
      "previous_reading": 123030.0,
      "usage": 2450.5,
      "unit": "kWh",
      "cost_per_unit": 0.10,
      "status": "active",
      "last_reading": "2024-06-19 08:00",
      "next_reading": "2024-06-20 08:00",
    },
    {
      "id": "2",
      "meter_type": "Gas",
      "location": "Kitchen Area",
      "current_reading": 8520.2,
      "previous_reading": 8340.0,
      "usage": 180.2,
      "unit": "m³",
      "cost_per_unit": 0.90,
      "status": "active",
      "last_reading": "2024-06-19 08:15",
      "next_reading": "2024-06-20 08:15",
    },
    {
      "id": "3",
      "meter_type": "Water",
      "location": "Main Supply",
      "current_reading": 45200.0,
      "previous_reading": 44000.0,
      "usage": 1200.0,
      "unit": "L",
      "cost_per_unit": 0.04,
      "status": "active",
      "last_reading": "2024-06-19 08:30",
      "next_reading": "2024-06-20 08:30",
    },
    {
      "id": "4",
      "meter_type": "Electricity",
      "location": "HVAC System",
      "current_reading": 28450.8,
      "previous_reading": 27980.5,
      "usage": 470.3,
      "unit": "kWh",
      "cost_per_unit": 0.10,
      "status": "maintenance",
      "last_reading": "2024-06-18 16:00",
      "next_reading": "2024-06-20 16:00",
    },
  ];

  List<Map<String, dynamic>> alerts = [
    {
      "id": "1",
      "type": "high_usage",
      "message": "Electricity usage 15% above average",
      "severity": "warning",
      "location": "Main Building",
      "timestamp": "2024-06-19 14:30",
      "value": 2450.5,
      "threshold": 2130.0,
      "status": "active",
    },
    {
      "id": "2",
      "type": "meter_error",
      "message": "HVAC meter reading overdue",
      "severity": "danger",
      "location": "HVAC System",
      "timestamp": "2024-06-19 12:00",
      "status": "active",
    },
    {
      "id": "3",
      "type": "efficiency",
      "message": "Energy efficiency below target",
      "severity": "info",
      "location": "Kitchen Area",
      "timestamp": "2024-06-19 10:15",
      "value": 82.0,
      "threshold": 85.0,
      "status": "resolved",
    },
  ];

  List<Map<String, dynamic>> get filteredEnergyData {
    return energyData.where((data) {
      bool matchesSearch = searchQuery.isEmpty ||
          (data["date"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  List<Map<String, dynamic>> get filteredMeterReadings {
    return meterReadings.where((meter) {
      bool matchesSearch = searchQuery.isEmpty ||
          (meter["meter_type"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (meter["location"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesMeter = selectedMeter == "all" || (meter["meter_type"] as String).toLowerCase() == selectedMeter.toLowerCase();
      return matchesSearch && matchesMeter;
    }).toList();
  }

  List<Map<String, dynamic>> get activeAlerts {
    return alerts.where((alert) => (alert["status"] as String) == "active").toList();
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'danger':
        return dangerColor;
      case 'warning':
        return warningColor;
      case 'info':
        return infoColor;
      default:
        return successColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'maintenance':
        return warningColor;
      case 'error':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildOverviewTab() {
    double totalElectricity = filteredEnergyData.fold(0.0, (sum, data) => sum + (data["electricity_cost"] as double));
    double totalGas = filteredEnergyData.fold(0.0, (sum, data) => sum + (data["gas_cost"] as double));
    double totalWater = filteredEnergyData.fold(0.0, (sum, data) => sum + (data["water_cost"] as double));
    double totalCost = totalElectricity + totalGas + totalWater;
    double avgEfficiency = filteredEnergyData.fold(0.0, (sum, data) => sum + (data["efficiency_score"] as int)) / filteredEnergyData.length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildSummaryCard(
                "Total Cost",
                "\$${totalCost.toStringAsFixed(2)}",
                Icons.attach_money,
                primaryColor,
              ),
              _buildSummaryCard(
                "Electricity",
                "\$${totalElectricity.toStringAsFixed(2)}",
                Icons.electrical_services,
                warningColor,
              ),
              _buildSummaryCard(
                "Gas Usage",
                "\$${totalGas.toStringAsFixed(2)}",
                Icons.local_fire_department,
                infoColor,
              ),
              _buildSummaryCard(
                "Water Usage",
                "\$${totalWater.toStringAsFixed(2)}",
                Icons.water_drop,
                successColor,
              ),
            ],
          ),

          // Efficiency and Alerts Row
          Row(
            spacing: spMd,
            children: [
              Expanded(
                child: Container(
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
                        "Energy Efficiency",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${avgEfficiency.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: avgEfficiency >= 85 ? successColor : warningColor,
                        ),
                      ),
                      Text(
                        avgEfficiency >= 85 ? "Excellent" : "Needs Improvement",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
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
                        "Active Alerts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${activeAlerts.length}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: activeAlerts.length > 0 ? dangerColor : successColor,
                        ),
                      ),
                      Text(
                        activeAlerts.length > 0 ? "Requires Attention" : "All Clear",
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

          // Recent Energy Data
          Container(
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
                  "Recent Energy Usage",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...filteredEnergyData.take(3).map((data) => Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${DateTime.parse(data["date"] as String).dMMMy}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Electricity: ${(data["electricity_usage"] as double).toStringAsFixed(1)} kWh",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${(data["total_cost"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (data["efficiency_score"] as int) >= 85 ? successColor : warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${data["efficiency_score"]}% Eff",
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
                )).toList(),
              ],
            ),
          ),

          // Active Alerts
          if (activeAlerts.isNotEmpty)
            Container(
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
                    "Active Alerts",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...activeAlerts.map((alert) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getSeverityColor(alert["severity"] as String).withAlpha(20),
                      border: Border.all(color: _getSeverityColor(alert["severity"] as String)),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          alert["severity"] == "danger" ? Icons.error :
                          alert["severity"] == "warning" ? Icons.warning :
                          Icons.info,
                          color: _getSeverityColor(alert["severity"] as String),
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${alert["message"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${alert["location"]} • ${DateTime.parse(alert["timestamp"] as String).dMMMy}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: "Resolve",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMetersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Search meters...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                width: 150,
                child: QDropdownField(
                  label: "Meter Type",
                  value: selectedMeter,
                  items: [
                    {"label": "All Types", "value": "all"},
                    {"label": "Electricity", "value": "electricity"},
                    {"label": "Gas", "value": "gas"},
                    {"label": "Water", "value": "water"},
                  ],
                  onChanged: (value, label) {
                    selectedMeter = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Meter Readings List
          ...filteredMeterReadings.map((meter) => Container(
            margin: EdgeInsets.only(bottom: spSm),
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
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        meter["meter_type"] == "Electricity" ? Icons.electrical_services :
                        meter["meter_type"] == "Gas" ? Icons.local_fire_department :
                        Icons.water_drop,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${meter["meter_type"]} - ${meter["location"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Last reading: ${DateTime.parse(meter["last_reading"] as String).dMMMy}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor(meter["status"] as String),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${meter["status"]}".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  minItemWidth: 200,
                  children: [
                    _buildMeterStatCard(
                      "Current Reading",
                      "${(meter["current_reading"] as double).toStringAsFixed(1)} ${meter["unit"]}",
                      Icons.speed,
                      infoColor,
                    ),
                    _buildMeterStatCard(
                      "Usage",
                      "${(meter["usage"] as double).toStringAsFixed(1)} ${meter["unit"]}",
                      Icons.trending_up,
                      warningColor,
                    ),
                    _buildMeterStatCard(
                      "Cost",
                      "\$${((meter["usage"] as double) * (meter["cost_per_unit"] as double)).toStringAsFixed(2)}",
                      Icons.attach_money,
                      successColor,
                    ),
                    _buildMeterStatCard(
                      "Rate",
                      "\$${(meter["cost_per_unit"] as double).toStringAsFixed(3)} per ${meter["unit"]}",
                      Icons.calculate,
                      primaryColor,
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Update Reading",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "View History",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeterStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Energy Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Meters", icon: Icon(Icons.speed)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildMetersTab(),
      ],
    );
  }
}
