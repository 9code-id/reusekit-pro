import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaWarehouseManagementView extends StatefulWidget {
  const LtaWarehouseManagementView({super.key});

  @override
  State<LtaWarehouseManagementView> createState() => _LtaWarehouseManagementViewState();
}

class _LtaWarehouseManagementViewState extends State<LtaWarehouseManagementView> {
  int selectedIndex = 0;
  String searchQuery = "";
  String selectedWarehouse = "";
  String selectedCategory = "";
  String selectedStatus = "";

  List<Map<String, dynamic>> warehouses = [
    {
      "id": "1",
      "name": "Central Warehouse",
      "location": "Downtown District",
      "address": "123 Main Street, Downtown",
      "capacity": 10000,
      "current_stock": 7500,
      "status": "Active",
      "manager": "John Smith",
      "phone": "+1-555-0123",
      "email": "central@logistics.com",
      "image": "https://picsum.photos/300/200?random=1&keyword=warehouse"
    },
    {
      "id": "2",
      "name": "North Warehouse",
      "location": "Industrial Zone North",
      "address": "456 Industrial Ave, North District",
      "capacity": 15000,
      "current_stock": 12000,
      "status": "Active",
      "manager": "Sarah Johnson",
      "phone": "+1-555-0124",
      "email": "north@logistics.com",
      "image": "https://picsum.photos/300/200?random=2&keyword=warehouse"
    },
    {
      "id": "3",
      "name": "South Warehouse", 
      "location": "Port Area South",
      "address": "789 Port Road, South District",
      "capacity": 8000,
      "current_stock": 5200,
      "status": "Maintenance",
      "manager": "Mike Rodriguez",
      "phone": "+1-555-0125",
      "email": "south@logistics.com",
      "image": "https://picsum.photos/300/200?random=3&keyword=warehouse"
    },
    {
      "id": "4",
      "name": "East Warehouse",
      "location": "Commercial District East",
      "address": "321 Commerce Blvd, East District",
      "capacity": 12000,
      "current_stock": 9800,
      "status": "Active",
      "manager": "Emily Chen",
      "phone": "+1-555-0126",
      "email": "east@logistics.com",
      "image": "https://picsum.photos/300/200?random=4&keyword=warehouse"
    }
  ];

