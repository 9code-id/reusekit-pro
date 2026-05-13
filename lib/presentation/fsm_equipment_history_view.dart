import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmEquipmentHistoryView extends StatefulWidget {
  const FsmEquipmentHistoryView({super.key});

  @override
  State<FsmEquipmentHistoryView> createState() => _FsmEquipmentHistoryViewState();
}

class _FsmEquipmentHistoryViewState extends State<FsmEquipmentHistoryView> {
  List<Map<String, dynamic>> equipmentHistory = [
    {
      "id": "EQ001",
      "name": "Industrial Generator Model X200",
      "serialNumber": "SN-2024-001",
      "category": "Power Equipment",
      "installDate": "2024-01-15",
      "location": "Main Facility - Building A",
      "status": "Active",
      "warranty": "2026-01-15",
      "lastMaintenance": "2024-05-20",
      "totalServiceCalls": 8,
      "uptime": 98.5,
      "image": "https://picsum.photos/100/100?random=1&keyword=generator"
    },
    {
      "id": "EQ002", 
      "name": "HVAC System Pro Series 500",
      "serialNumber": "SN-2024-002",
      "category": "Climate Control",
      "installDate": "2024-02-10",
      "location": "Main Facility - Building B",
      "status": "Maintenance Required",
      "warranty": "2027-02-10",
      "lastMaintenance": "2024-04-15",
      "totalServiceCalls": 12,
      "uptime": 95.2,
      "image": "https://picsum.photos/100/100?random=2&keyword=hvac"
    },
    {
      "id": "EQ003",
      "name": "Fire Safety System v3.1",
      "serialNumber": "SN-2024-003", 
      "category": "Safety Equipment",
      "installDate": "2024-03-05",
      "location": "Warehouse - Section C",
      "status": "Active",
      "warranty": "2029-03-05",
      "lastMaintenance": "2024-06-01",
      "totalServiceCalls": 3,
      "uptime": 99.8,
      "image": "https://picsum.photos/100/100?random=3&keyword=safety"
    },
    {
      "id": "EQ004",
      "name": "Conveyor Belt System MK4",
      "serialNumber": "SN-2024-004",
      "category": "Manufacturing",
      "installDate": "2023-11-20",
      "location": "Production Floor - Line 1",
      "status": "Under Repair",
      "warranty": "2025-11-20",
      "lastMaintenance": "2024-03-18",
      "totalServiceCalls": 15,
      "uptime": 87.3,
      "image": "https://picsum.photos/100/100?random=4&keyword=conveyor"
    },
    {
      "id": "EQ005",
      "name": "Security Camera Network HD",
      "serialNumber": "SN-2024-005",
      "category": "Security",
      "installDate": "2024-04-12",
      "location": "Multiple Locations",
      "status": "Active",
      "warranty": "2026-04-12",
      "lastMaintenance": "2024-05-30",
      "totalServiceCalls": 5,
      "uptime": 97.1,
      "image": "https://picsum.photos/100/100?random=5&keyword=camera"
    }
  ];

  List<Map<String, dynamic>> filteredHistory = [];
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Power Equipment", "value": "Power Equipment"},
    {"label": "Climate Control", "value": "Climate Control"},
    {"label": "Safety Equipment", "value": "Safety Equipment"},
    {"label": "Manufacturing", "value": "Manufacturing"},
    {"label": "Security", "value": "Security"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Maintenance Required", "value": "Maintenance Required"},
    {"label": "Under Repair", "value": "Under Repair"},
    {"label": "Inactive", "value": "Inactive"},
  ];

  @override
  void initState() {
    super.initState();
    filteredHistory = equipmentHistory;
  }

  void _filterHistory() {
    filteredHistory = equipmentHistory.where((equipment) {
      bool matchesSearch = equipment["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          equipment["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || equipment["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || equipment["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Maintenance Required":
        return warningColor;
      case "Under Repair":
        return dangerColor;
      case "Inactive":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildEquipmentCard(Map<String, dynamic> equipment) {
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
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${equipment["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${equipment["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "ID: ${equipment["id"]} • ${equipment["serialNumber"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(equipment["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${equipment["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStatusColor(equipment["status"]),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Category", "${equipment["category"]}", Icons.category),
              ),
              Expanded(
                child: _buildInfoItem("Location", "${equipment["location"]}", Icons.location_on),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Install Date", "${equipment["installDate"]}", Icons.calendar_today),
              ),
              Expanded(
                child: _buildInfoItem("Warranty Until", "${equipment["warranty"]}", Icons.shield),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Service Calls", "${equipment["totalServiceCalls"]}", Icons.build),
              ),
              Expanded(
                child: _buildInfoItem("Uptime", "${(equipment["uptime"] as num).toStringAsFixed(1)}%", Icons.trending_up),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to equipment details
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Service History",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to service history
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    int totalEquipment = equipmentHistory.length;
    int activeEquipment = equipmentHistory.where((eq) => eq["status"] == "Active").length;
    int maintenanceRequired = equipmentHistory.where((eq) => eq["status"] == "Maintenance Required").length;
    int underRepair = equipmentHistory.where((eq) => eq["status"] == "Under Repair").length;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard("Total Equipment", "$totalEquipment", Icons.inventory, primaryColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Active", "$activeEquipment", Icons.check_circle, successColor),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: _buildStatCard("Maintenance Required", "$maintenanceRequired", Icons.warning, warningColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Under Repair", "$underRepair", Icons.build, dangerColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Equipment History"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add equipment
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCards(),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Equipment",
                    value: searchQuery,
                    hint: "Search by name or ID...",
                    onChanged: (value) {
                      searchQuery = value;
                      _filterHistory();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      _filterHistory();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusItems,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      _filterHistory();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              "Equipment List (${filteredHistory.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...filteredHistory.map((equipment) => _buildEquipmentCard(equipment)).toList(),
          ],
        ),
      ),
    );
  }
}
