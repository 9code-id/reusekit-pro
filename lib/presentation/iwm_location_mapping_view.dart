import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmLocationMappingView extends StatefulWidget {
  const IwmLocationMappingView({super.key});

  @override
  State<IwmLocationMappingView> createState() => _IwmLocationMappingViewState();
}

class _IwmLocationMappingViewState extends State<IwmLocationMappingView> {
  int selectedTab = 0;
  String selectedWarehouse = "WH001";
  String selectedZone = "all";
  String searchQuery = "";
  String filterStatus = "all";
  bool showQRCodes = false;

  List<Map<String, dynamic>> warehouses = [
    {"label": "Main Distribution Center (WH001)", "value": "WH001"},
    {"label": "Secondary Warehouse (WH002)", "value": "WH002"},
    {"label": "Cold Storage Facility (WH003)", "value": "WH003"},
  ];

  List<Map<String, dynamic>> zones = [
    {"label": "All Zones", "value": "all"},
    {"label": "Zone A - Electronics", "value": "A"},
    {"label": "Zone B - Clothing", "value": "B"},
    {"label": "Zone C - Home & Garden", "value": "C"},
    {"label": "Zone D - Sports", "value": "D"},
  ];

  List<Map<String, dynamic>> locations = [
    {
      "id": "A01-01-01",
      "zone": "A",
      "aisle": "01",
      "shelf": "01",
      "bin": "01",
      "type": "Standard",
      "status": "Occupied",
      "capacity": 50,
      "occupied": 45,
      "item": "Samsung Galaxy S24",
      "sku": "ELEC-SAM-001",
      "lastUpdated": "2024-01-15 14:30",
      "qrCode": "QR-A010101",
      "barcode": "123456789012",
      "temperature": "22°C",
      "humidity": "45%"
    },
    {
      "id": "A01-01-02",
      "zone": "A",
      "aisle": "01",
      "shelf": "01",
      "bin": "02",
      "type": "Standard",
      "status": "Partially Occupied",
      "capacity": 50,
      "occupied": 20,
      "item": "iPhone 15 Pro",
      "sku": "ELEC-APL-001",
      "lastUpdated": "2024-01-15 12:15",
      "qrCode": "QR-A010102",
      "barcode": "123456789013",
      "temperature": "22°C",
      "humidity": "45%"
    },
    {
      "id": "A01-02-01",
      "zone": "A",
      "aisle": "01",
      "shelf": "02",
      "bin": "01",
      "type": "High-Value",
      "status": "Reserved",
      "capacity": 30,
      "occupied": 0,
      "item": "Reserved for MacBook Pro",
      "sku": "ELEC-APL-002",
      "lastUpdated": "2024-01-14 16:45",
      "qrCode": "QR-A010201",
      "barcode": "123456789014",
      "temperature": "22°C",
      "humidity": "45%"
    },
    {
      "id": "B02-01-01",
      "zone": "B",
      "aisle": "02",
      "shelf": "01",
      "bin": "01",
      "type": "Standard",
      "status": "Available",
      "capacity": 75,
      "occupied": 0,
      "item": "",
      "sku": "",
      "lastUpdated": "2024-01-15 10:00",
      "qrCode": "QR-B020101",
      "barcode": "123456789015",
      "temperature": "21°C",
      "humidity": "50%"
    },
    {
      "id": "B02-01-02",
      "zone": "B",
      "aisle": "02",
      "shelf": "01",
      "bin": "02",
      "type": "Bulk",
      "status": "Occupied",
      "capacity": 100,
      "occupied": 85,
      "item": "Nike Air Max Shoes",
      "sku": "CLTH-NIK-001",
      "lastUpdated": "2024-01-15 09:30",
      "qrCode": "QR-B020102",
      "barcode": "123456789016",
      "temperature": "21°C",
      "humidity": "50%"
    },
  ];

