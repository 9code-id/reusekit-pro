import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaTruckMaintenanceView extends StatefulWidget {
  const CmaTruckMaintenanceView({super.key});

  @override
  State<CmaTruckMaintenanceView> createState() => _CmaTruckMaintenanceViewState();
}

class _CmaTruckMaintenanceViewState extends State<CmaTruckMaintenanceView> {
  int selectedTab = 0;
  String selectedTruck = "";
  String selectedServiceType = "All";
  bool showFilters = false;

  List<Map<String, dynamic>> trucks = [
    {
      "id": 1,
      "name": "Fleet Unit #1001",
      "model": "Freightliner Cascadia",
      "year": 2022,
      "mileage": 185420,
      "vin": "1FUJGBDV8NLAA1234",
      "status": "Active",
      "nextService": "2024-07-15",
      "image": "https://picsum.photos/300/200?random=1&keyword=truck"
    },
    {
      "id": 2,
      "name": "Fleet Unit #1002",
      "model": "Volvo VNL 860",
      "year": 2023,
      "mileage": 124850,
      "vin": "4V4NC9EH9PN123456",
      "status": "In Service",
      "nextService": "2024-06-28",
      "image": "https://picsum.photos/300/200?random=2&keyword=truck"
    },
    {
      "id": 3,
      "name": "Fleet Unit #1003",
      "model": "Peterbilt 579",
      "year": 2021,
      "mileage": 298750,
      "vin": "1XP5DB9X2MD123789",
      "status": "Active",
      "nextService": "2024-07-05",
      "image": "https://picsum.photos/300/200?random=3&keyword=truck"
    }
  ];

  List<Map<String, dynamic>> maintenanceRecords = [
    {
      "id": 1,
      "truckId": 1,
      "serviceType": "Oil Change",
      "date": "2024-06-15",
      "mileage": 185000,
      "cost": 245.50,
      "technician": "Mike Johnson",
      "shop": "AAA Truck Service",
      "status": "Completed",
      "description": "Standard oil change with filter replacement",
      "parts": ["Engine Oil", "Oil Filter", "Drain Plug Gasket"],
      "laborHours": 1.5,
      "priority": "Routine",
      "nextDue": "2024-09-15"
    },
    {
      "id": 2,
      "truckId": 1,
      "serviceType": "Brake Service",
      "date": "2024-06-10",
      "mileage": 184500,
      "cost": 1850.00,
      "technician": "Sarah Wilson",
      "shop": "Pro Fleet Maintenance",
      "status": "Completed",
      "description": "Front brake pad replacement and rotor resurfacing",
      "parts": ["Brake Pads", "Brake Rotors", "Brake Fluid"],
      "laborHours": 4.0,
      "priority": "High",
      "nextDue": "2024-12-10"
    },
    {
      "id": 3,
      "truckId": 2,
      "serviceType": "Tire Rotation",
      "date": "2024-06-12",
      "mileage": 124200,
      "cost": 180.00,
      "technician": "Robert Chen",
      "shop": "Highway Tire Center",
      "status": "Completed",
      "description": "Tire rotation and pressure check",
      "parts": ["Valve Stems"],
      "laborHours": 2.0,
      "priority": "Routine",
      "nextDue": "2024-09-12"
    },
    {
      "id": 4,
      "truckId": 3,
      "serviceType": "Engine Diagnostic",
      "date": "2024-06-18",
      "mileage": 298500,
      "cost": 450.00,
      "technician": "David Martinez",
      "shop": "Elite Truck Repair",
      "status": "In Progress",
      "description": "Engine performance diagnostic and repairs",
      "parts": ["Diagnostic Fee"],
      "laborHours": 3.0,
      "priority": "High",
      "nextDue": "N/A"
    },
    {
      "id": 5,
      "truckId": 1,
      "serviceType": "DOT Inspection",
      "date": "2024-05-20",
      "mileage": 180000,
      "cost": 125.00,
      "technician": "Lisa Thompson",
      "shop": "Certified DOT Inspections",
      "status": "Completed",
      "description": "Annual DOT safety inspection",
      "parts": [],
      "laborHours": 1.0,
      "priority": "Mandatory",
      "nextDue": "2025-05-20"
    },
    {
      "id": 6,
      "truckId": 2,
      "serviceType": "Transmission Service",
      "date": "2024-07-01",
      "mileage": 125000,
      "cost": 2850.00,
      "technician": "Mark Rodriguez",
      "shop": "Premium Transmission",
      "status": "Scheduled",
      "description": "Transmission fluid change and filter replacement",
      "parts": ["Transmission Fluid", "Transmission Filter"],
      "laborHours": 6.0,
      "priority": "High",
      "nextDue": "2025-07-01"
    }
  ];

