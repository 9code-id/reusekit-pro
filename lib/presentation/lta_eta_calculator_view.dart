import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaEtaCalculatorView extends StatefulWidget {
  const LtaEtaCalculatorView({super.key});

  @override
  State<LtaEtaCalculatorView> createState() => _LtaEtaCalculatorViewState();
}

class _LtaEtaCalculatorViewState extends State<LtaEtaCalculatorView> {
  String fromLocation = "";
  String toLocation = "";
  String selectedVehicle = "";
  String driverName = "";
  String departureTime = "";
  String cargoType = "";
  String specialRequirements = "";
  bool includeTraffic = true;
  bool includeWeather = true;
  bool includeRoadConditions = true;

  Map<String, dynamic>? calculationResult;
  bool isCalculating = false;

  List<Map<String, dynamic>> vehicles = [
    {
      "id": "1",
      "name": "Truck Alpha-001",
      "type": "Heavy Truck",
      "capacity": "40 tons",
      "fuelEfficiency": "8 km/l",
      "avgSpeed": "65 km/h",
      "status": "Available",
    },
    {
      "id": "2",
      "name": "Van Beta-002",
      "type": "Delivery Van",
      "capacity": "3 tons",
      "fuelEfficiency": "12 km/l",
      "avgSpeed": "80 km/h",
      "status": "Available",
    },
    {
      "id": "3",
      "name": "Truck Gamma-003",
      "type": "Medium Truck",
      "capacity": "20 tons",
      "fuelEfficiency": "10 km/l",
      "avgSpeed": "70 km/h",
      "status": "In Transit",
    },
  ];

  List<Map<String, dynamic>> get availableVehicles {
    return vehicles.where((vehicle) => vehicle["status"] == "Available").toList();
  }

  List<Map<String, dynamic>> get vehicleOptions {
    return availableVehicles.map((vehicle) => {
      "label": "${vehicle["name"]} (${vehicle["type"]})",
      "value": vehicle["id"],
    }).toList();
  }

