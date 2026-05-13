import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaInventoryTrackingView extends StatefulWidget {
  const ComaInventoryTrackingView({super.key});

  @override
  State<ComaInventoryTrackingView> createState() => _ComaInventoryTrackingViewState();
}

class _ComaInventoryTrackingViewState extends State<ComaInventoryTrackingView> {
  String searchQuery = "";
  String selectedLocation = "All";
  String selectedMovementType = "All";
  DateTime? fromDate;
  DateTime? toDate;

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All", "value": "All"},
    {"label": "Warehouse A-1", "value": "Warehouse A-1"},
    {"label": "Warehouse B-2", "value": "Warehouse B-2"},
    {"label": "Yard C-1", "value": "Yard C-1"},
    {"label": "Shed D-1", "value": "Shed D-1"},
    {"label": "Storage E-1", "value": "Storage E-1"},
  ];

  List<Map<String, dynamic>> movementTypeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Stock In", "value": "Stock In"},
    {"label": "Stock Out", "value": "Stock Out"},
    {"label": "Transfer", "value": "Transfer"},
    {"label": "Adjustment", "value": "Adjustment"},
    {"label": "Return", "value": "Return"},
  ];

  List<Map<String, dynamic>> movements = [
    {
      "id": "MOV001",
      "date": "2024-06-18T14:30:00",
      "materialId": "MAT001",
      "materialName": "Portland Cement",
      "movementType": "Stock In",
      "quantity": 50,
      "unit": "bags",
      "fromLocation": "Delivery Dock",
      "toLocation": "Warehouse A-1",
      "reference": "PO-2024-001",
      "performedBy": "John Smith",
      "notes": "Delivery from BuildMart Supply",
      "batchNumber": "BAT001",
      "expiryDate": "2024-12-15",
      "unitCost": 12.50,
      "totalCost": 625.00,
      "image": "https://picsum.photos/120/120?random=21&keyword=cement"
    },
    {
      "id": "MOV002",
      "date": "2024-06-18T10:15:00",
      "materialId": "MAT005",
      "materialName": "Pine Timber",
      "movementType": "Stock Out",
      "quantity": 3,
      "unit": "cubic meters",
      "fromLocation": "Shed E-1",
      "toLocation": "Construction Site A",
      "reference": "REQ-2024-015",
      "performedBy": "Mike Johnson",
      "notes": "Material requisition for Foundation Project",
      "batchNumber": null,
      "expiryDate": null,
      "unitCost": 180.00,
      "totalCost": 540.00,
      "image": "https://picsum.photos/120/120?random=22&keyword=wood"
    },
    {
      "id": "MOV003",
      "date": "2024-06-17T16:45:00",
      "materialId": "MAT002",
      "materialName": "Steel Reinforcement Bar",
      "movementType": "Transfer",
      "quantity": 0.5,
      "unit": "tons",
      "fromLocation": "Yard B-2",
      "toLocation": "Yard C-1",
      "reference": "TRF-2024-008",
      "performedBy": "Sarah Wilson",
      "notes": "Relocation for easier access",
      "batchNumber": "STL-2024-06",
      "expiryDate": null,
      "unitCost": 650.00,
      "totalCost": 325.00,
      "image": "https://picsum.photos/120/120?random=23&keyword=steel"
    },
    {
      "id": "MOV004",
      "date": "2024-06-17T09:20:00",
      "materialId": "MAT003",
      "materialName": "River Sand",
      "movementType": "Stock In",
      "quantity": 15,
      "unit": "cubic meters",
      "fromLocation": "Delivery Dock",
      "toLocation": "Yard C-1",
      "reference": "PO-2024-003",
      "performedBy": "David Brown",
      "notes": "Fresh sand delivery",
      "batchNumber": "SND-2024-12",
      "expiryDate": null,
      "unitCost": 25.00,
      "totalCost": 375.00,
      "image": "https://picsum.photos/120/120?random=24&keyword=sand"
    },
    {
      "id": "MOV005",
      "date": "2024-06-16T13:30:00",
      "materialId": "MAT006",
      "materialName": "Exterior Paint",
      "movementType": "Adjustment",
      "quantity": -2,
      "unit": "liters",
      "fromLocation": "Warehouse F-1",
      "toLocation": "Warehouse F-1",
      "reference": "ADJ-2024-003",
      "performedBy": "Lisa Anderson",
      "notes": "Stock count adjustment - damaged containers",
      "batchNumber": "PNT-2024-05",
      "expiryDate": "2025-03-20",
      "unitCost": 45.00,
      "totalCost": -90.00,
      "image": "https://picsum.photos/120/120?random=25&keyword=paint"
    },
    {
      "id": "MOV006",
      "date": "2024-06-15T11:00:00",
      "materialId": "MAT004",
      "materialName": "Red Clay Bricks",
      "movementType": "Stock Out",
      "quantity": 1000,
      "unit": "pieces",
      "fromLocation": "Warehouse D-1",
      "toLocation": "Construction Site B",
      "reference": "REQ-2024-012",
      "performedBy": "Tom Wilson",
      "notes": "Bricks for wall construction",
      "batchNumber": "BRK-2024-03",
      "expiryDate": null,
      "unitCost": 0.35,
      "totalCost": 350.00,
      "image": "https://picsum.photos/120/120?random=26&keyword=bricks"
    },
    {
      "id": "MOV007",
      "date": "2024-06-14T15:20:00",
      "materialId": "MAT001",
      "materialName": "Portland Cement",
      "movementType": "Return",
      "quantity": 5,
      "unit": "bags",
      "fromLocation": "Construction Site A",
      "toLocation": "Warehouse A-1",
      "reference": "RET-2024-001",
      "performedBy": "John Smith",
      "notes": "Excess cement returned from project",
      "batchNumber": "BAT001",
      "expiryDate": "2024-12-15",
      "unitCost": 12.50,
      "totalCost": 62.50,
      "image": "https://picsum.photos/120/120?random=27&keyword=cement"
    },
  ];

  List<Map<String, dynamic>> get filteredMovements {
    return movements.where((movement) {
      bool matchesSearch = searchQuery.isEmpty ||
          (movement["materialName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (movement["materialId"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (movement["reference"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesLocation = selectedLocation == "All" ||
          movement["fromLocation"] == selectedLocation ||
          movement["toLocation"] == selectedLocation;

      bool matchesMovementType = selectedMovementType == "All" || 
          movement["movementType"] == selectedMovementType;

      DateTime movementDate = DateTime.parse(movement["date"] as String);
      bool matchesDateRange = true;
      if (fromDate != null && toDate != null) {
        matchesDateRange = movementDate.isAfter(fromDate!) && 
                          movementDate.isBefore(toDate!.add(Duration(days: 1)));
      }

      return matchesSearch && matchesLocation && matchesMovementType && matchesDateRange;
    }).toList()..sort((a, b) => 
        DateTime.parse(b["date"] as String).compareTo(DateTime.parse(a["date"] as String)));
  }

  Color _getMovementTypeColor(String movementType) {
    switch (movementType) {
      case "Stock In":
      case "Return":
        return successColor;
      case "Stock Out":
        return warningColor;
      case "Transfer":
        return infoColor;
      case "Adjustment":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  IconData _getMovementTypeIcon(String movementType) {
    switch (movementType) {
      case "Stock In":
        return Icons.arrow_downward;
      case "Stock Out":
        return Icons.arrow_upward;
      case "Transfer":
        return Icons.swap_horiz;
      case "Adjustment":
        return Icons.tune;
      case "Return":
        return Icons.undo;
      default:
        return Icons.inventory;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _exportReport();
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search movements...",
              value: searchQuery,
              hint: "Enter material name, ID, or reference",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Total Movements",
                    "${movements.length}",
                    Icons.trending_up,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Today",
                    "${movements.where((m) => DateTime.parse(m["date"] as String).day == DateTime.now().day).length}",
                    Icons.today,
                    infoColor,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Stock In",
                    "${movements.where((m) => m["movementType"] == "Stock In").length}",
                    Icons.arrow_downward,
                    successColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Stock Out",
                    "${movements.where((m) => m["movementType"] == "Stock Out").length}",
                    Icons.arrow_upward,
                    warningColor,
                  ),
                ),
              ],
            ),

            // Quick Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: spSm,
                children: [
                  _buildQuickFilter("All", selectedMovementType == "All"),
                  _buildQuickFilter("Stock In", selectedMovementType == "Stock In"),
                  _buildQuickFilter("Stock Out", selectedMovementType == "Stock Out"),
                  _buildQuickFilter("Transfer", selectedMovementType == "Transfer"),
                  _buildQuickFilter("Adjustment", selectedMovementType == "Adjustment"),
                ],
              ),
            ),

            // Date Range Filter
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QDatePicker(
                      label: "From Date",
                      value: fromDate,
                      onChanged: (value) {
                        fromDate = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDatePicker(
                      label: "To Date",
                      value: toDate,
                      onChanged: (value) {
                        toDate = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Movements List
            Column(
              spacing: spSm,
              children: filteredMovements.map((movement) {
                return _buildMovementCard(movement);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
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
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        selectedMovementType = label == "All" ? "All" : label;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isActive ? primaryColor : disabledOutlineBorderColor,
          ),
          boxShadow: [shadowSm],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : disabledBoldColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildMovementCard(Map<String, dynamic> movement) {
    Color movementColor = _getMovementTypeColor(movement["movementType"] as String);
    IconData movementIcon = _getMovementTypeIcon(movement["movementType"] as String);
    DateTime movementDate = DateTime.parse(movement["date"] as String);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: movementColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: movementColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  movementIcon,
                  color: movementColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${movement["materialName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${movement["materialId"]} • ${movement["reference"]}",
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
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: movementColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${movement["movementType"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: movementColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${movementDate.dMMMykkss}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Movement Details
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.inventory_2,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Quantity: ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${movement["quantity"]} ${movement["unit"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(movement["totalCost"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: (movement["totalCost"] as double) >= 0 ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "From: ${movement["fromLocation"]} → To: ${movement["toLocation"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if (movement["batchNumber"] != null)
                  Row(
                    children: [
                      Icon(
                        Icons.batch_prediction,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Batch: ${movement["batchNumber"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (movement["expiryDate"] != null) ...[
                        SizedBox(width: spSm),
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Expires: ${DateTime.parse(movement["expiryDate"] as String).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ],
                  ),
              ],
            ),
          ),

          // Performed By & Notes
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Performed by ${movement["performedBy"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          if (movement["notes"] != null && (movement["notes"] as String).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${movement["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

          // Action Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Details",
              size: bs.sm,
              onPressed: () {
                //navigateTo('movement_details')
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Filter Movements"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Location",
                items: locationOptions,
                value: selectedLocation,
                onChanged: (value, label) {
                  selectedLocation = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Movement Type",
                items: movementTypeOptions,
                value: selectedMovementType,
                onChanged: (value, label) {
                  selectedMovementType = value;
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                selectedLocation = "All";
                selectedMovementType = "All";
                fromDate = null;
                toDate = null;
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Clear"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Apply"),
            ),
          ],
        );
      },
    );
  }

  void _exportReport() {
    ss("Inventory movement report exported successfully");
  }
}
