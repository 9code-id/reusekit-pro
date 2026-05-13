import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaPackageListView extends StatefulWidget {
  const DlaPackageListView({super.key});

  @override
  State<DlaPackageListView> createState() => _DlaPackageListViewState();
}

class _DlaPackageListViewState extends State<DlaPackageListView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedPriority = "all";
  String selectedDateRange = "all";
  
  final List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Created", "value": "created"},
    {"label": "In Transit", "value": "in_transit"},
    {"label": "Out for Delivery", "value": "out_for_delivery"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Failed", "value": "failed"},
    {"label": "Returned", "value": "returned"},
  ];

  final List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": "all"},
    {"label": "Standard", "value": "standard"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Express", "value": "express"},
    {"label": "Overnight", "value": "overnight"},
  ];

  final List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "All Time", "value": "all"},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "3months"},
  ];

  final List<Map<String, dynamic>> packages = [
    {
      "id": "PKG-2024-001",
      "trackingNumber": "DLA001234567890",
      "packageName": "Samsung Galaxy S24",
      "category": "electronics",
      "weight": 0.8,
      "value": 12000000,
      "priority": "express",
      "status": "delivered",
      "senderName": "Tech Store Jakarta",
      "recipientName": "John Smith",
      "recipientPhone": "+62 812 3456 7890",
      "recipientAddress": "Jl. Sudirman No. 45, Jakarta Pusat",
      "createdDate": "2024-01-10",
      "deliveredDate": "2024-01-12",
      "fragile": true,
      "requiresSignature": true,
      "cashOnDelivery": false,
      "estimatedDelivery": "2024-01-12",
      "actualDelivery": "2024-01-12 14:30",
      "driverName": "Ahmad Santoso",
      "vehicleId": "DLA-001",
    },
    {
      "id": "PKG-2024-002",
      "trackingNumber": "DLA001234567891",
      "packageName": "Nike Air Max 270",
      "category": "clothing",
      "weight": 1.2,
      "value": 1800000,
      "priority": "medium",
      "status": "in_transit",
      "senderName": "Fashion Hub Bandung",
      "recipientName": "Sarah Johnson",
      "recipientPhone": "+62 813 4567 8901",
      "recipientAddress": "Jl. Asia Afrika No. 88, Bandung",
      "createdDate": "2024-01-14",
      "deliveredDate": null,
      "fragile": false,
      "requiresSignature": false,
      "cashOnDelivery": true,
      "estimatedDelivery": "2024-01-16",
      "actualDelivery": null,
      "driverName": "Budi Prakoso",
      "vehicleId": "DLA-002",
    },
    {
      "id": "PKG-2024-003",
      "trackingNumber": "DLA001234567892",
      "packageName": "Coffee Bean Premium",
      "category": "food",
      "weight": 2.5,
      "value": 450000,
      "priority": "standard",
      "status": "out_for_delivery",
      "senderName": "Coffee Roasters Surabaya",
      "recipientName": "Mike Wilson",
      "recipientPhone": "+62 814 5678 9012",
      "recipientAddress": "Jl. Pemuda No. 123, Surabaya",
      "createdDate": "2024-01-13",
      "deliveredDate": null,
      "fragile": true,
      "requiresSignature": false,
      "cashOnDelivery": false,
      "estimatedDelivery": "2024-01-15",
      "actualDelivery": null,
      "driverName": "Sari Indah",
      "vehicleId": "DLA-004",
    },
    {
      "id": "PKG-2024-004",
      "trackingNumber": "DLA001234567893",
      "packageName": "Programming Books Set",
      "category": "books",
      "weight": 3.0,
      "value": 750000,
      "priority": "high",
      "status": "failed",
      "senderName": "Tech Books Publisher",
      "recipientName": "Lisa Brown",
      "recipientPhone": "+62 815 6789 0123",
      "recipientAddress": "Jl. Diponegoro No. 67, Yogyakarta",
      "createdDate": "2024-01-11",
      "deliveredDate": null,
      "fragile": false,
      "requiresSignature": true,
      "cashOnDelivery": false,
      "estimatedDelivery": "2024-01-13",
      "actualDelivery": null,
      "driverName": "Eko Widodo",
      "vehicleId": "DLA-003",
      "failureReason": "Recipient not available, address incorrect",
    },
    {
      "id": "PKG-2024-005",
      "trackingNumber": "DLA001234567894",
      "packageName": "Garden Tools Set",
      "category": "home",
      "weight": 4.5,
      "value": 850000,
      "priority": "overnight",
      "status": "created",
      "senderName": "Garden Pro Tools",
      "recipientName": "Tom Anderson",
      "recipientPhone": "+62 816 7890 1234",
      "recipientAddress": "Jl. Gatot Subroto No. 99, Medan",
      "createdDate": "2024-01-15",
      "deliveredDate": null,
      "fragile": false,
      "requiresSignature": true,
      "cashOnDelivery": true,
      "estimatedDelivery": "2024-01-16",
      "actualDelivery": null,
      "driverName": null,
      "vehicleId": null,
    },
  ];

  List<Map<String, dynamic>> get filteredPackages {
    return packages.where((package) {
      bool matchesSearch = package["packageName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          package["trackingNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          package["recipientName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          package["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || package["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "all" || package["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "created":
        return infoColor;
      case "in_transit":
        return warningColor;
      case "out_for_delivery":
        return primaryColor;
      case "delivered":
        return successColor;
      case "failed":
        return dangerColor;
      case "returned":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "standard":
        return successColor;
      case "medium":
        return infoColor;
      case "high":
        return warningColor;
      case "express":
        return dangerColor;
      case "overnight":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "created":
        return "Created";
      case "in_transit":
        return "In Transit";
      case "out_for_delivery":
        return "Out for Delivery";
      case "delivered":
        return "Delivered";
      case "failed":
        return "Failed";
      case "returned":
        return "Returned";
      default:
        return "Unknown";
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "electronics":
        return Icons.devices;
      case "clothing":
        return Icons.checkroom;
      case "food":
        return Icons.restaurant;
      case "books":
        return Icons.menu_book;
      case "home":
        return Icons.home;
      case "health":
        return Icons.health_and_safety;
      case "documents":
        return Icons.description;
      default:
        return Icons.inventory;
    }
  }

  Widget _buildPackageSummary() {
    int totalPackages = packages.length;
    int inTransit = packages.where((p) => p["status"] == "in_transit").length;
    int delivered = packages.where((p) => p["status"] == "delivered").length;
    int failed = packages.where((p) => p["status"] == "failed").length;
    int outForDelivery = packages.where((p) => p["status"] == "out_for_delivery").length;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Package Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$totalPackages",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$inTransit",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "In Transit",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$outForDelivery",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Out for Delivery",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$delivered",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Delivered",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$failed",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Failed",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search",
                  value: searchQuery,
                  hint: "Search by name, tracking number, or recipient",
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
                  si("Searching for: $searchQuery");
                },
              ),
            ],
          ),
          Row(
            spacing: spSm,
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
              Expanded(
                child: QDropdownField(
                  label: "Date Range",
                  items: dateRangeOptions,
                  value: selectedDateRange,
                  onChanged: (value, label) {
                    selectedDateRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(Map<String, dynamic> package) {
    Color statusColor = _getStatusColor(package["status"]);
    Color priorityColor = _getPriorityColor(package["priority"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                _getCategoryIcon(package["category"]),
                color: primaryColor,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${package["packageName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${package["id"]} - ${package["trackingNumber"]}",
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
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      _getStatusLabel(package["status"]),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${package["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: priorityColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
                    Icon(Icons.person, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "To: ${package["recipientName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone, color: disabledBoldColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${package["recipientPhone"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: disabledBoldColor, size: 14),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${package["recipientAddress"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            spacing: spLg,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${package["weight"]} kg",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Weight",
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${((package["value"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Value",
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${package["createdDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Created",
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
          if (package["fragile"] == true || package["requiresSignature"] == true || package["cashOnDelivery"] == true)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                spacing: spSm,
                children: [
                  if (package["fragile"] == true)
                    Row(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 14),
                        SizedBox(width: 2),
                        Text(
                          "Fragile",
                          style: TextStyle(
                            fontSize: 10,
                            color: warningColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  if (package["requiresSignature"] == true)
                    Row(
                      children: [
                        Icon(Icons.edit, color: infoColor, size: 14),
                        SizedBox(width: 2),
                        Text(
                          "Signature",
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  if (package["cashOnDelivery"] == true)
                    Row(
                      children: [
                        Icon(Icons.payment, color: successColor, size: 14),
                        SizedBox(width: 2),
                        Text(
                          "COD",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          if (package["status"] == "failed" && package["failureReason"] != null)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.error, color: dangerColor, size: 14),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Failure: ${package["failureReason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Track",
                  size: bs.sm,
                  onPressed: () {
                    si("Track package ${package["trackingNumber"]}");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Details",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("View details for ${package["id"]}");
                  },
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  si("More options for ${package["id"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Package Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              si("Create new package");
            },
          ),
          QButton(
            icon: Icons.file_download,
            size: bs.sm,
            onPressed: () {
              si("Export package data");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPackageSummary(),
            _buildFilterSection(),
            if (filteredPackages.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 64, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "No packages found",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredPackages.map((package) => _buildPackageCard(package)).toList(),
          ],
        ),
      ),
    );
  }
}
