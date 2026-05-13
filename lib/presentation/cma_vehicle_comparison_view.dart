import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaVehicleComparisonView extends StatefulWidget {
  const CmaVehicleComparisonView({super.key});

  @override
  State<CmaVehicleComparisonView> createState() => _CmaVehicleComparisonViewState();
}

class _CmaVehicleComparisonViewState extends State<CmaVehicleComparisonView> {
  List<Map<String, dynamic>> vehicles = [
    {
      "id": "1",
      "name": "Toyota Camry 2024",
      "brand": "Toyota",
      "model": "Camry",
      "year": 2024,
      "price": 28500,
      "image": "https://picsum.photos/300/200?random=1&keyword=toyota",
      "fuelType": "Hybrid",
      "mpg": 52,
      "engine": "2.5L 4-Cylinder",
      "transmission": "CVT",
      "drivetrain": "FWD",
      "seating": 5,
      "safety_rating": 5,
      "warranty": "3 years/36,000 miles",
      "features": ["Apple CarPlay", "Android Auto", "Lane Assist", "Adaptive Cruise Control"]
    },
    {
      "id": "2", 
      "name": "Honda Accord 2024",
      "brand": "Honda",
      "model": "Accord",
      "year": 2024,
      "price": 27200,
      "image": "https://picsum.photos/300/200?random=2&keyword=honda",
      "fuelType": "Hybrid",
      "mpg": 48,
      "engine": "2.0L 4-Cylinder",
      "transmission": "CVT",
      "drivetrain": "FWD",
      "seating": 5,
      "safety_rating": 5,
      "warranty": "3 years/36,000 miles",
      "features": ["Honda Sensing", "Wireless CarPlay", "Remote Start", "Heated Seats"]
    },
    {
      "id": "3",
      "name": "Nissan Altima 2024",
      "brand": "Nissan",
      "model": "Altima",
      "year": 2024,
      "price": 25400,
      "image": "https://picsum.photos/300/200?random=3&keyword=nissan",
      "fuelType": "Gasoline",
      "mpg": 39,
      "engine": "2.5L 4-Cylinder",
      "transmission": "CVT",
      "drivetrain": "FWD",
      "seating": 5,
      "safety_rating": 4,
      "warranty": "3 years/36,000 miles",
      "features": ["ProPILOT Assist", "Intelligent Key", "Dual Zone Climate", "8-inch Display"]
    }
  ];

  List<String> selectedVehicles = [];
  String sortBy = "price";

  void _toggleVehicleSelection(String vehicleId) {
    if (selectedVehicles.contains(vehicleId)) {
      selectedVehicles.remove(vehicleId);
    } else {
      if (selectedVehicles.length < 3) {
        selectedVehicles.add(vehicleId);
      } else {
        sw("Maximum 3 vehicles can be compared");
      }
    }
    setState(() {});
  }

  List<Map<String, dynamic>> get _selectedVehicleData {
    return vehicles.where((v) => selectedVehicles.contains(v["id"])).toList();
  }

  void _sortVehicles() {
    vehicles.sort((a, b) {
      switch (sortBy) {
        case "price":
          return (a["price"] as int).compareTo(b["price"] as int);
        case "mpg":
          return (b["mpg"] as int).compareTo(a["mpg"] as int);
        case "year":
          return (b["year"] as int).compareTo(a["year"] as int);
        default:
          return a["name"].toString().compareTo(b["name"].toString());
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Comparison"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          // Sort & Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Sort By",
                        items: [
                          {"label": "Price (Low to High)", "value": "price"},
                          {"label": "Fuel Economy (High to Low)", "value": "mpg"},
                          {"label": "Year (Newest First)", "value": "year"},
                          {"label": "Name (A-Z)", "value": "name"},
                        ],
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          _sortVehicles();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Compare (${selectedVehicles.length})",
                      size: bs.sm,
                      onPressed: selectedVehicles.length >= 2 ? () {
                        _showComparisonSheet();
                      } : null,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Vehicle List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                final isSelected = selectedVehicles.contains(vehicle["id"]);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      // Vehicle Image & Selection
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            child: Image.network(
                              "${vehicle["image"]}",
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () => _toggleVehicleSelection(vehicle["id"]),
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor : Colors.white,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  boxShadow: [shadowSm],
                                ),
                                child: Icon(
                                  isSelected ? Icons.check : Icons.add,
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Vehicle Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name & Price
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${vehicle["name"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${vehicle["year"]} • ${vehicle["fuelType"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "\$${((vehicle["price"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Key Specs
                            Row(
                              children: [
                                Expanded(
                                  child: _buildSpecItem(
                                    icon: Icons.local_gas_station,
                                    label: "MPG",
                                    value: "${vehicle["mpg"]}",
                                  ),
                                ),
                                Expanded(
                                  child: _buildSpecItem(
                                    icon: Icons.star,
                                    label: "Safety",
                                    value: "${vehicle["safety_rating"]}/5",
                                  ),
                                ),
                                Expanded(
                                  child: _buildSpecItem(
                                    icon: Icons.people,
                                    label: "Seats",
                                    value: "${vehicle["seating"]}",
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Engine & Transmission
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.settings, size: 16, color: primaryColor),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${vehicle["engine"]} • ${vehicle["transmission"]} • ${vehicle["drivetrain"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
          ),
        ],
      ),
    );
  }

  Widget _buildSpecItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 20, color: primaryColor),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  void _showComparisonSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Vehicle Comparison",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Comparison Table
            Expanded(
              child: SingleChildScrollView(
                child: _buildComparisonTable(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonTable() {
    final selectedData = _selectedVehicleData;
    
    return Column(
      children: [
        // Vehicle Names Header
        Row(
          children: [
            Container(
              width: 120,
              child: Text(
                "Features",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            ...selectedData.map((vehicle) => Expanded(
              child: Text(
                "${vehicle["name"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            )).toList(),
          ],
        ),

        SizedBox(height: spSm),

        // Comparison Rows
        ...[
          _buildComparisonRow("Price", selectedData.map((v) => "\$${((v["price"] as int).toDouble()).currency}").toList()),
          _buildComparisonRow("Year", selectedData.map((v) => "${v["year"]}").toList()),
          _buildComparisonRow("Engine", selectedData.map((v) => "${v["engine"]}").toList()),
          _buildComparisonRow("MPG", selectedData.map((v) => "${v["mpg"]}").toList()),
          _buildComparisonRow("Transmission", selectedData.map((v) => "${v["transmission"]}").toList()),
          _buildComparisonRow("Drivetrain", selectedData.map((v) => "${v["drivetrain"]}").toList()),
          _buildComparisonRow("Seating", selectedData.map((v) => "${v["seating"]} seats").toList()),
          _buildComparisonRow("Safety Rating", selectedData.map((v) => "${v["safety_rating"]}/5 stars").toList()),
          _buildComparisonRow("Warranty", selectedData.map((v) => "${v["warranty"]}").toList()),
        ],
      ],
    );
  }

  Widget _buildComparisonRow(String feature, List<String> values) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            child: Text(
              feature,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          ...values.map((value) => Expanded(
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }
}
