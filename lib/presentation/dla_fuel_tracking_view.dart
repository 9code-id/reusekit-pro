import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaFuelTrackingView extends StatefulWidget {
  const DlaFuelTrackingView({super.key});

  @override
  State<DlaFuelTrackingView> createState() => _DlaFuelTrackingViewState();
}

class _DlaFuelTrackingViewState extends State<DlaFuelTrackingView> {
  int currentTab = 0;
  String selectedVehicle = "";
  String fuelAmount = "";
  String fuelCost = "";
  String fuelStation = "";
  String driverName = "";
  String mileage = "";
  String receiptNumber = "";
  String notes = "";

  final List<Map<String, dynamic>> vehicles = [
    {"label": "DLA-001 (Toyota Hiace)", "value": "DLA-001"},
    {"label": "DLA-002 (Isuzu Elf)", "value": "DLA-002"},
    {"label": "DLA-003 (Honda Beat)", "value": "DLA-003"},
    {"label": "DLA-004 (Toyota Avanza)", "value": "DLA-004"},
  ];

  final List<Map<String, dynamic>> fuelTransactions = [
    {
      "id": "FUEL-001",
      "vehicleId": "DLA-001",
      "date": "2024-01-15",
      "amount": 45.5,
      "cost": 682500,
      "pricePerLiter": 15000,
      "station": "Shell SPBU Sudirman",
      "driver": "John Smith",
      "mileage": 15420,
      "receiptNumber": "SHL240115001",
      "efficiency": 12.5,
    },
    {
      "id": "FUEL-002",
      "vehicleId": "DLA-002",
      "date": "2024-01-14",
      "amount": 38.2,
      "cost": 573000,
      "pricePerLiter": 15000,
      "station": "Pertamina Gatsu",
      "driver": "Sarah Johnson",
      "mileage": 28750,
      "receiptNumber": "PTM240114002",
      "efficiency": 11.8,
    },
    {
      "id": "FUEL-003",
      "vehicleId": "DLA-003",
      "date": "2024-01-13",
      "amount": 12.0,
      "cost": 180000,
      "pricePerLiter": 15000,
      "station": "Total SPBU TB Simatupang",
      "driver": "Mike Wilson",
      "mileage": 8500,
      "receiptNumber": "TOT240113003",
      "efficiency": 28.5,
    },
    {
      "id": "FUEL-004",
      "vehicleId": "DLA-004",
      "date": "2024-01-12",
      "amount": 42.8,
      "cost": 642000,
      "pricePerLiter": 15000,
      "station": "BP SPBU Kemang",
      "driver": "Lisa Brown",
      "mileage": 45600,
      "receiptNumber": "BP240112004",
      "efficiency": 13.2,
    },
  ];

  final List<Map<String, dynamic>> fuelStations = [
    {"label": "Shell SPBU Sudirman", "value": "shell_sudirman"},
    {"label": "Pertamina Gatsu", "value": "pertamina_gatsu"},
    {"label": "Total SPBU TB Simatupang", "value": "total_simatupang"},
    {"label": "BP SPBU Kemang", "value": "bp_kemang"},
    {"label": "Other", "value": "other"},
  ];

