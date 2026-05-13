import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaGoodsReceiptView extends StatefulWidget {
  const ImaGoodsReceiptView({super.key});

  @override
  State<ImaGoodsReceiptView> createState() => _ImaGoodsReceiptViewState();
}

class _ImaGoodsReceiptViewState extends State<ImaGoodsReceiptView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  String sortBy = "receipt_date";
  
  List<Map<String, dynamic>> goodsReceipts = [
    {
      "id": "GRN-2024-001",
      "receipt_number": "REC-001",
      "po_number": "PO-2024-045",
      "supplier": "Tech Solutions Inc",
      "receipt_date": "2024-01-15",
      "received_by": "John Smith",
      "status": "completed",
      "type": "standard",
      "total_items": 25,
      "total_value": 15750.00,
      "warehouse": "Main Warehouse",
      "location": "Zone A-1",
      "items": [
        {
          "item_code": "TH001",
          "name": "Wireless Headphones",
          "expected_qty": 10,
          "received_qty": 10,
          "unit_price": 125.00,
          "total_price": 1250.00,
          "condition": "good",
          "batch_number": "BT001",
          "expiry_date": null,
        },
        {
          "item_code": "BS002",
          "name": "Bluetooth Speakers",
          "expected_qty": 15,
          "received_qty": 15,
          "unit_price": 300.00,
          "total_price": 4500.00,
          "condition": "good",
          "batch_number": "BT002",
          "expiry_date": null,
        },
      ],
      "notes": "All items received in perfect condition",
      "quality_check": "passed",
      "inspector": "Mike Johnson",
      "inspection_date": "2024-01-15",
      "documents": ["Invoice", "Packing List", "Quality Certificate"],
    },
    {
      "id": "GRN-2024-002",
      "receipt_number": "REC-002",
      "po_number": "PO-2024-042",
      "supplier": "Office Supplies Co",
      "receipt_date": "2024-01-14",
      "received_by": "Sarah Wilson",
      "status": "partial",
      "type": "urgent",
      "total_items": 35,
      "total_value": 5950.00,
      "warehouse": "Main Warehouse",
      "location": "Zone B-2",
      "items": [
        {
          "item_code": "OC003",
          "name": "Office Chairs",
          "expected_qty": 20,
          "received_qty": 20,
          "unit_price": 150.00,
          "total_price": 3000.00,
          "condition": "good",
          "batch_number": "BT003",
          "expiry_date": null,
        },
        {
          "item_code": "DL004",
          "name": "Desk Lamps",
          "expected_qty": 30,
          "received_qty": 15,
          "unit_price": 65.00,
          "total_price": 975.00,
          "condition": "damaged",
          "batch_number": "BT004",
          "expiry_date": null,
        },
      ],
      "notes": "15 desk lamps damaged during transit",
      "quality_check": "failed",
      "inspector": "Lisa Brown",
      "inspection_date": "2024-01-14",
      "documents": ["Invoice", "Damage Report"],
    },
    {
      "id": "GRN-2024-003",
      "receipt_number": "REC-003",
      "po_number": "PO-2024-040",
      "supplier": "Electronics World",
      "receipt_date": "2024-01-13",
      "received_by": "David Lee",
      "status": "completed",
      "type": "standard",
      "total_items": 100,
      "total_value": 25000.00,
      "warehouse": "Tech Warehouse",
      "location": "Zone C-1",
      "items": [
        {
          "item_code": "LP005",
          "name": "Laptops",
          "expected_qty": 30,
          "received_qty": 30,
          "unit_price": 550.00,
          "total_price": 16500.00,
          "condition": "excellent",
          "batch_number": "BT005",
          "expiry_date": null,
        },
        {
          "item_code": "MN006",
          "name": "Monitors",
          "expected_qty": 40,
          "received_qty": 40,
          "unit_price": 180.00,
          "total_price": 7200.00,
          "condition": "good",
          "batch_number": "BT006",
          "expiry_date": null,
        },
      ],
      "notes": "All electronics tested and working properly",
      "quality_check": "passed",
      "inspector": "Tom Wilson",
      "inspection_date": "2024-01-13",
      "documents": ["Invoice", "Test Certificates", "Warranty Cards"],
    },
    {
      "id": "GRN-2024-004",
      "receipt_number": "REC-004",
      "po_number": "PO-2024-038",
      "supplier": "Medical Supplies Ltd",
      "receipt_date": "2024-01-12",
      "received_by": "Emma Davis",
      "status": "pending",
      "type": "urgent",
      "total_items": 50,
      "total_value": 8000.00,
      "warehouse": "Medical Warehouse",
      "location": "Zone D-1",
      "items": [
        {
          "item_code": "FK007",
          "name": "First Aid Kits",
          "expected_qty": 25,
          "received_qty": 25,
          "unit_price": 80.00,
          "total_price": 2000.00,
          "condition": "good",
          "batch_number": "BT007",
          "expiry_date": "2026-01-12",
        },
        {
          "item_code": "SE008",
          "name": "Safety Equipment",
          "expected_qty": 25,
          "received_qty": 25,
          "unit_price": 240.00,
          "total_price": 6000.00,
          "condition": "good",
          "batch_number": "BT008",
          "expiry_date": "2027-01-12",
        },
      ],
      "notes": "Medical supplies require special storage conditions",
      "quality_check": "pending",
      "inspector": "Dr. Smith",
      "inspection_date": null,
      "documents": ["Invoice", "Medical Certificates"],
    },
    {
      "id": "GRN-2024-005",
      "receipt_number": "REC-005",
      "po_number": "PO-2024-050",
      "supplier": "Furniture Plus",
      "receipt_date": "2024-01-16",
      "received_by": "Mark Anderson",
      "status": "completed",
      "type": "bulk",
      "total_items": 40,
      "total_value": 18000.00,
      "warehouse": "Furniture Warehouse",
      "location": "Zone E-1",
      "items": [
        {
          "item_code": "CT009",
          "name": "Conference Tables",
          "expected_qty": 5,
          "received_qty": 5,
          "unit_price": 800.00,
          "total_price": 4000.00,
          "condition": "excellent",
          "batch_number": "BT009",
          "expiry_date": null,
        },
        {
          "item_code": "EC010",
          "name": "Executive Chairs",
          "expected_qty": 15,
          "received_qty": 15,
          "unit_price": 320.00,
          "total_price": 4800.00,
          "condition": "good",
          "batch_number": "BT010",
          "expiry_date": null,
        },
      ],
      "notes": "Large furniture items properly assembled",
      "quality_check": "passed",
      "inspector": "Robert Jones",
      "inspection_date": "2024-01-16",
      "documents": ["Invoice", "Assembly Instructions", "Warranty"],
    },
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Completed", "value": "completed"},
    {"label": "Partial", "value": "partial"},
    {"label": "Pending", "value": "pending"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": "all"},
    {"label": "Standard", "value": "standard"},
    {"label": "Urgent", "value": "urgent"},
    {"label": "Bulk", "value": "bulk"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Receipt Date", "value": "receipt_date"},
    {"label": "GRN Number", "value": "id"},
    {"label": "Supplier", "value": "supplier"},
    {"label": "Total Value", "value": "total_value"},
    {"label": "Status", "value": "status"},
  ];

  List<Map<String, dynamic>> get filteredGoodsReceipts {
    var items = goodsReceipts.where((item) {
      bool matchesSearch = item["supplier"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["po_number"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["receipt_number"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || item["status"] == selectedStatus;
      bool matchesType = selectedType == "all" || item["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();

    items.sort((a, b) {
      switch (sortBy) {
        case "receipt_date":
          return b["receipt_date"].compareTo(a["receipt_date"]);
        case "id":
          return a["id"].compareTo(b["id"]);
        case "supplier":
          return a["supplier"].compareTo(b["supplier"]);
        case "total_value":
          return (b["total_value"] as double).compareTo(a["total_value"] as double);
        case "status":
          return a["status"].compareTo(b["status"]);
        default:
          return 0;
      }
    });

    return items;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "partial":
        return warningColor;
      case "pending":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "urgent":
        return dangerColor;
      case "bulk":
        return infoColor;
      case "standard":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  Color _getQualityColor(String qualityCheck) {
    switch (qualityCheck) {
      case "passed":
        return successColor;
      case "failed":
        return dangerColor;
      case "pending":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Color _getConditionColor(String condition) {
    switch (condition) {
      case "excellent":
        return successColor;
      case "good":
        return infoColor;
      case "damaged":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  void _showReceiptDetails(Map<String, dynamic> receipt) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${receipt["id"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Receipt: ${receipt["receipt_number"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(receipt["status"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: _getStatusColor(receipt["status"]),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      "${receipt["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(receipt["status"]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Receipt Information
                    Text(
                      "Receipt Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    _buildInfoRow("PO Number", "${receipt["po_number"]}"),
                    _buildInfoRow("Supplier", "${receipt["supplier"]}"),
                    _buildInfoRow("Receipt Date", "${receipt["receipt_date"]}"),
                    _buildInfoRow("Received By", "${receipt["received_by"]}"),
                    _buildInfoRow("Warehouse", "${receipt["warehouse"]}"),
                    _buildInfoRow("Location", "${receipt["location"]}"),
                    _buildInfoRow("Total Items", "${receipt["total_items"]}"),
                    _buildInfoRow("Total Value", "\$${(receipt["total_value"] as double).currency}"),
                    _buildInfoRow("Type", "${receipt["type"]}".toUpperCase()),
                    
                    // Quality Information
                    SizedBox(height: spMd),
                    Text(
                      "Quality Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    _buildInfoRow("Quality Check", "${receipt["quality_check"]}".toUpperCase()),
                    _buildInfoRow("Inspector", "${receipt["inspector"]}"),
                    if (receipt["inspection_date"] != null)
                      _buildInfoRow("Inspection Date", "${receipt["inspection_date"]}"),
                    
                    // Documents
                    SizedBox(height: spMd),
                    Text(
                      "Documents",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (receipt["documents"] as List).map((doc) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: infoColor,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "$doc",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                    // Items Details
                    SizedBox(height: spMd),
                    Text(
                      "Items Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    ...(receipt["items"] as List).map((item) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
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
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "Code: ${item["item_code"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getConditionColor(item["condition"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["condition"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getConditionColor(item["condition"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
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
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${item["received_qty"]}/${item["expected_qty"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Unit Price",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(item["unit_price"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(item["total_price"] as double).currency}",
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
                            
                            SizedBox(height: spSm),
                            
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Batch: ${item["batch_number"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                if (item["expiry_date"] != null)
                                  Expanded(
                                    child: Text(
                                      "Expiry: ${item["expiry_date"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: warningColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    
                    if (receipt["notes"] != null && receipt["notes"].toString().isNotEmpty) ...[
                      SizedBox(height: spMd),
                      Text(
                        "Notes",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "${receipt["notes"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Print Receipt",
                      size: bs.md,
                      onPressed: () {
                        back();
                        _printReceipt(receipt);
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Export PDF",
                      size: bs.md,
                      onPressed: () {
                        back();
                        _exportPDF(receipt);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _printReceipt(Map<String, dynamic> receipt) {
    si("Printing receipt for ${receipt["id"]}");
  }

  void _exportPDF(Map<String, dynamic> receipt) {
    si("Exporting PDF for ${receipt["id"]}");
  }

  void _generateReport() {
    si("Generating goods receipt report");
  }

  void _bulkExport() {
    si("Bulk export selected");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Goods Receipt"),
        actions: [
          IconButton(
            icon: Icon(Icons.assessment),
            onPressed: _generateReport,
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _bulkExport,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
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
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.receipt,
                              color: primaryColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Receipts",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${goodsReceipts.length}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Completed",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${goodsReceipts.where((item) => item["status"] == "completed").length}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.verified,
                              color: successColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Quality Passed",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${goodsReceipts.where((item) => item["quality_check"] == "passed").length}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.monetization_on,
                              color: infoColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Value",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((goodsReceipts.fold(0.0, (sum, item) => sum + (item["total_value"] as double)))).currency}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search receipts...",
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
                    label: "Status",
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
                    label: "Type",
                    items: typeItems,
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortItems,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Receipts List
            Text(
              "Goods Receipts (${filteredGoodsReceipts.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            ...filteredGoodsReceipts.map((receipt) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(radiusMd),
                    onTap: () => _showReceiptDetails(receipt),
                    child: Padding(
                      padding: EdgeInsets.all(spMd),
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
                                      "${receipt["id"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "Receipt: ${receipt["receipt_number"]}",
                                      style: TextStyle(
                                        fontSize: 14,
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(receipt["status"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      border: Border.all(
                                        color: _getStatusColor(receipt["status"]),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      "${receipt["status"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor(receipt["status"]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getTypeColor(receipt["type"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${receipt["type"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: _getTypeColor(receipt["type"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Icon(
                                Icons.business,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${receipt["supplier"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Text(
                                "\$${(receipt["total_value"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${receipt["receipt_date"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.person,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${receipt["received_by"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.inventory,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${receipt["total_items"]} items",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getQualityColor(receipt["quality_check"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      receipt["quality_check"] == "passed" ? Icons.verified :
                                      receipt["quality_check"] == "failed" ? Icons.error :
                                      Icons.pending,
                                      size: 14,
                                      color: _getQualityColor(receipt["quality_check"]),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "QC: ${receipt["quality_check"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: _getQualityColor(receipt["quality_check"]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            
            if (filteredGoodsReceipts.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No goods receipts found",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
