import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaPoApprovalView extends StatefulWidget {
  const ImaPoApprovalView({super.key});

  @override
  State<ImaPoApprovalView> createState() => _ImaPoApprovalViewState();
}

class _ImaPoApprovalViewState extends State<ImaPoApprovalView> {
  String searchQuery = "";
  String selectedDepartment = "";
  String selectedPriority = "";
  
  List<Map<String, dynamic>> pendingApprovals = [
    {
      "orderNumber": "PO-2024-0157",
      "supplierId": "SUP001",
      "supplierName": "Global Electronics Supply Co.",
      "requestedBy": "Mike Wilson",
      "department": "Electronics",
      "date": "2024-12-16",
      "dueDate": "2024-12-23",
      "priority": "High",
      "totalAmount": 125000.0,
      "itemCount": 18,
      "reason": "Critical components for new product line",
      "budgetCode": "PROJ-2024-15",
      "deliveryAddress": "Production Floor 1",
      "approvalLevel": "Manager",
      "submittedAt": "2024-12-16T09:30:00",
      "lineItems": [
        {"product": "Arduino Mega", "quantity": 50, "unitPrice": 45.99, "total": 2299.50},
        {"product": "Sensor Kit Pro", "quantity": 25, "unitPrice": 89.99, "total": 2249.75},
        {"product": "Display Module", "quantity": 30, "unitPrice": 125.50, "total": 3765.00},
      ],
      "attachments": ["quote.pdf", "specs.doc"],
      "history": [
        {"action": "Submitted", "by": "Mike Wilson", "date": "2024-12-16T09:30:00"},
        {"action": "Reviewed", "by": "John Smith", "date": "2024-12-16T10:15:00"},
      ],
    },
    {
      "orderNumber": "PO-2024-0158",
      "supplierId": "SUP002",
      "supplierName": "Advanced Components Inc.",
      "requestedBy": "Lisa Brown",
      "department": "Components",
      "date": "2024-12-16",
      "dueDate": "2024-12-30",
      "priority": "Medium",
      "totalAmount": 68000.0,
      "itemCount": 12,
      "reason": "Regular inventory replenishment",
      "budgetCode": "INV-2024-Q4",
      "deliveryAddress": "Warehouse B",
      "approvalLevel": "Director",
      "submittedAt": "2024-12-16T11:45:00",
      "lineItems": [
        {"product": "Capacitor Set", "quantity": 100, "unitPrice": 12.50, "total": 1250.00},
        {"product": "Resistor Kit", "quantity": 75, "unitPrice": 18.75, "total": 1406.25},
        {"product": "IC Collection", "quantity": 40, "unitPrice": 95.00, "total": 3800.00},
      ],
      "attachments": ["inventory_report.xlsx"],
      "history": [
        {"action": "Submitted", "by": "Lisa Brown", "date": "2024-12-16T11:45:00"},
      ],
    },
    {
      "orderNumber": "PO-2024-0159",
      "supplierId": "SUP003",
      "supplierName": "Industrial Materials Corp.",
      "requestedBy": "Emma Davis",
      "department": "Materials",
      "date": "2024-12-15",
      "dueDate": "2024-12-29",
      "priority": "Low",
      "totalAmount": 45000.0,
      "itemCount": 8,
      "reason": "Q1 2025 material preparation",
      "budgetCode": "MAT-2025-Q1",
      "deliveryAddress": "Storage Facility C",
      "approvalLevel": "Manager",
      "submittedAt": "2024-12-15T14:20:00",
      "lineItems": [
        {"product": "Steel Sheets", "quantity": 20, "unitPrice": 350.00, "total": 7000.00},
        {"product": "Aluminum Bars", "quantity": 15, "unitPrice": 285.50, "total": 4282.50},
        {"product": "Copper Wire", "quantity": 10, "unitPrice": 125.75, "total": 1257.50},
      ],
      "attachments": ["material_forecast.pdf", "supplier_quote.pdf"],
      "history": [
        {"action": "Submitted", "by": "Emma Davis", "date": "2024-12-15T14:20:00"},
        {"action": "Budget Verified", "by": "Finance Team", "date": "2024-12-15T16:30:00"},
      ],
    },
  ];
  
  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": ""},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Components", "value": "Components"},
    {"label": "Materials", "value": "Materials"},
    {"label": "Packaging", "value": "Packaging"},
    {"label": "Office", "value": "Office"},
  ];
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": ""},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
    {"label": "Urgent", "value": "Urgent"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PO Approval Queue"),
        actions: [
          IconButton(
            onPressed: () {
              _showApprovalSettings();
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          _buildApprovalStats(),
          Expanded(
            child: _buildApprovalList(),
          ),
        ],
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
                  label: "Search orders...",
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
                  label: "Department",
                  items: departmentOptions,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    _applyFilters();
                  },
                ),
              ),
              SizedBox(width: spMd),
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

  Widget _buildApprovalStats() {
    int totalPending = pendingApprovals.length;
    int highPriority = pendingApprovals.where((po) => po["priority"] == "High" || po["priority"] == "Urgent").length;
    int overdue = pendingApprovals.where((po) => DateTime.parse(po["dueDate"]).isBefore(DateTime.now())).length;
    double totalValue = pendingApprovals.fold(0.0, (sum, po) => sum + (po["totalAmount"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          _buildStatCard("Pending", "$totalPending", Icons.pending_actions, primaryColor),
          SizedBox(width: spSm),
          _buildStatCard("High Priority", "$highPriority", Icons.priority_high, dangerColor),
          SizedBox(width: spSm),
          _buildStatCard("Overdue", "$overdue", Icons.warning, warningColor),
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
              textAlign: TextAlign.center,
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

  Widget _buildApprovalList() {
    List<Map<String, dynamic>> filteredApprovals = _getFilteredApprovals();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: ListView.builder(
        itemCount: filteredApprovals.length,
        itemBuilder: (context, index) {
          final approval = filteredApprovals[index];
          return _buildApprovalCard(approval);
        },
      ),
    );
  }

  Widget _buildApprovalCard(Map<String, dynamic> approval) {
    bool isOverdue = DateTime.parse(approval["dueDate"]).isBefore(DateTime.now());
    bool isUrgent = approval["priority"] == "High" || approval["priority"] == "Urgent";
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isOverdue ? Border.all(color: dangerColor, width: 2) : null,
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
                    Row(
                      children: [
                        Text(
                          "${approval["orderNumber"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        if (isOverdue)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "OVERDUE",
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${approval["supplierName"]}",
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
                      color: _getPriorityColor(approval["priority"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${approval["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getPriorityColor(approval["priority"]),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "\$${((approval["totalAmount"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
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
                _buildInfoRow("Requested By", "${approval["requestedBy"]}"),
                _buildInfoRow("Department", "${approval["department"]}"),
                _buildInfoRow("Due Date", "${DateTime.parse(approval["dueDate"]).dMMMy}"),
                _buildInfoRow("Items", "${approval["itemCount"]} items"),
                _buildInfoRow("Budget Code", "${approval["budgetCode"]}"),
                _buildInfoRow("Approval Level", "${approval["approvalLevel"]}"),
              ],
            ),
          ),
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
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${approval["reason"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  icon: Icons.visibility,
                  size: bs.sm,
                  onPressed: () {
                    _showApprovalDetails(approval);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Approve",
                  icon: Icons.check,
                  size: bs.sm,
                  color: successColor,
                  onPressed: () {
                    _approveOrder(approval);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Reject",
                  icon: Icons.close,
                  size: bs.sm,
                  color: dangerColor,
                  onPressed: () {
                    _rejectOrder(approval);
                  },
                ),
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

  List<Map<String, dynamic>> _getFilteredApprovals() {
    List<Map<String, dynamic>> filtered = pendingApprovals;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((approval) {
        return approval["orderNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               approval["supplierName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               approval["requestedBy"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    if (selectedDepartment.isNotEmpty) {
      filtered = filtered.where((approval) => approval["department"] == selectedDepartment).toList();
    }
    
    if (selectedPriority.isNotEmpty) {
      filtered = filtered.where((approval) => approval["priority"] == selectedPriority).toList();
    }
    
    // Sort by priority and due date
    filtered.sort((a, b) {
      int priorityComparison = _getPriorityWeight(b["priority"]).compareTo(_getPriorityWeight(a["priority"]));
      if (priorityComparison != 0) return priorityComparison;
      
      return DateTime.parse(a["dueDate"]).compareTo(DateTime.parse(b["dueDate"]));
    });
    
    return filtered;
  }

  int _getPriorityWeight(String priority) {
    switch (priority.toLowerCase()) {
      case 'urgent':
        return 4;
      case 'high':
        return 3;
      case 'medium':
        return 2;
      case 'low':
        return 1;
      default:
        return 0;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'urgent':
        return dangerColor;
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

  void _approveOrder(Map<String, dynamic> approval) async {
    bool isConfirmed = await confirm("Are you sure you want to approve ${approval["orderNumber"]}?");
    if (isConfirmed) {
      showLoading();
      
      // Simulate API call
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        
        // Remove from pending list
        pendingApprovals.removeWhere((item) => item["orderNumber"] == approval["orderNumber"]);
        setState(() {});
        
        ss("Purchase order ${approval["orderNumber"]} approved successfully!");
      });
    }
  }

  void _rejectOrder(Map<String, dynamic> approval) async {
    String rejectionReason = "";
    
    bool result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Reject Purchase Order"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Please provide a reason for rejecting ${approval["orderNumber"]}:"),
              SizedBox(height: spMd),
              QMemoField(
                label: "Rejection Reason",
                value: rejectionReason,
                onChanged: (value) {
                  rejectionReason = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Reject Order"),
            ),
          ],
        );
      },
    ) ?? false;
    
    if (result && rejectionReason.isNotEmpty) {
      showLoading();
      
      // Simulate API call
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        
        // Remove from pending list
        pendingApprovals.removeWhere((item) => item["orderNumber"] == approval["orderNumber"]);
        setState(() {});
        
        ss("Purchase order ${approval["orderNumber"]} rejected!");
      });
    }
  }

  void _showApprovalDetails(Map<String, dynamic> approval) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: EdgeInsets.all(spMd),
          child: Column(
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
                "Approval Details - ${approval["orderNumber"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailSection("Order Information", [
                        {"label": "Supplier", "value": approval["supplierName"]},
                        {"label": "Requested By", "value": approval["requestedBy"]},
                        {"label": "Department", "value": approval["department"]},
                        {"label": "Priority", "value": approval["priority"]},
                        {"label": "Due Date", "value": DateTime.parse(approval["dueDate"]).dMMMy},
                        {"label": "Budget Code", "value": approval["budgetCode"]},
                        {"label": "Delivery Address", "value": approval["deliveryAddress"]},
                      ]),
                      SizedBox(height: spMd),
                      _buildLineItemsSection(approval["lineItems"]),
                      SizedBox(height: spMd),
                      _buildApprovalHistorySection(approval["history"]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Approve",
                      icon: Icons.check,
                      size: bs.md,
                      color: successColor,
                      onPressed: () {
                        Navigator.pop(context);
                        _approveOrder(approval);
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: "Reject",
                      icon: Icons.close,
                      size: bs.md,
                      color: dangerColor,
                      onPressed: () {
                        Navigator.pop(context);
                        _rejectOrder(approval);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailSection(String title, List<Map<String, String>> items) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: items.map((item) {
              return _buildInfoRow(item["label"]!, item["value"]!);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLineItemsSection(List<dynamic> lineItems) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Line Items",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: lineItems.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["product"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Qty: ${item["quantity"]} × \$${(item["unitPrice"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${(item["total"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalHistorySection(List<dynamic> history) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Approval History",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: history.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: primaryColor, size: 8),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${item["action"]} by ${item["by"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${DateTime.parse(item["date"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showApprovalSettings() {
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
                "Approval Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              _buildActionItem(Icons.rule, "Approval Rules", () {}),
              _buildActionItem(Icons.notifications, "Notification Settings", () {}),
              _buildActionItem(Icons.group, "Approval Delegates", () {}),
              _buildActionItem(Icons.schedule, "Auto-Approval Rules", () {}),
              _buildActionItem(Icons.history, "Approval History", () {}),
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
