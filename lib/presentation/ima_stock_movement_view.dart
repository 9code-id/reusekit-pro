import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaStockMovementView extends StatefulWidget {
  const ImaStockMovementView({super.key});

  @override
  State<ImaStockMovementView> createState() => _ImaStockMovementViewState();
}

class _ImaStockMovementViewState extends State<ImaStockMovementView> {
  String selectedWarehouse = "wh_001";
  String selectedMovementType = "all";
  String searchQuery = "";
  String dateRange = "today";
  String sortBy = "timestamp";
  
  List<Map<String, dynamic>> warehouses = [
    {
      "id": "wh_001",
      "name": "Main Warehouse",
      "location": "Building A",
    },
    {
      "id": "wh_002",
      "name": "Secondary Warehouse",
      "location": "Building B",
    },
  ];

  List<Map<String, dynamic>> movementTypes = [
    {"label": "All Types", "value": "all"},
    {"label": "Inbound", "value": "inbound"},
    {"label": "Outbound", "value": "outbound"},
    {"label": "Transfer", "value": "transfer"},
    {"label": "Adjustment", "value": "adjustment"},
    {"label": "Return", "value": "return"},
    {"label": "Damage", "value": "damage"},
  ];

  List<Map<String, dynamic>> stockMovements = [
    {
      "id": "mov_001",
      "warehouseId": "wh_001",
      "movementType": "inbound",
      "productSku": "PROD-001",
      "productName": "Laptop Computer",
      "batchNumber": "BATCH-2024-001",
      "fromLocation": null,
      "toLocation": "A1-001-L1-01",
      "quantity": 25,
      "unitPrice": 1200.00,
      "totalValue": 30000.00,
      "timestamp": "2024-12-05T09:30:00Z",
      "employeeId": "EMP-001",
      "employeeName": "John Smith",
      "referenceNumber": "PO-2024-001",
      "reason": "Purchase Order",
      "notes": "New stock arrival",
      "status": "completed",
      "approvedBy": "Manager A",
      "approvedAt": "2024-12-05T09:45:00Z"
    },
    {
      "id": "mov_002",
      "warehouseId": "wh_001",
      "movementType": "outbound",
      "productSku": "PROD-001",
      "productName": "Laptop Computer",
      "batchNumber": "BATCH-2024-001",
      "fromLocation": "A1-001-L1-01",
      "toLocation": null,
      "quantity": -10,
      "unitPrice": 1200.00,
      "totalValue": -12000.00,
      "timestamp": "2024-12-05T14:15:00Z",
      "employeeId": "EMP-002",
      "employeeName": "Sarah Johnson",
      "referenceNumber": "SO-2024-001",
      "reason": "Sales Order",
      "notes": "Customer shipment",
      "status": "completed",
      "approvedBy": "Manager B",
      "approvedAt": "2024-12-05T14:20:00Z"
    },
    {
      "id": "mov_003",
      "warehouseId": "wh_001",
      "movementType": "transfer",
      "productSku": "PROD-002",
      "productName": "Server Equipment",
      "batchNumber": "BATCH-2024-002",
      "fromLocation": "A1-002-L2-05",
      "toLocation": "B2-001-L1-03",
      "quantity": 5,
      "unitPrice": 2500.00,
      "totalValue": 12500.00,
      "timestamp": "2024-12-05T11:45:00Z",
      "employeeId": "EMP-003",
      "employeeName": "Mike Wilson",
      "referenceNumber": "TR-2024-001",
      "reason": "Rebalancing",
      "notes": "Moving to accessible location",
      "status": "pending",
      "approvedBy": null,
      "approvedAt": null
    },
    {
      "id": "mov_004",
      "warehouseId": "wh_001",
      "movementType": "adjustment",
      "productSku": "PROD-003",
      "productName": "Mobile Accessories",
      "batchNumber": "BATCH-2024-003",
      "fromLocation": "B2-001-L1-03",
      "toLocation": "B2-001-L1-03",
      "quantity": -2,
      "unitPrice": 50.00,
      "totalValue": -100.00,
      "timestamp": "2024-12-04T16:30:00Z",
      "employeeId": "EMP-004",
      "employeeName": "Lisa Chen",
      "referenceNumber": "ADJ-2024-001",
      "reason": "Cycle Count",
      "notes": "Found discrepancy during count",
      "status": "completed",
      "approvedBy": "Manager A",
      "approvedAt": "2024-12-04T16:35:00Z"
    },
    {
      "id": "mov_005",
      "warehouseId": "wh_002",
      "movementType": "return",
      "productSku": "PROD-004",
      "productName": "Industrial Equipment",
      "batchNumber": "BATCH-2024-004",
      "fromLocation": null,
      "toLocation": "C3-001-L3-10",
      "quantity": 3,
      "unitPrice": 3000.00,
      "totalValue": 9000.00,
      "timestamp": "2024-12-03T13:20:00Z",
      "employeeId": "EMP-005",
      "employeeName": "David Brown",
      "referenceNumber": "RET-2024-001",
      "reason": "Customer Return",
      "notes": "Defective items returned",
      "status": "completed",
      "approvedBy": "Manager C",
      "approvedAt": "2024-12-03T13:25:00Z"
    },
    {
      "id": "mov_006",
      "warehouseId": "wh_001",
      "movementType": "damage",
      "productSku": "PROD-001",
      "productName": "Laptop Computer",
      "batchNumber": "BATCH-2024-001",
      "fromLocation": "A1-001-L1-01",
      "toLocation": null,
      "quantity": -1,
      "unitPrice": 1200.00,
      "totalValue": -1200.00,
      "timestamp": "2024-12-02T10:00:00Z",
      "employeeId": "EMP-001",
      "employeeName": "John Smith",
      "referenceNumber": "DMG-2024-001",
      "reason": "Physical Damage",
      "notes": "Damaged during handling",
      "status": "completed",
      "approvedBy": "Manager A",
      "approvedAt": "2024-12-02T10:05:00Z"
    }
  ];

