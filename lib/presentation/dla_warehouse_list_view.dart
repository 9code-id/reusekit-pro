import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaWarehouseListView extends StatefulWidget {
  const DlaWarehouseListView({super.key});

  @override
  State<DlaWarehouseListView> createState() => _DlaWarehouseListViewState();
}

class _DlaWarehouseListViewState extends State<DlaWarehouseListView> {
  String searchQuery = "";
  String statusFilter = "all";
  String typeFilter = "all";

  List<Map<String, dynamic>> statusFilterOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Under Maintenance", "value": "maintenance"},
    {"label": "Temporarily Closed", "value": "temp_closed"},
  ];

  List<Map<String, dynamic>> typeFilterOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Distribution Center", "value": "distribution"},
    {"label": "Storage Facility", "value": "storage"},
    {"label": "Cross-Dock Terminal", "value": "cross_dock"},
    {"label": "Cold Storage", "value": "cold_storage"},
    {"label": "Fulfillment Center", "value": "fulfillment"},
  ];

  List<Map<String, dynamic>> warehouses = [
    {
      "id": "WH001",
      "name": "Central Distribution Center",
      "code": "CDC-01",
      "type": "distribution",
      "status": "active",
      "address": "Jl. Raya Industri No. 123, Bekasi",
      "city": "Bekasi",
      "contact_person": "John Manager",
      "phone": "+62812345678",
      "email": "john@warehouse.com",
      "total_area": 5000.0,
      "storage_capacity": 15000.0,
      "loading_docks": 8,
      "security_level": "high",
      "climate_control": true,
      "security_camera": true,
      "fire_safety": true,
      "operating_hours": "24_7",
      "current_utilization": 78.5,
      "total_inventory": 4250,
      "active_orders": 156,
      "image": "https://picsum.photos/400/250?random=1&keyword=warehouse"
    },
    {
      "id": "WH002",
      "name": "North Storage Facility",
      "code": "NSF-02",
      "type": "storage",
      "status": "active",
      "address": "Komplex Industri Utara Blok A-15, Tangerang",
      "city": "Tangerang",
      "contact_person": "Sarah Supervisor",
      "phone": "+62823456789",
      "email": "sarah@warehouse.com",
      "total_area": 3200.0,
      "storage_capacity": 9600.0,
      "loading_docks": 4,
      "security_level": "medium",
      "climate_control": false,
      "security_camera": true,
      "fire_safety": true,
      "operating_hours": "regular",
      "current_utilization": 65.2,
      "total_inventory": 2890,
      "active_orders": 89,
      "image": "https://picsum.photos/400/250?random=2&keyword=storage"
    },
    {
      "id": "WH003",
      "name": "Cold Storage West",
      "code": "CSW-03",
      "type": "cold_storage",
      "status": "maintenance",
      "address": "Jl. Logistik Barat No. 67, Jakarta Barat",
      "city": "Jakarta Barat",
      "contact_person": "Mike Chief",
      "phone": "+62834567890",
      "email": "mike@warehouse.com",
      "total_area": 2800.0,
      "storage_capacity": 8400.0,
      "loading_docks": 6,
      "security_level": "maximum",
      "climate_control": true,
      "security_camera": true,
      "fire_safety": true,
      "operating_hours": "extended",
      "current_utilization": 45.0,
      "total_inventory": 1680,
      "active_orders": 23,
      "image": "https://picsum.photos/400/250?random=3&keyword=cold+storage"
    },
    {
      "id": "WH004",
      "name": "Cross-Dock Terminal East",
      "code": "CTE-04",
      "type": "cross_dock",
      "status": "active",
      "address": "Kawasan Industri Timur Lot 8, Karawang",
      "city": "Karawang",
      "contact_person": "Lisa Manager",
      "phone": "+62845678901",
      "email": "lisa@warehouse.com",
      "total_area": 1800.0,
      "storage_capacity": 3600.0,
      "loading_docks": 12,
      "security_level": "medium",
      "climate_control": false,
      "security_camera": true,
      "fire_safety": true,
      "operating_hours": "24_7",
      "current_utilization": 92.3,
      "total_inventory": 1245,
      "active_orders": 287,
      "image": "https://picsum.photos/400/250?random=4&keyword=crossdock"
    },
    {
      "id": "WH005",
      "name": "Fulfillment Center South",
      "code": "FCS-05",
      "type": "fulfillment",
      "status": "temp_closed",
      "address": "Jl. E-Commerce Hub No. 234, Depok",
      "city": "Depok",
      "contact_person": "David Operator",
      "phone": "+62856789012",
      "email": "david@warehouse.com",
      "total_area": 4500.0,
      "storage_capacity": 13500.0,
      "loading_docks": 10,
      "security_level": "high",
      "climate_control": true,
      "security_camera": true,
      "fire_safety": true,
      "operating_hours": "regular",
      "current_utilization": 0.0,
      "total_inventory": 0,
      "active_orders": 0,
      "image": "https://picsum.photos/400/250?random=5&keyword=fulfillment"
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "inactive":
        return disabledColor;
      case "maintenance":
        return warningColor;
      case "temp_closed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getUtilizationColor(double utilization) {
    if (utilization >= 90) return dangerColor;
    if (utilization >= 75) return warningColor;
    if (utilization >= 50) return infoColor;
    return successColor;
  }

  List<Map<String, dynamic>> get filteredWarehouses {
    return warehouses.where((warehouse) {
      bool matchesSearch = warehouse["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          warehouse["code"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          warehouse["city"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = statusFilter == "all" || warehouse["status"] == statusFilter;
      bool matchesType = typeFilter == "all" || warehouse["type"] == typeFilter;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Widget _buildStatsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarehouseCard(Map<String, dynamic> warehouse) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusSm),
                  topRight: Radius.circular(radiusSm),
                ),
                child: Image.network(
                  "${warehouse["image"]}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: _getStatusColor(warehouse["status"]),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${warehouse["status"]}".replaceAll('_', ' ').toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${warehouse["code"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(180),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${warehouse["type"]}".replaceAll('_', ' ').toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${warehouse["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${warehouse["address"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${warehouse["contact_person"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.phone,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${warehouse["phone"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
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
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Storage",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${((warehouse["storage_capacity"] as double) / 1000).toStringAsFixed(1)}K m³",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
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
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Docks",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${warehouse["loading_docks"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
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
                          color: _getUtilizationColor(warehouse["current_utilization"] as double).withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Utilization",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${(warehouse["current_utilization"] as double).toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _getUtilizationColor(warehouse["current_utilization"] as double),
                              ),
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
                    if (warehouse["climate_control"] as bool) ...[
                      Icon(
                        Icons.ac_unit,
                        size: 16,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                    ],
                    if (warehouse["security_camera"] as bool) ...[
                      Icon(
                        Icons.security,
                        size: 16,
                        color: successColor,
                      ),
                      SizedBox(width: spXs),
                    ],
                    if (warehouse["fire_safety"] as bool) ...[
                      Icon(
                        Icons.local_fire_department,
                        size: 16,
                        color: dangerColor,
                      ),
                      SizedBox(width: spXs),
                    ],
                    Expanded(
                      child: Text(
                        "Inventory: ${warehouse["total_inventory"]} items",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${warehouse["active_orders"]} orders",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
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
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.inventory,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.map,
                      size: bs.sm,
                      onPressed: () {},
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

  @override
  Widget build(BuildContext context) {
    int totalWarehouses = warehouses.length;
    int activeWarehouses = warehouses.where((w) => w["status"] == "active").length;
    double totalCapacity = warehouses.fold(0.0, (sum, w) => sum + (w["storage_capacity"] as double));
    double avgUtilization = warehouses.fold(0.0, (sum, w) => sum + (w["current_utilization"] as double)) / warehouses.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Warehouse Network"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Warehouse Overview",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "Manage and monitor your warehouse network",
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spLg),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatsCard(
                    "Total\nWarehouses",
                    totalWarehouses.toString(),
                    Icons.warehouse,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatsCard(
                    "Active\nFacilities",
                    activeWarehouses.toString(),
                    Icons.check_circle,
                    successColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatsCard(
                    "Total Capacity",
                    "${(totalCapacity / 1000).toStringAsFixed(0)}K m³",
                    Icons.inventory,
                    infoColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatsCard(
                    "Avg Utilization",
                    "${avgUtilization.toStringAsFixed(0)}%",
                    Icons.analytics,
                    warningColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            Text(
              "Search & Filter",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search warehouses...",
                    value: searchQuery,
                    hint: "Name, code, or city",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.map,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Status",
                    items: statusFilterOptions,
                    value: statusFilter,
                    onChanged: (value, label) {
                      statusFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Type",
                    items: typeFilterOptions,
                    value: typeFilter,
                    onChanged: (value, label) {
                      typeFilter = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            Row(
              children: [
                Text(
                  "Warehouse List (${filteredWarehouses.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.view_list,
                  size: bs.sm,
                  onPressed: () {},
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.sort,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            if (filteredWarehouses.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No warehouses found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              ...filteredWarehouses.map((warehouse) => _buildWarehouseCard(warehouse)).toList(),
            ],
          ],
        ),
      ),
    );
  }
}
