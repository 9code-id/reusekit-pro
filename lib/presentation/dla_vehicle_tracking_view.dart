import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaVehicleTrackingView extends StatefulWidget {
  const DlaVehicleTrackingView({super.key});

  @override
  State<DlaVehicleTrackingView> createState() => _DlaVehicleTrackingViewState();
}

class _DlaVehicleTrackingViewState extends State<DlaVehicleTrackingView> {
  String selectedVehicle = "all";
  bool showOnlyActive = false;

  final List<Map<String, dynamic>> vehicleOptions = [
    {"label": "All Vehicles", "value": "all"},
    {"label": "DLA-001 (Toyota Hiace)", "value": "DLA-001"},
    {"label": "DLA-002 (Isuzu Elf)", "value": "DLA-002"},
    {"label": "DLA-003 (Honda Beat)", "value": "DLA-003"},
    {"label": "DLA-004 (Toyota Avanza)", "value": "DLA-004"},
  ];

  final List<Map<String, dynamic>> trackingData = [
    {
      "vehicleId": "DLA-001",
      "licensePlate": "B 1234 ABC",
      "driver": "John Smith",
      "status": "In Transit",
      "currentLocation": "Jl. Sudirman, Jakarta",
      "destination": "Bandung Distribution Center",
      "latitude": -6.2088,
      "longitude": 106.8456,
      "speed": 65,
      "fuelLevel": 85,
      "eta": "2h 15m",
      "progress": 65,
      "lastUpdate": "2 minutes ago",
      "deliveryCount": 3,
      "totalDeliveries": 5,
    },
    {
      "vehicleId": "DLA-002",
      "licensePlate": "B 5678 DEF",
      "driver": "Sarah Johnson",
      "status": "Delivering",
      "currentLocation": "Jl. Asia Afrika, Bandung",
      "destination": "Customer Location",
      "latitude": -6.9175,
      "longitude": 107.6191,
      "speed": 0,
      "fuelLevel": 60,
      "eta": "15m",
      "progress": 90,
      "lastUpdate": "1 minute ago",
      "deliveryCount": 7,
      "totalDeliveries": 8,
    },
    {
      "vehicleId": "DLA-003",
      "licensePlate": "B 9012 GHI",
      "driver": "Mike Wilson",
      "status": "Available",
      "currentLocation": "Jakarta Warehouse",
      "destination": "-",
      "latitude": -6.1751,
      "longitude": 106.8650,
      "speed": 0,
      "fuelLevel": 95,
      "eta": "-",
      "progress": 0,
      "lastUpdate": "5 minutes ago",
      "deliveryCount": 0,
      "totalDeliveries": 0,
    },
    {
      "vehicleId": "DLA-004",
      "licensePlate": "B 3456 JKL",
      "driver": "Lisa Brown",
      "status": "In Transit",
      "currentLocation": "Jl. Tol Cipularang",
      "destination": "Surabaya Hub",
      "latitude": -6.7000,
      "longitude": 107.4000,
      "speed": 80,
      "fuelLevel": 40,
      "eta": "4h 30m",
      "progress": 25,
      "lastUpdate": "3 minutes ago",
      "deliveryCount": 1,
      "totalDeliveries": 6,
    },
  ];

