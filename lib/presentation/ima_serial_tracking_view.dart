import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaSerialTrackingView extends StatefulWidget {
  const ImaSerialTrackingView({super.key});

  @override
  State<ImaSerialTrackingView> createState() => _ImaSerialTrackingViewState();
}

class _ImaSerialTrackingViewState extends State<ImaSerialTrackingView> {
  bool loading = false;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> serialItems = [
    {
      "id": "SER001",
      "serialNumber": "SN2024001",
      "productName": "MacBook Pro 16-inch",
      "productId": "PROD001",
      "model": "MBP16-2024",
      "brand": "Apple",
      "category": "Laptops",
      "purchaseDate": "2024-01-15",
      "warrantyExpiry": "2026-01-15",
      "purchasePrice": 2500.0,
      "currentValue": 2200.0,
      "status": "Active",
      "condition": "Excellent",
      "location": "Office-101",
      "assignedTo": "John Doe",
      "supplier": "Tech Store Inc",
      "invoiceNumber": "INV-2024-001",
      "image": "https://picsum.photos/60/60?random=1&keyword=laptop",
    },
    {
      "id": "SER002",
      "serialNumber": "SN2024002",
      "productName": "iPhone 15 Pro",
      "productId": "PROD002",
      "model": "IP15P-256",
      "brand": "Apple",
      "category": "Smartphones",
      "purchaseDate": "2024-02-20",
      "warrantyExpiry": "2025-02-20",
      "purchasePrice": 1200.0,
      "currentValue": 1000.0,
      "status": "Active",
      "condition": "Good",
      "location": "Warehouse-A1",
      "assignedTo": "Jane Smith",
      "supplier": "Mobile World",
      "invoiceNumber": "INV-2024-002",
      "image": "https://picsum.photos/60/60?random=2&keyword=phone",
    },
    {
      "id": "SER003",
      "serialNumber": "SN2024003",
      "productName": "Dell XPS 13",
      "productId": "PROD003",
      "model": "XPS13-2024",
      "brand": "Dell",
      "category": "Laptops",
      "purchaseDate": "2024-03-10",
      "warrantyExpiry": "2026-03-10",
      "purchasePrice": 1800.0,
      "currentValue": 1500.0,
      "status": "In Repair",
      "condition": "Fair",
      "location": "Service Center",
      "assignedTo": "Mike Johnson",
      "supplier": "Dell Direct",
      "invoiceNumber": "INV-2024-003",
      "image": "https://picsum.photos/60/60?random=3&keyword=laptop",
    },
    {
      "id": "SER004",
      "serialNumber": "SN2024004",
      "productName": "Samsung Monitor 32",
      "productId": "PROD004",
      "model": "SM32-4K",
      "brand": "Samsung",
      "category": "Monitors",
      "purchaseDate": "2024-04-05",
      "warrantyExpiry": "2027-04-05",
      "purchasePrice": 800.0,
      "currentValue": 700.0,
      "status": "Available",
      "condition": "Excellent",
      "location": "Warehouse-B2",
      "assignedTo": null,
      "supplier": "Display Solutions",
      "invoiceNumber": "INV-2024-004",
      "image": "https://picsum.photos/60/60?random=4&keyword=monitor",
    },
    {
      "id": "SER005",
      "serialNumber": "SN2024005",
      "productName": "Canon Camera EOS R5",
      "productId": "PROD005",
      "model": "EOSR5-2024",
      "brand": "Canon",
      "category": "Cameras",
      "purchaseDate": "2024-05-12",
      "warrantyExpiry": "2026-05-12",
      "purchasePrice": 3500.0,
      "currentValue": 3200.0,
      "status": "Sold",
      "condition": "Excellent",
      "location": "Sold",
      "assignedTo": "Customer ABC",
      "supplier": "Camera Pro",
      "invoiceNumber": "INV-2024-005",
      "image": "https://picsum.photos/60/60?random=5&keyword=camera",
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Available", "value": "Available"},
    {"label": "In Repair", "value": "In Repair"},
    {"label": "Sold", "value": "Sold"},
    {"label": "Lost", "value": "Lost"},
    {"label": "Disposed", "value": "Disposed"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Laptops", "value": "Laptops"},
    {"label": "Smartphones", "value": "Smartphones"},
    {"label": "Monitors", "value": "Monitors"},
    {"label": "Cameras", "value": "Cameras"},
    {"label": "Tablets", "value": "Tablets"},
  ];

  List<Map<String, dynamic>> get filteredItems {
    var items = serialItems.where((item) {
      bool matchesSearch = "${item["serialNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["productName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["model"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["assignedTo"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || item["status"] == selectedStatus;
      bool matchesCategory = selectedCategory == "All" || item["category"] == selectedCategory;
      
      return matchesSearch && matchesStatus && matchesCategory;
    }).toList();

    // Sort by purchase date (newest first)
    items.sort((a, b) => "${b["purchaseDate"]}".compareTo("${a["purchaseDate"]}"));
    
    return items;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Available":
        return infoColor;
      case "In Repair":
        return warningColor;
      case "Sold":
        return primaryColor;
      case "Lost":
        return dangerColor;
      case "Disposed":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  Color _getConditionColor(String condition) {
    switch (condition) {
      case "Excellent":
        return successColor;
      case "Good":
        return infoColor;
      case "Fair":
        return warningColor;
      case "Poor":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  int get totalItems {
    return filteredItems.length;
  }

  int get activeItems {
    return filteredItems.where((item) => item["status"] == "Active" || item["status"] == "Available").length;
  }

  double get totalCurrentValue {
    return filteredItems.fold(0.0, (sum, item) => sum + (item["currentValue"] as double));
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
        title: Text("Serial Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // Navigate to serial scanner
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to serial analytics
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
            _buildSerialList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new serial item
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
                "Total Items",
                "$totalItems",
                Icons.inventory,
                primaryColor,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildSummaryCard(
                "Active Items",
                "$activeItems",
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
            "\$${totalCurrentValue.currency}",
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
                label: "Search items...",
                value: searchQuery,
                hint: "Search by serial, product, model, or assignee",
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
                label: "Category",
                items: categoryOptions,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSerialList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Serial Items (${filteredItems.length})",
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
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            final item = filteredItems[index];
            return _buildSerialItem(item);
          },
        ),
      ],
    );
  }

  Widget _buildSerialItem(Map<String, dynamic> item) {
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
            color: _getStatusColor("${item["status"]}"),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${item["image"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["productName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "S/N: ${item["serialNumber"]} | Model: ${item["model"]}",
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
                            color: _getStatusColor("${item["status"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getStatusColor("${item["status"]}"),
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
                            color: _getConditionColor("${item["condition"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${item["condition"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: _getConditionColor("${item["condition"]}"),
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
                      "Purchase Price",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(item["purchasePrice"] as double).currency}",
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
                      "Current Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(item["currentValue"] as double).currency}",
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
                      "Brand",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${item["brand"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
                      "Purchase Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${item["purchaseDate"]}",
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
                      "Warranty Expiry",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${item["warrantyExpiry"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
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
                      "Location",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${item["location"]}",
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
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Assigned to: ${item["assignedTo"] ?? "Unassigned"}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Supplier: ${item["supplier"]} | Invoice: ${item["invoiceNumber"]}",
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
                  _showItemActions(item);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showItemActions(Map<String, dynamic> item) {
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
              "Item Actions",
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
                // Navigate to item details
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: infoColor),
              title: Text("View History"),
              onTap: () {
                back();
                _viewItemHistory(item);
              },
            ),
            ListTile(
              leading: Icon(Icons.edit, color: warningColor),
              title: Text("Update Item"),
              onTap: () {
                back();
                _updateItem(item);
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: successColor),
              title: Text("Assign/Transfer"),
              onTap: () {
                back();
                _assignItem(item);
              },
            ),
            ListTile(
              leading: Icon(Icons.qr_code, color: primaryColor),
              title: Text("Generate QR Code"),
              onTap: () {
                back();
                _generateQRCode(item);
              },
            ),
            ListTile(
              leading: Icon(Icons.build, color: warningColor),
              title: Text("Mark for Repair"),
              onTap: () {
                back();
                _markForRepair(item);
              },
            ),
            ListTile(
              leading: Icon(Icons.sell, color: infoColor),
              title: Text("Mark as Sold"),
              onTap: () {
                back();
                _markAsSold(item);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _viewItemHistory(Map<String, dynamic> item) {
    // View item history logic
  }

  void _updateItem(Map<String, dynamic> item) {
    // Update item logic
    ss("Item updated successfully");
  }

  void _assignItem(Map<String, dynamic> item) {
    // Assign/transfer item logic
    ss("Item assigned successfully");
  }

  void _generateQRCode(Map<String, dynamic> item) {
    // Generate QR code logic
    ss("QR code generated for ${item["serialNumber"]}");
  }

  void _markForRepair(Map<String, dynamic> item) {
    // Mark for repair logic
    ss("Item marked for repair");
  }

  void _markAsSold(Map<String, dynamic> item) async {
    bool isConfirmed = await confirm("Mark this item as sold?");
    if (isConfirmed) {
      // Mark as sold logic
      ss("Item marked as sold");
    }
  }
}
