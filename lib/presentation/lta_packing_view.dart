import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaPackingView extends StatefulWidget {
  const LtaPackingView({super.key});

  @override
  State<LtaPackingView> createState() => _LtaPackingViewState();
}

class _LtaPackingViewState extends State<LtaPackingView> {
  bool loading = true;
  String searchQuery = "";
  String selectedStatus = "All Status";
  String selectedPackageType = "All Types";
  String selectedWorker = "All Workers";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Ready to Pack", "value": "Ready to Pack"},
    {"label": "Packing", "value": "Packing"},
    {"label": "Packed", "value": "Packed"},
    {"label": "Quality Check", "value": "Quality Check"},
    {"label": "Ready to Ship", "value": "Ready to Ship"},
    {"label": "On Hold", "value": "On Hold"},
  ];

  List<Map<String, dynamic>> packageTypeOptions = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Standard Box", "value": "Standard Box"},
    {"label": "Express Box", "value": "Express Box"},
    {"label": "Fragile Package", "value": "Fragile Package"},
    {"label": "Cold Package", "value": "Cold Package"},
    {"label": "Hazmat Package", "value": "Hazmat Package"},
    {"label": "Bulk Package", "value": "Bulk Package"},
  ];

  List<Map<String, dynamic>> workerOptions = [
    {"label": "All Workers", "value": "All Workers"},
    {"label": "Alice Johnson", "value": "Alice Johnson"},
    {"label": "Bob Miller", "value": "Bob Miller"},
    {"label": "Carol Davis", "value": "Carol Davis"},
    {"label": "David Wilson", "value": "David Wilson"},
    {"label": "Eva Brown", "value": "Eva Brown"},
  ];

  List<Map<String, dynamic>> packingOrders = [
    {
      "id": "pack_001",
      "orderNumber": "ORD-2024-001",
      "pickingListId": "pick_001",
      "customerName": "TechCorp Solutions",
      "status": "Packing",
      "priority": "High",
      "assignedWorker": "Alice Johnson",
      "startTime": "2024-03-15T10:30:00Z",
      "estimatedCompletion": "2024-03-15T14:00:00Z",
      "actualCompletion": "",
      "packageType": "Fragile Package",
      "totalItems": 8,
      "packedItems": 5,
      "totalWeight": 4.2,
      "packedWeight": 2.8,
      "packagingMaterials": ["Bubble Wrap", "Foam Padding", "Fragile Stickers"],
      "specialInstructions": "Handle with extreme care - high-value electronics",
      "qualityCheckRequired": true,
      "packages": [
        {
          "id": "pkg_001_1",
          "type": "Medium Box",
          "dimensions": "40x30x20 cm",
          "weight": 1.5,
          "status": "Packed",
          "items": ["EL-001", "EL-002"],
          "trackingNumber": "TRK001234567",
        },
        {
          "id": "pkg_001_2",
          "type": "Small Box",
          "dimensions": "25x20x15 cm",
          "weight": 1.3,
          "status": "Packed",
          "items": ["EL-003"],
          "trackingNumber": "TRK001234568",
        },
        {
          "id": "pkg_001_3",
          "type": "Large Box",
          "dimensions": "50x40x30 cm",
          "weight": 0.0,
          "status": "Packing",
          "items": ["EL-004", "AC-001"],
          "trackingNumber": "",
        },
      ],
      "notes": "Customer requested extra padding for all electronic items",
    },
    {
      "id": "pack_002",
      "orderNumber": "ORD-2024-002",
      "pickingListId": "pick_002",
      "customerName": "AutoParts Express",
      "status": "Ready to Ship",
      "priority": "Medium",
      "assignedWorker": "Bob Miller",
      "startTime": "2024-03-15T09:00:00Z",
      "estimatedCompletion": "2024-03-15T12:30:00Z",
      "actualCompletion": "2024-03-15T12:15:00Z",
      "packageType": "Bulk Package",
      "totalItems": 6,
      "packedItems": 6,
      "totalWeight": 8.5,
      "packedWeight": 8.5,
      "packagingMaterials": ["Cardboard Dividers", "Plastic Wrap", "Heavy Duty Tape"],
      "specialInstructions": "Heavy automotive parts - reinforce bottom of boxes",
      "qualityCheckRequired": false,
      "packages": [
        {
          "id": "pkg_002_1",
          "type": "Heavy Duty Box",
          "dimensions": "60x40x40 cm",
          "weight": 5.2,
          "status": "Quality Checked",
          "items": ["AU-101", "AU-102"],
          "trackingNumber": "TRK002345678",
        },
        {
          "id": "pkg_002_2",
          "type": "Medium Box",
          "dimensions": "40x30x25 cm",
          "weight": 3.3,
          "status": "Quality Checked",
          "items": ["AU-103"],
          "trackingNumber": "TRK002345679",
        },
      ],
      "notes": "All items packed securely with extra reinforcement",
    },
    {
      "id": "pack_003",
      "orderNumber": "ORD-2024-003",
      "pickingListId": "pick_003",
      "customerName": "MedSupply Inc",
      "status": "Ready to Pack",
      "priority": "Urgent",
      "assignedWorker": "Carol Davis",
      "startTime": "",
      "estimatedCompletion": "2024-03-15T16:00:00Z",
      "actualCompletion": "",
      "packageType": "Cold Package",
      "totalItems": 12,
      "packedItems": 0,
      "totalWeight": 1.6,
      "packedWeight": 0.0,
      "packagingMaterials": ["Insulated Box", "Gel Packs", "Temperature Monitor"],
      "specialInstructions": "Maintain cold chain - temperature must stay below 8°C",
      "qualityCheckRequired": true,
      "packages": [
        {
          "id": "pkg_003_1",
          "type": "Insulated Box",
          "dimensions": "35x25x25 cm",
          "weight": 0.0,
          "status": "Ready",
          "items": ["PH-201", "PH-202", "PH-203"],
          "trackingNumber": "",
        },
      ],
      "notes": "Temperature-sensitive pharmaceuticals - priority handling required",
    },
    {
      "id": "pack_004",
      "orderNumber": "ORD-2024-004",
      "pickingListId": "pick_004",
      "customerName": "ChemLab Solutions",
      "status": "On Hold",
      "priority": "High",
      "assignedWorker": "David Wilson",
      "startTime": "2024-03-15T11:30:00Z",
      "estimatedCompletion": "2024-03-15T16:30:00Z",
      "actualCompletion": "",
      "packageType": "Hazmat Package",
      "totalItems": 5,
      "packedItems": 2,
      "totalWeight": 5.7,
      "packedWeight": 2.9,
      "packagingMaterials": ["Hazmat Containers", "Absorbent Material", "Warning Labels"],
      "specialInstructions": "Hazardous chemicals - follow safety protocols",
      "qualityCheckRequired": true,
      "packages": [
        {
          "id": "pkg_004_1",
          "type": "Hazmat Container",
          "dimensions": "30x30x30 cm",
          "weight": 2.9,
          "status": "On Hold",
          "items": ["CH-301", "CH-302"],
          "trackingNumber": "",
        },
        {
          "id": "pkg_004_2",
          "type": "Hazmat Container",
          "dimensions": "35x35x30 cm",
          "weight": 0.0,
          "status": "Pending",
          "items": ["CH-303"],
          "trackingNumber": "",
        },
      ],
      "notes": "Waiting for safety equipment repair before continuing",
    },
    {
      "id": "pack_005",
      "orderNumber": "ORD-2024-005",
      "pickingListId": "pick_005",
      "customerName": "Office Solutions Pro",
      "status": "Quality Check",
      "priority": "Low",
      "assignedWorker": "Eva Brown",
      "startTime": "2024-03-15T08:45:00Z",
      "estimatedCompletion": "2024-03-15T11:30:00Z",
      "actualCompletion": "2024-03-15T11:20:00Z",
      "packageType": "Standard Box",
      "totalItems": 15,
      "packedItems": 15,
      "totalWeight": 3.4,
      "packedWeight": 3.4,
      "packagingMaterials": ["Standard Boxes", "Paper Fill", "Standard Tape"],
      "specialInstructions": "Standard office supplies - no special handling required",
      "qualityCheckRequired": true,
      "packages": [
        {
          "id": "pkg_005_1",
          "type": "Large Box",
          "dimensions": "45x35x30 cm",
          "weight": 2.1,
          "status": "Quality Check",
          "items": ["OF-001", "OF-002", "OF-003"],
          "trackingNumber": "TRK005678901",
        },
        {
          "id": "pkg_005_2",
          "type": "Medium Box",
          "dimensions": "35x25x20 cm",
          "weight": 1.3,
          "status": "Quality Check",
          "items": ["OF-004", "OF-005"],
          "trackingNumber": "TRK005678902",
        },
      ],
      "notes": "Standard packing completed - awaiting final quality inspection",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadPackingData();
  }

  void _loadPackingData() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredPackingOrders {
    return packingOrders.where((order) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${order["orderNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["customerName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["assignedWorker"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["packageType"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All Status" || 
          order["status"] == selectedStatus;
      
      bool matchesPackageType = selectedPackageType == "All Types" || 
          order["packageType"] == selectedPackageType;
      
      bool matchesWorker = selectedWorker == "All Workers" || 
          order["assignedWorker"] == selectedWorker;
      
      return matchesSearch && matchesStatus && matchesPackageType && matchesWorker;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Ready to Pack":
        return warningColor;
      case "Packing":
        return primaryColor;
      case "Packed":
        return infoColor;
      case "Quality Check":
        return Colors.orange;
      case "Ready to Ship":
        return successColor;
      case "On Hold":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Ready to Pack":
        return Icons.schedule;
      case "Packing":
        return Icons.inventory;
      case "Packed":
        return Icons.archive;
      case "Quality Check":
        return Icons.verified;
      case "Ready to Ship":
        return Icons.local_shipping;
      case "On Hold":
        return Icons.pause_circle;
      default:
        return Icons.help;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Urgent":
        return dangerColor;
      case "High":
        return Colors.orange;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPackageStatusColor(String status) {
    switch (status) {
      case "Ready":
        return warningColor;
      case "Packing":
        return primaryColor;
      case "Packed":
        return infoColor;
      case "Quality Check":
        return Colors.orange;
      case "Quality Checked":
        return successColor;
      case "On Hold":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildSummaryCards() {
    List<Map<String, dynamic>> displayOrders = filteredPackingOrders;
    int readyToPack = displayOrders.where((o) => o["status"] == "Ready to Pack").length;
    int packing = displayOrders.where((o) => o["status"] == "Packing").length;
    int packed = displayOrders.where((o) => o["status"] == "Packed").length;
    int qualityCheck = displayOrders.where((o) => o["status"] == "Quality Check").length;
    int readyToShip = displayOrders.where((o) => o["status"] == "Ready to Ship").length;
    int onHold = displayOrders.where((o) => o["status"] == "On Hold").length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard("Ready to Pack", readyToPack, warningColor, Icons.schedule),
        _buildSummaryCard("Packing", packing, primaryColor, Icons.inventory),
        _buildSummaryCard("Quality Check", qualityCheck, Colors.orange, Icons.verified),
        _buildSummaryCard("Ready to Ship", readyToShip, successColor, Icons.local_shipping),
        _buildSummaryCard("On Hold", onHold, dangerColor, Icons.pause_circle),
      ],
    );
  }

  Widget _buildSummaryCard(String title, int count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "$count",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackingCard(Map<String, dynamic> order) {
    String status = "${order["status"]}";
    double itemProgress = (order["packedItems"] as num) / (order["totalItems"] as num);
    double weightProgress = (order["packedWeight"] as num) / (order["totalWeight"] as num);
    bool isCompleted = status == "Ready to Ship";
    bool onHold = status == "On Hold";
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: _getStatusColor(status),
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                _getStatusIcon(status),
                color: _getStatusColor(status),
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "${order["orderNumber"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStatusColor(status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${order["priority"]}").withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${order["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: _getPriorityColor("${order["priority"]}"),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              if (onHold)
                Icon(
                  Icons.warning,
                  color: dangerColor,
                  size: 16,
                ),
              if (order["qualityCheckRequired"] == true)
                Icon(
                  Icons.verified,
                  color: infoColor,
                  size: 16,
                ),
            ],
          ),
          SizedBox(height: spSm),

          // Customer and Worker Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.business, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${order["customerName"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.person, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${order["assignedWorker"]}",
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.category, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${order["packageType"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.scale, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${(order["totalWeight"] as num).toStringAsFixed(1)}kg",
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
            ],
          ),
          SizedBox(height: spSm),

          // Progress Information
          Column(
            children: [
              // Items Progress
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Items: ${order["packedItems"]}/${order["totalItems"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: itemProgress,
                          backgroundColor: Colors.grey.withValues(alpha: 0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isCompleted ? successColor : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "${(itemProgress * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? successColor : primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),

              // Weight Progress
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Weight: ${(order["packedWeight"] as num).toStringAsFixed(1)}/${(order["totalWeight"] as num).toStringAsFixed(1)}kg",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: weightProgress,
                          backgroundColor: Colors.grey.withValues(alpha: 0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isCompleted ? successColor : secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "${(weightProgress * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? successColor : secondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Packages
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Packages (${(order["packages"] as List).length}):",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  children: (order["packages"] as List).map((package) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _getPackageStatusColor("${package["status"]}"),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${package["type"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${package["dimensions"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          if ("${package["trackingNumber"]}".isNotEmpty)
                            Text(
                              "${package["trackingNumber"]}",
                              style: TextStyle(
                                fontSize: 9,
                                color: disabledBoldColor,
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Packaging Materials
          if ((order["packagingMaterials"] as List).isNotEmpty) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Materials:",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: 2),
                Wrap(
                  spacing: spXs,
                  children: (order["packagingMaterials"] as List).map((material) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                      decoration: BoxDecoration(
                        color: infoColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$material",
                        style: TextStyle(
                          fontSize: 9,
                          color: infoColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: spSm),
          ],

          // Special Instructions
          if ("${order["specialInstructions"]}".isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, size: 12, color: warningColor),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "${order["specialInstructions"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: warningColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spSm),
          ],

          // Notes
          if ("${order["notes"]}".isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, size: 12, color: disabledBoldColor),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "${order["notes"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spSm),
          ],

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: status == "Ready to Pack" ? "Start Packing" : 
                         status == "Packing" ? "Update Progress" :
                         status == "Packed" ? "Quality Check" :
                         status == "Quality Check" ? "Approve" :
                         status == "Ready to Ship" ? "Ship Order" : "Resume",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.print,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.qr_code,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Packing Management"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Map<String, dynamic>> displayOrders = filteredPackingOrders;

    return Scaffold(
      appBar: AppBar(
        title: Text("Packing Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            QTextField(
              label: "Search packing orders...",
              value: searchQuery,
              hint: "Search by order, customer, worker, or package type",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

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
                    label: "Package Type",
                    items: packageTypeOptions,
                    value: selectedPackageType,
                    onChanged: (value, label) {
                      selectedPackageType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Assigned Worker",
              items: workerOptions,
              value: selectedWorker,
              onChanged: (value, label) {
                selectedWorker = value;
                setState(() {});
              },
            ),

            // Summary Cards
            _buildSummaryCards(),

            // Results Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${displayOrders.length} packing orders found",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Packing Orders
            if (displayOrders.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.inventory,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No packing orders found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or check back later",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: displayOrders.map((order) => _buildPackingCard(order)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
