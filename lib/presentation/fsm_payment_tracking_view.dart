import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmPaymentTrackingView extends StatefulWidget {
  const FsmPaymentTrackingView({super.key});

  @override
  State<FsmPaymentTrackingView> createState() => _FsmPaymentTrackingViewState();
}

class _FsmPaymentTrackingViewState extends State<FsmPaymentTrackingView> {
  String selectedStatus = "All";
  String selectedTimeframe = "This Month";
  String searchQuery = "";
  DateTime startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime endDate = DateTime.now();

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "Failed", "value": "Failed"},
    {"label": "Refunded", "value": "Refunded"},
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> payments = [
    {
      "id": "PAY-2024-001",
      "invoiceId": "INV-2024-001",
      "client": "ABC Corporation",
      "amount": 1250.00,
      "paymentDate": "2024-01-28",
      "dueDate": "2024-01-31",
      "method": "Bank Transfer",
      "status": "Paid",
      "reference": "REF-123456",
      "currency": "USD",
      "fees": 12.50,
      "netAmount": 1237.50,
    },
    {
      "id": "PAY-2024-002",
      "invoiceId": "INV-2024-002",
      "client": "XYZ Industries",
      "amount": 875.50,
      "paymentDate": null,
      "dueDate": "2024-02-15",
      "method": "Credit Card",
      "status": "Pending",
      "reference": "REF-123457",
      "currency": "USD",
      "fees": 26.27,
      "netAmount": 849.23,
    },
    {
      "id": "PAY-2024-003",
      "invoiceId": "INV-2024-003",
      "client": "Tech Solutions Inc",
      "amount": 2100.00,
      "paymentDate": null,
      "dueDate": "2024-01-15",
      "method": "PayPal",
      "status": "Overdue",
      "reference": "REF-123458",
      "currency": "USD",
      "fees": 63.00,
      "netAmount": 2037.00,
    },
    {
      "id": "PAY-2024-004",
      "invoiceId": "INV-2024-004",
      "client": "Global Industries",
      "amount": 650.25,
      "paymentDate": "2024-01-30",
      "dueDate": "2024-02-01",
      "method": "Digital Wallet",
      "status": "Paid",
      "reference": "REF-123459",
      "currency": "USD",
      "fees": 19.51,
      "netAmount": 630.74,
    },
    {
      "id": "PAY-2024-005",
      "invoiceId": "INV-2024-005",
      "client": "StartUp Co",
      "amount": 425.00,
      "paymentDate": "2024-01-25",
      "dueDate": "2024-01-25",
      "method": "Credit Card",
      "status": "Failed",
      "reference": "REF-123460",
      "currency": "USD",
      "fees": 12.75,
      "netAmount": 412.25,
    },
    {
      "id": "PAY-2024-006",
      "invoiceId": "INV-2024-006",
      "client": "Enterprise Corp",
      "amount": 3200.00,
      "paymentDate": "2024-01-20",
      "dueDate": "2024-01-20",
      "method": "Bank Transfer",
      "status": "Refunded",
      "reference": "REF-123461",
      "currency": "USD",
      "fees": 0.00,
      "netAmount": 3200.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportReport,
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildPaymentSummary(),
            _buildFilters(),
            _buildPaymentsList(),
            _buildPaymentAnalytics(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummary() {
    double totalPaid = payments
        .where((p) => p["status"] == "Paid")
        .fold(0.0, (sum, p) => sum + (p["amount"] as num).toDouble());
    
    double totalPending = payments
        .where((p) => p["status"] == "Pending")
        .fold(0.0, (sum, p) => sum + (p["amount"] as num).toDouble());

    double totalOverdue = payments
        .where((p) => p["status"] == "Overdue")
        .fold(0.0, (sum, p) => sum + (p["amount"] as num).toDouble());

    int totalCount = payments.length;

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
            "Payment Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(child: _buildSummaryCard("Total Payments", "$totalCount", primaryColor, Icons.payment)),
              SizedBox(width: spSm),
              Expanded(child: _buildSummaryCard("Paid", "\$${totalPaid.toStringAsFixed(0)}", successColor, Icons.check_circle)),
            ],
          ),
          Row(
            children: [
              Expanded(child: _buildSummaryCard("Pending", "\$${totalPending.toStringAsFixed(0)}", warningColor, Icons.schedule)),
              SizedBox(width: spSm),
              Expanded(child: _buildSummaryCard("Overdue", "\$${totalOverdue.toStringAsFixed(0)}", dangerColor, Icons.warning)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(51)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w600,
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
            "Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Search Payments",
            value: searchQuery,
            hint: "Search by client, invoice ID, or reference...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Payment Status",
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
                  label: "Timeframe",
                  items: timeframeOptions,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (selectedTimeframe == "Custom Range") ...[
            Row(
              children: [
                Expanded(
                  child: QDatePicker(
                    label: "Start Date",
                    value: startDate,
                    onChanged: (value) {
                      startDate = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDatePicker(
                    label: "End Date",
                    value: endDate,
                    onChanged: (value) {
                      endDate = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Apply Filters",
                  size: bs.sm,
                  onPressed: _applyFilters,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Clear Filters",
                  size: bs.sm,
                  onPressed: _clearFilters,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentsList() {
    List<Map<String, dynamic>> filteredPayments = payments;

    if (selectedStatus != "All") {
      filteredPayments = filteredPayments.where((p) => p["status"] == selectedStatus).toList();
    }

    if (searchQuery.isNotEmpty) {
      filteredPayments = filteredPayments.where((p) =>
          p["client"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          p["invoiceId"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          p["reference"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment Transactions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${filteredPayments.length} payments",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ...filteredPayments.map((payment) => _buildPaymentItem(payment)),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(Map<String, dynamic> payment) {
    Color statusColor;
    IconData statusIcon;
    
    switch (payment["status"]) {
      case "Paid":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        break;
      case "Pending":
        statusColor = warningColor;
        statusIcon = Icons.schedule;
        break;
      case "Overdue":
        statusColor = dangerColor;
        statusIcon = Icons.warning;
        break;
      case "Failed":
        statusColor = dangerColor;
        statusIcon = Icons.error;
        break;
      case "Refunded":
        statusColor = infoColor;
        statusIcon = Icons.undo;
        break;
      default:
        statusColor = disabledBoldColor;
        statusIcon = Icons.payment;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  statusIcon,
                  color: statusColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${payment["client"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${payment["invoiceId"]} • ${payment["method"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Ref: ${payment["reference"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((payment["amount"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${payment["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Due Date:",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "${payment["dueDate"]}",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                if (payment["paymentDate"] != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Paid Date:",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                      Text(
                        "${payment["paymentDate"]}",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fees:",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "\$${((payment["fees"] as num).toDouble()).toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Net Amount:",
                      style: TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "\$${((payment["netAmount"] as num).toDouble()).toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewPaymentDetails(payment),
                ),
              ),
              SizedBox(width: spSm),
              if (payment["status"] == "Pending") ...[
                Expanded(
                  child: QButton(
                    label: "Send Reminder",
                    size: bs.sm,
                    onPressed: () => _sendReminder(payment),
                  ),
                ),
              ] else if (payment["status"] == "Failed") ...[
                Expanded(
                  child: QButton(
                    label: "Retry Payment",
                    size: bs.sm,
                    onPressed: () => _retryPayment(payment),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: QButton(
                    label: "Download Receipt",
                    size: bs.sm,
                    onPressed: () => _downloadReceipt(payment),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentAnalytics() {
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
            "Payment Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildAnalyticsRow("Success Rate", "87.5%", successColor),
          _buildAnalyticsRow("Average Payment Time", "2.3 days", infoColor),
          _buildAnalyticsRow("Total Processing Fees", "\$154.03", warningColor),
          _buildAnalyticsRow("Collection Efficiency", "92.1%", primaryColor),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Detailed Analytics",
              size: bs.md,
              onPressed: () {
                // Navigate to detailed analytics
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsRow(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _applyFilters() {
    setState(() {});
    si("Filters applied");
  }

  void _clearFilters() {
    selectedStatus = "All";
    selectedTimeframe = "This Month";
    searchQuery = "";
    setState(() {});
    si("Filters cleared");
  }

  void _exportReport() {
    ss("Payment report exported successfully!");
  }

  void _viewPaymentDetails(Map<String, dynamic> payment) {
    // Navigate to payment details
  }

  void _sendReminder(Map<String, dynamic> payment) {
    ss("Payment reminder sent to ${payment["client"]}");
  }

  void _retryPayment(Map<String, dynamic> payment) {
    ss("Payment retry initiated for ${payment["invoiceId"]}");
  }

  void _downloadReceipt(Map<String, dynamic> payment) {
    ss("Receipt downloaded for ${payment["invoiceId"]}");
  }
}
