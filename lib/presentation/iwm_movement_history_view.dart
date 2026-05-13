import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmMovementHistoryView extends StatefulWidget {
  const IwmMovementHistoryView({super.key});

  @override
  State<IwmMovementHistoryView> createState() => _IwmMovementHistoryViewState();
}

class _IwmMovementHistoryViewState extends State<IwmMovementHistoryView> {
  int selectedTab = 0;
  String selectedWarehouse = "all";
  String selectedMovementType = "all";
  String selectedDateRange = "last_30_days";
  String searchQuery = "";
  
  List<Map<String, dynamic>> warehouses = [
    {"label": "All Warehouses", "value": "all"},
    {"label": "Main Warehouse", "value": "main"},
    {"label": "Secondary Warehouse", "value": "secondary"},
    {"label": "Distribution Center", "value": "distribution"},
  ];
  
  List<Map<String, dynamic>> movementTypes = [
    {"label": "All Movements", "value": "all"},
    {"label": "Inbound", "value": "inbound"},
    {"label": "Outbound", "value": "outbound"},
    {"label": "Transfer", "value": "transfer"},
    {"label": "Adjustment", "value": "adjustment"},
    {"label": "Return", "value": "return"},
  ];
  
  List<Map<String, dynamic>> dateRanges = [
    {"label": "Today", "value": "today"},
    {"label": "Last 7 Days", "value": "last_7_days"},
    {"label": "Last 30 Days", "value": "last_30_days"},
    {"label": "Last 90 Days", "value": "last_90_days"},
    {"label": "Custom Range", "value": "custom"},
  ];
  
  List<Map<String, dynamic>> movementSummary = [
    {
      "title": "Total Movements",
      "value": 1248,
      "subtitle": "Last 30 Days",
      "icon": Icons.swap_horiz,
      "color": primaryColor
    },
    {
      "title": "Inbound",
      "value": 456,
      "subtitle": "36.5% of Total",
      "icon": Icons.arrow_downward,
      "color": successColor
    },
    {
      "title": "Outbound",
      "value": 623,
      "subtitle": "49.9% of Total",
      "icon": Icons.arrow_upward,
      "color": warningColor
    },
    {
      "title": "Transfers",
      "value": 169,
      "subtitle": "13.5% of Total",
      "icon": Icons.swap_vert,
      "color": infoColor
    },
  ];
  
  List<Map<String, dynamic>> movementHistory = [
    {
      "id": "MV-2024-001234",
      "type": "Inbound",
      "sku": "SKU-001234",
      "productName": "Premium Office Chair",
      "warehouse": "Main Warehouse",
      "location": "A1-B3-15",
      "quantity": 25,
      "unitCost": 125.50,
      "totalCost": 3137.50,
      "reference": "PO-2024-5678",
      "supplier": "Office Furniture Co.",
      "timestamp": "2024-01-15 10:30:00",
      "user": "John Smith",
      "status": "Completed",
      "notes": "Delivery completed successfully"
    },
    {
      "id": "MV-2024-001235",
      "type": "Outbound",
      "sku": "SKU-005678",
      "productName": "Wireless Mouse",
      "warehouse": "Distribution Center",
      "location": "B2-C1-08",
      "quantity": -15,
      "unitCost": 45.00,
      "totalCost": 675.00,
      "reference": "SO-2024-9101",
      "supplier": "Customer Order",
      "timestamp": "2024-01-15 11:45:00",
      "user": "Sarah Johnson",
      "status": "Completed",
      "notes": "Shipped to customer"
    },
    {
      "id": "MV-2024-001236",
      "type": "Transfer",
      "sku": "SKU-009876",
      "productName": "USB Cable",
      "warehouse": "Main Warehouse → Secondary Warehouse",
      "location": "A3-D1-22 → B1-C2-15",
      "quantity": 50,
      "unitCost": 12.00,
      "totalCost": 600.00,
      "reference": "TR-2024-0145",
      "supplier": "Internal Transfer",
      "timestamp": "2024-01-15 14:20:00",
      "user": "Mike Chen",
      "status": "In Transit",
      "notes": "Transfer to secondary warehouse"
    },
    {
      "id": "MV-2024-001237",
      "type": "Adjustment",
      "sku": "SKU-112233",
      "productName": "Laptop Stand",
      "warehouse": "Main Warehouse",
      "location": "C1-A2-10",
      "quantity": -3,
      "unitCost": 75.00,
      "totalCost": 225.00,
      "reference": "ADJ-2024-0087",
      "supplier": "Physical Count Adjustment",
      "timestamp": "2024-01-14 16:15:00",
      "user": "Emily Davis",
      "status": "Completed",
      "notes": "Cycle count adjustment - damaged items"
    },
    {
      "id": "MV-2024-001238",
      "type": "Return",
      "sku": "SKU-445566",
      "productName": "Bluetooth Keyboard",
      "warehouse": "Distribution Center",
      "location": "D1-B3-05",
      "quantity": 2,
      "unitCost": 89.99,
      "totalCost": 179.98,
      "reference": "RET-2024-3456",
      "supplier": "Customer Return",
      "timestamp": "2024-01-14 09:30:00",
      "user": "Alex Rodriguez",
      "status": "Completed",
      "notes": "Customer return - unopened items"
    },
  ];
  
