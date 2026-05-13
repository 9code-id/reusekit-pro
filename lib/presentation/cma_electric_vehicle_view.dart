import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaElectricVehicleView extends StatefulWidget {
  const CmaElectricVehicleView({super.key});

  @override
  State<CmaElectricVehicleView> createState() => _CmaElectricVehicleViewState();
}

class _CmaElectricVehicleViewState extends State<CmaElectricVehicleView> {
  int selectedTab = 0;
  String selectedCategory = "All";
  String selectedBrand = "All";
  String priceRange = "All";
  bool showFilters = false;

  List<Map<String, dynamic>> electricVehicles = [
    {
      "id": 1,
      "name": "Tesla Model S",
      "brand": "Tesla",
      "category": "Sedan",
      "price": 89990,
      "year": 2024,
      "range": 405,
      "batteryCapacity": 100,
      "chargingTime": "10 hours (AC) / 30 min (DC)",
      "acceleration": "3.1 seconds",
      "topSpeed": "200 mph",
      "efficiency": "120 MPGe",
      "color": "Pearl White",
      "rating": 4.8,
      "reviews": 245,
      "image": "https://picsum.photos/400/250?random=1&keyword=electric-car",
      "dealer": "Tesla Showroom",
      "location": "San Francisco, CA",
      "availability": "In Stock",
      "features": ["Autopilot", "Supercharging", "Over-the-air updates", "Premium Interior"],
      "isFavorite": false,
      "isNew": true,
      "type": "BEV",
      "warranty": "8 years / 150,000 miles"
    },
    {
      "id": 2,
      "name": "BMW iX",
      "brand": "BMW",
      "category": "SUV",
      "price": 84100,
      "year": 2024,
      "range": 324,
      "batteryCapacity": 111.5,
      "chargingTime": "11 hours (AC) / 35 min (DC)",
      "acceleration": "4.6 seconds",
      "topSpeed": "155 mph",
      "efficiency": "86 MPGe",
      "color": "Storm Bay",
      "rating": 4.6,
      "reviews": 156,
      "image": "https://picsum.photos/400/250?random=2&keyword=electric-suv",
      "dealer": "BMW Electric",
      "location": "Los Angeles, CA",
      "availability": "Limited",
      "features": ["iDrive 8", "Harman Kardon Sound", "Panoramic Roof", "Air Suspension"],
      "isFavorite": true,
      "isNew": false,
      "type": "BEV",
      "warranty": "4 years / 50,000 miles"
    },
    {
      "id": 3,
      "name": "Ford F-150 Lightning",
      "brand": "Ford",
      "category": "Truck",
      "price": 59974,
      "year": 2024,
      "range": 320,
      "batteryCapacity": 131,
      "chargingTime": "13 hours (AC) / 41 min (DC)",
      "acceleration": "4.5 seconds",
      "topSpeed": "110 mph",
      "efficiency": "78 MPGe",
      "color": "Lightning Blue",
      "rating": 4.5,
      "reviews": 189,
      "image": "https://picsum.photos/400/250?random=3&keyword=electric-truck",
      "dealer": "Ford Electric Center",
      "location": "Detroit, MI",
      "availability": "Pre-order",
      "features": ["Pro Power Onboard", "Intelligent Backup Power", "Mega Power Frunk", "Ford Co-Pilot360"],
      "isFavorite": false,
      "isNew": true,
      "type": "BEV",
      "warranty": "8 years / 100,000 miles"
    },
    {
      "id": 4,
      "name": "Mercedes EQS",
      "brand": "Mercedes-Benz",
      "category": "Sedan",
      "price": 102310,
      "year": 2024,
      "range": 453,
      "batteryCapacity": 107.8,
      "chargingTime": "11.5 hours (AC) / 31 min (DC)",
      "acceleration": "4.1 seconds",
      "topSpeed": "155 mph",
      "efficiency": "97 MPGe",
      "color": "Obsidian Black",
      "rating": 4.7,
      "reviews": 98,
      "image": "https://picsum.photos/400/250?random=4&keyword=luxury-electric",
      "dealer": "Mercedes-Benz Electric",
      "location": "New York, NY",
      "availability": "In Stock",
      "features": ["MBUX Hyperscreen", "Air Body Control", "Burmester 3D Sound", "Massage Seats"],
      "isFavorite": true,
      "isNew": false,
      "type": "BEV",
      "warranty": "4 years / 50,000 miles"
    },
    {
      "id": 5,
      "name": "Chevrolet Bolt EUV",
      "brand": "Chevrolet",
      "category": "Crossover",
      "price": 28795,
      "year": 2024,
      "range": 247,
      "batteryCapacity": 65,
      "chargingTime": "7 hours (AC) / 38 min (DC)",
      "acceleration": "7.0 seconds",
      "topSpeed": "93 mph",
      "efficiency": "125 MPGe",
      "color": "Summit White",
      "rating": 4.3,
      "reviews": 127,
      "image": "https://picsum.photos/400/250?random=5&keyword=electric-crossover",
      "dealer": "Chevrolet Electric",
      "location": "Chicago, IL",
      "availability": "In Stock",
      "features": ["Super Cruise", "Infotainment System", "Wireless Charging", "Keyless Entry"],
      "isFavorite": false,
      "isNew": true,
      "type": "BEV",
      "warranty": "8 years / 100,000 miles"
    },
    {
      "id": 6,
      "name": "Audi e-tron GT",
      "brand": "Audi",
      "category": "Sports Car",
      "price": 106500,
      "year": 2024,
      "range": 238,
      "batteryCapacity": 93.4,
      "chargingTime": "9.5 hours (AC) / 23 min (DC)",
      "acceleration": "3.9 seconds",
      "topSpeed": "152 mph",
      "efficiency": "77 MPGe",
      "color": "Daytona Gray",
      "rating": 4.9,
      "reviews": 76,
      "image": "https://picsum.photos/400/250?random=6&keyword=electric-sports",
      "dealer": "Audi Electric Performance",
      "location": "Miami, FL",
      "availability": "Limited",
      "features": ["Quattro AWD", "Air Suspension", "Bang & Olufsen Sound", "Virtual Cockpit"],
      "isFavorite": true,
      "isNew": false,
      "type": "BEV",
      "warranty": "4 years / 50,000 miles"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Sedan", "value": "Sedan"},
    {"label": "SUV", "value": "SUV"},
    {"label": "Crossover", "value": "Crossover"},
    {"label": "Truck", "value": "Truck"},
    {"label": "Sports Car", "value": "Sports Car"},
    {"label": "Hatchback", "value": "Hatchback"}
  ];

  List<Map<String, dynamic>> brands = [
    {"label": "All Brands", "value": "All"},
    {"label": "Tesla", "value": "Tesla"},
    {"label": "BMW", "value": "BMW"},
    {"label": "Mercedes-Benz", "value": "Mercedes-Benz"},
    {"label": "Audi", "value": "Audi"},
    {"label": "Ford", "value": "Ford"},
    {"label": "Chevrolet", "value": "Chevrolet"}
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "All Prices", "value": "All"},
    {"label": "Under \$50K", "value": "under_50k"},
    {"label": "\$50K - \$80K", "value": "50k_80k"},
    {"label": "\$80K - \$100K", "value": "80k_100k"},
    {"label": "Over \$100K", "value": "over_100k"}
  ];