  void _calculateETA() async {
    if (fromLocation.isEmpty || toLocation.isEmpty || selectedVehicle.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    setState(() {
      isCalculating = true;
    });

    // Simulate API call delay
    await Future.delayed(Duration(seconds: 2));

    final selectedVehicleData = vehicles.firstWhere((v) => v["id"] == selectedVehicle);
    
    // Mock calculation logic
    final baseDistance = 250.5; // km
    final baseTime = baseDistance / double.parse(selectedVehicleData["avgSpeed"].toString().split(' ')[0]);
    
    double totalTime = baseTime;
    if (includeTraffic) totalTime += 0.5;
    if (includeWeather) totalTime += 0.3;
    if (includeRoadConditions) totalTime += 0.2;

    final fuelRequired = baseDistance / double.parse(selectedVehicleData["fuelEfficiency"].toString().split(' ')[0]);
    final estimatedCost = fuelRequired * 1.5; // \$1.5 per liter

    final departure = DateTime.now().add(Duration(hours: 1));
    final arrival = departure.add(Duration(minutes: (totalTime * 60).round()));

    setState(() {
      calculationResult = {
        "distance": baseDistance,
        "estimatedTime": totalTime,
        "departureTime": departure,
        "arrivalTime": arrival,
        "fuelRequired": fuelRequired,
        "estimatedCost": estimatedCost,
        "route": [
          {"name": fromLocation, "lat": 37.7749, "lng": -122.4194},
          {"name": "Highway Junction A", "lat": 37.8749, "lng": -122.3194},
          {"name": "Rest Stop", "lat": 37.9749, "lng": -122.2194},
          {"name": toLocation, "lat": 38.0749, "lng": -122.1194},
        ],
        "trafficConditions": "Moderate",
        "weatherConditions": "Clear",
        "roadConditions": "Good",
      };
      isCalculating = false;
    });

    ss("ETA calculated successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ETA Calculator"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.history),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Input Form
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
                      Icon(
                        Icons.calculate,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Trip Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // From and To Locations
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "From Location",
                          value: fromLocation,
                          hint: "Enter pickup location",
                          onChanged: (value) {
                            fromLocation = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "To Location",
                          value: toLocation,
                          hint: "Enter destination",
                          onChanged: (value) {
                            toLocation = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

                  // Vehicle Selection and Driver
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Select Vehicle",
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
                        child: QTextField(
                          label: "Driver Name",
                          value: driverName,
                          hint: "Enter driver name",
                          onChanged: (value) {
                            driverName = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

                  // Departure Time and Cargo Type
                  Row(
                    children: [
                      Expanded(
                        child: QTimePicker(
                          label: "Departure Time",
                          value: departureTime.isNotEmpty ? departureTime.timeOfDay : TimeOfDay.now(),
                          onChanged: (value) {
                            departureTime = value!.kkmm;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Cargo Type",
                          value: cargoType,
                          hint: "e.g., Electronics, Food",
                          onChanged: (value) {
                            cargoType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

                  // Special Requirements
                  QMemoField(
                    label: "Special Requirements",
                    value: specialRequirements,
                    hint: "Any special handling or route requirements",
                    onChanged: (value) {
                      specialRequirements = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),

                  // Calculation Options
                  Text(
                    "Calculation Factors",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Include Traffic Conditions",
                        "value": "traffic",
                        "checked": includeTraffic,
                      }
                    ],
                    value: [if (includeTraffic) {"label": "Include Traffic Conditions", "value": "traffic", "checked": true}],
                    onChanged: (values, ids) {
                      includeTraffic = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Include Weather Impact",
                        "value": "weather",
                        "checked": includeWeather,
                      }
                    ],
                    value: [if (includeWeather) {"label": "Include Weather Impact", "value": "weather", "checked": true}],
                    onChanged: (values, ids) {
                      includeWeather = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Include Road Conditions",
                        "value": "road",
                        "checked": includeRoadConditions,
                      }
                    ],
                    value: [if (includeRoadConditions) {"label": "Include Road Conditions", "value": "road", "checked": true}],
                    onChanged: (values, ids) {
                      includeRoadConditions = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Calculate Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isCalculating ? "Calculating..." : "Calculate ETA",
                size: bs.md,
                onPressed: isCalculating ? null : _calculateETA,
              ),
            ),

            SizedBox(height: spMd),

            // Selected Vehicle Info
            if (selectedVehicle.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selected Vehicle Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(){
                      final vehicle = vehicles.firstWhere((v) => v["id"] == selectedVehicle);
                      return [
                        Row(
                          children: [
                            Text("Name: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("${vehicle["name"]}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Type: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("${vehicle["type"]}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Capacity: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("${vehicle["capacity"]}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Fuel Efficiency: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("${vehicle["fuelEfficiency"]}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Average Speed: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("${vehicle["avgSpeed"]}"),
                          ],
                        ),
                      ];
                    }(),
                  ],
                ),
              ),
              SizedBox(height: spMd),
            ],

            // Calculation Results
            if (calculationResult != null) ...[
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
                        Icon(
                          Icons.route,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "ETA Calculation Results",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),

                    // Key Metrics
                    Row(
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
                                Icon(
                                  Icons.straighten,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${(calculationResult!["distance"] as double).toStringAsFixed(1)} km",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Distance",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
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
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: successColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${(calculationResult!["estimatedTime"] as double).toStringAsFixed(1)}h",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Duration",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
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
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  color: warningColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "\$${(calculationResult!["estimatedCost"] as double).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Est. Cost",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Time Details
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Departure Time",
                                      style: TextStyle(
                                        color: infoColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${(calculationResult!["departureTime"] as DateTime).dMMMy} ${(calculationResult!["departureTime"] as DateTime).hour.toString().padLeft(2, '0')}:${(calculationResult!["departureTime"] as DateTime).minute.toString().padLeft(2, '0')}",
                                      style: TextStyle(
                                        color: Colors.black,
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
                                      "Estimated Arrival",
                                      style: TextStyle(
                                        color: successColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${(calculationResult!["arrivalTime"] as DateTime).dMMMy} ${(calculationResult!["arrivalTime"] as DateTime).hour.toString().padLeft(2, '0')}:${(calculationResult!["arrivalTime"] as DateTime).minute.toString().padLeft(2, '0')}",
                                      style: TextStyle(
                                        color: successColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
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

                    SizedBox(height: spMd),

                    // Conditions
                    Text(
                      "Current Conditions",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.traffic, size: 16, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "Traffic: ${calculationResult!["trafficConditions"]}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.cloud, size: 16, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "Weather: ${calculationResult!["weatherConditions"]}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.directions, size: 16, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "Road: ${calculationResult!["roadConditions"]}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Share ETA",
                            size: bs.sm,
                            onPressed: () {
                              ss("ETA shared successfully!");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Start Trip",
                            size: bs.sm,
                            onPressed: () {
                              ss("Trip started with tracking enabled!");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
