import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlInvoice7View extends StatefulWidget {
  @override
  State<GrlInvoice7View> createState() => _GrlInvoice7ViewState();
}

class _GrlInvoice7ViewState extends State<GrlInvoice7View> {
  List<Map<String, dynamic>> paymentHistory = [
    {
      "id": "PAY-001",
      "invoiceId": "INV-2024-001",
      "clientName": "TechStart Inc.",
      "amount": 4250.0,
      "paymentDate": "2024-01-20",
      "paymentMethod": "Bank Transfer",
      "status": "Completed",
      "reference": "TXN-123456789",
      "description": "Website Development Payment",
    },
    {
      "id": "PAY-002",
      "invoiceId": "INV-2024-002",
      "clientName": "Digital Solutions Ltd.",
      "amount": 1850.0,
      "paymentDate": "2024-01-18",
      "paymentMethod": "Credit Card",
      "status": "Completed",
      "reference": "CC-987654321",
      "description": "Logo Design Payment",
    },
    {
      "id": "PAY-003",
      "invoiceId": "INV-2024-003",
      "clientName": "Marketing Pro Agency",
      "amount": 3200.0,
      "paymentDate": "2024-01-15",
      "paymentMethod": "PayPal",
      "status": "Pending",
      "reference": "PP-456789123",
      "description": "SEO Optimization Payment",
    },
    {
      "id": "PAY-004",
      "invoiceId": "INV-2024-004",
      "clientName": "StartUp Innovations",
      "amount": 2750.0,
      "paymentDate": "2024-01-12",
      "paymentMethod": "Check",
      "status": "Processing",
      "reference": "CHK-789123456",
      "description": "Content Management Payment",
    },
    {
      "id": "PAY-005",
      "invoiceId": "INV-2024-005",
      "clientName": "E-Commerce Solutions",
      "amount": 5400.0,
      "paymentDate": "2024-01-10",
      "paymentMethod": "Bank Transfer",
      "status": "Failed",
      "reference": "TXN-321654987",
      "description": "E-commerce Platform Payment",
    },
  ];

  String searchQuery = "";
  String selectedStatus = "All";
  String selectedMethod = "All";
  String dateFilter = "All Time";

  List<String> statusOptions = ["All", "Completed", "Pending", "Processing", "Failed"];
  List<String> methodOptions = ["All", "Bank Transfer", "Credit Card", "PayPal", "Check"];
  List<String> dateOptions = ["All Time", "This Week", "This Month", "Last Month"];

