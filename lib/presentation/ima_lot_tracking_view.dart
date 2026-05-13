import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaLotTrackingView extends StatefulWidget {
  const ImaLotTrackingView({super.key});

  @override
  State<ImaLotTrackingView> createState() => _ImaLotTrackingViewState();
}

class _ImaLotTrackingViewState extends State<ImaLotTrackingView> {
  bool loading = false;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedProduct = "All";
  
  List<Map<String, dynamic>> lots = [
    {
      "id": "LOT001",
      "lotNumber": "LOT2024001",
      "productName": "Organic Wheat Flour",
      "productId": "PROD001",
      "category": "Food",
      "totalQuantity": 1000,
      "availableQuantity": 450,
      "reservedQuantity": 200,
      "soldQuantity": 350,
      "harvestDate": "2024-01-15",
      "productionDate": "2024-01-20",
      "expiryDate": "2025-01-20",
      "batchCode": "WF-2024-001",
      "supplierLot": "SUP-LOT-001",
      "supplier": "Organic Farms Co",
      "status": "Active",
      "qualityGrade": "Grade A",
      "certifications": ["Organic", "Non-GMO"],
      "storageLocation": "Warehouse-A1",
      "unitCost": 2.50,
      "testResults": {
        "moisture": 12.5,
        "protein": 14.2,
        "contamination": "None",
        "pesticides": "Below Limit"
      },
    },
    {
      "id": "LOT002",
      "lotNumber": "LOT2024002",
      "productName": "Free Range Eggs",
      "productId": "PROD002",
      "category": "Dairy",
      "totalQuantity": 500,
      "availableQuantity": 120,
      "reservedQuantity": 80,
      "soldQuantity": 300,
      "harvestDate": "2024-06-15",
      "productionDate": "2024-06-15",
      "expiryDate": "2024-06-29",
      "batchCode": "EGG-2024-002",
      "supplierLot": "SUP-LOT-002",
      "supplier": "Happy Hens Farm",
      "status": "Expiring Soon",
      "qualityGrade": "Grade AA",
      "certifications": ["Free Range", "Organic"],
      "storageLocation": "Cold Storage-B1",
      "unitCost": 0.75,
      "testResults": {
        "freshness": "Excellent",
        "salmonella": "Negative",
        "contamination": "None",
        "crackRate": "2%"
      },
    },
    {
      "id": "LOT003",
      "lotNumber": "LOT2024003",
      "productName": "Premium Coffee Beans",
      "productId": "PROD003",
      "category": "Beverages",
      "totalQuantity": 200,
      "availableQuantity": 50,
      "reservedQuantity": 30,
      "soldQuantity": 120,
      "harvestDate": "2024-03-01",
      "productionDate": "2024-03-10",
      "expiryDate": "2025-03-10",
      "batchCode": "COF-2024-003",
      "supplierLot": "SUP-LOT-003",
      "supplier": "Mountain Coffee Co",
      "status": "Active",
      "qualityGrade": "Premium",
      "certifications": ["Fair Trade", "Rainforest Alliance"],
      "storageLocation": "Warehouse-C2",
      "unitCost": 15.00,
      "testResults": {
        "acidity": "Balanced",
        "flavor": "Excellent",
        "aroma": "Strong",
        "defects": "None"
      },
    },
    {
      "id": "LOT004",
      "lotNumber": "LOT2024004",
      "productName": "Raw Almonds",
      "productId": "PROD004",
      "category": "Nuts",
      "totalQuantity": 800,
      "availableQuantity": 0,
      "reservedQuantity": 0,
      "soldQuantity": 800,
      "harvestDate": "2024-02-15",
      "productionDate": "2024-02-20",
      "expiryDate": "2025-02-20",
      "batchCode": "ALM-2024-004",
      "supplierLot": "SUP-LOT-004",
      "supplier": "California Nuts Inc",
      "status": "Sold Out",
      "qualityGrade": "Premium",
      "certifications": ["Organic", "Non-GMO"],
      "storageLocation": "Sold",
      "unitCost": 8.50,
      "testResults": {
        "moisture": "5.2%",
        "aflatoxin": "Below Limit",
        "contamination": "None",
        "sizeFit": "98%"
      },
    },
    {
      "id": "LOT005",
      "lotNumber": "LOT2024005",
      "productName": "Organic Honey",
      "productId": "PROD005",
      "category": "Sweeteners",
      "totalQuantity": 300,
      "availableQuantity": 280,
      "reservedQuantity": 20,
      "soldQuantity": 0,
      "harvestDate": "2024-05-01",
      "productionDate": "2024-05-05",
      "expiryDate": "2026-05-05",
      "batchCode": "HON-2024-005",
      "supplierLot": "SUP-LOT-005",
      "supplier": "Pure Honey Co",
      "status": "New",
      "qualityGrade": "Premium",
      "certifications": ["Organic", "Raw"],
      "storageLocation": "Warehouse-D1",
      "unitCost": 12.00,
      "testResults": {
        "purity": "100%",
        "moisture": "17.8%",
        "contamination": "None",
        "crystalization": "None"
      },
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "New", "value": "New"},
    {"label": "Active", "value": "Active"},
    {"label": "Expiring Soon", "value": "Expiring Soon"},
    {"label": "Sold Out", "value": "Sold Out"},
    {"label": "Expired", "value": "Expired"},
    {"label": "Recalled", "value": "Recalled"},
  ];

  List<Map<String, dynamic>> productOptions = [
    {"label": "All", "value": "All"},
    {"label": "Organic Wheat Flour", "value": "PROD001"},
    {"label": "Free Range Eggs", "value": "PROD002"},
    {"label": "Premium Coffee Beans", "value": "PROD003"},
    {"label": "Raw Almonds", "value": "PROD004"},
    {"label": "Organic Honey", "value": "PROD005"},
  ];

