import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaBarcodeView extends StatefulWidget {
  const ImaBarcodeView({super.key});

  @override
  State<ImaBarcodeView> createState() => _ImaBarcodeViewState();
}

class _ImaBarcodeViewState extends State<ImaBarcodeView> {
  bool loading = false;
  String searchQuery = "";
  String selectedFormat = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> barcodes = [
    {
      "id": "BAR001",
      "barcode": "123456789012",
      "format": "UPC-A",
      "productName": "Organic Apple Juice",
      "productId": "PROD001",
      "sku": "OAJ-001",
      "category": "Beverages",
      "status": "Active",
      "createdDate": "2024-01-15",
      "lastScanned": "2024-06-18",
      "scanCount": 145,
      "printCount": 500,
      "supplier": "Fresh Juice Co",
      "retailPrice": 4.99,
      "wholesalePrice": 3.25,
      "description": "Pure organic apple juice with no additives",
    },
    {
      "id": "BAR002",
      "barcode": "987654321098",
      "format": "EAN-13",
      "productName": "Premium Coffee Beans",
      "productId": "PROD002",
      "sku": "PCB-002",
      "category": "Coffee",
      "status": "Active",
      "createdDate": "2024-02-20",
      "lastScanned": "2024-06-17",
      "scanCount": 89,
      "printCount": 200,
      "supplier": "Mountain Coffee",
      "retailPrice": 24.99,
      "wholesalePrice": 18.50,
      "description": "Premium arabica coffee beans from Colombia",
    },
    {
      "id": "BAR003",
      "barcode": "456789123456",
      "format": "Code 128",
      "productName": "Wireless Bluetooth Headphones",
      "productId": "PROD003",
      "sku": "WBH-003",
      "category": "Electronics",
      "status": "Active",
      "createdDate": "2024-03-10",
      "lastScanned": "2024-06-19",
      "scanCount": 234,
      "printCount": 150,
      "supplier": "Tech Audio Inc",
      "retailPrice": 89.99,
      "wholesalePrice": 65.00,
      "description": "High-quality wireless headphones with noise cancellation",
    },
    {
      "id": "BAR004",
      "barcode": "789123456789",
      "format": "Code 39",
      "productName": "Organic Baby Formula",
      "productId": "PROD004",
      "sku": "OBF-004",
      "category": "Baby Care",
      "status": "Inactive",
      "createdDate": "2024-04-05",
      "lastScanned": "2024-05-20",
      "scanCount": 67,
      "printCount": 300,
      "supplier": "Baby Nutrition Co",
      "retailPrice": 29.99,
      "wholesalePrice": 22.00,
      "description": "Organic formula for infants 0-6 months",
    },
    {
      "id": "BAR005",
      "barcode": "321654987321",
      "format": "QR Code",
      "productName": "Smart Fitness Tracker",
      "productId": "PROD005",
      "sku": "SFT-005",
      "category": "Wearables",
      "status": "Active",
      "createdDate": "2024-05-12",
      "lastScanned": "2024-06-19",
      "scanCount": 178,
      "printCount": 100,
      "supplier": "FitTech Solutions",
      "retailPrice": 149.99,
      "wholesalePrice": 110.00,
      "description": "Advanced fitness tracker with heart rate monitoring",
    },
  ];

  List<Map<String, dynamic>> formatOptions = [
    {"label": "All", "value": "All"},
    {"label": "UPC-A", "value": "UPC-A"},
    {"label": "EAN-13", "value": "EAN-13"},
    {"label": "Code 128", "value": "Code 128"},
    {"label": "Code 39", "value": "Code 39"},
    {"label": "QR Code", "value": "QR Code"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Retired", "value": "Retired"},
  ];

  List<Map<String, dynamic>> get filteredBarcodes {
    var items = barcodes.where((barcode) {
      bool matchesSearch = "${barcode["barcode"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${barcode["productName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${barcode["sku"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFormat = selectedFormat == "All" || barcode["format"] == selectedFormat;
      bool matchesStatus = selectedStatus == "All" || barcode["status"] == selectedStatus;
      
      return matchesSearch && matchesFormat && matchesStatus;
    }).toList();

    // Sort by scan count (most scanned first)
    items.sort((a, b) => (b["scanCount"] as int).compareTo(a["scanCount"] as int));
    
    return items;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return disabledBoldColor;
      case "Pending":
        return warningColor;
      case "Retired":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getFormatColor(String format) {
    switch (format) {
      case "UPC-A":
        return primaryColor;
      case "EAN-13":
        return infoColor;
      case "Code 128":
        return successColor;
      case "Code 39":
        return warningColor;
      case "QR Code":
        return Colors.purple;
      default:
        return disabledBoldColor;
    }
  }

  int get totalBarcodes {
    return filteredBarcodes.length;
  }

  int get activeBarcodes {
    return filteredBarcodes.where((barcode) => barcode["status"] == "Active").length;
  }

  int get totalScans {
    return filteredBarcodes.fold(0, (sum, barcode) => sum + (barcode["scanCount"] as int));
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // Navigate to barcode scanner
            },
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              // Navigate to bulk print
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCards(),
            _buildFilters(),
            _buildBarcodeList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Generate new barcode
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                "Total Barcodes",
                "$totalBarcodes",
                Icons.qr_code,
                primaryColor,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildSummaryCard(
                "Active Barcodes",
                "$activeBarcodes",
                Icons.check_circle,
                successColor,
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          child: _buildSummaryCard(
            "Total Scans",
            "${totalScans.toString()}",
            Icons.scanner,
            infoColor,
          ),
        ),
      ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search barcodes...",
                value: searchQuery,
                hint: "Search by barcode, product name, or SKU",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Format",
                items: formatOptions,
                value: selectedFormat,
                onChanged: (value, label) {
                  selectedFormat = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
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
          ],
        ),
      ],
    );
  }