  List<Map<String, dynamic>> get filteredPayments {
    var filtered = paymentHistory;

    if (selectedStatus != "All") {
      filtered = filtered.where((payment) => payment["status"] == selectedStatus).toList();
    }

    if (selectedMethod != "All") {
      filtered = filtered.where((payment) => payment["paymentMethod"] == selectedMethod).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((payment) =>
          payment["clientName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          payment["invoiceId"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          payment["reference"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  double get totalReceived => paymentHistory
      .where((payment) => payment["status"] == "Completed")
      .fold(0.0, (sum, payment) => sum + (payment["amount"] as double));

  double get totalPending => paymentHistory
      .where((payment) => payment["status"] == "Pending" || payment["status"] == "Processing")
      .fold(0.0, (sum, payment) => sum + (payment["amount"] as double));

  double get totalFailed => paymentHistory
      .where((payment) => payment["status"] == "Failed")
      .fold(0.0, (sum, payment) => sum + (payment["amount"] as double));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment History"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _exportPayments,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshPayments,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            _buildPaymentSummary(),
            _buildFilterSection(),
            _buildPaymentsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total Received",
          totalReceived,
          successColor,
          Icons.check_circle,
          "+12.5%",
          true,
        ),
        _buildSummaryCard(
          "Pending",
          totalPending,
          warningColor,
          Icons.access_time,
          "+5.2%",
          true,
        ),
        _buildSummaryCard(
          "Failed",
          totalFailed,
          dangerColor,
          Icons.error,
          "-2.1%",
          false,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, double amount, Color color, IconData icon, String change, bool isPositive) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 28,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isPositive ? successColor.withAlpha(25) : dangerColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    color: isPositive ? successColor : dangerColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          Text(
            "\$${amount.currency}",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            "This Month",
            style: TextStyle(
              color: disabledColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.filter_list,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Filter Payments",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by client, invoice, or reference...",
                prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spSm,
                ),
              ),
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: DropdownButton<String>(
                    value: selectedStatus,
                    isExpanded: true,
                    underline: SizedBox.shrink(),
                    hint: Text("Status"),
                    items: statusOptions.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedStatus = value!;
                      setState(() {});
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: DropdownButton<String>(
                    value: selectedMethod,
                    isExpanded: true,
                    underline: SizedBox.shrink(),
                    hint: Text("Method"),
                    items: methodOptions.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedMethod = value!;
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment History (${filteredPayments.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spXs,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.sort,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: _exportPayments,
                      child: Icon(
                        Icons.download,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (filteredPayments.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.payment,
                    size: 64,
                    color: disabledColor,
                  ),
                  Text(
                    "No payments found",
                    style: TextStyle(
                      fontSize: fsH6,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search or filter criteria",
                    style: TextStyle(
                      color: disabledColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          else
            ...List.generate(filteredPayments.length, (index) {
              final payment = filteredPayments[index];
              return _buildPaymentItem(payment, index == filteredPayments.length - 1);
            }),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(Map<String, dynamic> payment, bool isLast) {
    Color statusColor = _getStatusColor(payment["status"]);
    IconData methodIcon = _getMethodIcon(payment["paymentMethod"]);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: isLast ? null : Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              methodIcon,
              color: statusColor,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${payment["id"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${payment["status"]}",
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${payment["clientName"]}",
                      style: TextStyle(
                        fontSize: 15,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(payment["amount"] as double).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.receipt,
                      size: 14,
                      color: disabledColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${payment["invoiceId"]}",
                      style: TextStyle(
                        color: disabledColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: disabledColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${payment["paymentDate"]}",
                      style: TextStyle(
                        color: disabledColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          methodIcon,
                          size: 14,
                          color: disabledColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${payment["paymentMethod"]}",
                          style: TextStyle(
                            color: disabledColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: spXs,
                      children: [
                        GestureDetector(
                          onTap: () => _viewPaymentDetails(payment),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.visibility,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (payment["status"] == "Pending" || payment["status"] == "Processing")
                          GestureDetector(
                            onTap: () => _processPayment(payment),
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.check,
                                size: 16,
                                color: successColor,
                              ),
                            ),
                          ),
                        if (payment["status"] == "Failed")
                          GestureDetector(
                            onTap: () => _retryPayment(payment),
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.refresh,
                                size: 16,
                                color: warningColor,
                              ),
                            ),
                          ),
                        GestureDetector(
                          onTap: () => _downloadReceipt(payment),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.download,
                              size: 16,
                              color: infoColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (payment["description"] != null && payment["description"].toString().isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: spXs),
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${payment["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Processing":
        return infoColor;
      case "Failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getMethodIcon(String method) {
    switch (method) {
      case "Bank Transfer":
        return Icons.account_balance;
      case "Credit Card":
        return Icons.credit_card;
      case "PayPal":
        return Icons.payment;
      case "Check":
        return Icons.check;
      default:
        return Icons.payment;
    }
  }

  void _viewPaymentDetails(Map<String, dynamic> payment) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    _buildDetailRow("Payment ID", "${payment["id"]}"),
                    _buildDetailRow("Invoice ID", "${payment["invoiceId"]}"),
                    _buildDetailRow("Client", "${payment["clientName"]}"),
                    _buildDetailRow("Amount", "\$${(payment["amount"] as double).currency}"),
                    _buildDetailRow("Payment Date", "${payment["paymentDate"]}"),
                    _buildDetailRow("Payment Method", "${payment["paymentMethod"]}"),
                    _buildDetailRow("Status", "${payment["status"]}"),
                    _buildDetailRow("Reference", "${payment["reference"]}"),
                    if (payment["description"] != null)
                      _buildDetailRow("Description", "${payment["description"]}"),
                  ],
                ),
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Download Receipt",
                      size: bs.md,
                      icon: Icons.download,
                      onPressed: () {
                        Navigator.pop(context);
                        _downloadReceipt(payment);
                      },
                    ),
                  ),
                  if (payment["status"] == "Failed")
                    Expanded(
                      child: QButton(
                        label: "Retry Payment",
                        size: bs.md,
                        icon: Icons.refresh,
                        onPressed: () {
                          Navigator.pop(context);
                          _retryPayment(payment);
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

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label:",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void _processPayment(Map<String, dynamic> payment) async {
    bool isConfirmed = await confirm("Mark this payment as completed?");
    if (isConfirmed) {
      payment["status"] = "Completed";
      setState(() {});
      ss("Payment marked as completed");
    }
  }

  void _retryPayment(Map<String, dynamic> payment) {
    payment["status"] = "Processing";
    setState(() {});
    si("Payment retry initiated");
  }

  void _downloadReceipt(Map<String, dynamic> payment) {
    ss("Receipt downloaded for ${payment["id"]}");
  }

  void _exportPayments() {
    ss("Payment history exported successfully");
  }

  void _refreshPayments() {
    si("Payment history refreshed");
  }
}