  Widget _buildFuelEntryTab() {
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
                  "Record Fuel Transaction",
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
                        label: "Fuel Amount (Liters)",
                        value: fuelAmount,
                        onChanged: (value) {
                          fuelAmount = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QNumberField(
                        label: "Total Cost (Rp)",
                        value: fuelCost,
                        onChanged: (value) {
                          fuelCost = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Fuel Station",
                  items: fuelStations,
                  value: fuelStation,
                  onChanged: (value, label) {
                    fuelStation = value;
                    setState(() {});
                  },
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Driver Name",
                        value: driverName,
                        hint: "Who filled the fuel",
                        onChanged: (value) {
                          driverName = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QNumberField(
                        label: "Current Mileage (km)",
                        value: mileage,
                        onChanged: (value) {
                          mileage = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "Receipt Number",
                  value: receiptNumber,
                  hint: "Fuel receipt number",
                  onChanged: (value) {
                    receiptNumber = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Additional Notes",
                  value: notes,
                  hint: "Any additional information",
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
                          ss("Fuel entry draft saved");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Record Fuel",
                        size: bs.md,
                        onPressed: () {
                          ss("Fuel transaction recorded successfully");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (fuelAmount.isNotEmpty && fuelCost.isNotEmpty)
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
                    "Calculation Summary",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Price per Liter:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Rp ${(((double.tryParse(fuelCost) ?? 0) / (double.tryParse(fuelAmount) ?? 1)).toInt()).toDouble().currency}",
                        style: TextStyle(
                          fontSize: 14,
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

  Widget _buildTransactionHistoryTab() {
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
                Icon(Icons.local_gas_station, color: primaryColor, size: 24),
                SizedBox(width: spSm),
                Text(
                  "Fuel Transaction History",
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
                    si("Filter fuel transactions");
                  },
                ),
              ],
            ),
          ),
          ...fuelTransactions.map((transaction) {
            Color efficiencyColor = (transaction["efficiency"] as double) > 20 ? successColor :
                                   (transaction["efficiency"] as double) > 15 ? warningColor : dangerColor;
            
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
                        child: Icon(Icons.local_gas_station, color: primaryColor, size: 20),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${transaction["vehicleId"]} - ${transaction["receiptNumber"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${transaction["driver"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${transaction["date"]}",
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
                          "${transaction["station"]}",
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
                              "${transaction["amount"]} L",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Amount",
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
                              "Rp ${((transaction["cost"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
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
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Rp ${((transaction["pricePerLiter"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Per Liter",
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
                      children: [
                        Icon(Icons.speed, color: efficiencyColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Fuel Efficiency: ${transaction["efficiency"]} km/L",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: efficiencyColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Mileage: ${((transaction["mileage"] as int) / 1000).toStringAsFixed(1)}K km",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      si("View transaction details: ${transaction["id"]}");
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
    double totalFuelCost = fuelTransactions.fold(0.0, (sum, item) => sum + (item["cost"] as int).toDouble());
    double totalFuelAmount = fuelTransactions.fold(0.0, (sum, item) => sum + (item["amount"] as double));
    double avgEfficiency = fuelTransactions.fold(0.0, (sum, item) => sum + (item["efficiency"] as double)) / fuelTransactions.length;
    double avgPricePerLiter = totalFuelCost / totalFuelAmount;

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
                  "Fuel Analytics Overview",
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
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.attach_money, color: dangerColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "Rp ${totalFuelCost.currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Total Cost",
                              style: TextStyle(
                                fontSize: 10,
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
                            Icon(Icons.local_gas_station, color: infoColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "${totalFuelAmount.toStringAsFixed(1)} L",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Total Fuel",
                              style: TextStyle(
                                fontSize: 10,
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
                            Icon(Icons.speed, color: successColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "${avgEfficiency.toStringAsFixed(1)} km/L",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Avg Efficiency",
                              style: TextStyle(
                                fontSize: 10,
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
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.trending_up, color: warningColor, size: 20),
                            SizedBox(height: spXs),
                            Text(
                              "Rp ${avgPricePerLiter.toInt().toDouble().currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Avg Price/L",
                              style: TextStyle(
                                fontSize: 10,
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
                  "Vehicle Fuel Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...vehicles.map((vehicle) {
                  List<Map<String, dynamic>> vehicleTransactions = fuelTransactions
                      .where((t) => t["vehicleId"] == vehicle["value"])
                      .toList();
                  
                  if (vehicleTransactions.isEmpty) return SizedBox.shrink();
                  
                  double vehicleFuelCost = vehicleTransactions.fold(0.0, (sum, item) => sum + (item["cost"] as int).toDouble());
                  double vehicleFuelAmount = vehicleTransactions.fold(0.0, (sum, item) => sum + (item["amount"] as double));
                  double vehicleAvgEfficiency = vehicleTransactions.fold(0.0, (sum, item) => sum + (item["efficiency"] as double)) / vehicleTransactions.length;
                  
                  Color efficiencyColor = vehicleAvgEfficiency > 20 ? successColor :
                                         vehicleAvgEfficiency > 15 ? warningColor : dangerColor;
                  
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
                                "${vehicleAvgEfficiency.toStringAsFixed(1)} km/L",
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
                                    "Rp ${vehicleFuelCost.currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: dangerColor,
                                    ),
                                  ),
                                  Text(
                                    "Total Cost",
                                    style: TextStyle(
                                      fontSize: 10,
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
                                    "${vehicleFuelAmount.toStringAsFixed(1)} L",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                  Text(
                                    "Total Fuel",
                                    style: TextStyle(
                                      fontSize: 10,
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
                                    "${vehicleTransactions.length}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Fill-ups",
                                    style: TextStyle(
                                      fontSize: 10,
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
                  "Fuel Station Usage",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...fuelStations.take(4).map((station) {
                  int stationUsage = fuelTransactions.where((t) => t["station"].toString().toLowerCase().contains(station["label"].toString().toLowerCase().split(" ")[0])).length;
                  if (stationUsage == 0) return SizedBox.shrink();
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.local_gas_station, color: infoColor, size: 16),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            station["label"],
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$stationUsage visits",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
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
                    ss("Fuel report exported successfully");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Print Summary",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () {
                    si("Printing fuel summary");
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
      title: "Fuel Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Add Entry", icon: Icon(Icons.add_circle)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildFuelEntryTab(),
        _buildTransactionHistoryTab(),
        _buildAnalyticsTab(),
      ],
    );
  }
}
