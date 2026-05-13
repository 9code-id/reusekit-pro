import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaFuelManagementView extends StatefulWidget {
  const LtaFuelManagementView({super.key});

  @override
  State<LtaFuelManagementView> createState() => _LtaFuelManagementViewState();
}

class _LtaFuelManagementViewState extends State<LtaFuelManagementView> {
  bool loading = true;
  String searchQuery = "";
  String selectedVehicle = "All Vehicles";
  String selectedFuelType = "All Fuel Types";
  String selectedTimeRange = "Last 30 Days";

  List<Map<String, dynamic>> vehicleOptions = [
    {"label": "All Vehicles", "value": "All Vehicles"},
    {"label": "B 1234 ABC", "value": "B 1234 ABC"},
    {"label": "B 5678 DEF", "value": "B 5678 DEF"},
    {"label": "B 9012 GHI", "value": "B 9012 GHI"},
    {"label": "B 3456 JKL", "value": "B 3456 JKL"},
  ];

  List<Map<String, dynamic>> fuelTypeOptions = [
    {"label": "All Fuel Types", "value": "All Fuel Types"},
    {"label": "Gasoline", "value": "Gasoline"},
    {"label": "Diesel", "value": "Diesel"},
    {"label": "Premium", "value": "Premium"},
    {"label": "Pertamax", "value": "Pertamax"},
  ];

