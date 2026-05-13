import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaMachineryTrackingView extends StatefulWidget {
  const AmaMachineryTrackingView({super.key});

  @override
  State<AmaMachineryTrackingView> createState() => _AmaMachineryTrackingViewState();
}

class _AmaMachineryTrackingViewState extends State<AmaMachineryTrackingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  bool showFilters = false;

  List<Map<String, dynamic>> machinery = [
    {
      "id": "MAC001",
      "name": "John Deere 6155R Tractor",
      "type": "Tractor",
      "serialNumber": "JD6155R2024001",
      "purchaseDate": "2024-03-15",
      "warrantyExpiry": "2027-03-15",
      "status": "Active",
      "location": "Field A - North Farm",
      "coordinates": [37.7749, -122.4194],
      "lastMaintenance": "2025-05-20",
      "nextMaintenance": "2025-08-20",
      "operatingHours": 1245,
      "fuelLevel": 75,
      "condition": "Excellent",
      "operator": "Mike Johnson",
      "costPerHour": 45.50,
      "utilization": 85,
      "alerts": 0,
      "icon": Icons.agriculture,
      "color": Colors.green
    },
    {
      "id": "MAC002", 
      "name": "Massey Ferguson 8S.265",
      "type": "Tractor",
      "serialNumber": "MF8S265-2023-789",
      "purchaseDate": "2023-11-10",
      "warrantyExpiry": "2026-11-10",
      "status": "Maintenance",
      "location": "Workshop - Main Facility",
      "coordinates": [37.7849, -122.4094],
      "lastMaintenance": "2025-06-10",
      "nextMaintenance": "2025-09-10",
      "operatingHours": 2156,
      "fuelLevel": 25,
      "condition": "Good",
      "operator": "Sarah Davis",
      "costPerHour": 42.00,
      "utilization": 78,
      "alerts": 2,
      "icon": Icons.agriculture,
      "color": Colors.orange
    },
    {
      "id": "MAC003",
      "name": "Case IH Axial-Flow 7150",  
      "type": "Harvester",
      "serialNumber": "CIH7150-2024-456",
      "purchaseDate": "2024-01-20",
      "warrantyExpiry": "2027-01-20",
      "status": "Active",
      "location": "Field C - East Farm",
      "coordinates": [37.7649, -122.4294],
      "lastMaintenance": "2025-04-15",
      "nextMaintenance": "2025-07-15",
      "operatingHours": 856,
      "fuelLevel": 60,
      "condition": "Excellent",
      "operator": "Tom Wilson",
      "costPerHour": 85.00,
      "utilization": 92,
      "alerts": 0,
      "icon": Icons.grass,
      "color": Colors.blue
    },
    {
      "id": "MAC004",
      "name": "New Holland T8.435",
      "type": "Tractor", 
      "serialNumber": "NH435-2022-321",
      "purchaseDate": "2022-08-05",
      "warrantyExpiry": "2025-08-05",
      "status": "Idle",
      "location": "Storage - West Barn",
      "coordinates": [37.7549, -122.4394],
      "lastMaintenance": "2025-03-12",
      "nextMaintenance": "2025-09-12",
      "operatingHours": 3245,
      "fuelLevel": 15,
      "condition": "Fair",  
      "operator": "Alex Brown",
      "costPerHour": 48.75,
      "utilization": 45,
      "alerts": 1,
      "icon": Icons.agriculture,
      "color": Colors.grey
    },
    {
      "id": "MAC005",
      "name": "Kubota M7-172 Premium KVT",
      "type": "Tractor",
      "serialNumber": "KUB172-2024-987",
      "purchaseDate": "2024-05-30",
      "warrantyExpiry": "2027-05-30", 
      "status": "Active",
      "location": "Field B - South Farm",
      "coordinates": [37.7449, -122.4494],
      "lastMaintenance": "2025-06-01",
      "nextMaintenance": "2025-09-01",
      "operatingHours": 789,
      "fuelLevel": 90,
      "condition": "Excellent",
      "operator": "Lisa Garcia",
      "costPerHour": 43.25,
      "utilization": 88,
      "alerts": 0,
      "icon": Icons.agriculture,
      "color": Colors.green
    },
    {
      "id": "MAC006",
      "name": "Caterpillar D6T Dozer",
      "type": "Equipment",
      "serialNumber": "CAT-D6T-2023-654",
      "purchaseDate": "2023-07-12",
      "warrantyExpiry": "2026-07-12",
      "status": "Repair",
      "location": "Workshop - Main Facility", 
      "coordinates": [37.7849, -122.4094],
      "lastMaintenance": "2025-05-05",
      "nextMaintenance": "2025-11-05",
      "operatingHours": 1876,
      "fuelLevel": 0,
      "condition": "Poor",
      "operator": "Robert Miller",
      "costPerHour": 95.50,
      "utilization": 25,
      "alerts": 3,
      "icon": Icons.construction,
      "color": Colors.red
    }
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Idle", "value": "Idle"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Repair", "value": "Repair"}
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Tractor", "value": "Tractor"},
    {"label": "Harvester", "value": "Harvester"},
    {"label": "Equipment", "value": "Equipment"}
  ];

  List<Map<String, dynamic>> get filteredMachinery {
    return machinery.where((machine) {
      bool matchesSearch = machine["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                        machine["serialNumber"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || machine["status"] == selectedStatus;
      bool matchesType = selectedType == "All" || machine["type"] == selectedType;
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Machinery Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Live Tracking", icon: Icon(Icons.location_on)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTrackingTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildOverviewStats(),
          _buildMachineryList(),
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
                label: "Search machinery...",
                value: searchQuery,
                hint: "Search by name or serial number",
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
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
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

  Widget _buildOverviewStats() {
    int totalMachinery = machinery.length;
    int activeMachinery = machinery.where((m) => m["status"] == "Active").length;
    int maintenanceCount = machinery.where((m) => m["status"] == "Maintenance" || m["status"] == "Repair").length;
    double avgUtilization = machinery.fold(0.0, (sum, m) => sum + (m["utilization"] as int)) / totalMachinery;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Machinery", totalMachinery.toString(), Icons.precision_manufacturing, primaryColor),
        _buildStatCard("Active", activeMachinery.toString(), Icons.check_circle, successColor),
        _buildStatCard("In Service", maintenanceCount.toString(), Icons.build, warningColor),
        _buildStatCard("Avg Utilization", "${avgUtilization.toStringAsFixed(1)}%", Icons.trending_up, infoColor),
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

  Widget _buildMachineryList() {
    return Column(
      spacing: spSm,
      children: filteredMachinery.map((machine) => _buildMachineryCard(machine)).toList(),
    );
  }

  Widget _buildMachineryCard(Map<String, dynamic> machine) {
    Color statusColor = _getStatusColor(machine["status"]);
    Color conditionColor = _getConditionColor(machine["condition"]);

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
              Icon(
                machine["icon"] as IconData,
                color: machine["color"] as Color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${machine["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${machine["type"]} • ${machine["serialNumber"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if ((machine["alerts"] as int) > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.warning, color: dangerColor, size: 12),
                      SizedBox(width: spXs),
                      Text(
                        "${machine["alerts"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
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
                  "${machine["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildInfoItem("Location", "${machine["location"]}", Icons.location_on),
              _buildInfoItem("Operator", "${machine["operator"]}", Icons.person),
              _buildInfoItem("Operating Hours", "${machine["operatingHours"]}h", Icons.access_time),
              _buildInfoItem("Condition", "${machine["condition"]}", Icons.star, conditionColor),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildProgressIndicator(
                  "Fuel Level",
                  machine["fuelLevel"] as int,
                  machine["fuelLevel"] as int > 50 ? successColor : 
                  machine["fuelLevel"] as int > 25 ? warningColor : dangerColor,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: _buildProgressIndicator(
                  "Utilization",
                  machine["utilization"] as int,
                  machine["utilization"] as int > 80 ? successColor :
                  machine["utilization"] as int > 50 ? warningColor : dangerColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Next Maintenance: ${DateTime.parse("${machine["nextMaintenance"]}").dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${(machine["costPerHour"] as double).toStringAsFixed(2)}/hr",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    si("Viewing details for ${machine["name"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.location_on,
                size: bs.sm,
                onPressed: () {
                  si("Tracking ${machine["name"]}");
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  si("More options for ${machine["name"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon, [Color? color]) {
    return Row(
      children: [
        Icon(icon, color: color ?? disabledBoldColor, size: 16),
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
                  color: color ?? primaryColor,
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

  Widget _buildProgressIndicator(String label, int value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),  
            ),
            Text(
              "$value%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        LinearProgressIndicator(
          value: value / 100,
          backgroundColor: disabledColor,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  Widget _buildTrackingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildMapPlaceholder(),
          _buildActiveLocationsList(),
        ],
      ),
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  size: 64,
                  color: primaryColor.withAlpha(100),
                ),
                SizedBox(height: spSm),
                Text(
                  "Live Machinery Map",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Real-time location tracking",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          ...machinery.where((m) => m["status"] == "Active").map((machine) {
            final coords = machine["coordinates"] as List;
            return Positioned(
              left: ((coords[1] as double) + 122.4194) * 1000,
              top: (37.7749 - (coords[0] as double)) * 2000 + 200,
              child: Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: machine["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusXs),
                  boxShadow: [shadowSm],
                ),
                child: Icon(
                  machine["icon"] as IconData,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildActiveLocationsList() {
    final activeMachinery = machinery.where((m) => m["status"] == "Active").toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Active Machinery Locations",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...activeMachinery.map((machine) => _buildLocationCard(machine)).toList(),
      ],
    );
  }

  Widget _buildLocationCard(Map<String, dynamic> machine) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (machine["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              machine["icon"] as IconData,
              color: machine["color"] as Color,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${machine["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${machine["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Operator: ${machine["operator"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: successColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "LIVE",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsStats(),
          _buildUsageChart(),
          _buildMaintenanceSchedule(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsStats() {
    double totalHours = machinery.fold(0.0, (sum, m) => sum + (m["operatingHours"] as int));
    double totalCost = machinery.fold(0.0, (sum, m) => sum + ((m["operatingHours"] as int) * (m["costPerHour"] as double)));
    int dueMaintenance = machinery.where((m) => DateTime.parse("${m["nextMaintenance"]}").isBefore(DateTime.now().add(Duration(days: 30)))).length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildAnalyticsCard("Total Hours", "${totalHours.toStringAsFixed(0)}h", Icons.timer, primaryColor),
        _buildAnalyticsCard("Operating Cost", "\$${(totalCost / 1000).toStringAsFixed(1)}K", Icons.monetization_on, warningColor),
        _buildAnalyticsCard("Due Maintenance", dueMaintenance.toString(), Icons.build_circle, dangerColor),
      ],
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
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

  Widget _buildUsageChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Machinery Utilization",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...machinery.map((machine) => _buildUtilizationBar(machine)).toList(),
        ],
      ),
    );
  }

  Widget _buildUtilizationBar(Map<String, dynamic> machine) {
    int utilization = machine["utilization"] as int;
    Color barColor = utilization > 80 ? successColor : utilization > 50 ? warningColor : dangerColor;

    return Column(
      spacing: spXs,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${machine["name"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              "$utilization%",
              style: TextStyle(
                fontSize: 12,
                color: barColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        LinearProgressIndicator(
          value: utilization / 100,
          backgroundColor: disabledColor,
          valueColor: AlwaysStoppedAnimation<Color>(barColor),
        ),
      ],
    );
  }

  Widget _buildMaintenanceSchedule() {
    final upcomingMaintenance = machinery
        .where((m) => DateTime.parse("${m["nextMaintenance"]}").isAfter(DateTime.now()))
        .toList()
        ..sort((a, b) => DateTime.parse("${a["nextMaintenance"]}").compareTo(DateTime.parse("${b["nextMaintenance"]}")));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Upcoming Maintenance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...upcomingMaintenance.take(5).map((machine) => _buildMaintenanceItem(machine)).toList(),
        ],
      ),
    );
  }

  Widget _buildMaintenanceItem(Map<String, dynamic> machine) {
    DateTime maintenanceDate = DateTime.parse("${machine["nextMaintenance"]}");
    int daysUntil = maintenanceDate.difference(DateTime.now()).inDays;
    Color urgencyColor = daysUntil <= 7 ? dangerColor : daysUntil <= 30 ? warningColor : successColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: urgencyColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 3,
            color: urgencyColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            machine["icon"] as IconData,
            color: urgencyColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${machine["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Due: ${maintenanceDate.dMMMy}",
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
              color: urgencyColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "$daysUntil days",
              style: TextStyle(
                fontSize: 12,
                color: urgencyColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Idle":
        return warningColor;
      case "Maintenance":
        return infoColor;
      case "Repair":
        return dangerColor;
      default:
        return disabledBoldColor;
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
        return disabledBoldColor;
    }
  }
}