  List<Map<String, dynamic>> get filteredVehicles {
    return electricVehicles.where((vehicle) {
      bool matchesCategory = selectedCategory == "All" || vehicle["category"] == selectedCategory;
      bool matchesBrand = selectedBrand == "All" || vehicle["brand"] == selectedBrand;
      
      bool matchesPrice = true;
      if (priceRange != "All") {
        int price = vehicle["price"] as int;
        switch (priceRange) {
          case "under_50k":
            matchesPrice = price < 50000;
            break;
          case "50k_80k":
            matchesPrice = price >= 50000 && price < 80000;
            break;
          case "80k_100k":
            matchesPrice = price >= 80000 && price < 100000;
            break;
          case "over_100k":
            matchesPrice = price >= 100000;
            break;
        }
      }
      
      return matchesCategory && matchesBrand && matchesPrice;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Electric Vehicles"),
        actions: [
          IconButton(
            icon: Icon(Icons.electric_bolt),
            onPressed: () {
              _showEVInfoDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              setState(() {
                showFilters = !showFilters;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          if (showFilters) _buildFilterSection(),
          
          // Quick Stats
          _buildQuickStats(),
          
          // Category Filter
          _buildCategoryFilter(),
          
          // Vehicles List
          Expanded(
            child: _buildVehiclesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Brand",
                  items: brands,
                  value: selectedBrand,
                  onChanged: (value, label) {
                    selectedBrand = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Price Range",
                  items: priceRanges,
                  value: priceRange,
                  onChanged: (value, label) {
                    priceRange = value;
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

  Widget _buildQuickStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          _buildStatItem("Available Models", "${filteredVehicles.length}", Icons.electric_car, successColor),
          SizedBox(width: spMd),
          _buildStatItem("Avg Range", "${_calculateAverageRange()} mi", Icons.battery_charging_full, infoColor),
          SizedBox(width: spMd),
          _buildStatItem("Starting From", "\$${_getLowestPrice()}K", Icons.attach_money, primaryColor),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 60,
      child: QHorizontalScroll(
        children: categories.map((category) {
          bool isSelected = selectedCategory == category["value"];
          return Container(
            margin: EdgeInsets.only(right: spSm),
            child: FilterChip(
              label: Text("${category["label"]}"),
              selected: isSelected,
              onSelected: (selected) {
                selectedCategory = category["value"];
                setState(() {});
              },
              backgroundColor: Colors.white,
              selectedColor: primaryColor.withAlpha(30),
              labelStyle: TextStyle(
                color: isSelected ? primaryColor : disabledBoldColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVehiclesList() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredVehicles.length,
      itemBuilder: (context, index) {
        final vehicle = filteredVehicles[index];
        return _buildVehicleCard(vehicle);
      },
    );
  }

  Widget _buildVehicleCard(Map<String, dynamic> vehicle) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Status
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    "${vehicle["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (vehicle["isNew"] as bool)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "NEW 2024",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.electric_bolt, color: Colors.yellow, size: 14),
                          SizedBox(width: spXs),
                          Text(
                            "${vehicle["type"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        vehicle["isFavorite"] = !(vehicle["isFavorite"] as bool);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [shadowSm],
                        ),
                        child: Icon(
                          vehicle["isFavorite"] as bool ? Icons.favorite : Icons.favorite_border,
                          color: vehicle["isFavorite"] as bool ? dangerColor : disabledBoldColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: _getAvailabilityColor(vehicle["availability"]),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${vehicle["availability"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Content
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Title and Price
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
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${vehicle["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${vehicle["brand"]} • ${vehicle["year"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${((vehicle["price"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                
                // Key EV Specs
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          _buildEVSpecItem(Icons.route, "${vehicle["range"]} mi", "Range"),
                          Spacer(),
                          _buildEVSpecItem(Icons.battery_full, "${vehicle["batteryCapacity"]} kWh", "Battery"),
                        ],
                      ),
                      Row(
                        children: [
                          _buildEVSpecItem(Icons.flash_on, "${vehicle["efficiency"]}", "Efficiency"),
                          Spacer(),
                          _buildEVSpecItem(Icons.speed, "${vehicle["acceleration"]}", "0-60 mph"),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Charging Info
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.electrical_services, size: 16, color: infoColor),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Charging: ${vehicle["chargingTime"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Rating and Reviews
                Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${vehicle["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      " (${vehicle["reviews"]} reviews)",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Warranty: ${vehicle["warranty"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                
                // Features
                if ((vehicle["features"] as List).isNotEmpty)
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (vehicle["features"] as List).take(3).map((feature) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "$feature",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                
                // Dealer Info and Actions
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${vehicle["dealer"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${vehicle["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        QButton(
                          label: "Test Drive",
                          size: bs.sm,
                          onPressed: () {
                            _scheduleTestDrive(vehicle);
                          },
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Details",
                          size: bs.sm,
                          onPressed: () {
                            _showVehicleDetails(vehicle);
                          },
                        ),
                      ],
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

  Widget _buildEVSpecItem(IconData icon, String value, String label) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 14, color: successColor),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
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
            ),
          ),
        ],
      ),
    );
  }

  Color _getAvailabilityColor(String availability) {
    switch (availability) {
      case "In Stock":
        return successColor;
      case "Limited":
        return warningColor;
      case "Pre-order":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  int _calculateAverageRange() {
    if (filteredVehicles.isEmpty) return 0;
    return (filteredVehicles
        .map((v) => v["range"] as int)
        .reduce((a, b) => a + b) / filteredVehicles.length).round();
  }

  int _getLowestPrice() {
    if (filteredVehicles.isEmpty) return 0;
    return ((filteredVehicles
        .map((v) => v["price"] as int)
        .reduce((a, b) => a < b ? a : b)) / 1000).round();
  }

  void _showEVInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.electric_bolt, color: successColor),
            SizedBox(width: spSm),
            Text("Electric Vehicle Guide"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Types of Electric Vehicles:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: spSm),
            Text("• BEV - Battery Electric Vehicle (100% electric)"),
            Text("• PHEV - Plug-in Hybrid Electric Vehicle"),
            Text("• HEV - Hybrid Electric Vehicle"),
            SizedBox(height: spMd),
            Text(
              "Key Benefits:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: spSm),
            Text("• Zero emissions"),
            Text("• Lower operating costs"),
            Text("• Instant torque"),
            Text("• Quiet operation"),
            Text("• Government incentives available"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  void _scheduleTestDrive(Map<String, dynamic> vehicle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Schedule Test Drive"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Vehicle: ${vehicle["name"]}"),
            SizedBox(height: spSm),
            Text("Dealer: ${vehicle["dealer"]}"),
            Text("Location: ${vehicle["location"]}"),
            SizedBox(height: spMd),
            Text("A test drive specialist will contact you within 24 hours to schedule your appointment."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Schedule",
            size: bs.sm,
            onPressed: () {
              ss("Test drive scheduled successfully!");
              back();
            },
          ),
        ],
      ),
    );
  }

  void _showVehicleDetails(Map<String, dynamic> vehicle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${vehicle["name"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => back(),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        child: Image.network(
                          "${vehicle["image"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    // Price and Availability
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: successColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Starting Price",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((vehicle["price"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            decoration: BoxDecoration(
                              color: _getAvailabilityColor(vehicle["availability"]),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${vehicle["availability"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Text(
                      "Electric Performance",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          _buildDetailRow("Range", "${vehicle["range"]} miles"),
                          _buildDetailRow("Battery Capacity", "${vehicle["batteryCapacity"]} kWh"),
                          _buildDetailRow("Charging Time", "${vehicle["chargingTime"]}"),
                          _buildDetailRow("Efficiency", "${vehicle["efficiency"]}"),
                          _buildDetailRow("Acceleration", "0-60 mph in ${vehicle["acceleration"]}"),
                          _buildDetailRow("Top Speed", "${vehicle["topSpeed"]}"),
                        ],
                      ),
                    ),
                    
                    Text(
                      "Vehicle Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          _buildDetailRow("Brand", "${vehicle["brand"]}"),
                          _buildDetailRow("Model Year", "${vehicle["year"]}"),
                          _buildDetailRow("Category", "${vehicle["category"]}"),
                          _buildDetailRow("Type", "${vehicle["type"]} (Battery Electric Vehicle)"),
                          _buildDetailRow("Color", "${vehicle["color"]}"),
                          _buildDetailRow("Warranty", "${vehicle["warranty"]}"),
                        ],
                      ),
                    ),
                    
                    Text(
                      "Standard Features",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: (vehicle["features"] as List).map((feature) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$feature",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                    Text(
                      "Customer Reviews",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "${vehicle["rating"]}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < (vehicle["rating"] as double).floor() ? Icons.star : Icons.star_border,
                                    color: warningColor,
                                    size: 16,
                                  );
                                }),
                              ),
                            ],
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Based on ${vehicle["reviews"]} reviews",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Customers love the performance and efficiency",
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
                    ),
                  ],
                ),
              ),
            ),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Schedule Test Drive",
                    onPressed: () {
                      back();
                      _scheduleTestDrive(vehicle);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Contact Dealer",
                    onPressed: () {
                      ss("Dealer contact information sent!");
                      back();
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

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          ":",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
