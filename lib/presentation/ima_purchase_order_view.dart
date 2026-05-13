import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaPurchaseOrderView extends StatefulWidget {
  const ImaPurchaseOrderView({super.key});

  @override
  State<ImaPurchaseOrderView> createState() => _ImaPurchaseOrderViewState();
}

class _ImaPurchaseOrderViewState extends State<ImaPurchaseOrderView> {
  String searchQuery = "";
  String selectedStatus = "";
  String selectedSupplier = "";
  String selectedPriority = "";
  
  List<Map<String, dynamic>> purchaseOrders = [
    {
      "orderNumber": "PO-2024-0156",
      "supplierId": "SUP001",
      "supplierName": "Global Electronics Supply Co.",
      "date": "2024-12-15",
      "dueDate": "2024-12-22",
      "status": "Approved",
      "priority": "High",
      "totalAmount": 85000.0,
      "currency": "USD",
      "itemCount": 12,
      "approvedBy": "Sarah Johnson",
      "requestedBy": "Mike Wilson",
      "department": "Electronics",
      "deliveryAddress": "Warehouse A, 123 Storage Ave",
      "notes": "Urgent delivery required for production line",
    },
    {
      "orderNumber": "PO-2024-0155",
      "supplierId": "SUP002",
      "supplierName": "Advanced Components Inc.",
      "date": "2024-12-14",
      "dueDate": "2024-12-21",
      "status": "Pending Approval",
      "priority": "Medium",
      "totalAmount": 42000.0,
      "currency": "USD",
      "itemCount": 8,
      "approvedBy": "",
      "requestedBy": "Lisa Brown",
      "department": "Components",
      "deliveryAddress": "Warehouse B, 456 Component St",
      "notes": "Standard delivery schedule",
    },
    {
      "orderNumber": "PO-2024-0154",
      "supplierId": "SUP003",
      "supplierName": "Industrial Materials Corp.",
      "date": "2024-12-13",
      "dueDate": "2024-12-27",
      "status": "In Transit",
      "priority": "Low",
      "totalAmount": 96000.0,
      "currency": "USD",
      "itemCount": 15,
      "approvedBy": "John Smith",
      "requestedBy": "Emma Davis",
      "department": "Materials",
      "deliveryAddress": "Main Warehouse, 789 Industrial Blvd",
      "notes": "Bulk order for Q1 inventory",
    },
    {
      "orderNumber": "PO-2024-0153",
      "supplierId": "SUP001",
      "supplierName": "Global Electronics Supply Co.",
      "date": "2024-12-12",
      "dueDate": "2024-12-19",
      "status": "Delivered",
      "priority": "High",
      "totalAmount": 73000.0,
      "currency": "USD",
      "itemCount": 10,
      "approvedBy": "Sarah Johnson",
      "requestedBy": "David Kim",
      "department": "Electronics",
      "deliveryAddress": "Production Floor 2",
      "notes": "Critical components for new product launch",
    },
    {
      "orderNumber": "PO-2024-0152",
      "supplierId": "SUP004",
      "supplierName": "Quick Delivery Services",
      "date": "2024-12-11",
      "dueDate": "2024-12-18",
      "status": "Cancelled",
      "priority": "Low",
      "totalAmount": 28000.0,
      "currency": "USD",
      "itemCount": 5,
      "approvedBy": "",
      "requestedBy": "Tom Wilson",
      "department": "Packaging",
      "deliveryAddress": "Storage Room C",
      "notes": "Cancelled due to budget constraints",
    },
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Draft", "value": "Draft"},
    {"label": "Pending Approval", "value": "Pending Approval"},
    {"label": "Approved", "value": "Approved"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];
  
  List<Map<String, dynamic>> supplierOptions = [
    {"label": "All Suppliers", "value": ""},
    {"label": "Global Electronics Supply Co.", "value": "SUP001"},
    {"label": "Advanced Components Inc.", "value": "SUP002"},
    {"label": "Industrial Materials Corp.", "value": "SUP003"},
    {"label": "Quick Delivery Services", "value": "SUP004"},
    {"label": "Office Solutions Plus", "value": "SUP005"},
  ];
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": ""},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Orders"),
        actions: [
          IconButton(
            onPressed: () {
              _showPOActions();
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          _buildQuickStats(),
          Expanded(
            child: _buildPurchaseOrdersList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(ImaCreatePoView());
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search purchase orders...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {
                  _performSearch();
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    _applyFilters();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Supplier",
                  items: supplierOptions,
                  value: selectedSupplier,
                  onChanged: (value, label) {
                    selectedSupplier = value;
                    _applyFilters();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: priorityOptions,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    _applyFilters();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    int totalOrders = purchaseOrders.length;
    int pendingApproval = purchaseOrders.where((po) => po["status"] == "Pending Approval").length;
    int inTransit = purchaseOrders.where((po) => po["status"] == "In Transit").length;
    double totalValue = purchaseOrders.fold(0.0, (sum, po) => sum + (po["totalAmount"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          _buildStatCard("Total", "$totalOrders", Icons.receipt_long, primaryColor),
          SizedBox(width: spSm),
          _buildStatCard("Pending", "$pendingApproval", Icons.pending, warningColor),
          SizedBox(width: spSm),
          _buildStatCard("In Transit", "$inTransit", Icons.local_shipping, infoColor),
          SizedBox(width: spSm),
          _buildStatCard("Value", "\$${(totalValue / 1000000).toStringAsFixed(1)}M", Icons.monetization_on, successColor),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseOrdersList() {
    List<Map<String, dynamic>> filteredOrders = _getFilteredOrders();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: ListView.builder(
        itemCount: filteredOrders.length,
        itemBuilder: (context, index) {
          final order = filteredOrders[index];
          return _buildPurchaseOrderCard(order);
        },
      ),
    );
  }

  Widget _buildPurchaseOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order["orderNumber"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${order["supplierName"]}",
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
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order["status"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${order["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(order["status"]),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(order["priority"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${order["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getPriorityColor(order["priority"]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                _buildInfoRow("Order Date", "${DateTime.parse(order["date"]).dMMMy}"),
                _buildInfoRow("Due Date", "${DateTime.parse(order["dueDate"]).dMMMy}"),
                _buildInfoRow("Total Amount", "\$${((order["totalAmount"] as double)).currency}"),
                _buildInfoRow("Items", "${order["itemCount"]} items"),
                _buildInfoRow("Requested By", "${order["requestedBy"]}"),
                if (order["approvedBy"].toString().isNotEmpty)
                  _buildInfoRow("Approved By", "${order["approvedBy"]}"),
                _buildInfoRow("Department", "${order["department"]}"),
              ],
            ),
          ),
          if (order["notes"].toString().isNotEmpty) ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, color: infoColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${order["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  icon: Icons.visibility,
                  size: bs.sm,
                  onPressed: () {
                    // navigateTo(ImaPurchaseOrderDetailView());
                  },
                ),
              ),
              SizedBox(width: spSm),
              if (order["status"] == "Pending Approval")
                Expanded(
                  child: QButton(
                    label: "Approve",
                    icon: Icons.check,
                    size: bs.sm,
                    onPressed: () {
                      _approvePurchaseOrder(order["orderNumber"]);
                    },
                  ),
                ),
              if (order["status"] == "Approved" || order["status"] == "In Transit")
                Expanded(
                  child: QButton(
                    label: "Track",
                    icon: Icons.local_shipping,
                    size: bs.sm,
                    onPressed: () {
                      // navigateTo(ImaPoTrackingView());
                    },
                  ),
                ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showOrderActions(order);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
          Text(": ", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredOrders() {
    List<Map<String, dynamic>> filtered = purchaseOrders;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) {
        return order["orderNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               order["supplierName"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    if (selectedStatus.isNotEmpty) {
      filtered = filtered.where((order) => order["status"] == selectedStatus).toList();
    }
    
    if (selectedSupplier.isNotEmpty) {
      filtered = filtered.where((order) => order["supplierId"] == selectedSupplier).toList();
    }
    
    if (selectedPriority.isNotEmpty) {
      filtered = filtered.where((order) => order["priority"] == selectedPriority).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return successColor;
      case 'pending approval':
        return warningColor;
      case 'in transit':
        return infoColor;
      case 'delivered':
        return successColor;
      case 'cancelled':
        return dangerColor;
      case 'draft':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _performSearch() {
    setState(() {});
  }

  void _applyFilters() {
    setState(() {});
  }

  void _approvePurchaseOrder(String orderNumber) async {
    bool isConfirmed = await confirm("Are you sure you want to approve purchase order $orderNumber?");
    if (isConfirmed) {
      showLoading();
      
      // Simulate API call
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        
        // Update order status
        int index = purchaseOrders.indexWhere((order) => order["orderNumber"] == orderNumber);
        if (index != -1) {
          purchaseOrders[index]["status"] = "Approved";
          purchaseOrders[index]["approvedBy"] = "Current User";
          setState(() {});
          ss("Purchase order approved successfully!");
        }
      });
    }
  }

  void _showOrderActions(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Order Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              _buildActionItem(Icons.edit, "Edit Order", () {}),
              _buildActionItem(Icons.copy, "Duplicate Order", () {}),
              _buildActionItem(Icons.print, "Print Order", () {}),
              _buildActionItem(Icons.email, "Email to Supplier", () {}),
              if (order["status"] == "Pending Approval")
                _buildActionItem(Icons.check, "Approve Order", () {
                  _approvePurchaseOrder(order["orderNumber"]);
                }),
              if (order["status"] != "Cancelled" && order["status"] != "Delivered")
                _buildActionItem(Icons.cancel, "Cancel Order", () {}),
              SizedBox(height: spMd),
            ],
          ),
        );
      },
    );
  }

  void _showPOActions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Purchase Order Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              _buildActionItem(Icons.add, "Create New PO", () {}),
              _buildActionItem(Icons.approval, "Bulk Approval", () {}),
              _buildActionItem(Icons.file_download, "Export Orders", () {}),
              _buildActionItem(Icons.import_export, "Import Orders", () {}),
              _buildActionItem(Icons.settings, "PO Settings", () {}),
              SizedBox(height: spMd),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionItem(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                onTap();
              },
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