  List<Map<String, dynamic>> itemMovements = [
    {
      "sku": "SKU-001234",
      "productName": "Premium Office Chair",
      "totalMovements": 45,
      "lastMovement": "2024-01-15",
      "currentStock": 125,
      "averageDaily": 2.5,
      "movements": [
        {"date": "2024-01-15", "type": "Inbound", "qty": 25, "ref": "PO-2024-5678"},
        {"date": "2024-01-14", "type": "Outbound", "qty": -8, "ref": "SO-2024-9876"},
        {"date": "2024-01-13", "type": "Outbound", "qty": -5, "ref": "SO-2024-9875"},
      ]
    },
    {
      "sku": "SKU-005678",
      "productName": "Wireless Mouse",
      "totalMovements": 89,
      "lastMovement": "2024-01-15",
      "currentStock": 234,
      "averageDaily": 4.8,
      "movements": [
        {"date": "2024-01-15", "type": "Outbound", "qty": -15, "ref": "SO-2024-9101"},
        {"date": "2024-01-14", "type": "Inbound", "qty": 50, "ref": "PO-2024-5679"},
        {"date": "2024-01-13", "type": "Outbound", "qty": -12, "ref": "SO-2024-9102"},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Movement History",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Movements", icon: Icon(Icons.list)),
        Tab(text: "By Item", icon: Icon(Icons.inventory)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildMovementsTab(),
        _buildByItemTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          _buildMovementSummary(),
          _buildMovementChart(),
          _buildRecentMovements(),
        ],
      ),
    );
  }

  Widget _buildMovementsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMovementFilters(),
          _buildMovementsList(),
        ],
      ),
    );
  }

  Widget _buildByItemTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItemFilters(),
          _buildItemMovementsList(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
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
                  label: "Movement Type",
                  items: movementTypes,
                  value: selectedMovementType,
                  onChanged: (value, label) {
                    selectedMovementType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Date Range",
            items: dateRanges,
            value: selectedDateRange,
            onChanged: (value, label) {
              selectedDateRange = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMovementFilters() {
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
                  label: "Search",
                  value: searchQuery,
                  hint: "Search by SKU, product, or reference",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.file_download,
                label: "Export",
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
                  label: "Movement Type",
                  items: movementTypes,
                  value: selectedMovementType,
                  onChanged: (value, label) {
                    selectedMovementType = value;
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

  Widget _buildItemFilters() {
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
            child: QTextField(
              label: "Search Items",
              value: searchQuery,
              hint: "Search by SKU or product name",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            label: "Analytics",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMovementSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Movement Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: movementSummary.map((summary) => _buildSummaryCard(summary)).toList(),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(Map<String, dynamic> summary) {
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
                  color: (summary["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  summary["icon"],
                  color: summary["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${summary["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${summary["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${summary["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovementChart() {
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
            "Movement Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
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
                    Icons.trending_up,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Movement Trends Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentMovements() {
    List<Map<String, dynamic>> recentMovements = movementHistory.take(5).toList();

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
            "Recent Movements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...recentMovements.map((movement) => _buildRecentMovementItem(movement)),
        ],
      ),
    );
  }

  Widget _buildRecentMovementItem(Map<String, dynamic> movement) {
    Color typeColor = _getMovementTypeColor(movement["type"]);
    IconData typeIcon = _getMovementTypeIcon(movement["type"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: typeColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              typeIcon,
              color: typeColor,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${movement["productName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${movement["type"]} • ${movement["quantity"]} units",
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
                "\$${((movement["totalCost"] as double).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${movement["timestamp"].toString().split(' ')[0]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMovementsList() {
    return Column(
      spacing: spSm,
      children: movementHistory.map((movement) => _buildMovementCard(movement)).toList(),
    );
  }

  Widget _buildMovementCard(Map<String, dynamic> movement) {
    Color typeColor = _getMovementTypeColor(movement["type"]);
    Color statusColor = _getStatusColor(movement["status"]);
    IconData typeIcon = _getMovementTypeIcon(movement["type"]);
    
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
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  typeIcon,
                  color: typeColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${movement["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${movement["productName"]} (${movement["sku"]})",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: typeColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${movement["type"]}",
                      style: TextStyle(
                        color: typeColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${movement["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Warehouse: ${movement["warehouse"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Location: ${movement["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Reference: ${movement["reference"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "User: ${movement["user"]} • ${movement["timestamp"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${movement["quantity"]} units",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: movement["quantity"] > 0 ? successColor : dangerColor,
                    ),
                  ),
                  Text(
                    "@ \$${((movement["unitCost"] as double).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${((movement["totalCost"] as double).toDouble()).currency}",
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
          if (movement["notes"] != "")
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "Notes: ${movement["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildItemMovementsList() {
    return Column(
      spacing: spSm,
      children: itemMovements.map((item) => _buildItemMovementCard(item)).toList(),
    );
  }

  Widget _buildItemMovementCard(Map<String, dynamic> item) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["sku"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${item["productName"]}",
                      style: TextStyle(
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
                    "${item["totalMovements"]}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Total Movements",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Stock: ${item["currentStock"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Last Movement: ${item["lastMovement"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Daily Average: ${(item["averageDaily"] as double).toStringAsFixed(1)} movements",
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
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Movements:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(item["movements"] as List).map((movement) => Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child: Row(
                    children: [
                      Text(
                        "${movement["date"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${movement["type"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: _getMovementTypeColor(movement["type"]),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${movement["qty"]} units",
                        style: TextStyle(
                          fontSize: 11,
                          color: movement["qty"] > 0 ? successColor : dangerColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${movement["ref"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          Row(
            children: [
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getMovementTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'inbound':
        return successColor;
      case 'outbound':
        return warningColor;
      case 'transfer':
        return infoColor;
      case 'adjustment':
        return dangerColor;
      case 'return':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getMovementTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'inbound':
        return Icons.arrow_downward;
      case 'outbound':
        return Icons.arrow_upward;
      case 'transfer':
        return Icons.swap_vert;
      case 'adjustment':
        return Icons.edit;
      case 'return':
        return Icons.undo;
      default:
        return Icons.swap_horiz;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in transit':
        return warningColor;
      case 'pending':
        return infoColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
