import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaInvoicePaymentView extends StatefulWidget {
  const AbaInvoicePaymentView({super.key});

  @override
  State<AbaInvoicePaymentView> createState() => _AbaInvoicePaymentViewState();
}

class _AbaInvoicePaymentViewState extends State<AbaInvoicePaymentView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedMethod = "All";
  String dateFilter = "All Time";
  int currentTab = 0;

  final List<Map<String, dynamic>> paymentStatuses = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "pending"},
    {"label": "Processing", "value": "processing"},
    {"label": "Completed", "value": "completed"},
    {"label": "Failed", "value": "failed"},
    {"label": "Refunded", "value": "refunded"},
  ];

  final List<Map<String, dynamic>> paymentMethods = [
    {"label": "All", "value": "All"},
    {"label": "Bank Transfer", "value": "bank_transfer"},
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "PayPal", "value": "paypal"},
    {"label": "Stripe", "value": "stripe"},
    {"label": "Cash", "value": "cash"},
  ];

  final List<Map<String, dynamic>> dateFilters = [
    {"label": "All Time", "value": "All Time"},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "3months"},
  ];

  List<Map<String, dynamic>> payments = [
    {
      "id": "PAY-001",
      "invoice_id": "INV-2024-001",
      "client_name": "Tech Solutions Inc",
      "amount": 2500.00,
      "payment_method": "bank_transfer",
      "payment_method_label": "Bank Transfer",
      "status": "completed",
      "transaction_id": "TXN-789456123",
      "payment_date": "2024-06-15",
      "processing_fee": 25.00,
      "net_amount": 2475.00,
      "reference": "Wire Transfer - Chase Bank",
      "notes": "Payment received via wire transfer",
    },
    {
      "id": "PAY-002",
      "invoice_id": "INV-2024-002",
      "client_name": "Global Marketing LLC",
      "amount": 1800.00,
      "payment_method": "credit_card",
      "payment_method_label": "Credit Card",
      "status": "processing",
      "transaction_id": "TXN-456789012",
      "payment_date": "2024-06-18",
      "processing_fee": 54.00,
      "net_amount": 1746.00,
      "reference": "Visa ending in 4532",
      "notes": "Payment processing via Stripe",
    },
    {
      "id": "PAY-003",
      "invoice_id": "INV-2024-003",
      "client_name": "StartupHub Co",
      "amount": 950.00,
      "payment_method": "paypal",
      "payment_method_label": "PayPal",
      "status": "completed",
      "transaction_id": "TXN-321654987",
      "payment_date": "2024-06-14",
      "processing_fee": 28.50,
      "net_amount": 921.50,
      "reference": "PayPal - startup@hub.com",
      "notes": "PayPal instant payment",
    },
    {
      "id": "PAY-004",
      "invoice_id": "INV-2024-004",
      "client_name": "Design Studio Plus",
      "amount": 3200.00,
      "payment_method": "stripe",
      "payment_method_label": "Stripe",
      "status": "failed",
      "transaction_id": "TXN-987654321",
      "payment_date": "2024-06-17",
      "processing_fee": 0.00,
      "net_amount": 0.00,
      "reference": "Card declined - Insufficient funds",
      "notes": "Payment failed due to insufficient funds",
    },
    {
      "id": "PAY-005",
      "invoice_id": "INV-2024-005",
      "client_name": "Consulting Group",
      "amount": 1200.00,
      "payment_method": "cash",
      "payment_method_label": "Cash",
      "status": "completed",
      "transaction_id": "TXN-147258369",
      "payment_date": "2024-06-13",
      "processing_fee": 0.00,
      "net_amount": 1200.00,
      "reference": "Cash payment - Receipt #2024-156",
      "notes": "Cash payment received at office",
    },
    {
      "id": "PAY-006",
      "invoice_id": "INV-2024-006",
      "client_name": "E-commerce Solutions",
      "amount": 4500.00,
      "payment_method": "bank_transfer",
      "payment_method_label": "Bank Transfer",
      "status": "pending",
      "transaction_id": "TXN-258741963",
      "payment_date": "2024-06-19",
      "processing_fee": 45.00,
      "net_amount": 4455.00,
      "reference": "ACH Transfer - Wells Fargo",
      "notes": "ACH transfer initiated, awaiting confirmation",
    },
  ];

  List<Map<String, dynamic>> get filteredPayments {
    return payments.where((payment) {
      bool matchesSearch = payment["client_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          payment["invoice_id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          payment["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || payment["status"] == selectedStatus;
      bool matchesMethod = selectedMethod == "All" || payment["payment_method"] == selectedMethod;
      
      return matchesSearch && matchesStatus && matchesMethod;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return successColor;
      case 'processing':
        return warningColor;
      case 'pending':
        return infoColor;
      case 'failed':
        return dangerColor;
      case 'refunded':
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'completed':
        return 'Completed';
      case 'processing':
        return 'Processing';
      case 'pending':
        return 'Pending';
      case 'failed':
        return 'Failed';
      case 'refunded':
        return 'Refunded';
      default:
        return status;
    }
  }

  Widget _buildOverviewTab() {
    double totalPaid = payments.where((p) => p["status"] == "completed").fold(0.0, (sum, p) => sum + (p["amount"] as num).toDouble());
    double totalPending = payments.where((p) => p["status"] == "pending").fold(0.0, (sum, p) => sum + (p["amount"] as num).toDouble());
    double totalProcessing = payments.where((p) => p["status"] == "processing").fold(0.0, (sum, p) => sum + (p["amount"] as num).toDouble());
    double totalFailed = payments.where((p) => p["status"] == "failed").fold(0.0, (sum, p) => sum + (p["amount"] as num).toDouble());

    return Column(
      spacing: spMd,
      children: [
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Total Paid",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "\$${totalPaid.currency}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.pending,
                          color: infoColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "\$${totalPending.currency}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.hourglass_empty,
                          color: warningColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Processing",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "\$${totalProcessing.currency}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
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
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.error,
                          color: dangerColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Failed",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "\$${totalFailed.currency}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Payment Methods Distribution",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Column(
                spacing: spSm,
                children: [
                  _buildPaymentMethodRow("Bank Transfer", 2, successColor),
                  _buildPaymentMethodRow("Credit Card", 1, warningColor),
                  _buildPaymentMethodRow("PayPal", 1, infoColor),
                  _buildPaymentMethodRow("Stripe", 1, dangerColor),
                  _buildPaymentMethodRow("Cash", 1, secondaryColor),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodRow(String method, int count, Color color) {
    double percentage = (count / payments.length) * 100;
    
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            method,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          "$count (${percentage.toStringAsFixed(0)}%)",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentsTab() {
    return Column(
      spacing: spMd,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search payments...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.filter_list,
              size: bs.sm,
              onPressed: () => _showFilterDialog(),
            ),
          ],
        ),
        if (filteredPayments.isNotEmpty) ...[
          Column(
            spacing: spSm,
            children: filteredPayments.map((payment) => _buildPaymentCard(payment)).toList(),
          ),
        ] else ...[
          Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
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
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Try adjusting your search or filters",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor(payment["status"]),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${payment["id"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(payment["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            _getStatusLabel(payment["status"]),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(payment["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${payment["client_name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: spXs,
                children: [
                  Text(
                    "\$${(payment["amount"] as num).toDouble().currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${payment["payment_date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.credit_card,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${payment["payment_method_label"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.receipt,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${payment["invoice_id"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (payment["notes"].toString().isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${payment["notes"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
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
              if (payment["status"] == "pending") ...[
                QButton(
                  label: "Process",
                  size: bs.sm,
                  onPressed: () => _processPayment(payment),
                ),
              ] else if (payment["status"] == "failed") ...[
                QButton(
                  label: "Retry",
                  size: bs.sm,
                  onPressed: () => _retryPayment(payment),
                ),
              ] else if (payment["status"] == "completed") ...[
                QButton(
                  icon: Icons.receipt,
                  size: bs.sm,
                  onPressed: () => _generateReceipt(payment),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Payments"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spMd,
          children: [
            QDropdownField(
              label: "Status",
              items: paymentStatuses,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Payment Method",
              items: paymentMethods,
              value: selectedMethod,
              onChanged: (value, label) {
                selectedMethod = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Date Range",
              items: dateFilters,
              value: dateFilter,
              onChanged: (value, label) {
                dateFilter = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              selectedStatus = "All";
              selectedMethod = "All";
              dateFilter = "All Time";
              setState(() {});
              Navigator.pop(context);
            },
            child: Text("Clear"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Apply"),
          ),
        ],
      ),
    );
  }

  void _viewPaymentDetails(Map<String, dynamic> payment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            _buildDetailRow("Payment ID", "${payment["id"]}"),
            _buildDetailRow("Invoice ID", "${payment["invoice_id"]}"),
            _buildDetailRow("Client", "${payment["client_name"]}"),
            _buildDetailRow("Amount", "\$${(payment["amount"] as num).toDouble().currency}"),
            _buildDetailRow("Processing Fee", "\$${(payment["processing_fee"] as num).toDouble().currency}"),
            _buildDetailRow("Net Amount", "\$${(payment["net_amount"] as num).toDouble().currency}"),
            _buildDetailRow("Method", "${payment["payment_method_label"]}"),
            _buildDetailRow("Status", _getStatusLabel(payment["status"])),
            _buildDetailRow("Transaction ID", "${payment["transaction_id"]}"),
            _buildDetailRow("Reference", "${payment["reference"]}"),
            _buildDetailRow("Date", "${payment["payment_date"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            "$label:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  void _processPayment(Map<String, dynamic> payment) async {
    bool isConfirmed = await confirm("Process payment ${payment["id"]}?");
    if (isConfirmed) {
      ss("Payment processing initiated");
      // Update payment status
      payment["status"] = "processing";
      setState(() {});
    }
  }

  void _retryPayment(Map<String, dynamic> payment) async {
    bool isConfirmed = await confirm("Retry failed payment ${payment["id"]}?");
    if (isConfirmed) {
      ss("Payment retry initiated");
      // Update payment status
      payment["status"] = "processing";
      setState(() {});
    }
  }

  void _generateReceipt(Map<String, dynamic> payment) {
    ss("Receipt generated for payment ${payment["id"]}");
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Invoice Payments",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Payments", icon: Icon(Icons.payment)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildOverviewTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildPaymentsTab(),
        ),
      ],
    );
  }
}
