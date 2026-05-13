import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaBillingSystemView extends StatefulWidget {
  const LtaBillingSystemView({super.key});

  @override
  State<LtaBillingSystemView> createState() => _LtaBillingSystemViewState();
}

class _LtaBillingSystemViewState extends State<LtaBillingSystemView> {
  bool loading = true;
  String selectedPeriod = "This Month";
  String selectedStatus = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> billingData = [
    {
      "id": "INV-2024-001",
      "clientName": "Express Logistics Co.",
      "clientId": "CLIENT_001",
      "amount": 2450.75,
      "currency": "USD",
      "status": "Paid",
      "issueDate": "2024-03-15T00:00:00Z",
      "dueDate": "2024-04-15T00:00:00Z",
      "paidDate": "2024-03-14T00:00:00Z",
      "services": ["Standard Delivery", "Express Shipping"],
      "itemCount": 15,
      "weight": 125.5,
      "distance": 450.0,
    },
    {
      "id": "INV-2024-002",
      "clientName": "Global Transport Ltd.",
      "clientId": "CLIENT_002",
      "amount": 1890.00,
      "currency": "USD",
      "status": "Pending",
      "issueDate": "2024-03-14T00:00:00Z",
      "dueDate": "2024-04-14T00:00:00Z",
      "paidDate": null,
      "services": ["Warehouse Storage", "Local Delivery"],
      "itemCount": 8,
      "weight": 89.2,
      "distance": 125.0,
    },
    {
      "id": "INV-2024-003",
      "clientName": "Fast Courier Services",
      "clientId": "CLIENT_003",
      "amount": 3250.25,
      "currency": "USD",
      "status": "Overdue",
      "issueDate": "2024-02-28T00:00:00Z",
      "dueDate": "2024-03-28T00:00:00Z",
      "paidDate": null,
      "services": ["International Shipping", "Insurance"],
      "itemCount": 22,
      "weight": 198.7,
      "distance": 1250.0,
    },
    {
      "id": "INV-2024-004",
      "clientName": "Metro Delivery Network",
      "clientId": "CLIENT_004",
      "amount": 890.50,
      "currency": "USD",
      "status": "Paid",
      "issueDate": "2024-03-10T00:00:00Z",
      "dueDate": "2024-04-10T00:00:00Z",
      "paidDate": "2024-03-09T00:00:00Z",
      "services": ["Same Day Delivery"],
      "itemCount": 3,
      "weight": 12.8,
      "distance": 45.0,
    },
    {
      "id": "INV-2024-005",
      "clientName": "Regional Freight Co.",
      "clientId": "CLIENT_005",
      "amount": 4180.75,
      "currency": "USD",
      "status": "Pending",
      "issueDate": "2024-03-12T00:00:00Z",
      "dueDate": "2024-04-12T00:00:00Z",
      "paidDate": null,
      "services": ["Freight Transportation", "Loading Service"],
      "itemCount": 45,
      "weight": 2500.0,
      "distance": 890.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadBillingData();
  }

  void _loadBillingData() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredBills {
    return billingData.where((bill) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${bill["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${bill["clientName"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus == "All" || bill["status"] == selectedStatus;

      return matchesSearch && matchesStatus;
    }).toList();
  }

  Map<String, dynamic> get billingStats {
    double totalAmount = billingData.fold(0.0, (sum, bill) => sum + (bill["amount"] as double));
    double paidAmount = billingData
        .where((bill) => bill["status"] == "Paid")
        .fold(0.0, (sum, bill) => sum + (bill["amount"] as double));
    double pendingAmount = billingData
        .where((bill) => bill["status"] == "Pending")
        .fold(0.0, (sum, bill) => sum + (bill["amount"] as double));
    double overdueAmount = billingData
        .where((bill) => bill["status"] == "Overdue")
        .fold(0.0, (sum, bill) => sum + (bill["amount"] as double));

    return {
      "totalAmount": totalAmount,
      "paidAmount": paidAmount,
      "pendingAmount": pendingAmount,
      "overdueAmount": overdueAmount,
      "totalInvoices": billingData.length,
      "paidInvoices": billingData.where((bill) => bill["status"] == "Paid").length,
      "pendingInvoices": billingData.where((bill) => bill["status"] == "Pending").length,
      "overdueInvoices": billingData.where((bill) => bill["status"] == "Overdue").length,
    };
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return successColor;
      case "Pending":
        return warningColor;
      case "Overdue":
        return dangerColor;
      case "Cancelled":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  String _formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Billing System"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    Map<String, dynamic> stats = billingStats;
    List<Map<String, dynamic>> displayBills = filteredBills;

    return Scaffold(
      appBar: AppBar(
        title: Text("Billing System"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Create new invoice
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              // Export billing report
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
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
                            Icons.attach_money,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Revenue",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${((stats["totalAmount"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stats["totalInvoices"]} invoices",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Paid",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${((stats["paidAmount"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "${stats["paidInvoices"]} invoices",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                            Icons.access_time,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Pending",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${((stats["pendingAmount"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "${stats["pendingInvoices"]} invoices",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                            Icons.warning,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Overdue",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${((stats["overdueAmount"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "${stats["overdueInvoices"]} invoices",
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

            // Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search invoices...",
                    value: searchQuery,
                    hint: "Search by ID or client name",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: periodOptions,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
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

            // Billing List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.receipt,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Invoices (${displayBills.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Generate Report",
                          size: bs.sm,
                          onPressed: () {
                            // Generate billing report
                          },
                        ),
                      ],
                    ),
                  ),
                  if (displayBills.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.receipt_long,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No invoices found",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Try adjusting your filters or create a new invoice",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: displayBills.map((bill) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${bill["id"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "${bill["clientName"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\$${((bill["amount"] as double)).currency}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor("${bill["status"]}").withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${bill["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: _getStatusColor("${bill["status"]}"),
                                            fontWeight: FontWeight.w600,
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
                                    Icons.date_range,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Due: ${_formatDate("${bill["dueDate"]}")}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.inventory_2,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${bill["itemCount"]} items",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.scale,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${(bill["weight"] as double).toStringAsFixed(1)} kg",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      // View invoice details
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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
