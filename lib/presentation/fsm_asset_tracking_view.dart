import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmAssetTrackingView extends StatefulWidget {
  const FsmAssetTrackingView({super.key});

  @override
  State<FsmAssetTrackingView> createState() => _FsmAssetTrackingViewState();
}

class _FsmAssetTrackingViewState extends State<FsmAssetTrackingView> {
  List<Map<String, dynamic>> assets = [
    {
      "id": "AT001",
      "name": "Industrial Generator Model X200",
      "category": "Power Equipment",
      "location": "Main Facility - Building A",
      "coordinates": {"lat": 37.7749, "lng": -122.4194},
      "status": "Active",
      "condition": "Excellent",
      "lastUpdated": "2024-06-20 14:30",
      "assignedTo": "John Smith",
      "department": "Maintenance",
      "serialNumber": "SN-2024-001",
      "value": 25000.0,
      "acquisitionDate": "2024-01-15",
      "batteryLevel": 85,
      "signalStrength": 95,
      "image": "https://picsum.photos/80/80?random=1&keyword=generator"
    },
    {
      "id": "AT002",
      "name": "Mobile Crane Unit HC-500",
      "category": "Heavy Machinery",
      "location": "Construction Site B",
      "coordinates": {"lat": 37.7849, "lng": -122.4094},
      "status": "In Transit",
      "condition": "Good",
      "lastUpdated": "2024-06-20 15:45",
      "assignedTo": "Mike Wilson",
      "department": "Operations",
      "serialNumber": "SN-2024-006",
      "value": 125000.0,
      "acquisitionDate": "2024-02-20",
      "batteryLevel": 72,
      "signalStrength": 88,
      "image": "https://picsum.photos/80/80?random=2&keyword=crane"
    },
    {
      "id": "AT003",
      "name": "Delivery Van Fleet Unit 03",
      "category": "Vehicles",
      "location": "On Route to Client Site",
      "coordinates": {"lat": 37.7649, "lng": -122.4294},
      "status": "Active",
      "condition": "Good",
      "lastUpdated": "2024-06-20 16:12",
      "assignedTo": "Sarah Johnson",
      "department": "Logistics",
      "serialNumber": "VAN-2024-003",
      "value": 35000.0,
      "acquisitionDate": "2024-03-10",
      "batteryLevel": 65,
      "signalStrength": 92,
      "image": "https://picsum.photos/80/80?random=3&keyword=van"
    },
    {
      "id": "AT004",
      "name": "Portable Generator PG-200",
      "category": "Power Equipment",
      "location": "Warehouse Section C",
      "coordinates": {"lat": 37.7549, "lng": -122.4394},
      "status": "Maintenance",
      "condition": "Fair",
      "lastUpdated": "2024-06-20 09:20",
      "assignedTo": "David Brown",
      "department": "Maintenance",
      "serialNumber": "PG-2024-002",
      "value": 8500.0,
      "acquisitionDate": "2024-04-05",
      "batteryLevel": 45,
      "signalStrength": 78,
      "image": "https://picsum.photos/80/80?random=4&keyword=portable"
    },
    {
      "id": "AT005",
      "name": "Security Patrol Vehicle SP-01",
      "category": "Vehicles", 
      "location": "Perimeter Route Alpha",
      "coordinates": {"lat": 37.7949, "lng": -122.3994},
      "status": "Active",
      "condition": "Excellent",
      "lastUpdated": "2024-06-20 16:45",
      "assignedTo": "Lisa Chen",
      "department": "Security",
      "serialNumber": "SEC-2024-001",
      "value": 45000.0,
      "acquisitionDate": "2024-01-20",
      "batteryLevel": 90,
      "signalStrength": 98,
      "image": "https://picsum.photos/80/80?random=5&keyword=security"
    }
  ];

