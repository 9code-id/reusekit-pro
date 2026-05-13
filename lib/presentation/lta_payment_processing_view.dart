import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaPaymentProcessingView extends StatefulWidget {
  const LtaPaymentProcessingView({super.key});

  @override
  State<LtaPaymentProcessingView> createState() => _LtaPaymentProcessingViewState();
}

class _LtaPaymentProcessingViewState extends State<LtaPaymentProcessingView> {
  bool loading = true;
  String selectedStatus = "All";
  String selectedMethod = "All";
  String searchQuery = "";
  String selectedPeriod = "This Month";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Processing", "value": "Processing"},
    {"label": "Failed", "value": "Failed"},
    {"label": "Refunded", "value": "Refunded"},
    {"label": "Pending", "value": "Pending"},
  ];

  List<Map<String, dynamic>> methodOptions = [
    {"label": "All", "value": "All"},
    {"label": "Credit Card", "value": "Credit Card"},
    {"label": "Bank Transfer", "value": "Bank Transfer"},
    {"label": "PayPal", "value": "PayPal"},
    {"label": "Cash", "value": "Cash"},
    {"label": "Check", "value": "Check"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> payments = [
    {
      "id": "PAY-2024-001",
      "invoiceId": "INV-2024-001",
      "clientName": "Express Logistics Co.",
      "amount": 2450.75,
      "currency": "USD",
      "method": "Credit Card",
      "status": "Completed",
      "transactionId": "TXN_1234567890",
      "processedAt": "2024-03-14T15:30:00Z",
      "fee": 73.52,
      "netAmount": 2377.23,
      "cardLast4": "4567",
      "cardType": "Visa",
    },
    {
      "id": "PAY-2024-002",
      "invoiceId": "INV-2024-002",
      "clientName": "Global Transport Ltd.",
      "amount": 1890.00,
      "currency": "USD",
      "method": "Bank Transfer",
      "status": "Processing",
      "transactionId": "TXN_2345678901",
      "processedAt": "2024-03-15T09:15:00Z",
      "fee": 25.00,
      "netAmount": 1865.00,
      "bankAccount": "****1234",
      "bankName": "First National Bank",
    },
    {
      "id": "PAY-2024-003",
      "invoiceId": "INV-2024-003",
      "clientName": "Fast Courier Services",
      "amount": 3250.25,
      "currency": "USD",
      "method": "PayPal",
      "status": "Failed",
      "transactionId": "TXN_3456789012",
      "processedAt": "2024-03-13T11:45:00Z",
      "fee": 0.0,
      "netAmount": 0.0,
      "errorCode": "INSUFFICIENT_FUNDS",
      "errorMessage": "Insufficient funds in PayPal account",
    },
    {
      "id": "PAY-2024-004",
      "invoiceId": "INV-2024-004",
      "clientName": "Metro Delivery Network",
      "amount": 890.50,
      "currency": "USD",
      "method": "Credit Card",
      "status": "Completed",
      "transactionId": "TXN_4567890123",
      "processedAt": "2024-03-12T14:20:00Z",
      "fee": 26.72,
      "netAmount": 863.78,
      "cardLast4": "8901",
      "cardType": "MasterCard",
    },
    {
      "id": "PAY-2024-005",
      "invoiceId": "INV-2024-005",
      "clientName": "Regional Freight Co.",
      "amount": 4180.75,
      "currency": "USD",
      "method": "Bank Transfer",
      "status": "Pending",
      "transactionId": "TXN_5678901234",
      "processedAt": "2024-03-15T16:00:00Z",
      "fee": 50.00,
      "netAmount": 4130.75,
      "bankAccount": "****5678",
      "bankName": "Commerce Bank",
    },
    {
      "id": "PAY-2024-006",
      "invoiceId": "INV-2024-001",
      "clientName": "Express Logistics Co.",
      "amount": 150.00,
      "currency": "USD",
      "method": "Credit Card",
      "status": "Refunded",
      "transactionId": "TXN_6789012345",
      "processedAt": "2024-03-11T10:30:00Z",
      "fee": -4.50,
      "netAmount": 145.50,
      "cardLast4": "4567",
      "cardType": "Visa",
      "refundReason": "Service cancellation",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadPayments();
  }

  void _loadPayments() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredPayments {
    return payments.where((payment) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${payment["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${payment["invoiceId"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${payment["clientName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${payment["transactionId"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus == "All" || payment["status"] == selectedStatus;
      bool matchesMethod = selectedMethod == "All" || payment["method"] == selectedMethod;

      return matchesSearch && matchesStatus && matchesMethod;
    }).toList();
  }

  Map<String, dynamic> get paymentStats {
    double totalProcessed = payments
        .where((p) => p["status"] == "Completed")
        .fold(0.0, (sum, p) => sum + (p["amount"] as double));
    
    double totalFees = payments
        .where((p) => p["status"] == "Completed")
        .fold(0.0, (sum, p) => sum + (p["fee"] as double));
    
    double totalRefunded = payments
        .where((p) => p["status"] == "Refunded")
        .fold(0.0, (sum, p) => sum + (p["amount"] as double));
    
    double pendingAmount = payments
        .where((p) => p["status"] == "Pending" || p["status"] == "Processing")
        .fold(0.0, (sum, p) => sum + (p["amount"] as double));

    return {
      "totalProcessed": totalProcessed,
      "totalFees": totalFees,
      "totalRefunded": totalRefunded,
      "pendingAmount": pendingAmount,
      "completedCount": payments.where((p) => p["status"] == "Completed").length,
      "failedCount": payments.where((p) => p["status"] == "Failed").length,
      "pendingCount": payments.where((p) => p["status"] == "Pending" || p["status"] == "Processing").length,
      "refundedCount": payments.where((p) => p["status"] == "Refunded").length,
    };
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Processing":
        return infoColor;
      case "Failed":
        return dangerColor;
      case "Refunded":
        return warningColor;
      case "Pending":
        return secondaryColor;
      default:
        return primaryColor;
    }
  }

  IconData _getMethodIcon(String method) {
    switch (method) {
      case "Credit Card":
        return Icons.credit_card;
      case "Bank Transfer":
        return Icons.account_balance;
      case "PayPal":
        return Icons.payment;
      case "Cash":
        return Icons.money;
      case "Check":
        return Icons.receipt;
      default:
        return Icons.payment;
    }
  }

  String _formatDateTime(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return "${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  void _retryPayment(String paymentId) async {
    bool isConfirmed = await confirm("Are you sure you want to retry this payment?");
    if (isConfirmed) {
      // Find payment and update status
      int index = payments.indexWhere((p) => p["id"] == paymentId);
      if (index != -1) {
        payments[index]["status"] = "Processing";
        setState(() {});
        ss("Payment retry initiated");
        
        // Simulate processing
        await Future.delayed(Duration(seconds: 3));
        payments[index]["status"] = "Completed";
        setState(() {});
        ss("Payment completed successfully");
      }
    }
  }

  void _refundPayment(String paymentId) async {
    bool isConfirmed = await confirm("Are you sure you want to refund this payment?");
    if (isConfirmed) {
      // Find payment and create refund entry
      Map<String, dynamic>? payment = payments.firstWhere(
        (p) => p["id"] == paymentId,
        orElse: () => {},
      );
      
      if (payment.isNotEmpty) {
        // Add refund entry
        payments.add({
          ...payment,
          "id": "REF-${DateTime.now().millisecondsSinceEpoch}",
          "status": "Refunded",
          "processedAt": DateTime.now().toIso8601String(),
          "fee": -(payment["fee"] as double),
          "refundReason": "Manual refund",
        });
        
        setState(() {});
        ss("Refund processed successfully");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Payment Processing"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    Map<String, dynamic> stats = paymentStats;
    List<Map<String, dynamic>> displayPayments = filteredPayments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Processing"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _loadPayments();
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              // Export payment report
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
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Processed",
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
                        "\$${((stats["totalProcessed"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "${stats["completedCount"]} payments",
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
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Pending",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
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
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "${stats["pendingCount"]} payments",
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
                            Icons.money_off,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Fees",
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
                        "\$${((stats["totalFees"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Processing fees",
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
                            Icons.error,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Failed",
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
                        "${stats["failedCount"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Failed payments",
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
            Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search payments...",
                  value: searchQuery,
                  hint: "Search by payment ID, invoice ID, client name, or transaction ID",
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
                        label: "Payment Method",
                        items: methodOptions,
                        value: selectedMethod,
                        onChanged: (value, label) {
                          selectedMethod = value;
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
                  ],
                ),
              ],
            ),

            // Payments List
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
                          Icons.payment,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Payment Transactions (${displayPayments.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Export",
                          size: bs.sm,
                          onPressed: () {
                            // Export payments
                          },
                        ),
                      ],
                    ),
                  ),
                  if (displayPayments.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.payment,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No payments found",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Try adjusting your filters",
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
                      children: displayPayments.map((payment) {
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
                                  Icon(
                                    _getMethodIcon("${payment["method"]}"),
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${payment["id"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${payment["clientName"]}",
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
                                        "\$${((payment["amount"] as double)).currency}",
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
                                          color: _getStatusColor("${payment["status"]}").withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${payment["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: _getStatusColor("${payment["status"]}"),
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
                                  Text(
                                    "${payment["method"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (payment["cardLast4"] != null) ...[
                                    Text(
                                      " •••• ${payment["cardLast4"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                  SizedBox(width: spSm),
                                  Text(
                                    _formatDateTime("${payment["processedAt"]}"),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  if (payment["status"] == "Failed")
                                    QButton(
                                      label: "Retry",
                                      size: bs.sm,
                                      onPressed: () => _retryPayment("${payment["id"]}"),
                                    ),
                                  if (payment["status"] == "Completed") ...[
                                    QButton(
                                      label: "Refund",
                                      size: bs.sm,
                                      onPressed: () => _refundPayment("${payment["id"]}"),
                                    ),
                                    SizedBox(width: spXs),
                                  ],
                                  QButton(
                                    label: "Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      // View payment details
                                    },
                                  ),
                                ],
                              ),
                              if (payment["errorMessage"] != null)
                                Container(
                                  margin: EdgeInsets.only(top: spXs),
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.error,
                                        size: 14,
                                        color: dangerColor,
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          "${payment["errorMessage"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: dangerColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
