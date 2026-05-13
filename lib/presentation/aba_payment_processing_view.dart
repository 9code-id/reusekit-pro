import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaPaymentProcessingView extends StatefulWidget {
  const AbaPaymentProcessingView({super.key});

  @override
  State<AbaPaymentProcessingView> createState() => _AbaPaymentProcessingViewState();
}

class _AbaPaymentProcessingViewState extends State<AbaPaymentProcessingView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedMethod = "all";
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Processing", "value": "processing"},
    {"label": "Completed", "value": "completed"},
    {"label": "Failed", "value": "failed"},
    {"label": "Pending Review", "value": "pending_review"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> methodOptions = [
    {"label": "All Methods", "value": "all"},
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "Bank Transfer", "value": "bank_transfer"},
    {"label": "ACH", "value": "ach"},
    {"label": "Wire Transfer", "value": "wire_transfer"},
    {"label": "Check", "value": "check"},
  ];

  List<Map<String, dynamic>> paymentQueue = [
    {
      "id": "PP-001",
      "customer_name": "John Smith",
      "customer_id": "CUST-001",
      "amount": 1250.00,
      "payment_method": "Credit Card",
      "card_last_four": "4532",
      "status": "processing",
      "initiated_date": "2024-06-19",
      "processing_time": "14:30:25",
      "invoice_id": "INV-2024-001",
      "gateway": "Stripe",
      "transaction_id": "pi_1234567890",
      "retry_count": 0,
      "estimated_completion": "14:35:00",
    },
    {
      "id": "PP-002",
      "customer_name": "Sarah Johnson",
      "customer_id": "CUST-002",
      "amount": 890.50,
      "payment_method": "Bank Transfer",
      "account_last_four": "7890",
      "status": "pending_review",
      "initiated_date": "2024-06-19",
      "processing_time": "13:45:10",
      "invoice_id": "INV-2024-002",
      "gateway": "Plaid",
      "transaction_id": "bt_9876543210",
      "retry_count": 1,
      "estimated_completion": "15:00:00",
    },
    {
      "id": "PP-003",
      "customer_name": "Michael Brown",
      "customer_id": "CUST-003",
      "amount": 2100.75,
      "payment_method": "ACH",
      "account_last_four": "1234",
      "status": "failed",
      "initiated_date": "2024-06-19",
      "processing_time": "12:20:45",
      "invoice_id": "INV-2024-003",
      "gateway": "Dwolla",
      "transaction_id": "ach_5678901234",
      "retry_count": 2,
      "failure_reason": "Insufficient funds",
    },
    {
      "id": "PP-004",
      "customer_name": "Emily Davis",
      "customer_id": "CUST-004",
      "amount": 450.00,
      "payment_method": "Wire Transfer",
      "account_last_four": "5678",
      "status": "completed",
      "initiated_date": "2024-06-19",
      "processing_time": "11:15:30",
      "completion_time": "11:18:45",
      "invoice_id": "INV-2024-004",
      "gateway": "FedWire",
      "transaction_id": "wt_1357924680",
      "retry_count": 0,
    },
    {
      "id": "PP-005",
      "customer_name": "David Wilson",
      "customer_id": "CUST-005",
      "amount": 780.25,
      "payment_method": "Credit Card",
      "card_last_four": "9012",
      "status": "cancelled",
      "initiated_date": "2024-06-18",
      "processing_time": "16:45:20",
      "invoice_id": "INV-2024-005",
      "gateway": "PayPal",
      "transaction_id": "pp_2468013579",
      "retry_count": 0,
      "cancellation_reason": "Customer request",
    },
  ];

  List<Map<String, dynamic>> get filteredPayments {
    return paymentQueue.where((payment) {
      final matchesSearch = payment["customer_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          payment["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          payment["transaction_id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "all" || payment["status"] == selectedStatus;
      final matchesMethod = selectedMethod == "all" || 
          payment["payment_method"].toString().toLowerCase().contains(selectedMethod.replaceAll("_", " "));
      
      return matchesSearch && matchesStatus && matchesMethod;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'processing':
        return infoColor;
      case 'pending_review':
        return warningColor;
      case 'failed':
        return dangerColor;
      case 'cancelled':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getMethodIcon(String method) {
    switch (method.toLowerCase()) {
      case 'credit card':
        return Icons.credit_card;
      case 'bank transfer':
        return Icons.account_balance;
      case 'ach':
        return Icons.account_balance_wallet;
      case 'wire transfer':
        return Icons.transfer_within_a_station;
      case 'check':
        return Icons.receipt;
      default:
        return Icons.payment;
    }
  }

  void _retryPayment(Map<String, dynamic> payment) async {
    bool isConfirmed = await confirm("Retry payment processing for ${payment["customer_name"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Payment retry initiated");
  }

  void _cancelPayment(Map<String, dynamic> payment) async {
    bool isConfirmed = await confirm("Cancel payment processing for ${payment["customer_name"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    sw("Payment cancelled");
  }

  void _approvePayment(Map<String, dynamic> payment) async {
    bool isConfirmed = await confirm("Approve payment for ${payment["customer_name"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Payment approved and processed");
  }

  Widget _buildQueueTab() {
    final processingCount = paymentQueue.where((p) => p["status"] == "processing").length;
    final pendingCount = paymentQueue.where((p) => p["status"] == "pending_review").length;
    final failedCount = paymentQueue.where((p) => p["status"] == "failed").length;
    final totalAmount = paymentQueue.fold(0.0, (sum, p) => sum + (p["amount"] as double));

    return Column(
      spacing: spMd,
      children: [
        // Summary Cards
        Row(
          children: [
            Expanded(
              child: Container(
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
                        Icon(Icons.trending_up, color: infoColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Processing",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$processingCount",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Container(
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
                        Icon(Icons.pending, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Pending Review",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$pendingCount",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
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
                        Icon(Icons.error, color: dangerColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Failed",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$failedCount",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Container(
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
                        Icon(Icons.attach_money, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Total Amount",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${totalAmount.currency}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Search and Filters
        Container(
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
                      label: "Search payments...",
                      value: searchQuery,
                      hint: "Customer name, payment ID, or transaction ID",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
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
                ],
              ),
            ],
          ),
        ),

        // Payment Queue List
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment Processing Queue",
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
              ),
              Divider(height: 1),
              ...List.generate(filteredPayments.length, (index) {
                final payment = filteredPayments[index];
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: index < filteredPayments.length - 1 
                          ? disabledOutlineBorderColor 
                          : Colors.transparent,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _getMethodIcon("${payment["payment_method"]}"),
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${payment["customer_name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${payment["id"]} • ${payment["customer_id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${payment["status"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${payment["status"]}".replaceAll("_", " ").toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor("${payment["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${(payment["amount"] as double).currency}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${payment["payment_method"]} •••• ${payment.containsKey("card_last_four") ? payment["card_last_four"] : payment["account_last_four"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${payment["gateway"]} • ${payment["transaction_id"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (payment["retry_count"] > 0)
                            Text(
                              "Retries: ${payment["retry_count"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                              ),
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Initiated: ${payment["processing_time"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (payment.containsKey("estimated_completion"))
                            Text(
                              "ETA: ${payment["estimated_completion"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                        ],
                      ),
                      if (payment.containsKey("failure_reason"))
                        Text(
                          "Failure: ${payment["failure_reason"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      if (payment.containsKey("cancellation_reason"))
                        Text(
                          "Cancelled: ${payment["cancellation_reason"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              si("Payment details viewed");
                            },
                          ),
                          if (payment["status"] == "failed")
                            ...[
                              SizedBox(width: spXs),
                              QButton(
                                label: "Retry",
                                size: bs.sm,
                                onPressed: () => _retryPayment(payment),
                              ),
                            ],
                          if (payment["status"] == "pending_review")
                            ...[
                              SizedBox(width: spXs),
                              QButton(
                                label: "Approve",
                                size: bs.sm,
                                onPressed: () => _approvePayment(payment),
                              ),
                            ],
                          if (payment["status"] == "processing" || payment["status"] == "pending_review")
                            ...[
                              SizedBox(width: spXs),
                              QButton(
                                label: "Cancel",
                                size: bs.sm,
                                onPressed: () => _cancelPayment(payment),
                              ),
                            ],
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTab() {
    return Column(
      spacing: spMd,
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
              Text(
                "Processing Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QSwitch(
                items: [
                  {
                    "label": "Auto-retry failed payments",
                    "value": true,
                    "checked": true,
                  }
                ],
                value: [
                  {"label": "Auto-retry failed payments", "value": true, "checked": true}
                ],
                onChanged: (values, ids) {
                  si("Auto-retry setting updated");
                },
              ),
              
              SizedBox(height: spSm),
              
              QSwitch(
                items: [
                  {
                    "label": "Email notifications for failed payments",
                    "value": true,
                    "checked": true,
                  }
                ],
                value: [
                  {"label": "Email notifications for failed payments", "value": true, "checked": true}
                ],
                onChanged: (values, ids) {
                  si("Notification setting updated");
                },
              ),
              
              SizedBox(height: spSm),
              
              QTextField(
                label: "Maximum retry attempts",
                value: "3",
                onChanged: (value) {
                  si("Retry limit updated");
                },
              ),
              
              SizedBox(height: spSm),
              
              QTextField(
                label: "Processing timeout (minutes)",
                value: "30",
                onChanged: (value) {
                  si("Timeout setting updated");
                },
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
              Text(
                "Gateway Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              _buildGatewayStatus("Stripe", "Online", successColor),
              _buildGatewayStatus("PayPal", "Online", successColor),  
              _buildGatewayStatus("Plaid", "Maintenance", warningColor),
              _buildGatewayStatus("Dwolla", "Online", successColor),
              _buildGatewayStatus("FedWire", "Offline", dangerColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGatewayStatus(String gateway, String status, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            gateway,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Payment Processing",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Queue", icon: Icon(Icons.queue)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        loading ? 
          Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: _buildQueueTab(),
          ),
        loading ? 
          Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: _buildSettingsTab(),
          ),
      ],
      actions: [
        IconButton(
          onPressed: () {
            si("Processing queue refreshed");
          },
          icon: Icon(Icons.refresh),
        ),
      ],
    );
  }
}
