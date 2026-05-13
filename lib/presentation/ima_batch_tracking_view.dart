import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaBatchTrackingView extends StatefulWidget {
  const ImaBatchTrackingView({super.key});

  @override
  State<ImaBatchTrackingView> createState() => _ImaBatchTrackingViewState();
}

class _ImaBatchTrackingViewState extends State<ImaBatchTrackingView> {
  bool loading = false;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedProduct = "All";
  
  List<Map<String, dynamic>> batches = [
    {
      "id": "BATCH001",
      "batchNumber": "BT2024001",
      "productName": "Antibiotics Pack",
      "productId": "PROD001",
      "quantity": 500,
      "receivedQuantity": 500,
      "soldQuantity": 200,
      "remainingQuantity": 250,
      "damagedQuantity": 50,
      "manufactureDate": "2024-01-15",
      "expiryDate": "2026-01-15",
      "receivedDate": "2024-02-01",
      "supplier": "PharmaCorp",
      "purchasePrice": 12.50,
      "sellingPrice": 25.00,
      "status": "Active",
      "location": "A-01-15",
      "qualityCheck": "Passed",
      "notes": "Premium quality batch",
    },
    {
      "id": "BATCH002",
      "batchNumber": "BT2024002",
      "productName": "Organic Milk",
      "productId": "PROD002",
      "quantity": 100,
      "receivedQuantity": 100,
      "soldQuantity": 80,
      "remainingQuantity": 15,
      "damagedQuantity": 5,
      "manufactureDate": "2024-06-01",
      "expiryDate": "2024-06-25",
      "receivedDate": "2024-06-05",
      "supplier": "Fresh Farms",
      "purchasePrice": 3.00,
      "sellingPrice": 4.50,
      "status": "Expiring Soon",
      "location": "B-02-08",
      "qualityCheck": "Passed",
      "notes": "Short shelf life",
    },
    {
      "id": "BATCH003",
      "batchNumber": "BT2024003",
      "productName": "Canned Tomatoes",
      "productId": "PROD003",
      "quantity": 200,
      "receivedQuantity": 200,
      "soldQuantity": 150,
      "remainingQuantity": 50,
      "damagedQuantity": 0,
      "manufactureDate": "2024-03-01",
      "expiryDate": "2026-03-01",
      "receivedDate": "2024-03-15",
      "supplier": "Food Industries",
      "purchasePrice": 1.50,
      "sellingPrice": 2.25,
      "status": "Active",
      "location": "C-03-22",
      "qualityCheck": "Passed",
      "notes": "High demand product",
    },
    {
      "id": "BATCH004",
      "batchNumber": "BT2024004",
      "productName": "Vitamin Supplements",
      "productId": "PROD004",
      "quantity": 300,
      "receivedQuantity": 300,
      "soldQuantity": 275,
      "remainingQuantity": 0,
      "damagedQuantity": 25,
      "manufactureDate": "2023-12-01",
      "expiryDate": "2024-06-20",
      "receivedDate": "2024-01-10",
      "supplier": "HealthCorp",
      "purchasePrice": 10.00,
      "sellingPrice": 15.75,
      "status": "Sold Out",
      "location": "D-01-05",
      "qualityCheck": "Passed",
      "notes": "Popular supplement",
    },
    {
      "id": "BATCH005",
      "batchNumber": "BT2024005",
      "productName": "Fresh Bread",
      "productId": "PROD005",
      "quantity": 50,
      "receivedQuantity": 50,
      "soldQuantity": 40,
      "remainingQuantity": 0,
      "damagedQuantity": 10,
      "manufactureDate": "2024-06-19",
      "expiryDate": "2024-06-22",
      "receivedDate": "2024-06-19",
      "supplier": "Local Bakery",
      "purchasePrice": 2.00,
      "sellingPrice": 3.00,
      "status": "Critical",
      "location": "E-01-12",
      "qualityCheck": "Passed",
      "notes": "Daily fresh delivery",
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Expiring Soon", "value": "Expiring Soon"},
    {"label": "Critical", "value": "Critical"},
    {"label": "Sold Out", "value": "Sold Out"},
    {"label": "Expired", "value": "Expired"},
  ];

  List<Map<String, dynamic>> productOptions = [
    {"label": "All", "value": "All"},
    {"label": "Antibiotics Pack", "value": "PROD001"},
    {"label": "Organic Milk", "value": "PROD002"},
    {"label": "Canned Tomatoes", "value": "PROD003"},
    {"label": "Vitamin Supplements", "value": "PROD004"},
    {"label": "Fresh Bread", "value": "PROD005"},
  ];

  List<Map<String, dynamic>> get filteredBatches {
    var items = batches.where((batch) {
      bool matchesSearch = "${batch["batchNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${batch["productName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${batch["supplier"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || batch["status"] == selectedStatus;
      bool matchesProduct = selectedProduct == "All" || batch["productId"] == selectedProduct;
      
      return matchesSearch && matchesStatus && matchesProduct;
    }).toList();

    // Sort by received date (newest first)
    items.sort((a, b) => "${b["receivedDate"]}".compareTo("${a["receivedDate"]}"));
    
    return items;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Expiring Soon":
        return warningColor;
      case "Critical":
        return dangerColor;
      case "Sold Out":
        return disabledBoldColor;
      case "Expired":
        return Colors.red.shade700;
      default:
        return primaryColor;
    }
  }

  int get totalBatches {
    return filteredBatches.length;
  }

  int get activeBatches {
    return filteredBatches.where((batch) => batch["status"] == "Active").length;
  }

  double get totalInventoryValue {
    return filteredBatches.fold(0.0, (sum, batch) => 
      sum + ((batch["remainingQuantity"] as int) * (batch["sellingPrice"] as double)));
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
        title: Text("Batch Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // Navigate to batch scanner
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to batch analytics
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
            _buildBatchList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new batch
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
                "Total Batches",
                "$totalBatches",
                Icons.inventory_2,
                primaryColor,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildSummaryCard(
                "Active Batches",
                "$activeBatches",
                Icons.check_circle,
                successColor,
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          child: _buildSummaryCard(
            "Total Inventory Value",
            "\$${totalInventoryValue.currency}",
            Icons.attach_money,
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
                label: "Search batches...",
                value: searchQuery,
                hint: "Search by batch number, product, or supplier",
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
                label: "Product",
                items: productOptions,
                value: selectedProduct,
                onChanged: (value, label) {
                  selectedProduct = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBatchList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Batch Records (${filteredBatches.length})",
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
          itemCount: filteredBatches.length,
          itemBuilder: (context, index) {
            final batch = filteredBatches[index];
            return _buildBatchItem(batch);
          },
        ),
      ],
    );
  }

  Widget _buildBatchItem(Map<String, dynamic> batch) {
    double soldPercentage = (batch["soldQuantity"] as int) / (batch["receivedQuantity"] as int) * 100;
    double inventoryValue = (batch["remainingQuantity"] as int) * (batch["sellingPrice"] as double);

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
            color: _getStatusColor("${batch["status"]}"),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _getStatusColor("${batch["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.inventory_2,
                  color: _getStatusColor("${batch["status"]}"),
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Batch: ${batch["batchNumber"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${batch["productName"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                            color: _getStatusColor("${batch["status"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${batch["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getStatusColor("${batch["status"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${batch["qualityCheck"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w500,
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
                      "Received",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${batch["receivedQuantity"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
                      "Sold",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${batch["soldQuantity"]} (${soldPercentage.toStringAsFixed(1)}%)",
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
                      "Remaining",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${batch["remainingQuantity"]}",
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
                      "Manufacture Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${batch["manufactureDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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
                      "Expiry Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${batch["expiryDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
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
                      "Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${inventoryValue.currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location: ${batch["location"]} | Supplier: ${batch["supplier"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (batch["notes"] != null && "${batch["notes"]}".isNotEmpty) ...[
                      SizedBox(height: spXs),
                      Text(
                        "Notes: ${batch["notes"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showBatchActions(batch);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showBatchActions(Map<String, dynamic> batch) {
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
              "Batch Actions",
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
                // Navigate to batch details
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: infoColor),
              title: Text("View History"),
              onTap: () {
                back();
                _viewBatchHistory(batch);
              },
            ),
            ListTile(
              leading: Icon(Icons.edit, color: warningColor),
              title: Text("Update Batch"),
              onTap: () {
                back();
                _updateBatch(batch);
              },
            ),
            ListTile(
              leading: Icon(Icons.qr_code, color: successColor),
              title: Text("Generate QR Code"),
              onTap: () {
                back();
                _generateQRCode(batch);
              },
            ),
            ListTile(
              leading: Icon(Icons.archive, color: disabledBoldColor),
              title: Text("Archive Batch"),
              onTap: () {
                back();
                _archiveBatch(batch);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _viewBatchHistory(Map<String, dynamic> batch) {
    // View batch history logic
  }

  void _updateBatch(Map<String, dynamic> batch) {
    // Update batch logic
    ss("Batch updated successfully");
  }

  void _generateQRCode(Map<String, dynamic> batch) {
    // Generate QR code logic
    ss("QR code generated for batch ${batch["batchNumber"]}");
  }

  void _archiveBatch(Map<String, dynamic> batch) async {
    bool isConfirmed = await confirm("Archive this batch?");
    if (isConfirmed) {
      // Archive batch logic
      ss("Batch archived successfully");
    }
  }
}