  List<Map<String, dynamic>> locationTypes = [
    {"label": "All Types", "value": "all"},
    {"label": "Standard", "value": "Standard"},
    {"label": "High-Value", "value": "High-Value"},
    {"label": "Bulk", "value": "Bulk"},
    {"label": "Hazardous", "value": "Hazardous"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Available", "value": "Available"},
    {"label": "Occupied", "value": "Occupied"},
    {"label": "Partially Occupied", "value": "Partially Occupied"},
    {"label": "Reserved", "value": "Reserved"},
    {"label": "Maintenance", "value": "Maintenance"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Location Mapping",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Locations", icon: Icon(Icons.location_on)),
        Tab(text: "Map View", icon: Icon(Icons.map)),
        Tab(text: "QR Codes", icon: Icon(Icons.qr_code)),
      ],
      tabChildren: [
        _buildLocationsTab(),
        _buildMapViewTab(),
        _buildQRCodesTab(),
      ],
    );
  }

  Widget _buildLocationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLocationFilters(),
          _buildLocationStats(),
          _buildLocationsList(),
        ],
      ),
    );
  }

  Widget _buildMapViewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMapControls(),
          _buildInteractiveMap(),
          _buildLocationHierarchy(),
        ],
      ),
    );
  }

  Widget _buildQRCodesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQRCodeControls(),
          _buildQRCodeGrid(),
        ],
      ),
    );
  }

  Widget _buildLocationFilters() {
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
                child: QTextField(
                  label: "Search Location",
                  value: searchQuery,
                  hint: "Enter location ID, SKU, or item name",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Warehouse",
                  items: warehouses,
                  value: selectedWarehouse,
                  onChanged: (value, label) {
                    selectedWarehouse = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Zone",
                  items: zones,
                  value: selectedZone,
                  onChanged: (value, label) {
                    selectedZone = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: filterStatus,
                  onChanged: (value, label) {
                    filterStatus = value;
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

  Widget _buildLocationStats() {
    List<Map<String, dynamic>> stats = [
      {
        "title": "Total Locations",
        "value": locations.length,
        "subtitle": "Mapped",
        "icon": Icons.location_on,
        "color": primaryColor
      },
      {
        "title": "Occupied",
        "value": locations.where((l) => l["status"] == "Occupied").length,
        "subtitle": "In Use",
        "icon": Icons.inventory,
        "color": successColor
      },
      {
        "title": "Available",
        "value": locations.where((l) => l["status"] == "Available").length,
        "subtitle": "Ready",
        "icon": Icons.check_circle,
        "color": infoColor
      },
      {
        "title": "Reserved",
        "value": locations.where((l) => l["status"] == "Reserved").length,
        "subtitle": "Allocated",
        "icon": Icons.schedule,
        "color": warningColor
      },
    ];

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: stats.map((stat) => _buildStatCard(stat)).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationsList() {
    List<Map<String, dynamic>> filteredLocations = locations.where((location) {
      bool matchesSearch = searchQuery.isEmpty ||
        location["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        location["item"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        location["sku"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesZone = selectedZone == "all" || location["zone"] == selectedZone;
      bool matchesStatus = filterStatus == "all" || location["status"] == filterStatus;
      
      return matchesSearch && matchesZone && matchesStatus;
    }).toList();

    return Column(
      spacing: spSm,
      children: filteredLocations.map((location) => _buildLocationCard(location)).toList(),
    );
  }

  Widget _buildLocationCard(Map<String, dynamic> location) {
    Color statusColor = _getStatusColor(location["status"]);
    double occupancyPercent = location["capacity"] > 0 
        ? ((location["occupied"] as int) / (location["capacity"] as int)) * 100 
        : 0;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.location_on,
                  color: statusColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${location["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Zone ${location["zone"]} • Aisle ${location["aisle"]} • Shelf ${location["shelf"]} • Bin ${location["bin"]}",
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
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${location["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          if (location["item"].toString().isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${location["item"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "SKU: ${location["sku"]}",
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
                      Text(
                        "${location["occupied"]}/${location["capacity"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${occupancyPercent.toStringAsFixed(0)}% Full",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.qr_code, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${location["qrCode"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.thermostat, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${location["temperature"]} • ${location["humidity"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "Updated: ${location["lastUpdated"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledColor,
                ),
              ),
            ],
          ),
          if (occupancyPercent > 0) ...[
            LinearProgressIndicator(
              value: occupancyPercent / 100,
              backgroundColor: disabledOutlineBorderColor,
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Update",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.qr_code_scanner,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapControls() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDropdownField(
              label: "View Level",
              items: [
                {"label": "Warehouse Overview", "value": "warehouse"},
                {"label": "Zone Level", "value": "zone"},
                {"label": "Aisle Level", "value": "aisle"},
                {"label": "Shelf Level", "value": "shelf"},
              ],
              value: "zone",
              onChanged: (value, label) {},
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.fullscreen,
            label: "Full Screen",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveMap() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            child: Text(
              "Interactive Location Map",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map,
                          size: 48,
                          color: primaryColor.withAlpha(100),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Interactive Map View",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Click on zones to drill down",
                          style: TextStyle(
                            color: disabledColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Simulated map elements
                  _buildMapZone("A", 30, 30, successColor),
                  _buildMapZone("B", 120, 30, warningColor),
                  _buildMapZone("C", 30, 120, infoColor),
                  _buildMapZone("D", 120, 120, dangerColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapZone(String zone, double left, double top, Color color) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () {
          si("Viewing Zone $zone details");
        },
        child: Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Center(
            child: Text(
              zone,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationHierarchy() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location Hierarchy",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildHierarchyLevel("Warehouse", "WH001 - Main Distribution Center", Icons.warehouse, 0),
          _buildHierarchyLevel("Zone", "Zone A - Electronics", Icons.grid_view, 1),
          _buildHierarchyLevel("Aisle", "Aisle 01", Icons.view_column, 2),
          _buildHierarchyLevel("Shelf", "Shelf 01", Icons.shelves, 3),
          _buildHierarchyLevel("Bin", "Bin 01", Icons.inventory_2, 4),
        ],
      ),
    );
  }

  Widget _buildHierarchyLevel(String type, String name, IconData icon, int level) {
    return Container(
      margin: EdgeInsets.only(left: level * 16.0),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(level * 2 + 3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 16),
          SizedBox(width: spXs),
          Text(
            "$type: ",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCodeControls() {
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
                  label: "Generate QR Codes For",
                  items: [
                    {"label": "All Locations", "value": "all"},
                    {"label": "Selected Zone", "value": "zone"},
                    {"label": "Empty Locations Only", "value": "empty"},
                    {"label": "Occupied Locations Only", "value": "occupied"},
                  ],
                  value: "all",
                  onChanged: (value, label) {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.print,
                label: "Print All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Show QR Code Details",
                "value": true,
                "checked": showQRCodes,
              }
            ],
            value: [if (showQRCodes) {"label": "Show QR Code Details", "value": true, "checked": true}],
            onChanged: (values, ids) {
              showQRCodes = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQRCodeGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: locations.take(8).map((location) => _buildQRCodeCard(location)).toList(),
    );
  }

  Widget _buildQRCodeCard(Map<String, dynamic> location) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${location["id"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(location["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${location["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(location["status"]),
                  ),
                ),
              ),
            ],
          ),
          // QR Code placeholder
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code,
                    size: 40,
                    color: primaryColor.withAlpha(100),
                  ),
                  Text(
                    "${location["qrCode"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showQRCodes) ...[
            Text(
              "Zone ${location["zone"]} • ${location["type"]}",
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Barcode: ${location["barcode"]}",
              style: TextStyle(
                fontSize: 10,
                color: disabledColor,
              ),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Print",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "available":
        return successColor;
      case "occupied":
        return primaryColor;
      case "partially occupied":
        return warningColor;
      case "reserved":
        return infoColor;
      case "maintenance":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