  List<Map<String, dynamic>> filteredAssets = [];
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedCategory = "All";
  String selectedCondition = "All";

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Lost", "value": "Lost"},
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Power Equipment", "value": "Power Equipment"},
    {"label": "Heavy Machinery", "value": "Heavy Machinery"},
    {"label": "Vehicles", "value": "Vehicles"},
    {"label": "Tools", "value": "Tools"},
    {"label": "Safety Equipment", "value": "Safety Equipment"},
  ];

  List<Map<String, dynamic>> conditionItems = [
    {"label": "All", "value": "All"},
    {"label": "Excellent", "value": "Excellent"},
    {"label": "Good", "value": "Good"},
    {"label": "Fair", "value": "Fair"},
    {"label": "Poor", "value": "Poor"},
  ];

  @override
  void initState() {
    super.initState();
    filteredAssets = assets;
  }

  void _filterAssets() {
    filteredAssets = assets.where((asset) {
      bool matchesSearch = asset["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          asset["assignedTo"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          asset["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || asset["status"] == selectedStatus;
      bool matchesCategory = selectedCategory == "All" || asset["category"] == selectedCategory;
      bool matchesCondition = selectedCondition == "All" || asset["condition"] == selectedCondition;
      
      return matchesSearch && matchesStatus && matchesCategory && matchesCondition;
    }).toList();
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "In Transit":
        return infoColor;
      case "Maintenance":
        return warningColor;
      case "Inactive":
        return disabledColor;
      case "Lost":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getConditionColor(String condition) {
    switch (condition) {
      case "Excellent":
        return successColor;
      case "Good":
        return infoColor;
      case "Fair":
        return warningColor;
      case "Poor":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getBatteryColor(int batteryLevel) {
    if (batteryLevel > 75) return successColor;
    if (batteryLevel > 50) return infoColor;
    if (batteryLevel > 25) return warningColor;
    return dangerColor;
  }

  Widget _buildAssetCard(Map<String, dynamic> asset) {
    int batteryLevel = asset["batteryLevel"] as int;
    int signalStrength = asset["signalStrength"] as int;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor(asset["status"]),
          ),
        ),
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
                    image: NetworkImage("${asset["image"]}"),
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
                      "${asset["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${asset["id"]} • ${asset["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(asset["status"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${asset["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: _getStatusColor(asset["status"]),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getConditionColor(asset["condition"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${asset["condition"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: _getConditionColor(asset["condition"]),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: primaryColor,
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "${asset["location"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Assigned To", "${asset["assignedTo"]}", Icons.person),
              ),
              Expanded(
                child: _buildInfoItem("Department", "${asset["department"]}", Icons.business),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Value", "\$${(asset["value"] as double).currency}", Icons.attach_money),
              ),
              Expanded(
                child: _buildInfoItem("Last Updated", "${asset["lastUpdated"]}", Icons.access_time),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getBatteryColor(batteryLevel).withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.battery_full,
                            size: 16,
                            color: _getBatteryColor(batteryLevel),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Battery",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getBatteryColor(batteryLevel),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "$batteryLevel%",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getBatteryColor(batteryLevel),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: batteryLevel / 100,
                        backgroundColor: disabledColor.withAlpha(50),
                        valueColor: AlwaysStoppedAnimation<Color>(_getBatteryColor(batteryLevel)),
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
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.signal_cellular_4_bar,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Signal",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "$signalStrength%",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: signalStrength / 100,
                        backgroundColor: disabledColor.withAlpha(50),
                        valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Track Location",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to map view
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to asset details
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
    int totalAssets = assets.length;
    int activeAssets = assets.where((a) => a["status"] == "Active").length;
    int inTransit = assets.where((a) => a["status"] == "In Transit").length;
    double totalValue = assets.fold(0.0, (sum, a) => sum + (a["value"] as double));

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard("Total Assets", "$totalAssets", Icons.inventory, primaryColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Active", "$activeAssets", Icons.check_circle, successColor),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: _buildStatCard("In Transit", "$inTransit", Icons.local_shipping, infoColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Total Value", "\$${totalValue.currency}", Icons.attach_money, warningColor),
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
        title: Text("Asset Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              // Navigate to map view
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add asset
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
                    label: "Search Assets",
                    value: searchQuery,
                    hint: "Search by name, assignee, or ID...",
                    onChanged: (value) {
                      searchQuery = value;
                      _filterAssets();
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
                    label: "Status",
                    items: statusItems,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      _filterAssets();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      _filterAssets();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Condition",
              items: conditionItems,
              value: selectedCondition,
              onChanged: (value, label) {
                selectedCondition = value;
                _filterAssets();
              },
            ),
            SizedBox(height: spMd),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tracked Assets (${filteredAssets.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "View on Map",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to map view
                  },
                ),
              ],
            ),
            SizedBox(height: spSm),
            ...filteredAssets.map((asset) => _buildAssetCard(asset)).toList(),
          ],
        ),
      ),
    );
  }
}