  List<Map<String, dynamic>> serviceTypes = [
    {"label": "All Services", "value": "All"},
    {"label": "Oil Change", "value": "Oil Change"},
    {"label": "Brake Service", "value": "Brake Service"},
    {"label": "Tire Service", "value": "Tire Service"},
    {"label": "Engine Service", "value": "Engine Service"},
    {"label": "Transmission", "value": "Transmission"},
    {"label": "DOT Inspection", "value": "DOT Inspection"}
  ];

  List<Map<String, dynamic>> get filteredRecords {
    return maintenanceRecords.where((record) {
      bool matchesTruck = selectedTruck.isEmpty || record["truckId"] == int.tryParse(selectedTruck);
      bool matchesService = selectedServiceType == "All" || 
          "${record["serviceType"]}".contains(selectedServiceType) ||
          record["serviceType"] == selectedServiceType;
      return matchesTruck && matchesService;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Truck Maintenance",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Service Records", icon: Icon(Icons.build)),
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
        Tab(text: "Fleet Status", icon: Icon(Icons.local_shipping)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildServiceRecordsTab(),
        _buildScheduleTab(),
        _buildFleetStatusTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Quick Stats
          ResponsiveGridView(
            minItemWidth: 150,
            children: [
              _buildStatCard("Active Trucks", "3", Icons.local_shipping, successColor),
              _buildStatCard("In Service", "1", Icons.build, warningColor),
              _buildStatCard("This Month", "\$3,750", Icons.attach_money, infoColor),
              _buildStatCard("Overdue", "0", Icons.warning, dangerColor),
            ],
          ),
          
          // Recent Activity
          Text(
            "Recent Maintenance Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Column(
            children: maintenanceRecords.take(3).map((record) {
              return _buildRecentActivityCard(record);
            }).toList(),
          ),
          
          // Upcoming Services
          Text(
            "Upcoming Services",
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
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                _buildUpcomingServiceItem("Fleet Unit #1003", "Oil Change", "July 5, 2024", warningColor),
                _buildUpcomingServiceItem("Fleet Unit #1001", "Brake Inspection", "July 15, 2024", infoColor),
                _buildUpcomingServiceItem("Fleet Unit #1002", "Tire Rotation", "July 22, 2024", successColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceRecordsTab() {
    return Column(
      children: [
        // Filters
        Container(
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
                      label: "Select Truck",
                      items: [
                        {"label": "All Trucks", "value": ""},
                        ...trucks.map((truck) => {
                          "label": "${truck["name"]}",
                          "value": "${truck["id"]}"
                        }).toList()
                      ],
                      value: selectedTruck,
                      onChanged: (value, label) {
                        selectedTruck = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Service Type",
                      items: serviceTypes,
                      value: selectedServiceType,
                      onChanged: (value, label) {
                        selectedServiceType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Service Records List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: filteredRecords.length,
            itemBuilder: (context, index) {
              final record = filteredRecords[index];
              return _buildServiceRecordCard(record);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Schedule New Service
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Schedule New Service",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Schedule Service",
                    icon: Icons.add,
                    onPressed: () {
                      _showScheduleServiceDialog();
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // This Week
          _buildScheduleSection("This Week", [
            {
              "truck": "Fleet Unit #1002",
              "service": "Transmission Service",
              "date": "July 1, 2024",
              "time": "9:00 AM",
              "shop": "Premium Transmission",
              "status": "Confirmed"
            }
          ]),
          
          // Next Week
          _buildScheduleSection("Next Week", [
            {
              "truck": "Fleet Unit #1003",
              "service": "Oil Change",
              "date": "July 5, 2024",
              "time": "2:00 PM",
              "shop": "Quick Lube Express",
              "status": "Pending"
            },
            {
              "truck": "Fleet Unit #1001",
              "service": "Brake Inspection",
              "date": "July 8, 2024",
              "time": "10:30 AM",
              "shop": "Pro Fleet Maintenance",
              "status": "Confirmed"
            }
          ]),
        ],
      ),
    );
  }

  Widget _buildFleetStatusTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Fleet Overview
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildFleetStatCard("Total Fleet", "3", "Active Trucks", successColor),
              _buildFleetStatCard("Average Age", "2.3", "Years", infoColor),
              _buildFleetStatCard("Total Mileage", "608K", "Miles", warningColor),
              _buildFleetStatCard("Uptime", "96.5%", "This Month", primaryColor),
            ],
          ),
          
          // Fleet List
          Text(
            "Fleet Vehicles",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Column(
            children: trucks.map((truck) {
              return _buildFleetVehicleCard(truck);
            }).toList(),
          ),
        ],
      ),
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
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

  Widget _buildRecentActivityCard(Map<String, dynamic> record) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: _getStatusColor(record["status"]),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${record["serviceType"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Truck #${record["truckId"]} • ${record["date"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${((record["cost"] as double).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(record["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${record["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: _getStatusColor(record["status"]),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingServiceItem(String truck, String service, String date, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "$truck • $date",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.schedule,
          size: 16,
          color: color,
        ),
      ],
    );
  }

  Widget _buildServiceRecordCard(Map<String, dynamic> record) {
    final truck = trucks.firstWhere((t) => t["id"] == record["truckId"], orElse: () => {"name": "Unknown"});
    
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
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: _getStatusColor(record["status"]).withAlpha(10),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${record["serviceType"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${truck["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: _getStatusColor(record["status"]),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${record["status"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    _buildRecordDetailItem(Icons.calendar_today, "Date", "${record["date"]}"),
                    SizedBox(width: spMd),
                    _buildRecordDetailItem(Icons.speed, "Mileage", "${record["mileage"]} mi"),
                  ],
                ),
                
                Row(
                  children: [
                    _buildRecordDetailItem(Icons.person, "Technician", "${record["technician"]}"),
                    SizedBox(width: spMd),
                    _buildRecordDetailItem(Icons.schedule, "Hours", "${record["laborHours"]}h"),
                  ],
                ),
                
                Row(
                  children: [
                    _buildRecordDetailItem(Icons.store, "Shop", "${record["shop"]}"),
                    Spacer(),
                    Text(
                      "\$${((record["cost"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                
                if (record["description"] != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${record["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                
                if ((record["parts"] as List).isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Parts Used:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (record["parts"] as List).map((part) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$part",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
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

  Widget _buildRecordDetailItem(IconData icon, String label, String value) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16, color: disabledBoldColor),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSection(String title, List<Map<String, dynamic>> appointments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Column(
          children: appointments.map((appointment) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${appointment["service"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${appointment["truck"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${appointment["date"]} at ${appointment["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.store, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${appointment["shop"]}",
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
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: appointment["status"] == "Confirmed" ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${appointment["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: appointment["status"] == "Confirmed" ? successColor : warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                      QButton(
                        label: "Edit",
                        size: bs.sm,
                        onPressed: () {
                          si("Edit appointment functionality");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFleetStatCard(String title, String value, String subtitle, Color color) {
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
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFleetVehicleCard(Map<String, dynamic> truck) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusMd)),
            child: Container(
              width: 100,
              height: 100,
              child: Image.network(
                "${truck["image"]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${truck["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getTruckStatusColor(truck["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${truck["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: _getTruckStatusColor(truck["status"]),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${truck["model"]} (${truck["year"]})",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.speed, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${truck["mileage"]} miles",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Next: ${truck["nextService"]}",
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
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Scheduled":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTruckStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "In Service":
        return warningColor;
      case "Out of Service":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showScheduleServiceDialog() {
    String selectedTruckId = "";
    String selectedServiceType = "";
    String selectedDate = "";
    String selectedTime = "";
    String notes = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Schedule Service"),
        content: Container(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Select Truck",
                items: trucks.map((truck) => {
                  "label": "${truck["name"]}",
                  "value": "${truck["id"]}"
                }).toList(),
                value: selectedTruckId,
                onChanged: (value, label) {
                  selectedTruckId = value;
                },
              ),
              QDropdownField(
                label: "Service Type",
                items: serviceTypes.where((type) => type["value"] != "All").toList(),
                value: selectedServiceType,
                onChanged: (value, label) {
                  selectedServiceType = value;
                },
              ),
              QDatePicker(
                label: "Service Date",
                value: selectedDate.isNotEmpty ? DateTime.parse(selectedDate) : DateTime.now(),
                onChanged: (value) {
                  selectedDate = value.toString().split(' ')[0];
                },
              ),
              QTimePicker(
                label: "Service Time",
                value: selectedTime.isNotEmpty ? TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $selectedTime")) : TimeOfDay.now(),
                onChanged: (value) {
                  selectedTime = value!.kkmm;
                },
              ),
              QMemoField(
                label: "Notes",
                value: notes,
                onChanged: (value) {
                  notes = value;
                },
              ),
            ],
          ),
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
              if (selectedTruckId.isNotEmpty && selectedServiceType.isNotEmpty) {
                ss("Service scheduled successfully!");
                back();
              } else {
                se("Please fill in all required fields");
              }
            },
          ),
        ],
      ),
    );
  }
}