  List<Map<String, dynamic>> get filteredLots {
    var items = lots.where((lot) {
      bool matchesSearch = "${lot["lotNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${lot["productName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${lot["batchCode"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${lot["supplier"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || lot["status"] == selectedStatus;
      bool matchesProduct = selectedProduct == "All" || lot["productId"] == selectedProduct;
      
      return matchesSearch && matchesStatus && matchesProduct;
    }).toList();

    // Sort by production date (newest first)
    items.sort((a, b) => "${b["productionDate"]}".compareTo("${a["productionDate"]}"));
    
    return items;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "New":
        return infoColor;
      case "Active":
        return successColor;
      case "Expiring Soon":
        return warningColor;
      case "Sold Out":
        return disabledBoldColor;
      case "Expired":
        return dangerColor;
      case "Recalled":
        return Colors.red.shade700;
      default:
        return primaryColor;
    }
  }

  int get totalLots {
    return filteredLots.length;
  }

  int get activeLots {
    return filteredLots.where((lot) => lot["status"] == "Active" || lot["status"] == "New").length;
  }

  double get totalInventoryValue {
    return filteredLots.fold(0.0, (sum, lot) => 
      sum + ((lot["availableQuantity"] as int) * (lot["unitCost"] as double)));
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
        title: Text("Lot Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.science),
            onPressed: () {
              // Navigate to quality testing
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to lot analytics
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
            _buildLotList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new lot
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
                "Total Lots",
                "$totalLots",
                Icons.inventory_2,
                primaryColor,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildSummaryCard(
                "Active Lots",
                "$activeLots",
                Icons.check_circle,
                successColor,
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          child: _buildSummaryCard(
            "Total Value",
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
                label: "Search lots...",
                value: searchQuery,
                hint: "Search by lot number, product, batch, or supplier",
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

  Widget _buildLotList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lot Records (${filteredLots.length})",
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
          itemCount: filteredLots.length,
          itemBuilder: (context, index) {
            final lot = filteredLots[index];
            return _buildLotItem(lot);
          },
        ),
      ],
    );
  }

  Widget _buildLotItem(Map<String, dynamic> lot) {
    double availablePercentage = (lot["availableQuantity"] as int) / (lot["totalQuantity"] as int) * 100;
    double soldPercentage = (lot["soldQuantity"] as int) / (lot["totalQuantity"] as int) * 100;

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
            color: _getStatusColor("${lot["status"]}"),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _getStatusColor("${lot["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.inventory_2,
                  color: _getStatusColor("${lot["status"]}"),
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lot: ${lot["lotNumber"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${lot["productName"]}",
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
                            color: _getStatusColor("${lot["status"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${lot["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getStatusColor("${lot["status"]}"),
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
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${lot["qualityGrade"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
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
                      "Total Quantity",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${lot["totalQuantity"]}",
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
                      "Available",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${lot["availableQuantity"]} (${availablePercentage.toStringAsFixed(1)}%)",
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
                      "Sold",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${lot["soldQuantity"]} (${soldPercentage.toStringAsFixed(1)}%)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
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
                      "Harvest Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${lot["harvestDate"]}",
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
                      "${lot["expiryDate"]}",
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
                      "Unit Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(lot["unitCost"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Certifications",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                QHorizontalScroll(
                  children: (lot["certifications"] as List).map((cert) => Container(
                    margin: EdgeInsets.only(right: spXs),
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$cert",
                      style: TextStyle(
                        fontSize: 10,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Batch Code: ${lot["batchCode"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Supplier: ${lot["supplier"]} | Location: ${lot["storageLocation"]}",
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
                  _showLotActions(lot);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLotActions(Map<String, dynamic> lot) {
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
              "Lot Actions",
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
                // Navigate to lot details
              },
            ),
            ListTile(
              leading: Icon(Icons.science, color: infoColor),
              title: Text("Quality Test Results"),
              onTap: () {
                back();
                _viewTestResults(lot);
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: warningColor),
              title: Text("View Traceability"),
              onTap: () {
                back();
                _viewTraceability(lot);
              },
            ),
            ListTile(
              leading: Icon(Icons.edit, color: successColor),
              title: Text("Update Lot"),
              onTap: () {
                back();
                _updateLot(lot);
              },
            ),
            ListTile(
              leading: Icon(Icons.qr_code, color: primaryColor),
              title: Text("Generate Labels"),
              onTap: () {
                back();
                _generateLabels(lot);
              },
            ),
            ListTile(
              leading: Icon(Icons.warning, color: dangerColor),
              title: Text("Initiate Recall"),
              onTap: () {
                back();
                _initiateRecall(lot);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _viewTestResults(Map<String, dynamic> lot) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quality Test Results"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Lot: ${lot["lotNumber"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ...(lot["testResults"] as Map<String, dynamic>).entries.map((entry) => 
                Padding(
                  padding: EdgeInsets.only(bottom: spXs),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${entry.key}:",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text("${entry.value}"),
                    ],
                  ),
                ),
              ).toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _viewTraceability(Map<String, dynamic> lot) {
    // View traceability logic
  }

  void _updateLot(Map<String, dynamic> lot) {
    // Update lot logic
    ss("Lot updated successfully");
  }

  void _generateLabels(Map<String, dynamic> lot) {
    // Generate labels logic
    ss("Labels generated for lot ${lot["lotNumber"]}");
  }

  void _initiateRecall(Map<String, dynamic> lot) async {
    bool isConfirmed = await confirm("Initiate recall for this lot? This action cannot be undone.");
    if (isConfirmed) {
      // Initiate recall logic
      se("Recall initiated for lot ${lot["lotNumber"]}");
    }
  }
}