  List<Map<String, dynamic>> timeRangeOptions = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> fuelRecords = [
    {
      "id": "FUEL001",
      "vehicleId": "VH001",
      "vehiclePlate": "B 1234 ABC",
      "date": "2024-03-15T08:30:00Z",
      "station": "Pertamina SPBU 123",
      "stationAddress": "Jl. Sudirman No. 123, Jakarta",
      "fuelType": "Diesel",
      "amount": 45.5,
      "pricePerLiter": 15000,
      "totalCost": 682500,
      "mileage": 45680,
      "attendant": "Budi Santoso",
      "paymentMethod": "Cash",
      "receiptNumber": "RC001234567",
      "driver": "Ahmad Wijaya",
      "notes": "Full tank for long distance trip",
      "fuelEfficiency": 12.5,
      "previousMileage": 45320,
      "distanceTraveled": 360
    },
    {
      "id": "FUEL002",
      "vehicleId": "VH002",
      "vehiclePlate": "B 5678 DEF",
      "date": "2024-03-14T14:15:00Z",
      "station": "Shell Station",
      "stationAddress": "Jl. Thamrin No. 456, Jakarta",
      "fuelType": "Gasoline",
      "amount": 40.0,
      "pricePerLiter": 14500,
      "totalCost": 580000,
      "mileage": 52000,
      "attendant": "Sari Dewi",
      "paymentMethod": "Credit Card",
      "receiptNumber": "SH987654321",
      "driver": "Siti Nurhaliza",
      "notes": "Regular refill",
      "fuelEfficiency": 10.8,
      "previousMileage": 51600,
      "distanceTraveled": 400
    },
    {
      "id": "FUEL003",
      "vehicleId": "VH003",
      "vehiclePlate": "B 9012 GHI",
      "date": "2024-03-13T16:45:00Z",
      "station": "BP Station",
      "stationAddress": "Jl. Gatot Subroto No. 789, Jakarta",
      "fuelType": "Premium",
      "amount": 38.2,
      "pricePerLiter": 16500,
      "totalCost": 630300,
      "mileage": 38200,
      "attendant": "Eko Prasetyo",
      "paymentMethod": "Debit Card",
      "receiptNumber": "BP123456789",
      "driver": "Andi Wijayanto",
      "notes": "Emergency refill due to low fuel warning",
      "fuelEfficiency": 11.2,
      "previousMileage": 37850,
      "distanceTraveled": 350
    },
    {
      "id": "FUEL004",
      "vehicleId": "VH001",
      "vehiclePlate": "B 1234 ABC",
      "date": "2024-03-12T11:20:00Z",
      "station": "Pertamina SPBU 456",
      "stationAddress": "Jl. Rasuna Said No. 321, Jakarta",
      "fuelType": "Diesel",
      "amount": 50.0,
      "pricePerLiter": 15000,
      "totalCost": 750000,
      "mileage": 45320,
      "attendant": "Dewi Sartika",
      "paymentMethod": "Cash",
      "receiptNumber": "RC998877665",
      "driver": "Ahmad Wijaya",
      "notes": "Preparation for delivery route",
      "fuelEfficiency": 13.1,
      "previousMileage": 44900,
      "distanceTraveled": 420
    },
    {
      "id": "FUEL005",
      "vehicleId": "VH004",
      "vehiclePlate": "B 3456 JKL",
      "date": "2024-03-11T09:10:00Z",
      "station": "Total Station",
      "stationAddress": "Jl. Kuningan No. 654, Jakarta",
      "fuelType": "Pertamax",
      "amount": 42.8,
      "pricePerLiter": 17000,
      "totalCost": 727600,
      "mileage": 28500,
      "attendant": "Rini Susanti",
      "paymentMethod": "Digital Wallet",
      "receiptNumber": "TT555444333",
      "driver": "Bambang Sutrisno",
      "notes": "Using premium fuel for better performance",
      "fuelEfficiency": 9.5,
      "previousMileage": 28150,
      "distanceTraveled": 350
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadFuelData();
  }

  void _loadFuelData() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredRecords {
    return fuelRecords.where((record) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${record["vehiclePlate"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${record["station"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${record["driver"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${record["attendant"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesVehicle = selectedVehicle == "All Vehicles" || 
          record["vehiclePlate"] == selectedVehicle;
      
      bool matchesFuelType = selectedFuelType == "All Fuel Types" || 
          record["fuelType"] == selectedFuelType;
      
      return matchesSearch && matchesVehicle && matchesFuelType;
    }).toList();
  }

  Map<String, dynamic> get fuelStatistics {
    List<Map<String, dynamic>> records = filteredRecords;
    
    double totalAmount = records.fold(0.0, (sum, record) => sum + (record["amount"] as double));
    int totalCost = records.fold(0, (sum, record) => sum + (record["totalCost"] as int));
    double avgEfficiency = records.fold(0.0, (sum, record) => sum + (record["fuelEfficiency"] as double)) / records.length;
    int totalDistance = records.fold(0, (sum, record) => sum + (record["distanceTraveled"] as int));
    
    return {
      "totalAmount": totalAmount,
      "totalCost": totalCost,
      "avgEfficiency": avgEfficiency,
      "totalDistance": totalDistance,
      "recordCount": records.length,
      "avgCostPerLiter": totalCost / totalAmount,
    };
  }

  Color _getFuelTypeColor(String fuelType) {
    switch (fuelType.toLowerCase()) {
      case 'diesel':
        return Colors.orange;
      case 'gasoline':
        return Colors.blue;
      case 'premium':
        return Colors.green;
      case 'pertamax':
        return Colors.purple;
      default:
        return primaryColor;
    }
  }

  IconData _getPaymentMethodIcon(String paymentMethod) {
    switch (paymentMethod.toLowerCase()) {
      case 'cash':
        return Icons.money;
      case 'credit card':
        return Icons.credit_card;
      case 'debit card':
        return Icons.credit_card;
      case 'digital wallet':
        return Icons.phone_android;
      default:
        return Icons.payment;
    }
  }

  void _deleteFuelRecord(String recordId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this fuel record?");
    if (isConfirmed) {
      fuelRecords.removeWhere((record) => record["id"] == recordId);
      setState(() {});
      ss("Fuel record deleted successfully");
    }
  }

  void _showFuelDetails(Map<String, dynamic> record) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 500,
          padding: EdgeInsets.all(spMd),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.local_gas_station, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Fuel Record Details",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: spMd),

                // Vehicle & Date Info
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.local_shipping, color: primaryColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${record["vehiclePlate"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        DateTime.parse("${record["date"]}").dMMMykkmm,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spMd),

                // Fuel Details
                _buildDetailRow("Station", "${record["station"]}"),
                _buildDetailRow("Address", "${record["stationAddress"]}"),
                _buildDetailRow("Fuel Type", "${record["fuelType"]}"),
                _buildDetailRow("Amount", "${(record["amount"] as double).toStringAsFixed(1)} Liters"),
                _buildDetailRow("Price per Liter", "Rp ${((record["pricePerLiter"] as int).toDouble()).currency}"),
                _buildDetailRow("Total Cost", "Rp ${((record["totalCost"] as int).toDouble()).currency}"),
                _buildDetailRow("Mileage", "${((record["mileage"] as int) / 1000).toStringAsFixed(1)}K km"),
                _buildDetailRow("Driver", "${record["driver"]}"),
                _buildDetailRow("Attendant", "${record["attendant"]}"),
                _buildDetailRow("Payment Method", "${record["paymentMethod"]}"),
                _buildDetailRow("Receipt Number", "${record["receiptNumber"]}"),
                _buildDetailRow("Fuel Efficiency", "${(record["fuelEfficiency"] as double).toStringAsFixed(1)} km/L"),
                _buildDetailRow("Distance Traveled", "${record["distanceTraveled"]} km"),
                
                if (record["notes"].isNotEmpty) ...[
                  SizedBox(height: spMd),
                  Text(
                    "Notes:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${record["notes"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: primaryColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color color) {
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
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Fuel Management"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Map<String, dynamic>> displayRecords = filteredRecords;
    Map<String, dynamic> stats = fuelStatistics;

    return Scaffold(
      appBar: AppBar(
        title: Text("Fuel Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new fuel record
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // View analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search fuel records...",
              value: searchQuery,
              hint: "Search by vehicle, station, driver, or attendant",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Filters
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
                    label: "Fuel Type",
                    items: fuelTypeOptions,
                    value: selectedFuelType,
                    onChanged: (value, label) {
                      selectedFuelType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Time Range",
                    items: timeRangeOptions,
                    value: selectedTimeRange,
                    onChanged: (value, label) {
                      selectedTimeRange = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard(
                  "Total Fuel",
                  "${(stats["totalAmount"] as double).toStringAsFixed(1)}L",
                  "From ${stats["recordCount"]} records",
                  Icons.local_gas_station,
                  primaryColor,
                ),
                _buildStatCard(
                  "Total Cost",
                  "Rp ${((stats["totalCost"] as int).toDouble() / 1000000).toStringAsFixed(1)}M",
                  "Average cost per liter",
                  Icons.attach_money,
                  successColor,
                ),
                _buildStatCard(
                  "Fuel Efficiency",
                  "${(stats["avgEfficiency"] as double).toStringAsFixed(1)} km/L",
                  "Average across all vehicles",
                  Icons.speed,
                  warningColor,
                ),
                _buildStatCard(
                  "Distance",
                  "${((stats["totalDistance"] as int) / 1000).toStringAsFixed(1)}K km",
                  "Total distance traveled",
                  Icons.timeline,
                  infoColor,
                ),
              ],
            ),

            // Results Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Text(
                    "${displayRecords.length} fuel records found",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  // Fuel type legend
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                      SizedBox(width: 2),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                      SizedBox(width: 2),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Fuel Types",
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

            // Fuel Records List
            if (displayRecords.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.local_gas_station,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No fuel records found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or add a new fuel record",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Add Fuel Record",
                      icon: Icons.add,
                      size: bs.md,
                      onPressed: () {
                        // Add fuel record
                      },
                    ),
                  ],
                ),
              )
            else
              Column(
                children: displayRecords.map((record) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: _getFuelTypeColor("${record["fuelType"]}"),
                          width: 4,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: _getFuelTypeColor("${record["fuelType"]}").withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.local_gas_station,
                                  color: _getFuelTypeColor("${record["fuelType"]}"),
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${record["station"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${record["vehiclePlate"]} • ${record["fuelType"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "Rp ${((record["totalCost"] as int).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),

                          // Fuel Details
                          ResponsiveGridView(
                            padding: EdgeInsets.zero,
                            minItemWidth: 120,
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${(record["amount"] as double).toStringAsFixed(1)}L",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Amount",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Rp ${((record["pricePerLiter"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Per Liter",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${(record["fuelEfficiency"] as double).toStringAsFixed(1)} km/L",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Efficiency",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${((record["mileage"] as int) / 1000).toStringAsFixed(1)}K",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Mileage",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),

                          // Additional Info
                          Row(
                            children: [
                              Icon(Icons.person, size: 14, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "${record["driver"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(_getPaymentMethodIcon("${record["paymentMethod"]}"), size: 14, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "${record["paymentMethod"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                DateTime.parse("${record["date"]}").dMMMy,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          if (record["notes"].isNotEmpty) ...[
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: warningColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${record["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                          SizedBox(height: spMd),

                          // Actions
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getFuelTypeColor("${record["fuelType"]}").withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${record["fuelType"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getFuelTypeColor("${record["fuelType"]}"),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Spacer(),
                              QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () => _showFuelDetails(record),
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                label: "Edit",
                                size: bs.sm,
                                onPressed: () {
                                  // Edit fuel record
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.delete,
                                size: bs.sm,
                                onPressed: () => _deleteFuelRecord("${record["id"]}"),
                              ),
                            ],
                          ),
                        ],
                      ),
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
