import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCarSharingView extends StatefulWidget {
  const CmaCarSharingView({super.key});

  @override
  State<CmaCarSharingView> createState() => _CmaCarSharingViewState();
}

class _CmaCarSharingViewState extends State<CmaCarSharingView> {
  String selectedLocation = "all";
  String selectedType = "all";
  String sortBy = "distance";

  List<Map<String, dynamic>> carSharingServices = [
    {
      "id": "1",
      "name": "Zipcar",
      "logo": "https://picsum.photos/60/60?random=1&keyword=car",
      "rating": 4.5,
      "vehicles_nearby": 12,
      "starting_price": 9.50,
      "pricing_model": "hourly",
      "membership_fee": 7.0,
      "gas_included": true,
      "insurance_included": true,
      "mileage_limit": 180,
      "locations": ["Downtown", "Airport", "University"],
      "vehicle_types": ["Economy", "Compact", "SUV", "Luxury"],
      "description": "Short-term car rental by the hour or day"
    },
    {
      "id": "2",
      "name": "Car2Go",
      "logo": "https://picsum.photos/60/60?random=2&keyword=share",
      "rating": 4.2,
      "vehicles_nearby": 8,
      "starting_price": 0.32,
      "pricing_model": "per minute",
      "membership_fee": 0,
      "gas_included": true,
      "insurance_included": true,
      "mileage_limit": null,
      "locations": ["Downtown", "Financial District"],
      "vehicle_types": ["Smart Car", "Compact"],
      "description": "Free-floating car sharing service"
    },
    {
      "id": "3",
      "name": "Getaround",
      "logo": "https://picsum.photos/60/60?random=3&keyword=rental",
      "rating": 4.3,
      "vehicles_nearby": 15,
      "starting_price": 8.00,
      "pricing_model": "hourly",
      "membership_fee": 0,
      "gas_included": false,
      "insurance_included": true,
      "mileage_limit": 200,
      "locations": ["Residential Areas", "Downtown", "Suburbs"],
      "vehicle_types": ["Economy", "Compact", "SUV", "Luxury", "Electric"],
      "description": "Peer-to-peer car sharing platform"
    },
    {
      "id": "4",
      "name": "Maven",
      "logo": "https://picsum.photos/60/60?random=4&keyword=vehicle",
      "rating": 4.1,
      "vehicles_nearby": 6,
      "starting_price": 12.00,
      "pricing_model": "hourly",
      "membership_fee": 0,
      "gas_included": true,
      "insurance_included": true,
      "mileage_limit": 150,
      "locations": ["Airport", "Business District"],
      "vehicle_types": ["Sedan", "SUV", "Electric"],
      "description": "GM's car sharing service"
    }
  ];

  List<Map<String, dynamic>> nearbyVehicles = [
    {
      "id": "v1",
      "service": "Zipcar",
      "model": "2024 Toyota Prius",
      "type": "Hybrid",
      "location": "Downtown Library",
      "distance": 0.3,
      "price_per_hour": 12.50,
      "price_per_day": 89.00,
      "available_until": "2024-03-20 18:00",
      "fuel_level": 85,
      "image": "https://picsum.photos/300/200?random=5&keyword=prius",
      "features": ["GPS", "Bluetooth", "USB Charging", "Gas Card"],
      "seats": 5,
      "transmission": "Automatic"
    },
    {
      "id": "v2",
      "service": "Car2Go",
      "model": "2023 Smart EQfortwo",
      "type": "Electric",
      "location": "City Center",
      "distance": 0.5,
      "price_per_minute": 0.32,
      "price_per_hour": 15.00,
      "available_until": "2024-03-21 10:00",
      "battery_level": 78,
      "image": "https://picsum.photos/300/200?random=6&keyword=smart",
      "features": ["Electric", "City Parking", "App Access"],
      "seats": 2,
      "transmission": "Automatic"
    },
    {
      "id": "v3",
      "service": "Getaround",
      "model": "2024 Honda CR-V",
      "type": "SUV",
      "location": "Residential Area",
      "distance": 1.2,
      "price_per_hour": 18.00,
      "price_per_day": 125.00,
      "available_until": "2024-03-22 12:00",
      "fuel_level": 92,
      "image": "https://picsum.photos/300/200?random=7&keyword=honda",
      "features": ["AWD", "Backup Camera", "Apple CarPlay", "Roof Rack"],
      "seats": 5,
      "transmission": "CVT"
    },
    {
      "id": "v4",
      "service": "Maven",
      "model": "2024 Chevrolet Bolt",
      "type": "Electric",
      "location": "Airport Terminal",
      "distance": 2.8,
      "price_per_hour": 14.00,
      "price_per_day": 95.00,
      "available_until": "2024-03-20 22:00",
      "battery_level": 65,
      "image": "https://picsum.photos/300/200?random=8&keyword=chevrolet",
      "features": ["Electric", "Fast Charging", "WiFi Hotspot"],
      "seats": 5,
      "transmission": "Automatic"
    }
  ];

