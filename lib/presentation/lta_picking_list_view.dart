import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaPickingListView extends StatefulWidget {
  const LtaPickingListView({super.key});

  @override
  State<LtaPickingListView> createState() => _LtaPickingListViewState();
}

class _LtaPickingListViewState extends State<LtaPickingListView> {
  bool loading = true;
  String searchQuery = "";
  String selectedStatus = "All Status";
  String selectedPriority = "All Priorities";
  String selectedWorker = "All Workers";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Pending", "value": "Pending"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Paused", "value": "Paused"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": "All Priorities"},
    {"label": "Urgent", "value": "Urgent"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> workerOptions = [
    {"label": "All Workers", "value": "All Workers"},
    {"label": "John Smith", "value": "John Smith"},
    {"label": "Sarah Wilson", "value": "Sarah Wilson"},
    {"label": "Mike Johnson", "value": "Mike Johnson"},
    {"label": "Lisa Garcia", "value": "Lisa Garcia"},
    {"label": "David Brown", "value": "David Brown"},
  ];

  List<Map<String, dynamic>> pickingLists = [
    {
      "id": "pick_001",
      "orderNumber": "ORD-2024-001",
      "customerName": "TechCorp Solutions",
      "priority": "High",
      "status": "In Progress",
      "assignedWorker": "John Smith",
      "createdDate": "2024-03-15T08:00:00Z",
      "startTime": "2024-03-15T09:15:00Z",
      "estimatedCompletion": "2024-03-15T12:00:00Z",
      "actualCompletion": "",
      "totalItems": 8,
      "pickedItems": 5,
      "totalQuantity": 125,
      "pickedQuantity": 78,
      "route": "Zone A → Zone B → Zone C",
      "estimatedDistance": 850,
      "actualDistance": 620,
      "notes": "Fragile electronics - handle with care",
      "items": [
        {
          "sku": "EL-001",
          "description": "Smartphone Pro Max",
          "location": "A-01-15",
          "requestedQty": 25,
          "pickedQty": 25,
          "status": "Completed",
          "weight": 0.5,
          "notes": "Picked from top shelf"
        },
        {
          "sku": "EL-002",
          "description": "Wireless Headphones",
          "location": "A-02-08",
          "requestedQty": 40,
          "pickedQty": 40,
          "status": "Completed",
          "weight": 0.8,
          "notes": ""
        },
        {
          "sku": "EL-003",
          "description": "Tablet 11-inch",
          "location": "A-03-12",
          "requestedQty": 15,
          "pickedQty": 13,
          "status": "Partial",
          "weight": 0.6,
          "notes": "Only 13 available, 2 reserved for another order"
        },
        {
          "sku": "EL-004",
          "description": "Laptop Gaming",
          "location": "B-01-05",
          "requestedQty": 10,
          "pickedQty": 0,
          "status": "Pending",
          "weight": 2.1,
          "notes": "Heavy item - use cart"
        },
        {
          "sku": "AC-001",
          "description": "Phone Cases",
          "location": "C-02-18",
          "requestedQty": 35,
          "pickedQty": 0,
          "status": "Pending",
          "weight": 0.2,
          "notes": ""
        },
      ],
    },
    {
      "id": "pick_002",
      "orderNumber": "ORD-2024-002",
      "customerName": "AutoParts Express",
      "priority": "Medium",
      "status": "Completed",
      "assignedWorker": "Sarah Wilson",
      "createdDate": "2024-03-15T07:30:00Z",
      "startTime": "2024-03-15T08:45:00Z",
      "estimatedCompletion": "2024-03-15T11:30:00Z",
      "actualCompletion": "2024-03-15T11:15:00Z",
      "totalItems": 6,
      "pickedItems": 6,
      "totalQuantity": 89,
      "pickedQuantity": 89,
      "route": "Zone C → Zone D",
      "estimatedDistance": 650,
      "actualDistance": 620,
      "notes": "Heavy automotive parts - used forklift",
      "items": [
        {
          "sku": "AU-101",
          "description": "Engine Oil Filter",
          "location": "C-01-22",
          "requestedQty": 45,
          "pickedQty": 45,
          "status": "Completed",
          "weight": 1.2,
          "notes": ""
        },
        {
          "sku": "AU-102",
          "description": "Brake Pads Set",
          "location": "C-02-15",
          "requestedQty": 25,
          "pickedQty": 25,
          "status": "Completed",
          "weight": 2.8,
          "notes": "Heavy item"
        },
        {
          "sku": "AU-103",
          "description": "Air Filter",
          "location": "D-01-08",
          "requestedQty": 19,
          "pickedQty": 19,
          "status": "Completed",
          "weight": 0.4,
          "notes": ""
        },
      ],
    },
    {
      "id": "pick_003",
      "orderNumber": "ORD-2024-003",
      "customerName": "MedSupply Inc",
      "priority": "Urgent",
      "status": "Pending",
      "assignedWorker": "Mike Johnson",
      "createdDate": "2024-03-15T10:15:00Z",
      "startTime": "",
      "estimatedCompletion": "2024-03-15T14:00:00Z",
      "actualCompletion": "",
      "totalItems": 12,
      "pickedItems": 0,
      "totalQuantity": 67,
      "pickedQuantity": 0,
      "route": "Cold Storage → Zone A",
      "estimatedDistance": 420,
      "actualDistance": 0,
      "notes": "Temperature-sensitive pharmaceuticals - maintain cold chain",
      "items": [
        {
          "sku": "PH-201",
          "description": "Insulin Pens",
          "location": "CS-01-05",
          "requestedQty": 30,
          "pickedQty": 0,
          "status": "Pending",
          "weight": 0.3,
          "notes": "Keep refrigerated"
        },
        {
          "sku": "PH-202",
          "description": "Vaccines",
          "location": "CS-01-08",
          "requestedQty": 25,
          "pickedQty": 0,
          "status": "Pending",
          "weight": 0.5,
          "notes": "Temperature critical"
        },
        {
          "sku": "PH-203",
          "description": "Blood Test Kits",
          "location": "A-04-10",
          "requestedQty": 12,
          "pickedQty": 0,
          "status": "Pending",
          "weight": 0.8,
          "notes": ""
        },
      ],
    },
    {
      "id": "pick_004",
      "orderNumber": "ORD-2024-004",
      "customerName": "ChemLab Solutions",
      "priority": "High",
      "status": "Paused",
      "assignedWorker": "Lisa Garcia",
      "createdDate": "2024-03-15T09:00:00Z",
      "startTime": "2024-03-15T10:30:00Z",
      "estimatedCompletion": "2024-03-15T15:30:00Z",
      "actualCompletion": "",
      "totalItems": 5,
      "pickedItems": 2,
      "totalQuantity": 45,
      "pickedQuantity": 20,
      "route": "Hazmat → Zone B",
      "estimatedDistance": 780,
      "actualDistance": 350,
      "notes": "Hazardous chemicals - safety protocols required",
      "items": [
        {
          "sku": "CH-301",
          "description": "Industrial Cleaner",
          "location": "HZ-01-03",
          "requestedQty": 15,
          "pickedQty": 15,
          "status": "Completed",
          "weight": 1.2,
          "notes": "Hazmat handling"
        },
        {
          "sku": "CH-302",
          "description": "Laboratory Acids",
          "location": "HZ-01-07",
          "requestedQty": 8,
          "pickedQty": 5,
          "status": "Partial",
          "weight": 2.1,
          "notes": "Safety equipment malfunction - awaiting repair"
        },
        {
          "sku": "CH-303",
          "description": "Solvent",
          "location": "HZ-02-02",
          "requestedQty": 22,
          "pickedQty": 0,
          "status": "Pending",
          "weight": 1.8,
          "notes": "Requires special ventilation"
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadPickingData();
  }

  void _loadPickingData() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredPickingLists {
    return pickingLists.where((list) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${list["orderNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${list["customerName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${list["assignedWorker"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (list["items"] as List).any((item) => 
              "${item["sku"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
              "${item["description"]}".toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesStatus = selectedStatus == "All Status" || 
          list["status"] == selectedStatus;
      
      bool matchesPriority = selectedPriority == "All Priorities" || 
          list["priority"] == selectedPriority;
      
      bool matchesWorker = selectedWorker == "All Workers" || 
          list["assignedWorker"] == selectedWorker;
      
      return matchesSearch && matchesStatus && matchesPriority && matchesWorker;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "In Progress":
        return primaryColor;
      case "Completed":
        return successColor;
      case "Paused":
        return Colors.orange;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Pending":
        return Icons.schedule;
      case "In Progress":
        return Icons.inventory;
      case "Completed":
        return Icons.check_circle;
      case "Paused":
        return Icons.pause_circle;
      case "Cancelled":
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Urgent":
        return dangerColor;
      case "High":
        return Colors.orange;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getItemStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "Partial":
        return Colors.orange;
      case "Completed":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildSummaryCards() {
    List<Map<String, dynamic>> displayLists = filteredPickingLists;
    int pendingLists = displayLists.where((l) => l["status"] == "Pending").length;
    int inProgressLists = displayLists.where((l) => l["status"] == "In Progress").length;
    int completedLists = displayLists.where((l) => l["status"] == "Completed").length;
    int pausedLists = displayLists.where((l) => l["status"] == "Paused").length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard("Pending", pendingLists, warningColor, Icons.schedule),
        _buildSummaryCard("In Progress", inProgressLists, primaryColor, Icons.inventory),
        _buildSummaryCard("Completed", completedLists, successColor, Icons.check_circle),
        _buildSummaryCard("Paused", pausedLists, Colors.orange, Icons.pause_circle),
      ],
    );
  }

  Widget _buildSummaryCard(String title, int count, Color color, IconData icon) {
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
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "$count",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickingListCard(Map<String, dynamic> pickingList) {
    String status = "${pickingList["status"]}";
    double itemProgress = (pickingList["pickedItems"] as num) / (pickingList["totalItems"] as num);
    double quantityProgress = (pickingList["pickedQuantity"] as num) / (pickingList["totalQuantity"] as num);
    bool isCompleted = status == "Completed";
    bool isPaused = status == "Paused";
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: _getStatusColor(status),
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                _getStatusIcon(status),
                color: _getStatusColor(status),
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "${pickingList["orderNumber"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStatusColor(status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${pickingList["priority"]}").withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${pickingList["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: _getPriorityColor("${pickingList["priority"]}"),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              if (isPaused)
                Icon(
                  Icons.warning,
                  color: Colors.orange,
                  size: 16,
                ),
            ],
          ),
          SizedBox(height: spSm),

          // Customer and Worker Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.business, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${pickingList["customerName"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.person, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${pickingList["assignedWorker"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
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
                    Row(
                      children: [
                        Icon(Icons.route, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${pickingList["route"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.straighten, size: 14, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "${pickingList["estimatedDistance"]}m est.",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Progress Information
          Column(
            children: [
              // Items Progress
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Items: ${pickingList["pickedItems"]}/${pickingList["totalItems"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: itemProgress,
                          backgroundColor: Colors.grey.withValues(alpha: 0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isCompleted ? successColor : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "${(itemProgress * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? successColor : primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),

              // Quantity Progress
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quantity: ${pickingList["pickedQuantity"]}/${pickingList["totalQuantity"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: quantityProgress,
                          backgroundColor: Colors.grey.withValues(alpha: 0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isCompleted ? successColor : secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "${(quantityProgress * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? successColor : secondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Sample Items (first 3)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Items (${(pickingList["items"] as List).length} total):",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  children: (pickingList["items"] as List).take(3).map((item) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _getItemStatusColor("${item["status"]}"),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${item["sku"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${item["description"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Text(
                            "${item["pickedQty"]}/${item["requestedQty"]}",
                            style: TextStyle(
                              fontSize: 9,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              if ((pickingList["items"] as List).length > 3)
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    "... and ${(pickingList["items"] as List).length - 3} more items",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),

          // Notes
          if ("${pickingList["notes"]}".isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, size: 12, color: warningColor),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "${pickingList["notes"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: warningColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spSm),
          ],

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: status == "Pending" ? "Start Picking" : 
                         status == "In Progress" ? "Update Progress" :
                         status == "Completed" ? "View Details" :
                         status == "Paused" ? "Resume" : "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.list,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.print,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Picking Lists"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Map<String, dynamic>> displayLists = filteredPickingLists;

    return Scaffold(
      appBar: AppBar(
        title: Text("Picking Lists"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            QTextField(
              label: "Search picking lists...",
              value: searchQuery,
              hint: "Search by order, customer, worker, or items",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
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
                    label: "Priority",
                    items: priorityOptions,
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Assigned Worker",
              items: workerOptions,
              value: selectedWorker,
              onChanged: (value, label) {
                selectedWorker = value;
                setState(() {});
              },
            ),

            // Summary Cards
            _buildSummaryCards(),

            // Results Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${displayLists.length} picking lists found",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Picking Lists
            if (displayLists.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.inventory,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No picking lists found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or create a new picking list",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Create Picking List",
                      icon: Icons.add,
                      size: bs.md,
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            else
              Column(
                children: displayLists.map((list) => _buildPickingListCard(list)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
