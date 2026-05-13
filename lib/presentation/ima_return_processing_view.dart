import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaReturnProcessingView extends StatefulWidget {
  const ImaReturnProcessingView({super.key});

  @override
  State<ImaReturnProcessingView> createState() => _ImaReturnProcessingViewState();
}

class _ImaReturnProcessingViewState extends State<ImaReturnProcessingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "";
  String selectedType = "";
  String selectedFacility = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Pending Inspection", "value": "pending_inspection"},
    {"label": "Under Inspection", "value": "under_inspection"},
    {"label": "Quality Check", "value": "quality_check"},
    {"label": "Approved for Restock", "value": "approved_restock"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "Disposed", "value": "disposed"},
    {"label": "Completed", "value": "completed"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Defective Product", "value": "defective"},
    {"label": "Wrong Item", "value": "wrong_item"},
    {"label": "Damaged in Transit", "value": "damaged"},
    {"label": "Customer Return", "value": "customer_return"},
    {"label": "Expired Product", "value": "expired"},
  ];

  List<Map<String, dynamic>> facilityOptions = [
    {"label": "All Facilities", "value": ""},
    {"label": "Main Warehouse", "value": "main"},
    {"label": "North Distribution", "value": "north"},
    {"label": "South Distribution", "value": "south"},
    {"label": "East Regional", "value": "east"},
  ];

  List<Map<String, dynamic>> returnProcessingData = [
    {
      "id": "RP001",
      "return_id": "RET-2024-001",
      "product_name": "Samsung Galaxy S24",
      "product_code": "SGS24-128",
      "quantity": 2,
      "return_reason": "Defective Product",
      "type": "defective",
      "status": "under_inspection",
      "facility": "main",
      "customer_name": "John Smith",
      "received_date": "2024-06-15T10:30:00Z",
      "inspection_date": "2024-06-16T09:00:00Z",
      "inspector": "Alice Johnson",
      "condition": "Poor",
      "restockable": false,
      "estimated_value": 1600.0,
      "processing_notes": "Screen damage detected, battery issues reported",
      "images": ["https://picsum.photos/400/300?random=1", "https://picsum.photos/400/300?random=2"],
      "priority": "High",
      "created_at": "2024-06-15T10:30:00Z",
    },
    {
      "id": "RP002",
      "return_id": "RET-2024-002",
      "product_name": "Apple MacBook Pro 14",
      "product_code": "MBP14-512",
      "quantity": 1,
      "return_reason": "Wrong Item",
      "type": "wrong_item",
      "status": "approved_restock",
      "facility": "north",
      "customer_name": "Sarah Wilson",
      "received_date": "2024-06-14T14:20:00Z",
      "inspection_date": "2024-06-15T11:00:00Z",
      "inspector": "Michael Brown",
      "condition": "Excellent",
      "restockable": true,
      "estimated_value": 2500.0,
      "processing_notes": "Product in original condition, all accessories included",
      "images": ["https://picsum.photos/400/300?random=3"],
      "priority": "Medium",
      "created_at": "2024-06-14T14:20:00Z",
    },
    {
      "id": "RP003",
      "return_id": "RET-2024-003",
      "product_name": "Sony WH-1000XM5",
      "product_code": "SWXM5-BLK",
      "quantity": 1,
      "return_reason": "Damaged in Transit",
      "type": "damaged",
      "status": "quality_check",
      "facility": "south",
      "customer_name": "David Chen",
      "received_date": "2024-06-13T16:45:00Z",
      "inspection_date": "2024-06-14T10:30:00Z",
      "inspector": "Emily Davis",
      "condition": "Fair",
      "restockable": false,
      "estimated_value": 350.0,
      "processing_notes": "Packaging damaged, headphone case cracked",
      "images": ["https://picsum.photos/400/300?random=4", "https://picsum.photos/400/300?random=5"],
      "priority": "Low",
      "created_at": "2024-06-13T16:45:00Z",
    },
    {
      "id": "RP004",
      "return_id": "RET-2024-004",
      "product_name": "Dell XPS 13",
      "product_code": "DXS13-256",
      "quantity": 1,
      "return_reason": "Customer Return",
      "type": "customer_return",
      "status": "pending_inspection",
      "facility": "east",
      "customer_name": "Lisa Rodriguez",
      "received_date": "2024-06-16T11:15:00Z",
      "inspection_date": null,
      "inspector": null,
      "condition": "Unknown",
      "restockable": null,
      "estimated_value": 1200.0,
      "processing_notes": "Awaiting inspection appointment",
      "images": [],
      "priority": "Medium",
      "created_at": "2024-06-16T11:15:00Z",
    },
    {
      "id": "RP005",
      "return_id": "RET-2024-005",
      "product_name": "iPhone 15 Pro",
      "product_code": "IP15P-128",
      "quantity": 1,
      "return_reason": "Expired Product",
      "type": "expired",
      "status": "disposed",
      "facility": "main",
      "customer_name": "Robert Johnson",
      "received_date": "2024-06-12T13:00:00Z",
      "inspection_date": "2024-06-13T14:00:00Z",
      "inspector": "Tom Wilson",
      "condition": "Poor",
      "restockable": false,
      "estimated_value": 0.0,
      "processing_notes": "Product beyond warranty, disposed according to policy",
      "images": ["https://picsum.photos/400/300?random=6"],
      "priority": "Low",
      "created_at": "2024-06-12T13:00:00Z",
    },
  ];

  List<Map<String, dynamic>> get filteredProcessing {
    return returnProcessingData.where((processing) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${processing["product_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${processing["return_id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${processing["customer_name"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus.isEmpty || processing["status"] == selectedStatus;
      bool matchesType = selectedType.isEmpty || processing["type"] == selectedType;
      bool matchesFacility = selectedFacility.isEmpty || processing["facility"] == selectedFacility;
      
      return matchesSearch && matchesStatus && matchesType && matchesFacility;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending_inspection": return warningColor;
      case "under_inspection": return infoColor;
      case "quality_check": return primaryColor;
      case "approved_restock": return successColor;
      case "rejected": return dangerColor;
      case "disposed": return disabledBoldColor;
      case "completed": return successColor;
      default: return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High": return dangerColor;
      case "Medium": return warningColor;
      case "Low": return successColor;
      default: return disabledBoldColor;
    }
  }

  String _formatStatus(String status) {
    switch (status) {
      case "pending_inspection": return "Pending Inspection";
      case "under_inspection": return "Under Inspection";
      case "quality_check": return "Quality Check";
      case "approved_restock": return "Approved for Restock";
      case "rejected": return "Rejected";
      case "disposed": return "Disposed";
      case "completed": return "Completed";
      default: return status;
    }
  }

  Map<String, dynamic> _getOverviewStats() {
    int totalProcessing = returnProcessingData.length;
    int pendingInspection = returnProcessingData.where((p) => p["status"] == "pending_inspection").length;
    int underInspection = returnProcessingData.where((p) => p["status"] == "under_inspection").length;
    int approvedRestock = returnProcessingData.where((p) => p["status"] == "approved_restock").length;
    int rejected = returnProcessingData.where((p) => p["status"] == "rejected").length;

    double totalValue = returnProcessingData.fold(0.0, (sum, item) => sum + (item["estimated_value"] as double));
    double restockValue = returnProcessingData
        .where((p) => p["restockable"] == true)
        .fold(0.0, (sum, item) => sum + (item["estimated_value"] as double));

    return {
      "total_processing": totalProcessing,
      "pending_inspection": pendingInspection,
      "under_inspection": underInspection,
      "approved_restock": approvedRestock,
      "rejected": rejected,
      "total_value": totalValue,
      "restock_value": restockValue,
      "restock_rate": totalProcessing > 0 ? (approvedRestock / totalProcessing * 100) : 0.0,
    };
  }

  void _showProcessingDetails(Map<String, dynamic> processing) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(spLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Return Processing Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow("Processing ID", "${processing["id"]}"),
                      _buildDetailRow("Return ID", "${processing["return_id"]}"),
                      _buildDetailRow("Product", "${processing["product_name"]}"),
                      _buildDetailRow("Product Code", "${processing["product_code"]}"),
                      _buildDetailRow("Quantity", "${processing["quantity"]} units"),
                      _buildDetailRow("Customer", "${processing["customer_name"]}"),
                      _buildDetailRow("Return Reason", "${processing["return_reason"]}"),
                      _buildDetailRow("Status", _formatStatus("${processing["status"]}")),
                      _buildDetailRow("Facility", "${processing["facility"]}".toUpperCase()),
                      _buildDetailRow("Condition", "${processing["condition"]}"),
                      _buildDetailRow("Restockable", processing["restockable"] == true ? "Yes" : "No"),
                      _buildDetailRow("Priority", "${processing["priority"]}"),
                      if (processing["inspector"] != null)
                        _buildDetailRow("Inspector", "${processing["inspector"]}"),
                      _buildDetailRow("Estimated Value", "\$${(processing["estimated_value"] as double).currency}"),
                      _buildDetailRow("Received Date", DateTime.parse(processing["received_date"]).dMMMy),
                      if (processing["inspection_date"] != null)
                        _buildDetailRow("Inspection Date", DateTime.parse(processing["inspection_date"]).dMMMy),
                      
                      SizedBox(height: spMd),
                      Text(
                        "Processing Notes",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text("${processing["processing_notes"]}"),
                      ),

                      if ((processing["images"] as List).isNotEmpty) ...[
                        SizedBox(height: spMd),
                        Text(
                          "Product Images",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (processing["images"] as List).length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 120,
                                margin: EdgeInsets.only(right: spSm),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${(processing["images"] as List)[index]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  if (processing["status"] == "pending_inspection") ...[
                    Expanded(
                      child: QButton(
                        label: "Start Inspection",
                        onPressed: () => _startInspection(processing),
                      ),
                    ),
                  ] else if (processing["status"] == "under_inspection") ...[
                    Expanded(
                      child: QButton(
                        label: "Complete Inspection",
                        onPressed: () => _completeInspection(processing),
                      ),
                    ),
                  ] else if (processing["status"] == "quality_check") ...[
                    Expanded(
                      child: QButton(
                        label: "Approve for Restock",
                        onPressed: () => _approveRestock(processing),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Reject",
                        color: dangerColor,
                        onPressed: () => _rejectReturn(processing),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _startInspection(Map<String, dynamic> processing) async {
    Navigator.of(context).pop();
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    processing["status"] = "under_inspection";
    processing["inspection_date"] = DateTime.now().toIso8601String();
    processing["inspector"] = "Current User";
    setState(() {});
    
    ss("Inspection started successfully");
  }

  void _completeInspection(Map<String, dynamic> processing) async {
    Navigator.of(context).pop();
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    processing["status"] = "quality_check";
    setState(() {});
    
    ss("Inspection completed, moved to quality check");
  }

  void _approveRestock(Map<String, dynamic> processing) async {
    Navigator.of(context).pop();
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    processing["status"] = "approved_restock";
    processing["restockable"] = true;
    setState(() {});
    
    ss("Return approved for restocking");
  }

  void _rejectReturn(Map<String, dynamic> processing) async {
    Navigator.of(context).pop();
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    processing["status"] = "rejected";
    processing["restockable"] = false;
    setState(() {});
    
    sw("Return has been rejected");
  }

  Widget _buildOverviewTab() {
    final stats = _getOverviewStats();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Return Processing Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Processing", "${stats["total_processing"]}", Icons.inventory, primaryColor),
              _buildStatCard("Pending Inspection", "${stats["pending_inspection"]}", Icons.pending_actions, warningColor),
              _buildStatCard("Under Inspection", "${stats["under_inspection"]}", Icons.search, infoColor),
              _buildStatCard("Quality Check", "${returnProcessingData.where((p) => p["status"] == "quality_check").length}", Icons.verified, primaryColor),
              _buildStatCard("Approved Restock", "${stats["approved_restock"]}", Icons.check_circle, successColor),
              _buildStatCard("Rejected", "${stats["rejected"]}", Icons.cancel, dangerColor),
            ],
          ),
          
          SizedBox(height: spLg),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildValueCard("Total Value", "\$${(stats["total_value"] as double).currency}", Icons.attach_money, primaryColor),
              _buildValueCard("Restock Value", "\$${(stats["restock_value"] as double).currency}", Icons.trending_up, successColor),
              _buildValueCard("Restock Rate", "${(stats["restock_rate"] as double).toStringAsFixed(1)}%", Icons.percent, infoColor),
              _buildValueCard("Average Value", "\$${(stats["total_processing"] > 0 ? (stats["total_value"] as double) / (stats["total_processing"] as int) : 0.0).toStringAsFixed(2)}", Icons.calculate, disabledBoldColor),
            ],
          ),
          
          SizedBox(height: spLg),
          Text(
            "Recent Processing Activities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          
          ...returnProcessingData.take(3).map((processing) => _buildProcessingCard(processing)),
        ],
      ),
    );
  }

  Widget _buildAllTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              QTextField(
                label: "Search processing...",
                value: searchQuery,
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
                      label: "Type",
                      items: typeOptions,
                      value: selectedType,
                      onChanged: (value, label) {
                        selectedType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Facility",
                items: facilityOptions,
                value: selectedFacility,
                onChanged: (value, label) {
                  selectedFacility = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: filteredProcessing.length,
            itemBuilder: (context, index) {
              return _buildProcessingCard(filteredProcessing[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTab() {
    final completedProcessing = returnProcessingData.where((p) => 
      p["status"] == "completed" || p["status"] == "disposed" || p["status"] == "rejected"
    ).toList();
    
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: completedProcessing.length,
      itemBuilder: (context, index) {
        return _buildProcessingCard(completedProcessing[index]);
      },
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingCard(Map<String, dynamic> processing) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor("${processing["status"]}"),
          ),
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
                      "${processing["product_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${processing["return_id"]} • ${processing["product_code"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${processing["priority"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${processing["priority"]} Priority",
                  style: TextStyle(
                    color: _getPriorityColor("${processing["priority"]}"),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${processing["customer_name"]}",
                style: TextStyle(color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.business, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${processing["facility"]}".toUpperCase(),
                style: TextStyle(color: disabledBoldColor),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.inventory, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${processing["quantity"]} units",
                style: TextStyle(color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "\$${(processing["estimated_value"] as double).currency}",
                style: TextStyle(color: disabledBoldColor),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor("${processing["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _formatStatus("${processing["status"]}"),
                  style: TextStyle(
                    color: _getStatusColor("${processing["status"]}"),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              Spacer(),
              Text(
                DateTime.parse(processing["received_date"]).dMMMy,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Details",
              size: bs.sm,
              onPressed: () => _showProcessingDetails(processing),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Return Processing",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "All Processing", icon: Icon(Icons.list)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAllTab(),
        _buildHistoryTab(),
      ],
    );
  }
}
