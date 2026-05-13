import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaPaymentTrackingView extends StatefulWidget {
  const AbaPaymentTrackingView({super.key});

  @override
  State<AbaPaymentTrackingView> createState() => _AbaPaymentTrackingViewState();
}

class _AbaPaymentTrackingViewState extends State<AbaPaymentTrackingView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  String selectedDateRange = "This Month";
  int currentTab = 0;
  bool loading = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Statuses", "value": "All"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Failed", "value": "Failed"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "All"},
    {"label": "ACH Transfer", "value": "ACH"},
    {"label": "Wire Transfer", "value": "Wire"},
    {"label": "Card Payment", "value": "Card"},
    {"label": "Check Payment", "value": "Check"},
    {"label": "Online Payment", "value": "Online"},
  ];

  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom"},
  ];

  List<Map<String, dynamic>> paymentTransactions = [
    {
      "id": "TXN001",
      "customerName": "ABC Corporation",
      "paymentMethod": "ACH Transfer",
      "amount": 15000.00,
      "status": "Completed",
      "initiatedDate": "2024-01-15",
      "completedDate": "2024-01-16",
      "reference": "REF-ABC-001",
      "bankAccount": "****1234",
      "processingTime": "24 hours",
      "fees": 25.00,
      "notes": "Regular monthly payment",
    },
    {
      "id": "TXN002",
      "customerName": "XYZ Industries",
      "paymentMethod": "Wire Transfer",
      "amount": 45000.00,
      "status": "In Progress",
      "initiatedDate": "2024-01-16",
      "completedDate": null,
      "reference": "REF-XYZ-002",
      "bankAccount": "****5678",
      "processingTime": "1-2 business days",
      "fees": 45.00,
      "notes": "Large invoice payment",
    },
    {
      "id": "TXN003",
      "customerName": "Smith & Partners",
      "paymentMethod": "Card Payment",
      "amount": 2500.00,
      "status": "Failed",
      "initiatedDate": "2024-01-16",
      "completedDate": null,
      "reference": "REF-SMP-003",
      "bankAccount": "****9012",
      "processingTime": "Instant",
      "fees": 75.00,
      "notes": "Card declined - insufficient funds",
    },
    {
      "id": "TXN004",
      "customerName": "Global Services Ltd",
      "paymentMethod": "Online Payment",
      "amount": 8750.00,
      "status": "Pending",
      "initiatedDate": "2024-01-16",
      "completedDate": null,
      "reference": "REF-GSL-004",
      "bankAccount": "****3456",
      "processingTime": "2-3 hours",
      "fees": 15.00,
      "notes": "Awaiting bank verification",
    },
    {
      "id": "TXN005",
      "customerName": "Tech Solutions Inc",
      "paymentMethod": "Check Payment",
      "amount": 12000.00,
      "status": "Completed",
      "initiatedDate": "2024-01-14",
      "completedDate": "2024-01-15",
      "reference": "REF-TSI-005",
      "bankAccount": "****7890",
      "processingTime": "3-5 business days",
      "fees": 5.00,
      "notes": "Physical check processed",
    },
  ];

  List<Map<String, dynamic>> trackingSteps = [
    {
      "step": 1,
      "title": "Payment Initiated",
      "description": "Customer submitted payment request",
      "status": "completed",
      "timestamp": "2024-01-16 09:30 AM",
    },
    {
      "step": 2,
      "title": "Payment Verification",
      "description": "Verifying customer account and payment details",
      "status": "completed",
      "timestamp": "2024-01-16 09:35 AM",
    },
    {
      "step": 3,
      "title": "Bank Processing",
      "description": "Payment submitted to bank for processing",
      "status": "in_progress",
      "timestamp": "2024-01-16 10:00 AM",
    },
    {
      "step": 4,
      "title": "Payment Completion",
      "description": "Payment successfully processed and funds transferred",
      "status": "pending",
      "timestamp": null,
    },
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    return paymentTransactions.where((transaction) {
      bool matchesSearch = searchQuery.isEmpty ||
          (transaction["customerName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (transaction["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (transaction["reference"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || transaction["status"] == selectedStatus;
      bool matchesType = selectedType == "All" || transaction["paymentMethod"].toString().contains(selectedType);
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  void _refreshData() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 1));
    
    loading = false;
    setState(() {});
    ss("Payment tracking data refreshed");
  }

  void _viewTransactionDetails(Map<String, dynamic> transaction) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 500,
          padding: EdgeInsets.all(spLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transaction Details",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              _buildDetailRow("Transaction ID", "${transaction["id"]}"),
              _buildDetailRow("Customer", "${transaction["customerName"]}"),
              _buildDetailRow("Amount", "\$${(transaction["amount"] as double).currency}"),
              _buildDetailRow("Payment Method", "${transaction["paymentMethod"]}"),
              _buildDetailRow("Status", "${transaction["status"]}"),
              _buildDetailRow("Reference", "${transaction["reference"]}"),
              _buildDetailRow("Bank Account", "${transaction["bankAccount"]}"),
              _buildDetailRow("Processing Time", "${transaction["processingTime"]}"),
              _buildDetailRow("Fees", "\$${(transaction["fees"] as double).currency}"),
              _buildDetailRow("Notes", "${transaction["notes"]}"),
              SizedBox(height: spLg),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Tracking",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.of(context).pop();
                        _showTrackingDetails(transaction);
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Export Details",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.of(context).pop();
                        ss("Transaction details exported");
                      },
                    ),
                  ),
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
      ),
    );
  }

  void _showTrackingDetails(Map<String, dynamic> transaction) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 600,
          padding: EdgeInsets.all(spLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment Tracking - ${transaction["id"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: spLg),
              ...trackingSteps.map((step) => _buildTrackingStep(step)).toList(),
              SizedBox(height: spLg),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Close",
                  size: bs.sm,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackingStep(Map<String, dynamic> step) {
    Color statusColor = step["status"] == "completed" 
        ? successColor 
        : step["status"] == "in_progress" 
            ? warningColor 
            : disabledColor;
    
    IconData statusIcon = step["status"] == "completed" 
        ? Icons.check_circle 
        : step["status"] == "in_progress" 
            ? Icons.access_time 
            : Icons.radio_button_unchecked;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: statusColor, width: 2),
            ),
            child: Center(
              child: Icon(
                statusIcon,
                color: statusColor,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${step["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${step["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                if (step["timestamp"] != null) ...[
                  SizedBox(height: spXs),
                  Text(
                    "${step["timestamp"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _retryPayment(Map<String, dynamic> transaction) async {
    bool isConfirmed = await confirm("Are you sure you want to retry this payment?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Payment retry initiated successfully");
    }
  }

  void _cancelPayment(Map<String, dynamic> transaction) async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this payment? This action cannot be undone.");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      ss("Payment cancelled successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Payment Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Payments", icon: Icon(Icons.payment)),
        Tab(text: "In Progress", icon: Icon(Icons.hourglass_empty)),
        Tab(text: "Failed", icon: Icon(Icons.error_outline)),
      ],
      tabChildren: [
        _buildAllPaymentsTab(),
        _buildInProgressTab(),
        _buildFailedPaymentsTab(),
      ],
    );
  }

  Widget _buildAllPaymentsTab() {
    return loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryCards(),
                SizedBox(height: spLg),
                _buildFiltersSection(),
                SizedBox(height: spLg),
                _buildPaymentsList(),
              ],
            ),
          );
  }

  Widget _buildInProgressTab() {
    List<Map<String, dynamic>> inProgressPayments = filteredTransactions
        .where((payment) => payment["status"] == "In Progress" || payment["status"] == "Pending")
        .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payments In Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          if (inProgressPayments.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.hourglass_empty,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No payments in progress",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          else
            ...inProgressPayments.map((payment) => _buildPaymentCard(payment)).toList(),
        ],
      ),
    );
  }

  Widget _buildFailedPaymentsTab() {
    List<Map<String, dynamic>> failedPayments = filteredTransactions
        .where((payment) => payment["status"] == "Failed")
        .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Failed Payments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          if (failedPayments.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No failed payments",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          else
            ...failedPayments.map((payment) => _buildPaymentCard(payment, showRetryOption: true)).toList(),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    int totalPayments = paymentTransactions.length;
    int completedPayments = paymentTransactions.where((p) => p["status"] == "Completed").length;
    int inProgressPayments = paymentTransactions.where((p) => p["status"] == "In Progress" || p["status"] == "Pending").length;
    int failedPayments = paymentTransactions.where((p) => p["status"] == "Failed").length;

    double totalAmount = paymentTransactions.fold(0.0, (sum, payment) => sum + (payment["amount"] as double));
    double completedAmount = paymentTransactions
        .where((p) => p["status"] == "Completed")
        .fold(0.0, (sum, payment) => sum + (payment["amount"] as double));

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.payments, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Total Payments",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "$totalPayments",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${totalAmount.currency}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Completed",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "$completedPayments",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${completedAmount.currency}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.hourglass_empty, color: warningColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "In Progress",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "$inProgressPayments",
                  style: TextStyle(
                    color: warningColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.error, color: dangerColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Failed",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "$failedPayments",
                  style: TextStyle(
                    color: dangerColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFiltersSection() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filters",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              QButton(
                label: "Refresh",
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: _refreshData,
              ),
            ],
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Search payments...",
            value: searchQuery,
            hint: "Search by customer, ID, or reference",
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
                  label: "Payment Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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

  Widget _buildPaymentsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment Transactions (${filteredTransactions.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QButton(
                  label: "Export All",
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {
                    ss("Payment tracking data exported");
                  },
                ),
              ],
            ),
          ),
          if (filteredTransactions.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.payment,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No payment transactions found",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 16,
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
            ...filteredTransactions.map((payment) => _buildPaymentCard(payment)).toList(),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment, {bool showRetryOption = false}) {
    Color statusColor = payment["status"] == "Completed" 
        ? successColor 
        : payment["status"] == "Failed" 
            ? dangerColor 
            : payment["status"] == "In Progress" 
                ? warningColor 
                : infoColor;

    IconData statusIcon = payment["status"] == "Completed" 
        ? Icons.check_circle 
        : payment["status"] == "Failed" 
            ? Icons.error 
            : payment["status"] == "In Progress" 
                ? Icons.hourglass_empty 
                : Icons.schedule;

    return Container(
      margin: EdgeInsets.only(left: spMd, right: spMd, bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: statusColor, width: 4),
        ),
        color: statusColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  statusIcon,
                  color: statusColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${payment["customerName"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
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
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "${payment["id"]} • ${payment["paymentMethod"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "\$${(payment["amount"] as double).currency}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Initiated",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${payment["initiatedDate"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Processing Time",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${payment["processingTime"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewTransactionDetails(payment),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Track Payment",
                  icon: Icons.track_changes,
                  size: bs.sm,
                  onPressed: () => _showTrackingDetails(payment),
                ),
              ),
              if (showRetryOption && payment["status"] == "Failed") ...[
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Retry",
                    icon: Icons.refresh,
                    size: bs.sm,
                    onPressed: () => _retryPayment(payment),
                  ),
                ),
              ],
              if (payment["status"] == "In Progress" || payment["status"] == "Pending") ...[
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    icon: Icons.cancel,
                    size: bs.sm,
                    onPressed: () => _cancelPayment(payment),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