  Widget _buildBarcodeList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Barcodes (${filteredBarcodes.length})",
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
          itemCount: filteredBarcodes.length,
          itemBuilder: (context, index) {
            final barcode = filteredBarcodes[index];
            return _buildBarcodeItem(barcode);
          },
        ),
      ],
    );
  }

  Widget _buildBarcodeItem(Map<String, dynamic> barcode) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor("${barcode["status"]}"),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: disabledColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 2,
                      width: 60,
                      color: primaryColor,
                    ),
                    SizedBox(height: 2),
                    Container(
                      height: 1,
                      width: 60,
                      color: primaryColor,
                    ),
                    SizedBox(height: 2),
                    Container(
                      height: 2,
                      width: 60,
                      color: primaryColor,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${barcode["barcode"]}",
                      style: TextStyle(
                        fontSize: 8,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${barcode["productName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Barcode: ${barcode["barcode"]} | SKU: ${barcode["sku"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${barcode["status"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${barcode["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getStatusColor("${barcode["status"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getFormatColor("${barcode["format"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${barcode["format"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getFormatColor("${barcode["format"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: disabledColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Retail Price",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(barcode["retailPrice"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
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
                      "Wholesale Price",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(barcode["wholesalePrice"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
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
                      "Scan Count",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${barcode["scanCount"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Created: ${barcode["createdDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Last Scanned: ${barcode["lastScanned"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Printed: ${barcode["printCount"]} times",
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
                onPressed: () {
                  _showBarcodeActions(barcode);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showBarcodeActions(Map<String, dynamic> barcode) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Barcode Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.visibility, color: primaryColor),
              title: Text("View Details"),
              onTap: () {
                back();
                // Navigate to barcode details
              },
            ),
            ListTile(
              leading: Icon(Icons.print, color: infoColor),
              title: Text("Print Barcode"),
              onTap: () {
                back();
                _printBarcode(barcode);
              },
            ),
            ListTile(
              leading: Icon(Icons.copy, color: successColor),
              title: Text("Copy Barcode"),
              onTap: () {
                back();
                _copyBarcode(barcode);
              },
            ),
            ListTile(
              leading: Icon(Icons.edit, color: warningColor),
              title: Text("Edit Barcode"),
              onTap: () {
                back();
                _editBarcode(barcode);
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: primaryColor),
              title: Text("Scan History"),
              onTap: () {
                back();
                _viewScanHistory(barcode);
              },
            ),
            ListTile(
              leading: Icon(Icons.download, color: infoColor),
              title: Text("Export Data"),
              onTap: () {
                back();
                _exportBarcodeData(barcode);
              },
            ),
            if (barcode["status"] == "Active") ...[
              ListTile(
                leading: Icon(Icons.pause, color: warningColor),
                title: Text("Deactivate"),
                onTap: () {
                  back();
                  _deactivateBarcode(barcode);
                },
              ),
            ] else ...[
              ListTile(
                leading: Icon(Icons.play_arrow, color: successColor),
                title: Text("Activate"),
                onTap: () {
                  back();
                  _activateBarcode(barcode);
                },
              ),
            ],
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Barcode"),
              onTap: () {
                back();
                _deleteBarcode(barcode);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _printBarcode(Map<String, dynamic> barcode) {
    // Print barcode logic
    ss("Barcode ${barcode["barcode"]} sent to printer");
  }

  void _copyBarcode(Map<String, dynamic> barcode) {
    // Copy barcode to clipboard logic
    ss("Barcode ${barcode["barcode"]} copied to clipboard");
  }

  void _editBarcode(Map<String, dynamic> barcode) {
    // Edit barcode logic
    ss("Barcode updated successfully");
  }

  void _viewScanHistory(Map<String, dynamic> barcode) {
    // View scan history logic
  }

  void _exportBarcodeData(Map<String, dynamic> barcode) {
    // Export barcode data logic
    ss("Barcode data exported successfully");
  }

  void _deactivateBarcode(Map<String, dynamic> barcode) async {
    bool isConfirmed = await confirm("Deactivate this barcode?");
    if (isConfirmed) {
      // Deactivate barcode logic
      ss("Barcode deactivated successfully");
    }
  }

  void _activateBarcode(Map<String, dynamic> barcode) {
    // Activate barcode logic
    ss("Barcode activated successfully");
  }

  void _deleteBarcode(Map<String, dynamic> barcode) async {
    bool isConfirmed = await confirm("Delete this barcode? This action cannot be undone.");
    if (isConfirmed) {
      // Delete barcode logic
      ss("Barcode deleted successfully");
    }
  }
}
