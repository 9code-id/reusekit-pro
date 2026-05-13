import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaPackListView extends StatefulWidget {
  const ImaPackListView({super.key});

  @override
  State<ImaPackListView> createState() => _ImaPackListViewState();
}

class _ImaPackListViewState extends State<ImaPackListView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPacker = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All"},
    {"label": "Ready to Pack", "value": "Ready to Pack"},
    {"label": "Packing", "value": "Packing"},
    {"label": "Packed", "value": "Packed"},
    {"label": "Quality Check", "value": "Quality Check"},
  ];

  List<Map<String, dynamic>> packerItems = [
    {"label": "All Packers", "value": "All"},
    {"label": "John Smith", "value": "John Smith"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Mike Wilson", "value": "Mike Wilson"},
    {"label": "Emma Davis", "value": "Emma Davis"},
  ];

  List<Map<String, dynamic>> packLists = [
    {
      "id": "PK-2024-001",
      "pickListId": "PL-2024-001",
      "orderNumber": "ORD-45892",
      "customer": "ABC Electronics Store",
      "status": "Packing",
      "assignedTo": "Sarah Johnson",
      "startTime": "2024-06-19 09:00",
      "estimatedCompletion": "2024-06-19 11:00",
      "actualCompletion": null,
      "itemCount": 8,
      "packedCount": 6,
      "packagingType": "Standard Box",
      "weight": 12.5,
      "dimensions": "40x30x20 cm",
      "specialInstructions": "Handle with care - electronics",
      "items": [
        {"sku": "ELEC-001", "name": "Smartphone", "quantity": 2, "packed": 2},
        {"sku": "ELEC-002", "name": "Laptop", "quantity": 1, "packed": 1},
        {"sku": "ELEC-003", "name": "Tablet", "quantity": 3, "packed": 3},
        {"sku": "ELEC-004", "name": "Headphones", "quantity": 2, "packed": 0},
      ]
    },
    {
      "id": "PK-2024-002",
      "pickListId": "PL-2024-002",
      "orderNumber": "ORD-45893",
      "customer": "Tech Solutions Ltd",
      "status": "Ready to Pack",
      "assignedTo": "John Smith",
      "startTime": null,
      "estimatedCompletion": "2024-06-19 14:00",
      "actualCompletion": null,
      "itemCount": 12,
      "packedCount": 0,
      "packagingType": "Large Box",
      "weight": 25.8,
      "dimensions": "60x40x30 cm",
      "specialInstructions": "Fragile items - use bubble wrap",
      "items": [
        {"sku": "COMP-001", "name": "Desktop PC", "quantity": 2, "packed": 0},
        {"sku": "COMP-002", "name": "Monitor", "quantity": 4, "packed": 0},
        {"sku": "COMP-003", "name": "Keyboard", "quantity": 6, "packed": 0},
      ]
    },
    {
      "id": "PK-2024-003",
      "pickListId": "PL-2024-003",
      "orderNumber": "ORD-45894",
      "customer": "Home Appliances Co",
      "status": "Packed",
      "assignedTo": "Mike Wilson",
      "startTime": "2024-06-18 10:00",
      "estimatedCompletion": "2024-06-18 15:00",
      "actualCompletion": "2024-06-18 14:30",
      "itemCount": 6,
      "packedCount": 6,
      "packagingType": "Custom Crate",
      "weight": 45.2,
      "dimensions": "80x60x40 cm",
      "specialInstructions": "Heavy items - use forklift",
      "items": [
        {"sku": "APPL-001", "name": "Refrigerator", "quantity": 1, "packed": 1},
        {"sku": "APPL-002", "name": "Washing Machine", "quantity": 1, "packed": 1},
        {"sku": "APPL-003", "name": "Microwave", "quantity": 4, "packed": 4},
      ]
    },
    {
      "id": "PK-2024-004",
      "pickListId": "PL-2024-004",
      "orderNumber": "ORD-45895",
      "customer": "Office Supplies Inc",
      "status": "Quality Check",
      "assignedTo": "Emma Davis",
      "startTime": "2024-06-19 08:00",
      "estimatedCompletion": "2024-06-19 10:00",
      "actualCompletion": "2024-06-19 09:45",
      "itemCount": 15,
      "packedCount": 15,
      "packagingType": "Multiple Boxes",
      "weight": 18.7,
      "dimensions": "Various",
      "specialInstructions": "Label each box clearly",
      "items": [
        {"sku": "OFF-001", "name": "Office Chair", "quantity": 5, "packed": 5},
        {"sku": "OFF-002", "name": "Desk Lamp", "quantity": 10, "packed": 10},
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredPackLists {
    return packLists.where((packList) {
      final matchesSearch = packList["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          packList["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          packList["orderNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "All" || packList["status"] == selectedStatus;
      final matchesPacker = selectedPacker == "All" || packList["assignedTo"] == selectedPacker;
      
      return matchesSearch && matchesStatus && matchesPacker;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Packed":
        return successColor;
      case "Packing":
        return primaryColor;
      case "Ready to Pack":
        return warningColor;
      case "Quality Check":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  void _startPacking(Map<String, dynamic> packList) {
    packList["status"] = "Packing";
    packList["startTime"] = DateTime.now().toString();
    setState(() {});
    ss("Started packing for ${packList["id"]}");
  }

  void _completePacking(Map<String, dynamic> packList) async {
    bool isConfirmed = await confirm("Complete packing for ${packList["id"]}?");
    if (isConfirmed) {
      packList["status"] = "Quality Check";
      packList["actualCompletion"] = DateTime.now().toString();
      setState(() {});
      ss("Packing completed for ${packList["id"]}");
    }
  }

  void _approveQualityCheck(Map<String, dynamic> packList) async {
    bool isConfirmed = await confirm("Approve quality check for ${packList["id"]}?");
    if (isConfirmed) {
      packList["status"] = "Packed";
      setState(() {});
      ss("Quality check approved for ${packList["id"]}");
    }
  }

  void _viewPackListDetails(Map<String, dynamic> packList) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Pack List Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("ID: ${packList["id"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spXs),
              Text("Pick List: ${packList["pickListId"]}"),
              Text("Order: ${packList["orderNumber"]}"),
              Text("Customer: ${packList["customer"]}"),
              Text("Status: ${packList["status"]}"),
              Text("Assigned To: ${packList["assignedTo"]}"),
              Text("Progress: ${packList["packedCount"]}/${packList["itemCount"]} items"),
              Text("Weight: ${packList["weight"]} kg"),
              Text("Dimensions: ${packList["dimensions"]}"),
              if (packList["specialInstructions"] != null)
                Text("Instructions: ${packList["specialInstructions"]}"),
              SizedBox(height: spSm),
              Text("Items:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...((packList["items"] as List).map((item) => Padding(
                padding: EdgeInsets.only(top: spXs),
                child: Text("• ${item["name"]} (${item["packed"]}/${item["quantity"]})"),
              ))),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPackListCard(Map<String, dynamic> packList) {
    double progressPercentage = (packList["packedCount"] as int) / (packList["itemCount"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
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
                      "${packList["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${packList["customer"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(packList["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${packList["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(packList["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.inventory_2, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Order: ${packList["orderNumber"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.list_alt, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Pick: ${packList["pickListId"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${packList["assignedTo"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.scale, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${packList["weight"]} kg",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${packList["packagingType"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.straighten, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${packList["dimensions"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          if (packList["specialInstructions"] != null) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, size: 16, color: warningColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${packList["specialInstructions"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progress: ${packList["packedCount"]}/${packList["itemCount"]} items",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: progressPercentage,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progressPercentage == 1.0 ? successColor : primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${(progressPercentage * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
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
                  onPressed: () => _viewPackListDetails(packList),
                ),
              ),
              SizedBox(width: spSm),
              if (packList["status"] == "Ready to Pack")
                QButton(
                  label: "Start Packing",
                  size: bs.sm,
                  onPressed: () => _startPacking(packList),
                )
              else if (packList["status"] == "Packing")
                QButton(
                  label: "Complete",
                  size: bs.sm,
                  onPressed: () => _completePacking(packList),
                )
              else if (packList["status"] == "Quality Check")
                QButton(
                  label: "Approve",
                  size: bs.sm,
                  onPressed: () => _approveQualityCheck(packList),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    int totalPackLists = packLists.length;
    int readyToPack = packLists.where((p) => p["status"] == "Ready to Pack").length;
    int packing = packLists.where((p) => p["status"] == "Packing").length;
    int qualityCheck = packLists.where((p) => p["status"] == "Quality Check").length;
    int packed = packLists.where((p) => p["status"] == "Packed").length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.inventory, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$totalPackLists",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Pack Lists",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.pending_actions, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$readyToPack",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Ready to Pack",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.work, color: infoColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$packing",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Packing",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$packed",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Packed",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Text(
            "Recent Pack Lists",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...packLists.take(3).map((packList) => _buildPackListCard(packList)),
        ],
      ),
    );
  }

  Widget _buildActiveTab() {
    List<Map<String, dynamic>> activePackLists = packLists.where((p) => 
        p["status"] != "Packed").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search pack lists...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
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
                  label: "Filter by Status",
                  items: statusItems,
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
                  label: "Filter by Packer",
                  items: packerItems,
                  value: selectedPacker,
                  onChanged: (value, label) {
                    selectedPacker = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          if (activePackLists.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.inbox, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No active pack lists found",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            )
          else
            ...filteredPackLists.where((p) => p["status"] != "Packed").map((packList) => _buildPackListCard(packList)),
        ],
      ),
    );
  }

  Widget _buildCompletedTab() {
    List<Map<String, dynamic>> completedPackLists = packLists.where((p) => 
        p["status"] == "Packed").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search completed pack lists...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          if (completedPackLists.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.archive, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No completed pack lists found",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            )
          else
            ...completedPackLists.map((packList) => _buildPackListCard(packList)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Pack Lists",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Active", icon: Icon(Icons.work)),
        Tab(text: "Completed", icon: Icon(Icons.archive)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildActiveTab(),
        _buildCompletedTab(),
      ],
    );
  }
}