  List<Map<String, dynamic>> get filteredVehicles {
    return trackingData.where((vehicle) {
      bool matchesVehicle = selectedVehicle == "all" || vehicle["vehicleId"] == selectedVehicle;
      bool matchesStatus = !showOnlyActive || vehicle["status"] != "Available";
      return matchesVehicle && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Transit":
        return infoColor;
      case "Delivering":
        return warningColor;
      case "Available":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getFuelColor(int fuelLevel) {
    if (fuelLevel < 30) return dangerColor;
    if (fuelLevel < 60) return warningColor;
    return successColor;
  }

  Widget _buildFleetSummary() {
    int inTransit = trackingData.where((v) => v["status"] == "In Transit").length;
    int delivering = trackingData.where((v) => v["status"] == "Delivering").length;
    int available = trackingData.where((v) => v["status"] == "Available").length;
    int lowFuel = trackingData.where((v) => (v["fuelLevel"] as int) < 30).length;

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
          Text(
            "Fleet Status Overview",
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
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.local_shipping, color: infoColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "$inTransit",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "In Transit",
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
                      Icon(Icons.delivery_dining, color: warningColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "$delivering",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Delivering",
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
                      Icon(Icons.check_circle, color: successColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "$available",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Available",
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
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.local_gas_station, color: dangerColor, size: 20),
                      SizedBox(height: spXs),
                      Text(
                        "$lowFuel",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Low Fuel",
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
    );
  }

  Widget _buildFilterSection() {
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
                child: QDropdownField(
                  label: "Filter Vehicle",
                  items: vehicleOptions,
                  value: selectedVehicle,
                  onChanged: (value, label) {
                    selectedVehicle = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  ss("Vehicle tracking data refreshed");
                  setState(() {});
                },
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Show only active vehicles",
                "value": true,
                "checked": showOnlyActive,
              }
            ],
            value: [if (showOnlyActive) {"label": "Show only active vehicles", "value": true, "checked": true}],
            onChanged: (values, ids) {
              showOnlyActive = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingCard(Map<String, dynamic> vehicle) {
    Color statusColor = _getStatusColor(vehicle["status"]);
    Color fuelColor = _getFuelColor(vehicle["fuelLevel"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(Icons.local_shipping, color: statusColor, size: 20),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${vehicle["vehicleId"]} - ${vehicle["licensePlate"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${vehicle["driver"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${vehicle["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          if (vehicle["status"] != "Available") ...[
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: primaryColor, size: 14),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${vehicle["currentLocation"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (vehicle["destination"] != "-") ...[
                    Row(
                      children: [
                        Icon(Icons.flag, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "To: ${vehicle["destination"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (vehicle["progress"] as int) / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${vehicle["progress"]}% Complete",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        if (vehicle["eta"] != "-")
                          Text(
                            "ETA: ${vehicle["eta"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: fuelColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_gas_station, color: fuelColor, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${vehicle["fuelLevel"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: fuelColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.speed, color: primaryColor, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${vehicle["speed"]} km/h",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (vehicle["totalDeliveries"] > 0)
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory, color: successColor, size: 12),
                        SizedBox(width: spXs),
                        Text(
                          "${vehicle["deliveryCount"]}/${vehicle["totalDeliveries"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Text(
                "Last update: ${vehicle["lastUpdate"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              Row(
                spacing: spXs,
                children: [
                  QButton(
                    icon: Icons.phone,
                    size: bs.sm,
                    onPressed: () {
                      si("Calling ${vehicle["driver"]}");
                    },
                  ),
                  QButton(
                    icon: Icons.message,
                    size: bs.sm,
                    onPressed: () {
                      si("Messaging ${vehicle["driver"]}");
                    },
                  ),
                  QButton(
                    icon: Icons.map,
                    size: bs.sm,
                    onPressed: () {
                      si("View ${vehicle["vehicleId"]} on map");
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      height: 200,
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusMd),
        child: Stack(
          children: [
            Container(
              color: primaryColor.withAlpha(10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, size: 48, color: primaryColor),
                    SizedBox(height: spSm),
                    Text(
                      "Live Vehicle Map",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Real-time vehicle locations",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: spSm,
              right: spSm,
              child: QButton(
                icon: Icons.fullscreen,
                size: bs.sm,
                onPressed: () {
                  si("Open full map view");
                },
              ),
            ),
            ...filteredVehicles.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> vehicle = entry.value;
              
              return Positioned(
                left: 50.0 + (index * 40.0),
                top: 80.0 + (index * 20.0),
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: _getStatusColor(vehicle["status"]),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_shipping,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: 2),
                      Text(
                        vehicle["vehicleId"],
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Tracking"),
        actions: [
          QButton(
            icon: Icons.notifications,
            size: bs.sm,
            onPressed: () {
              si("Vehicle alerts and notifications");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildFleetSummary(),
            _buildFilterSection(),
            _buildMapPlaceholder(),
            if (filteredVehicles.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 64, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "No vehicles to track",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredVehicles.map((vehicle) => _buildTrackingCard(vehicle)).toList(),
          ],
        ),
      ),
    );
  }
}