  List<Map<String, dynamic>> get filteredMovements {
    var filtered = stockMovements.where((movement) {
      bool matchesWarehouse = movement["warehouseId"] == selectedWarehouse;
      bool matchesType = selectedMovementType == "all" || movement["movementType"] == selectedMovementType;
      bool matchesSearch = searchQuery.isEmpty || 
          movement["productSku"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          movement["productName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          movement["referenceNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          movement["employeeName"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDateRange = true;
      if (dateRange != "all") {
        DateTime movementDate = DateTime.parse(movement["timestamp"]);
        DateTime now = DateTime.now();
        switch (dateRange) {
          case "today":
            matchesDateRange = movementDate.day == now.day && 
                             movementDate.month == now.month && 
                             movementDate.year == now.year;
            break;
          case "week":
            DateTime weekAgo = now.subtract(Duration(days: 7));
            matchesDateRange = movementDate.isAfter(weekAgo);
            break;
          case "month":
            DateTime monthAgo = now.subtract(Duration(days: 30));
            matchesDateRange = movementDate.isAfter(monthAgo);
            break;
        }
      }
      
      return matchesWarehouse && matchesType && matchesSearch && matchesDateRange;
    }).toList();

    // Sort movements
    filtered.sort((a, b) {
      switch (sortBy) {
        case "timestamp":
          return DateTime.parse(b["timestamp"]).compareTo(DateTime.parse(a["timestamp"]));
        case "productName":
          return a["productName"].toString().compareTo(b["productName"].toString());
        case "quantity":
          return (b["quantity"] as int).abs().compareTo((a["quantity"] as int).abs());
        case "value":
          return (b["totalValue"] as double).abs().compareTo((a["totalValue"] as double).abs());
        case "type":
          return a["movementType"].toString().compareTo(b["movementType"].toString());
        default:
          return 0;
      }
    });

    return filtered;
  }

  Map<String, dynamic> get selectedWarehouseData {
    return warehouses.firstWhere((warehouse) => warehouse["id"] == selectedWarehouse);
  }

  Map<String, dynamic> get movementStatistics {
    var warehouseMovements = stockMovements.where((m) => m["warehouseId"] == selectedWarehouse).toList();
    var totalInbound = warehouseMovements.where((m) => m["movementType"] == "inbound").fold(0, (sum, m) => sum + (m["quantity"] as int));
    var totalOutbound = warehouseMovements.where((m) => m["movementType"] == "outbound").fold(0, (sum, m) => sum + (m["quantity"] as int).abs());
    var totalValueIn = warehouseMovements.where((m) => (m["totalValue"] as double) > 0).fold(0.0, (sum, m) => sum + (m["totalValue"] as double));
    var totalValueOut = warehouseMovements.where((m) => (m["totalValue"] as double) < 0).fold(0.0, (sum, m) => sum + (m["totalValue"] as double).abs());
    
    return {
      "totalMovements": warehouseMovements.length,
      "inboundCount": warehouseMovements.where((m) => m["movementType"] == "inbound").length,
      "outboundCount": warehouseMovements.where((m) => m["movementType"] == "outbound").length,
      "transferCount": warehouseMovements.where((m) => m["movementType"] == "transfer").length,
      "adjustmentCount": warehouseMovements.where((m) => m["movementType"] == "adjustment").length,
      "totalInbound": totalInbound,
      "totalOutbound": totalOutbound,
      "totalValueIn": totalValueIn,
      "totalValueOut": totalValueOut,
      "pendingMovements": warehouseMovements.where((m) => m["status"] == "pending").length,
    };
  }

  Color _getMovementTypeColor(String type) {
    switch (type) {
      case "inbound":
        return successColor;
      case "outbound":
        return primaryColor;
      case "transfer":
        return infoColor;
      case "adjustment":
        return warningColor;
      case "return":
        return successColor;
      case "damage":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getMovementTypeIcon(String type) {
    switch (type) {
      case "inbound":
        return Icons.arrow_downward;
      case "outbound":
        return Icons.arrow_upward;
      case "transfer":
        return Icons.swap_horiz;
      case "adjustment":
        return Icons.tune;
      case "return":
        return Icons.keyboard_return;
      case "damage":
        return Icons.warning;
      default:
        return Icons.inventory;
    }
  }

  String _formatMovementType(String type) {
    switch (type) {
      case "inbound":
        return "Inbound";
      case "outbound":
        return "Outbound";
      case "transfer":
        return "Transfer";
      case "adjustment":
        return "Adjustment";
      case "return":
        return "Return";
      case "damage":
        return "Damage";
      default:
        return "Unknown";
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "pending":
        return warningColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showMovementDetails(Map<String, dynamic> movement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Movement Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow("Reference", "${movement["referenceNumber"]}"),
              _buildDetailRow("Type", _formatMovementType(movement["movementType"])),
              _buildDetailRow("Status", "${movement["status"]}".toUpperCase()),
              _buildDetailRow("Timestamp", "${DateTime.parse(movement["timestamp"]).dMMMy} at ${DateTime.parse(movement["timestamp"]).kkmm}"),
              Divider(),
              _buildDetailRow("Product SKU", "${movement["productSku"]}"),
              _buildDetailRow("Product Name", "${movement["productName"]}"),
              _buildDetailRow("Batch Number", "${movement["batchNumber"]}"),
              _buildDetailRow("Quantity", "${movement["quantity"]} units"),
              _buildDetailRow("Unit Price", "\$${(movement["unitPrice"] as double).currency}"),
              _buildDetailRow("Total Value", "\$${(movement["totalValue"] as double).abs().currency}"),
              Divider(),
              if (movement["fromLocation"] != null)
                _buildDetailRow("From Location", "${movement["fromLocation"]}"),
              if (movement["toLocation"] != null)
                _buildDetailRow("To Location", "${movement["toLocation"]}"),
              _buildDetailRow("Employee", "${movement["employeeName"]}"),
              _buildDetailRow("Reason", "${movement["reason"]}"),
              if (movement["notes"].toString().isNotEmpty)
                _buildDetailRow("Notes", "${movement["notes"]}"),
              if (movement["approvedBy"] != null) ...[
                Divider(),
                _buildDetailRow("Approved By", "${movement["approvedBy"]}"),
                _buildDetailRow("Approved At", "${DateTime.parse(movement["approvedAt"]).dMMMy} at ${DateTime.parse(movement["approvedAt"]).kkmm}"),
              ],
            ],
          ),
        ),
        actions: [
          if (movement["status"] == "pending")
            QButton(
              label: "Approve",
              size: bs.sm,
              onPressed: () {
                Navigator.of(context).pop();
                ss("Movement approved");
              },
            ),
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovementCard(Map<String, dynamic> movement) {
    bool isPositive = (movement["quantity"] as int) > 0;
    String locationText = "";
    
    if (movement["fromLocation"] != null && movement["toLocation"] != null) {
      locationText = "${movement["fromLocation"]} → ${movement["toLocation"]}";
    } else if (movement["fromLocation"] != null) {
      locationText = "From: ${movement["fromLocation"]}";
    } else if (movement["toLocation"] != null) {
      locationText = "To: ${movement["toLocation"]}";
    }
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getMovementTypeColor(movement["movementType"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: _getMovementTypeColor(movement["movementType"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  _getMovementTypeIcon(movement["movementType"]),
                  size: 18,
                  color: _getMovementTypeColor(movement["movementType"]),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${movement["referenceNumber"]}",
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
                            color: _getStatusColor(movement["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${movement["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(movement["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text(
                      _formatMovementType(movement["movementType"]),
                      style: TextStyle(
                        fontSize: 12,
                        color: _getMovementTypeColor(movement["movementType"]),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          // Product Info
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.inventory, size: 14, color: primaryColor),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "${movement["productName"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  "SKU: ${movement["productSku"]} • Batch: ${movement["batchNumber"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Quantity and Value
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quantity",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          isPositive ? Icons.add : Icons.remove,
                          size: 14,
                          color: isPositive ? successColor : dangerColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${(movement["quantity"] as int).abs()} units",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isPositive ? successColor : dangerColor,
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
                    Text(
                      "Total Value",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "\$${(movement["totalValue"] as double).abs().currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          if (locationText.isNotEmpty) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    locationText,
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
          
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.person, size: 14, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "${movement["employeeName"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${DateTime.parse(movement["timestamp"]).dMMMy} ${DateTime.parse(movement["timestamp"]).kkmm}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spXs),
              GestureDetector(
                onTap: () => _showMovementDetails(movement),
                child: Icon(
                  Icons.info_outline,
                  size: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var stats = movementStatistics;

    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Movement"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              ss("Add new movement");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warehouse Selection
            QDropdownField(
              label: "Select Warehouse",
              items: warehouses.map((w) => {
                "label": "${w["name"]} - ${w["location"]}",
                "value": "${w["id"]}"
              }).toList(),
              value: selectedWarehouse,
              onChanged: (value, label) {
                selectedWarehouse = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Warehouse Info Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warehouse, color: primaryColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${selectedWarehouseData["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${selectedWarehouseData["location"]}",
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
            ),
            SizedBox(height: spMd),

            // Statistics
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total Movements",
                    "${stats["totalMovements"]}",
                    Icons.swap_vert,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Inbound",
                    "${stats["inboundCount"]}",
                    Icons.arrow_downward,
                    successColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Outbound",
                    "${stats["outboundCount"]}",
                    Icons.arrow_upward,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Pending",
                    "${stats["pendingMovements"]}",
                    Icons.schedule,
                    warningColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Value In",
                    "\$${((stats["totalValueIn"] as double) / 1000).toStringAsFixed(1)}K",
                    Icons.trending_up,
                    successColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Value Out",
                    "\$${((stats["totalValueOut"] as double) / 1000).toStringAsFixed(1)}K",
                    Icons.trending_down,
                    dangerColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Units In",
                    "${stats["totalInbound"]}",
                    Icons.add_circle,
                    infoColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Units Out",
                    "${stats["totalOutbound"]}",
                    Icons.remove_circle,
                    warningColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Filters and Search
            QTextField(
              label: "Search movements...",
              value: searchQuery,
              hint: "SKU, product name, reference, or employee",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            Row(
              children: [
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
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Date Range",
                    items: [
                      {"label": "All Time", "value": "all"},
                      {"label": "Today", "value": "today"},
                      {"label": "Last 7 days", "value": "week"},
                      {"label": "Last 30 days", "value": "month"},
                    ],
                    value: dateRange,
                    onChanged: (value, label) {
                      dateRange = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Sort by",
              items: [
                {"label": "Timestamp (Latest)", "value": "timestamp"},
                {"label": "Product Name", "value": "productName"},
                {"label": "Quantity", "value": "quantity"},
                {"label": "Total Value", "value": "value"},
                {"label": "Movement Type", "value": "type"},
              ],
              value: sortBy,
              onChanged: (value, label) {
                sortBy = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    size: bs.sm,
                    onPressed: () {
                      ss("Export movement report");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Generate Summary",
                    icon: Icons.assessment,
                    size: bs.sm,
                    onPressed: () {
                      ss("Generate movement summary");
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Movement List
            Text(
              "Stock Movements (${filteredMovements.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            if (filteredMovements.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.swap_vert_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No movements found",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or add new movements",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredMovements.map((movement) => _buildMovementCard(movement)).toList(),
          ],
        ),
      ),
    );
  }
}
