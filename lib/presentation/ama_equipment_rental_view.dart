import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaEquipmentRentalView extends StatefulWidget {
  const AmaEquipmentRentalView({super.key});

  @override
  State<AmaEquipmentRentalView> createState() => _AmaEquipmentRentalViewState();
}

class _AmaEquipmentRentalViewState extends State<AmaEquipmentRentalView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedAvailability = "All";
  bool showFilters = false;

  List<Map<String, dynamic>> rentalEquipment = [
    {
      "id": "RENT001",
      "name": "John Deere 9620R Tractor",
      "category": "Tractor",
      "brand": "John Deere",
      "model": "9620R",
      "year": 2023,
      "horsepower": 620,
      "dailyRate": 350.00,
      "weeklyRate": 2100.00,
      "monthlyRate": 7500.00,
      "availability": "Available",
      "location": "North Farm Equipment Center",
      "description": "High-performance tractor suitable for large-scale farming operations",
      "features": ["GPS Navigation", "Auto Steer", "Variable Rate Technology", "Climate Control"],
      "specifications": {
        "engine": "13.5L PowerTech PSS",
        "transmission": "e23 PowerShift",
        "hydraulics": "Closed Center Load Sensing",
        "fuelCapacity": "1135L"
      },
      "images": ["https://picsum.photos/400/300?random=1&keyword=tractor"],
      "rating": 4.8,
      "totalRentals": 45,
      "lastMaintenance": "2025-05-15",
      "nextMaintenance": "2025-08-15",
      "operatingHours": 1250,
      "maxHours": 5000,
      "insurance": "Included",
      "delivery": "Available",
      "operator": "Optional",
      "icon": Icons.agriculture,
      "available": true
    },
    {
      "id": "RENT002",
      "name": "Case IH Magnum 380 CVX",
      "category": "Tractor",
      "brand": "Case IH",
      "model": "Magnum 380 CVX",
      "year": 2022,
      "horsepower": 380,
      "dailyRate": 285.00,
      "weeklyRate": 1750.00,
      "monthlyRate": 6200.00,
      "availability": "Available",
      "location": "Central Equipment Hub",
      "description": "Versatile tractor with continuously variable transmission for precision farming",
      "features": ["CVX Transmission", "AFS Pro 1200 Display", "Precision Farming Ready", "LED Lighting"],
      "specifications": {
        "engine": "FPT Cursor 13 Stage V",
        "transmission": "CVX Continuously Variable",
        "hydraulics": "Load Sensing System",
        "fuelCapacity": "757L"
      },
      "images": ["https://picsum.photos/400/300?random=2&keyword=tractor"],
      "rating": 4.6,
      "totalRentals": 38,
      "lastMaintenance": "2025-04-20",
      "nextMaintenance": "2025-07-20",
      "operatingHours": 980,
      "maxHours": 4500,
      "insurance": "Included",
      "delivery": "Available",
      "operator": "Optional",
      "icon": Icons.agriculture,
      "available": true
    },
    {
      "id": "RENT003",
      "name": "Claas Lexion 8900",
      "category": "Harvester",
      "brand": "Claas",
      "model": "Lexion 8900",
      "year": 2024,
      "horsepower": 790,
      "dailyRate": 650.00,
      "weeklyRate": 4200.00,
      "monthlyRate": 15000.00,
      "availability": "Rented",
      "location": "South Harvest Center",
      "description": "Premium combine harvester for efficient grain harvesting operations",
      "features": ["Terra Trac System", "APS Threshing", "Lexion Efficient Power", "Cemos Dialog"],
      "specifications": {
        "engine": "Mercedes-Benz OM471LA",
        "grainTank": "18000L",
        "cuttingWidth": "13.8m",
        "threshingSystem": "APS"
      },
      "images": ["https://picsum.photos/400/300?random=3&keyword=harvester"],
      "rating": 4.9,
      "totalRentals": 22,
      "lastMaintenance": "2025-06-01",
      "nextMaintenance": "2025-09-01",
      "operatingHours": 450,
      "maxHours": 3000,
      "insurance": "Included",
      "delivery": "Available",
      "operator": "Required",
      "icon": Icons.grass,
      "available": false,
      "currentRenter": "Johnson Farms",
      "returnDate": "2025-07-15"
    },
    {
      "id": "RENT004",
      "name": "New Holland CR10.90",
      "category": "Harvester",
      "brand": "New Holland",
      "model": "CR10.90",
      "year": 2023,
      "horsepower": 652,
      "dailyRate": 580.00,
      "weeklyRate": 3800.00,
      "monthlyRate": 13500.00,
      "availability": "Available",
      "location": "East Equipment Depot",
      "description": "Advanced combine harvester with twin rotor technology",
      "features": ["Twin Rotor System", "IntelliSense Technology", "SuperSteer FWD", "CrossFlow Cleaning"],
      "specifications": {
        "engine": "FPT Cursor 16 Stage V",
        "grainTank": "14100L",
        "cuttingWidth": "12.2m",
        "threshingSystem": "Twin Rotor"
      },
      "images": ["https://picsum.photos/400/300?random=4&keyword=harvester"],
      "rating": 4.7,
      "totalRentals": 31,
      "lastMaintenance": "2025-05-10",
      "nextMaintenance": "2025-08-10",
      "operatingHours": 675,
      "maxHours": 3500,
      "insurance": "Included",
      "delivery": "Available",
      "operator": "Optional",
      "icon": Icons.grass,
      "available": true
    },
    {
      "id": "RENT005",
      "name": "Caterpillar 950M Wheel Loader",
      "category": "Loader",
      "brand": "Caterpillar",
      "model": "950M",
      "year": 2022,
      "horsepower": 274,
      "dailyRate": 425.00,
      "weeklyRate": 2650.00,
      "monthlyRate": 9500.00,
      "availability": "Maintenance",
      "location": "West Construction Hub",
      "description": "Versatile wheel loader for material handling and construction tasks",
      "features": ["Cat C7.1 Engine", "Load Sensing Hydraulics", "Comfort Cab", "Traction Control"],
      "specifications": {
        "engine": "Cat C7.1 ACERT Stage V",
        "bucketCapacity": "4.2m³",
        "operatingWeight": "17500kg",
        "hydraulicFlow": "310L/min"
      },
      "images": ["https://picsum.photos/400/300?random=5&keyword=loader"],
      "rating": 4.5,
      "totalRentals": 28,
      "lastMaintenance": "2025-06-12",
      "nextMaintenance": "2025-09-12",
      "operatingHours": 1420,
      "maxHours": 6000,
      "insurance": "Included",
      "delivery": "Available",
      "operator": "Optional",
      "icon": Icons.construction,
      "available": false,
      "maintenanceType": "Scheduled Service",
      "expectedReturn": "2025-06-20"
    },
    {
      "id": "RENT006",
      "name": "Krone Big X 1180 Forage Harvester",
      "category": "Harvester",
      "brand": "Krone",
      "model": "Big X 1180",
      "year": 2024,
      "horsepower": 1156,
      "dailyRate": 780.00,
      "weeklyRate": 4900.00,
      "monthlyRate": 17500.00,
      "availability": "Available",
      "location": "North Farm Equipment Center",
      "description": "High-capacity forage harvester for silage production",
      "features": ["VariLOC Chopping Cylinder", "OptiLOC Metal Detection", "AutoScan", "Premium Cab"],
      "specifications": {
        "engine": "Liebherr D9812 Stage V",
        "choppingCylinder": "660mm diameter",
        "headerWidth": "8.4m",
        "chopLength": "4-30mm"
      },
      "images": ["https://picsum.photos/400/300?random=6&keyword=harvester"],
      "rating": 4.8,
      "totalRentals": 15,
      "lastMaintenance": "2025-05-25",
      "nextMaintenance": "2025-08-25",
      "operatingHours": 320,
      "maxHours": 2500,
      "insurance": "Included",
      "delivery": "Available",
      "operator": "Required",
      "icon": Icons.grass,
      "available": true
    }
  ];

  List<Map<String, dynamic>> myRentals = [
    {
      "id": "RENT001",
      "equipmentName": "John Deere 9620R Tractor",
      "rentalId": "RNT-2025-001",
      "startDate": "2025-06-10",
      "endDate": "2025-06-24",
      "status": "Active",
      "dailyRate": 350.00,
      "totalCost": 4900.00,
      "deposit": 1000.00,
      "location": "North Farm Equipment Center",
      "deliveryDate": "2025-06-10",
      "returnLocation": "Same",
      "operator": "Self-operated",
      "insurance": "Full Coverage",
      "hoursUsed": 85,
      "fuelLevel": 75,
      "condition": "Excellent"
    },
    {
      "id": "RENT003",
      "equipmentName": "Claas Lexion 8900",
      "rentalId": "RNT-2025-002",
      "startDate": "2025-05-15",
      "endDate": "2025-05-29",
      "status": "Completed",
      "dailyRate": 650.00,
      "totalCost": 9100.00,
      "deposit": 2000.00,
      "location": "South Harvest Center",
      "deliveryDate": "2025-05-15",
      "returnLocation": "Same",
      "operator": "Provided",
      "insurance": "Full Coverage",
      "hoursUsed": 112,
      "fuelLevel": 100,
      "condition": "Good"
    }
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Tractor", "value": "Tractor"},
    {"label": "Harvester", "value": "Harvester"},
    {"label": "Loader", "value": "Loader"},
    {"label": "Planter", "value": "Planter"},
    {"label": "Sprayer", "value": "Sprayer"}
  ];

  List<Map<String, dynamic>> availabilityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Available", "value": "Available"},
    {"label": "Rented", "value": "Rented"},
    {"label": "Maintenance", "value": "Maintenance"}
  ];

  List<Map<String, dynamic>> get filteredEquipment {
    return rentalEquipment.where((equipment) {
      bool matchesSearch = equipment["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                        equipment["brand"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || equipment["category"] == selectedCategory;
      bool matchesAvailability = selectedAvailability == "All" || equipment["availability"] == selectedAvailability;
      return matchesSearch && matchesCategory && matchesAvailability;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Equipment Rental",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Browse", icon: Icon(Icons.search)),
        Tab(text: "My Rentals", icon: Icon(Icons.assignment)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildBrowseTab(),
        _buildMyRentalsTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildBrowseTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildRentalStats(),
          _buildEquipmentGrid(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search equipment...",
                value: searchQuery,
                hint: "Search by name or brand",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: showFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
              size: bs.sm,
              onPressed: () {
                showFilters = !showFilters;
                setState(() {});
              },
            ),
          ],
        ),
        if (showFilters) ...[
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Availability",
                  items: availabilityOptions,
                  value: selectedAvailability,
                  onChanged: (value, label) {
                    selectedAvailability = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildRentalStats() {
    int totalEquipment = rentalEquipment.length;
    int availableEquipment = rentalEquipment.where((e) => e["availability"] == "Available").length;
    int rentedEquipment = rentalEquipment.where((e) => e["availability"] == "Rented").length;
    double avgRating = rentalEquipment.fold(0.0, (sum, e) => sum + (e["rating"] as double)) / totalEquipment;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Equipment", totalEquipment.toString(), Icons.precision_manufacturing, primaryColor),
        _buildStatCard("Available", availableEquipment.toString(), Icons.check_circle, successColor),
        _buildStatCard("Rented", rentedEquipment.toString(), Icons.schedule, warningColor),
        _buildStatCard("Avg Rating", "${avgRating.toStringAsFixed(1)}/5", Icons.star, infoColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
              Icon(icon, color: color, size: 24),
              Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
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
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEquipmentGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: filteredEquipment.map((equipment) => _buildEquipmentCard(equipment)).toList(),
    );
  }

  Widget _buildEquipmentCard(Map<String, dynamic> equipment) {
    Color availabilityColor = _getAvailabilityColor(equipment["availability"]);
    bool isAvailable = equipment["available"] as bool;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          top: BorderSide(
            width: 4,
            color: availabilityColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Stack(
              children: [
                Image.network(
                  "${(equipment["images"] as List)[0]}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: availabilityColor.withAlpha(220),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${equipment["availability"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      equipment["icon"] as IconData,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${equipment["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${equipment["brand"]} ${equipment["model"]} • ${equipment["year"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${equipment["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) => Icon(
                        index < (equipment["rating"] as double).floor() ? Icons.star : Icons.star_border,
                        color: warningColor,
                        size: 12,
                      )),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${equipment["rating"]} (${equipment["totalRentals"]})",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Daily Rate",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(equipment["dailyRate"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Weekly Rate",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(equipment["weeklyRate"] as double).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: disabledBoldColor, size: 12),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${equipment["location"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: isAvailable ? "Rent Now" : "View Details",
                    size: bs.sm,
                    onPressed: () {
                      if (isAvailable) {
                        ss("Starting rental process for ${equipment["name"]}");
                      } else {
                        si("Viewing details for ${equipment["name"]}");
                      }
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

  Widget _buildMyRentalsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRentalSummary(),
          _buildActiveRentalsList(),
        ],
      ),
    );
  }

  Widget _buildRentalSummary() {
    int activeRentals = myRentals.where((r) => r["status"] == "Active").length;
    double totalSpent = myRentals.fold(0.0, (sum, r) => sum + (r["totalCost"] as double));
    int totalRentals = myRentals.length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildRentalStatCard("Active Rentals", activeRentals.toString(), Icons.schedule, warningColor),
        _buildRentalStatCard("Total Spent", "\$${(totalSpent / 1000).toStringAsFixed(1)}K", Icons.monetization_on, primaryColor),
        _buildRentalStatCard("Total Rentals", totalRentals.toString(), Icons.history, successColor),
      ],
    );
  }

  Widget _buildRentalStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
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
    );
  }

  Widget _buildActiveRentalsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "My Active Rentals",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...myRentals.map((rental) => _buildRentalCard(rental)).toList(),
      ],
    );
  }

  Widget _buildRentalCard(Map<String, dynamic> rental) {
    Color statusColor = rental["status"] == "Active" ? successColor : 
                       rental["status"] == "Completed" ? primaryColor : warningColor;
    DateTime startDate = DateTime.parse("${rental["startDate"]}");
    DateTime endDate = DateTime.parse("${rental["endDate"]}");
    int daysLeft = endDate.difference(DateTime.now()).inDays;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${rental["equipmentName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Rental ID: ${rental["rentalId"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${rental["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (rental["status"] == "Active")
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: statusColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time, color: statusColor, size: 16),
                  SizedBox(width: spSm),
                  Text(
                    daysLeft > 0 ? "$daysLeft days remaining" : "Due today",
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildRentalInfoItem("Start Date", "${startDate.dMMMy}", Icons.event),
              _buildRentalInfoItem("End Date", "${endDate.dMMMy}", Icons.event_available),
              _buildRentalInfoItem("Daily Rate", "\$${(rental["dailyRate"] as double).currency}", Icons.monetization_on),
              _buildRentalInfoItem("Total Cost", "\$${(rental["totalCost"] as double).currency}", Icons.receipt),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildRentalInfoItem("Hours Used", "${rental["hoursUsed"]}h", Icons.timer),
              _buildRentalInfoItem("Fuel Level", "${rental["fuelLevel"]}%", Icons.local_gas_station),
              _buildRentalInfoItem("Condition", "${rental["condition"]}", Icons.star),
              _buildRentalInfoItem("Location", "${rental["location"]}", Icons.location_on),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: rental["status"] == "Active" ? "Extend Rental" : "View Details",
                  size: bs.sm,
                  onPressed: () {
                    si("${rental["status"] == "Active" ? "Extending" : "Viewing"} rental ${rental["rentalId"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.support_agent,
                size: bs.sm,
                onPressed: () {
                  si("Contacting support for rental ${rental["rentalId"]}");
                },
              ),
              if (rental["status"] == "Active") ...[
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.assignment_return,
                  size: bs.sm,
                  onPressed: () {
                    si("Initiating early return for ${rental["rentalId"]}");
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRentalInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: disabledBoldColor, size: 16),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTab() {
    final completedRentals = [
      {
        "equipmentName": "Claas Lexion 8900",
        "rentalId": "RNT-2025-002",
        "startDate": "2025-05-15",
        "endDate": "2025-05-29",
        "totalCost": 9100.00,
        "rating": 5,
        "review": "Excellent harvester, helped us complete the harvest on time",
        "hoursUsed": 112,
        "efficiency": 95
      },
      {
        "equipmentName": "New Holland T8.435",
        "rentalId": "RNT-2025-001",
        "startDate": "2025-04-10",
        "endDate": "2025-04-20",
        "totalCost": 4800.00,
        "rating": 4,
        "review": "Good tractor, minor issues with hydraulics but overall satisfied",
        "hoursUsed": 98,
        "efficiency": 88
      },
      {
        "equipmentName": "Case IH Magnum 380 CVX", 
        "rentalId": "RNT-2025-003",
        "startDate": "2025-03-20",
        "endDate": "2025-04-05",
        "totalCost": 4550.00,
        "rating": 5,
        "review": "Perfect for our spring planting operations",
        "hoursUsed": 124,
        "efficiency": 92
      }
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildHistoryStats(completedRentals),
          _buildCompletedRentalsList(completedRentals),
        ],
      ),
    );
  }

  Widget _buildHistoryStats(List<Map<String, dynamic>> completedRentals) {
    int totalRentals = completedRentals.length;
    double totalSpent = completedRentals.fold(0.0, (sum, r) => sum + (r["totalCost"] as double));
    double avgRating = completedRentals.fold(0.0, (sum, r) => sum + (r["rating"] as int)) / totalRentals;
    double avgEfficiency = completedRentals.fold(0.0, (sum, r) => sum + (r["efficiency"] as int)) / totalRentals;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildHistoryStatCard("Total Rentals", totalRentals.toString(), Icons.history, primaryColor),
        _buildHistoryStatCard("Total Spent", "\$${(totalSpent / 1000).toStringAsFixed(1)}K", Icons.monetization_on, warningColor),
        _buildHistoryStatCard("Avg Rating", "${avgRating.toStringAsFixed(1)}/5", Icons.star, successColor),
        _buildHistoryStatCard("Avg Efficiency", "${avgEfficiency.toStringAsFixed(0)}%", Icons.trending_up, infoColor),
      ],
    );
  }

  Widget _buildHistoryStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  title,
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
    );
  }

  Widget _buildCompletedRentalsList(List<Map<String, dynamic>> completedRentals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Rental History",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...completedRentals.map((rental) => _buildCompletedRentalCard(rental)).toList(),
      ],
    );
  }

  Widget _buildCompletedRentalCard(Map<String, dynamic> rental) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: successColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: successColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${rental["equipmentName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Rental ID: ${rental["rentalId"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (index) => Icon(
                  index < (rental["rating"] as int) ? Icons.star : Icons.star_border,
                  color: warningColor,
                  size: 16,
                )),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildHistoryInfoItem("Period", "${DateTime.parse("${rental["startDate"]}").dMMMy} - ${DateTime.parse("${rental["endDate"]}").dMMMy}", Icons.date_range),
              _buildHistoryInfoItem("Hours Used", "${rental["hoursUsed"]}h", Icons.timer),
              _buildHistoryInfoItem("Total Cost", "\$${(rental["totalCost"] as double).currency}", Icons.receipt),
              _buildHistoryInfoItem("Efficiency", "${rental["efficiency"]}%", Icons.trending_up),
            ],
          ),
          if (rental["review"] != null && (rental["review"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.rate_review, color: successColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${rental["review"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Rent Again",
                  size: bs.sm,
                  onPressed: () {
                    ss("Initiating new rental for ${rental["equipmentName"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.receipt_long,
                size: bs.sm,
                onPressed: () {
                  si("Downloading receipt for ${rental["rentalId"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: successColor, size: 16),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getAvailabilityColor(String availability) {
    switch (availability) {
      case "Available":
        return successColor;
      case "Rented":
        return warningColor;
      case "Maintenance":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