  List<Map<String, dynamic>> myReservations = [
    {
      "id": "r1",
      "service": "Zipcar",
      "vehicle": "2024 Toyota Prius",
      "location": "Downtown Library",
      "start_time": "2024-03-18 14:00",
      "end_time": "2024-03-18 18:00",
      "total_cost": 50.00,
      "status": "confirmed",
      "reservation_code": "ZC-789123"
    },
    {
      "id": "r2",
      "service": "Getaround",
      "vehicle": "2023 Tesla Model 3",
      "location": "Shopping Center",
      "start_time": "2024-03-22 09:00",
      "end_time": "2024-03-22 17:00",
      "total_cost": 120.00,
      "status": "upcoming",
      "reservation_code": "GA-456789"
    }
  ];

  String selectedTab = "discover";

  List<Map<String, dynamic>> get filteredVehicles {
    List<Map<String, dynamic>> filtered = List.from(nearbyVehicles);
    
    if (selectedType != "all") {
      filtered = filtered.where((v) => v["type"].toString().toLowerCase() == selectedType.toLowerCase()).toList();
    }
    
    switch (sortBy) {
      case "distance":
        filtered.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
        break;
      case "price":
        filtered.sort((a, b) => (a["price_per_hour"] as double).compareTo(b["price_per_hour"] as double));
        break;
      case "service":
        filtered.sort((a, b) => a["service"].toString().compareTo(b["service"].toString()));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Sharing"),
        actions: [
          IconButton(
            onPressed: () {
              _showLocationPicker();
            },
            icon: Icon(Icons.location_on),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Selection
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QCategoryPicker(
              items: [
                {"label": "Discover", "value": "discover"},
                {"label": "My Bookings", "value": "bookings"},
                {"label": "Services", "value": "services"},
              ],
              value: selectedTab,
              onChanged: (index, label, value, item) {
                selectedTab = value;
                setState(() {});
              },
            ),
          ),

          SizedBox(height: spMd),

          // Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "discover":
        return _buildDiscoverTab();
      case "bookings":
        return _buildBookingsTab();
      case "services":
        return _buildServicesTab();
      default:
        return _buildDiscoverTab();
    }
  }

  Widget _buildDiscoverTab() {
    return Column(
      children: [
        // Filters
        Container(
          padding: EdgeInsets.symmetric(horizontal: spMd),
          child: Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Vehicle Type",
                  items: [
                    {"label": "All Types", "value": "all"},
                    {"label": "Electric", "value": "electric"},
                    {"label": "Hybrid", "value": "hybrid"},
                    {"label": "SUV", "value": "suv"},
                    {"label": "Compact", "value": "compact"},
                  ],
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Sort By",
                  items: [
                    {"label": "Distance", "value": "distance"},
                    {"label": "Price", "value": "price"},
                    {"label": "Service", "value": "service"},
                  ],
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: spMd),

        // Available Vehicles
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: filteredVehicles.length,
            itemBuilder: (context, index) {
              final vehicle = filteredVehicles[index];
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    // Vehicle Image
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                      child: Stack(
                        children: [
                          Image.network(
                            "${vehicle["image"]}",
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${vehicle["service"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusXs),
                                boxShadow: [shadowSm],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    vehicle["type"] == "Electric" ? Icons.battery_charging_full : Icons.local_gas_station,
                                    size: 12,
                                    color: vehicle["type"] == "Electric" ? successColor : primaryColor,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    vehicle["type"] == "Electric" 
                                      ? "${vehicle["battery_level"]}%"
                                      : "${vehicle["fuel_level"]}%",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: vehicle["type"] == "Electric" ? successColor : primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Vehicle Details
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Vehicle Name & Distance
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${vehicle["model"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on, size: 12, color: disabledBoldColor),
                                        SizedBox(width: 2),
                                        Text(
                                          "${vehicle["location"]} • ${vehicle["distance"]} mi",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getTypeColor(vehicle["type"]).withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${vehicle["type"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getTypeColor(vehicle["type"]),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: spSm),

                          // Pricing
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                if (vehicle.containsKey("price_per_minute")) ...[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "\$${vehicle["price_per_minute"]}/min",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "Per Minute",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 1,
                                    color: primaryColor.withAlpha(100),
                                  ),
                                ],
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "\$${vehicle["price_per_hour"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Per Hour",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (vehicle.containsKey("price_per_day")) ...[
                                  Container(
                                    height: 30,
                                    width: 1,
                                    color: primaryColor.withAlpha(100),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "\$${vehicle["price_per_day"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "Per Day",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          SizedBox(height: spSm),

                          // Vehicle Features
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (vehicle["features"] as List).take(4).map((feature) => 
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: disabledColor.withAlpha(100),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$feature",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ).toList(),
                          ),

                          SizedBox(height: spSm),

                          // Availability & Action
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Available until",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      DateTime.parse(vehicle["available_until"]).dMMMy,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                label: "Reserve",
                                size: bs.sm,
                                onPressed: () {
                                  _showReservationDialog(vehicle);
                                },
                              ),
                            ],
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
    );
  }

  Widget _buildBookingsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: myReservations.length,
      itemBuilder: (context, index) {
        final reservation = myReservations[index];
        final statusColor = reservation["status"] == "confirmed" ? successColor : infoColor;
        
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: statusColor),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${reservation["vehicle"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${reservation["service"]} • ${reservation["location"]}",
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
                      color: statusColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${reservation["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: spSm),

              // Booking Details
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
                        Icon(Icons.schedule, size: 16, color: primaryColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Start: ${DateTime.parse(reservation["start_time"]).dMMMykkmm}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.event, size: 16, color: primaryColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "End: ${DateTime.parse(reservation["end_time"]).dMMMykkmm}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.receipt, size: 16, color: primaryColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Code: ${reservation["reservation_code"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${(reservation["total_cost"] as double).currency}",
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

              SizedBox(height: spSm),

              // Action Buttons
              Row(
                children: [
                  if (reservation["status"] == "upcoming") ...[
                    Expanded(
                      child: QButton(
                        label: "Modify",
                        size: bs.sm,
                        onPressed: () {
                          _modifyReservation(reservation);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Cancel",
                        size: bs.sm,
                        onPressed: () {
                          _cancelReservation(reservation);
                        },
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: QButton(
                        label: "View Receipt",
                        size: bs.sm,
                        onPressed: () {
                          _viewReceipt(reservation);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Rate Trip",
                        size: bs.sm,
                        onPressed: () {
                          _rateTrip(reservation);
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildServicesTab() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: carSharingServices.length,
      itemBuilder: (context, index) {
        final service = carSharingServices[index];
        
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Header
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${service["logo"]}",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spSm),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${service["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.star, size: 12, color: warningColor),
                            Text(
                              " ${service["rating"]} • ${service["vehicles_nearby"]} vehicles nearby",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: spSm),

              Text(
                "${service["description"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),

              SizedBox(height: spSm),

              // Pricing Info
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Starting at \$${service["starting_price"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${service["pricing_model"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if ((service["membership_fee"] as double) > 0) ...[
                      Text(
                        "\$${service["membership_fee"]}/month",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ] else ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "NO MEMBERSHIP FEE",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: spSm),

              // Service Features
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFeatureRow("Gas Included", service["gas_included"], Icons.local_gas_station),
                        _buildFeatureRow("Insurance Included", service["insurance_included"], Icons.security),
                        if (service["mileage_limit"] != null)
                          _buildFeatureRow("${service["mileage_limit"]} miles/day", true, Icons.speed),
                      ],
                    ),
                  ),
                  QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      _showServiceDetails(service);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeatureRow(String feature, bool included, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Icon(
            icon,
            size: 12,
            color: included ? successColor : disabledBoldColor,
          ),
          SizedBox(width: spXs),
          Text(
            feature,
            style: TextStyle(
              fontSize: 11,
              color: included ? successColor : disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case "electric":
        return successColor;
      case "hybrid":
        return infoColor;
      case "suv":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  void _showReservationDialog(Map<String, dynamic> vehicle) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reserve ${vehicle["model"]}",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            Text("Location: ${vehicle["location"]}"),
            Text("Distance: ${vehicle["distance"]} miles"),
            Text("Rate: \$${vehicle["price_per_hour"]}/hour"),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reserve Now",
                    size: bs.md,
                    onPressed: () {
                      Navigator.pop(context);
                      ss("Vehicle reserved successfully!");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showServiceDetails(Map<String, dynamic> service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${service["name"]} Details",
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
            
            Text("Available Locations:"),
            ...(service["locations"] as List).map((location) => 
              Text("• $location", style: TextStyle(fontSize: 12)),
            ).toList(),
            
            SizedBox(height: spSm),
            
            Text("Vehicle Types:"),
            ...(service["vehicle_types"] as List).map((type) => 
              Text("• $type", style: TextStyle(fontSize: 12)),
            ).toList(),
          ],
        ),
      ),
    );
  }

  void _showLocationPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Location"),
        content: Text("Choose your preferred pickup location"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              si("Location updated");
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  void _modifyReservation(Map<String, dynamic> reservation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Modify Reservation"),
        content: Text("Modify your reservation for ${reservation["vehicle"]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              si("Opening modification options");
            },
            child: Text("Modify"),
          ),
        ],
      ),
    );
  }

  void _cancelReservation(Map<String, dynamic> reservation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cancel Reservation"),
        content: Text("Are you sure you want to cancel this reservation?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Keep"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Reservation cancelled");
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _viewReceipt(Map<String, dynamic> reservation) {
    si("Displaying receipt for ${reservation["reservation_code"]}");
  }

  void _rateTrip(Map<String, dynamic> reservation) {
    si("Opening rating form");
  }
}