  List<Map<String, dynamic>> inventoryItems = [
    {
      "id": "1",
      "name": "Electronic Components",
      "sku": "EC-001",
      "category": "Electronics",
      "quantity": 1500,
      "unit": "pieces",
      "location": "A-01-15",
      "warehouse": "Central Warehouse",
      "last_updated": "2024-01-15T10:30:00Z",
      "status": "In Stock"
    },
    {
      "id": "2",
      "name": "Automotive Parts",
      "sku": "AP-002",
      "category": "Automotive",
      "quantity": 850,
      "unit": "pieces",
      "location": "B-02-08",
      "warehouse": "North Warehouse",
      "last_updated": "2024-01-15T09:15:00Z",
      "status": "Low Stock"
    },
    {
      "id": "3",
      "name": "Medical Supplies",
      "sku": "MS-003",
      "category": "Healthcare",
      "quantity": 2200,
      "unit": "units",
      "location": "C-03-12",
      "warehouse": "East Warehouse",
      "last_updated": "2024-01-15T11:45:00Z",
      "status": "In Stock"
    },
    {
      "id": "4",
      "name": "Construction Tools",
      "sku": "CT-004",
      "category": "Construction",
      "quantity": 150,
      "unit": "sets",
      "location": "D-04-06",
      "warehouse": "South Warehouse",
      "last_updated": "2024-01-15T08:20:00Z",
      "status": "Critical"
    }
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "id": "1",
      "action": "Stock Received",
      "item": "Electronic Components",
      "quantity": 500,
      "warehouse": "Central Warehouse",
      "time": "2024-01-15T10:30:00Z",
      "user": "John Smith"
    },
    {
      "id": "2",
      "action": "Stock Transferred",
      "item": "Automotive Parts",
      "quantity": 200,
      "warehouse": "North Warehouse",
      "time": "2024-01-15T09:45:00Z",
      "user": "Sarah Johnson"
    },
    {
      "id": "3",
      "action": "Stock Shipped",
      "item": "Medical Supplies", 
      "quantity": 300,
      "warehouse": "East Warehouse",
      "time": "2024-01-15T11:15:00Z",
      "user": "Emily Chen"
    }
  ];

  List<Map<String, dynamic>> dropdownWarehouses = [
    {"label": "All Warehouses", "value": ""},
    {"label": "Central Warehouse", "value": "1"},
    {"label": "North Warehouse", "value": "2"},
    {"label": "South Warehouse", "value": "3"},
    {"label": "East Warehouse", "value": "4"}
  ];

  List<Map<String, dynamic>> dropdownCategories = [
    {"label": "All Categories", "value": ""},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Automotive", "value": "Automotive"},
    {"label": "Healthcare", "value": "Healthcare"},
    {"label": "Construction", "value": "Construction"}
  ];

  List<Map<String, dynamic>> dropdownStatus = [
    {"label": "All Status", "value": ""},
    {"label": "In Stock", "value": "In Stock"},
    {"label": "Low Stock", "value": "Low Stock"},
    {"label": "Critical", "value": "Critical"},
    {"label": "Out of Stock", "value": "Out of Stock"}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Warehouse Management",
      selectedIndex: selectedIndex,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Inventory", icon: Icon(Icons.inventory)),
        Tab(text: "Activities", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildInventoryTab(),
        _buildActivitiesTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildWarehouseStats(),
          _buildWarehouseList(),
        ],
      ),
    );
  }

  Widget _buildWarehouseStats() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border(
                left: BorderSide(width: 4, color: primaryColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Warehouses",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "4",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border(
                left: BorderSide(width: 4, color: successColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Active Warehouses",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "3",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border(
                left: BorderSide(width: 4, color: infoColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Capacity",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "45K",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWarehouseList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Warehouses",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.all(0),
          minItemWidth: 280,
          children: warehouses.map((warehouse) {
            Color statusColor = successColor;
            if ("${warehouse["status"]}" == "Maintenance") statusColor = warningColor;
            
            double utilizationRate = ((warehouse["current_stock"] as int) / (warehouse["capacity"] as int)) * 100;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(width: 4, color: statusColor),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${warehouse["image"]}",
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${warehouse["name"]}",
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
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${warehouse["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${warehouse["location"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${warehouse["manager"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 16, color: disabledBoldColor),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Utilization: ${utilizationRate.toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${warehouse["current_stock"]}/${warehouse["capacity"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: utilizationRate / 100,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        ss("Viewing ${warehouse["name"]} details");
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildInventoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildInventoryFilters(),
          _buildInventoryStats(),
          _buildInventoryList(),
        ],
      ),
    );
  }

  Widget _buildInventoryFilters() {
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
            "Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Items",
                  value: searchQuery,
                  hint: "Search by name or SKU",
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
                onPressed: () {
                  ss("Searching inventory");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Warehouse",
                  items: dropdownWarehouses,
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
                  label: "Category",
                  items: dropdownCategories,
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
                  label: "Status",
                  items: dropdownStatus,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
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

  Widget _buildInventoryStats() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border(
                left: BorderSide(width: 4, color: successColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Items",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "4,700",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border(
                left: BorderSide(width: 4, color: warningColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Low Stock",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "23",
                  style: TextStyle(
                    fontSize: fsH3,
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
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border(
                left: BorderSide(width: 4, color: dangerColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Critical",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "5",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInventoryList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Inventory Items",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: inventoryItems.length,
          itemBuilder: (context, index) {
            final item = inventoryItems[index];
            Color statusColor = successColor;
            if ("${item["status"]}" == "Low Stock") statusColor = warningColor;
            if ("${item["status"]}" == "Critical") statusColor = dangerColor;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(width: 4, color: statusColor),
                ),
              ),
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
                              "${item["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "SKU: ${item["sku"]} • ${item["category"]}",
                              style: TextStyle(
                                fontSize: 14,
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
                          "${item["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.inventory, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${item["quantity"]} ${item["unit"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${item["location"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.warehouse, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${item["warehouse"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${DateTime.parse(item["last_updated"] as String).dMMMy}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildActivitiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildActivityStats(),
          _buildRecentActivities(),
        ],
      ),
    );
  }

  Widget _buildActivityStats() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border(
                left: BorderSide(width: 4, color: primaryColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Activities",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "47",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border(
                left: BorderSide(width: 4, color: successColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Items Received",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "1,250",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border(
                left: BorderSide(width: 4, color: infoColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Items Shipped",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "890",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Activities",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: recentActivities.length,
          itemBuilder: (context, index) {
            final activity = recentActivities[index];
            Color actionColor = primaryColor;
            IconData actionIcon = Icons.info;
            
            if ("${activity["action"]}" == "Stock Received") {
              actionColor = successColor;
              actionIcon = Icons.add_box;
            } else if ("${activity["action"]}" == "Stock Shipped") {
              actionColor = infoColor;
              actionIcon = Icons.local_shipping;
            } else if ("${activity["action"]}" == "Stock Transferred") {
              actionColor = warningColor;
              actionIcon = Icons.swap_horiz;
            }
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(width: 4, color: actionColor),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: actionColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(actionIcon, color: actionColor, size: 24),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${activity["action"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${activity["item"]} (${activity["quantity"]} units)",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.warehouse, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${activity["warehouse"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(Icons.person, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${activity["user"]}",
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${DateTime.parse(activity["time"] as String).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${TimeOfDay.fromDateTime(DateTime.parse(activity["time"] as String)).format(context)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
