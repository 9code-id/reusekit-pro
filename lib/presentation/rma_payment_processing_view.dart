import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPaymentProcessingView extends StatefulWidget {
  const RmaPaymentProcessingView({super.key});

  @override
  State<RmaPaymentProcessingView> createState() => _RmaPaymentProcessingViewState();
}

class _RmaPaymentProcessingViewState extends State<RmaPaymentProcessingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "";
  String selectedMethod = "";
  String selectedPeriod = "today";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Pending", "value": "pending"},
    {"label": "Processing", "value": "processing"},
    {"label": "Completed", "value": "completed"},
    {"label": "Failed", "value": "failed"},
    {"label": "Refunded", "value": "refunded"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> methodOptions = [
    {"label": "All Methods", "value": ""},
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "Debit Card", "value": "debit_card"},
    {"label": "Bank Transfer", "value": "bank_transfer"},
    {"label": "PayPal", "value": "paypal"},
    {"label": "Cash", "value": "cash"},
    {"label": "Check", "value": "check"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 30 Days", "value": "30days"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> payments = [
    {
      "payment_id": "PAY001",
      "rma_number": "RMA-2024-001",
      "customer_name": "John Smith",
      "customer_email": "john.smith@email.com",
      "amount": 250.0,
      "currency": "USD",
      "payment_method": "credit_card",
      "card_last_four": "4532",
      "status": "completed",
      "transaction_date": "2024-03-15",
      "transaction_time": "14:30:00",
      "gateway": "Stripe",
      "gateway_transaction_id": "pi_1234567890",
      "description": "RMA Processing Fee + Shipping",
      "fee": 7.5,
      "net_amount": 242.5,
      "refund_amount": 0.0,
      "processor_response": "approved",
      "billing_address": {
        "street": "123 Main St",
        "city": "New York",
        "state": "NY",
        "zip": "10001",
        "country": "US"
      }
    },
    {
      "payment_id": "PAY002",
      "rma_number": "RMA-2024-002",
      "customer_name": "Emily Davis",
      "customer_email": "emily.davis@email.com",
      "amount": 125.0,
      "currency": "USD",
      "payment_method": "paypal",
      "card_last_four": null,
      "status": "processing",
      "transaction_date": "2024-03-15",
      "transaction_time": "13:45:00",
      "gateway": "PayPal",
      "gateway_transaction_id": "PAYID-M123456",
      "description": "Repair Parts Payment",
      "fee": 3.75,
      "net_amount": 121.25,
      "refund_amount": 0.0,
      "processor_response": "pending",
      "billing_address": {
        "street": "456 Oak Ave",
        "city": "Los Angeles",
        "state": "CA",
        "zip": "90210",
        "country": "US"
      }
    },
    {
      "payment_id": "PAY003",
      "rma_number": "RMA-2024-003",
      "customer_name": "Robert Wilson",
      "customer_email": "robert.wilson@email.com",
      "amount": 75.0,
      "currency": "USD",
      "payment_method": "bank_transfer",
      "card_last_four": null,
      "status": "pending",
      "transaction_date": "2024-03-15",
      "transaction_time": "12:15:00",
      "gateway": "ACH",
      "gateway_transaction_id": "ACH_789012",
      "description": "Diagnostic Service Fee",
      "fee": 1.5,
      "net_amount": 73.5,
      "refund_amount": 0.0,
      "processor_response": "pending",
      "billing_address": {
        "street": "789 Pine St",
        "city": "Chicago",
        "state": "IL",
        "zip": "60601",
        "country": "US"
      }
    },
    {
      "payment_id": "PAY004",
      "rma_number": "RMA-2024-004",
      "customer_name": "Maria Garcia",
      "customer_email": "maria.garcia@email.com",
      "amount": 300.0,
      "currency": "USD",
      "payment_method": "credit_card",
      "card_last_four": "9876",
      "status": "failed",
      "transaction_date": "2024-03-15",
      "transaction_time": "11:30:00",
      "gateway": "Square",
      "gateway_transaction_id": "sq_declined_001",
      "description": "Express RMA Service",
      "fee": 0.0,
      "net_amount": 0.0,
      "refund_amount": 0.0,
      "processor_response": "declined - insufficient funds",
      "billing_address": {
        "street": "321 Elm St",
        "city": "Miami",
        "state": "FL",
        "zip": "33101",
        "country": "US"
      }
    },
    {
      "payment_id": "PAY005",
      "rma_number": "RMA-2024-005",
      "customer_name": "James Anderson",
      "customer_email": "james.anderson@email.com",
      "amount": 150.0,
      "currency": "USD",
      "payment_method": "debit_card",
      "card_last_four": "1234",
      "status": "refunded",
      "transaction_date": "2024-03-14",
      "transaction_time": "16:45:00",
      "gateway": "Stripe",
      "gateway_transaction_id": "pi_refunded_001",
      "description": "RMA Service - Cancelled",
      "fee": 4.5,
      "net_amount": 145.5,
      "refund_amount": 150.0,
      "processor_response": "refunded",
      "billing_address": {
        "street": "654 Maple Ave",
        "city": "Seattle",
        "state": "WA",
        "zip": "98101",
        "country": "US"
      }
    },
  ];

  List<Map<String, dynamic>> get filteredPayments {
    return payments.where((payment) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${payment["customer_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${payment["rma_number"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${payment["payment_id"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus.isEmpty ||
          payment["status"] == selectedStatus;

      bool matchesMethod = selectedMethod.isEmpty ||
          payment["payment_method"] == selectedMethod;

      return matchesSearch && matchesStatus && matchesMethod;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "processing":
        return infoColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      case "refunded":
        return secondaryColor;
      case "cancelled":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "processing":
        return "Processing";
      case "pending":
        return "Pending";
      case "failed":
        return "Failed";
      case "refunded":
        return "Refunded";
      case "cancelled":
        return "Cancelled";
      default:
        return "Unknown";
    }
  }

  String _getMethodLabel(String method) {
    switch (method) {
      case "credit_card":
        return "Credit Card";
      case "debit_card":
        return "Debit Card";
      case "bank_transfer":
        return "Bank Transfer";
      case "paypal":
        return "PayPal";
      case "cash":
        return "Cash";
      case "check":
        return "Check";
      default:
        return "Unknown";
    }
  }

  IconData _getMethodIcon(String method) {
    switch (method) {
      case "credit_card":
      case "debit_card":
        return Icons.credit_card;
      case "bank_transfer":
        return Icons.account_balance;
      case "paypal":
        return Icons.payment;
      case "cash":
        return Icons.money;
      case "check":
        return Icons.receipt;
      default:
        return Icons.payment;
    }
  }

  void _viewPaymentDetails(Map<String, dynamic> payment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow("Payment ID", "${payment["payment_id"]}"),
              _buildDetailRow("RMA Number", "${payment["rma_number"]}"),
              _buildDetailRow("Customer", "${payment["customer_name"]}"),
              _buildDetailRow("Email", "${payment["customer_email"]}"),
              _buildDetailRow("Amount", "\$${(payment["amount"] as double).currency} ${payment["currency"]}"),
              _buildDetailRow("Payment Method", _getMethodLabel("${payment["payment_method"]}")),
              if (payment["card_last_four"] != null)
                _buildDetailRow("Card", "**** **** **** ${payment["card_last_four"]}"),
              _buildDetailRow("Status", _getStatusLabel("${payment["status"]}")),
              _buildDetailRow("Date & Time", "${payment["transaction_date"]} ${payment["transaction_time"]}"),
              _buildDetailRow("Gateway", "${payment["gateway"]}"),
              _buildDetailRow("Transaction ID", "${payment["gateway_transaction_id"]}"),
              _buildDetailRow("Description", "${payment["description"]}"),
              _buildDetailRow("Processing Fee", "\$${(payment["fee"] as double).currency}"),
              _buildDetailRow("Net Amount", "\$${(payment["net_amount"] as double).currency}"),
              if ((payment["refund_amount"] as double) > 0)
                _buildDetailRow("Refund Amount", "\$${(payment["refund_amount"] as double).currency}"),
              _buildDetailRow("Processor Response", "${payment["processor_response"]}"),
              
              SizedBox(height: spMd),
              Text(
                "Billing Address:",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${(payment["billing_address"] as Map)["street"]}"),
                    Text("${(payment["billing_address"] as Map)["city"]}, ${(payment["billing_address"] as Map)["state"]} ${(payment["billing_address"] as Map)["zip"]}"),
                    Text("${(payment["billing_address"] as Map)["country"]}"),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          if (payment["status"] == "completed")
            QButton(
              label: "Process Refund",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                _processRefund(payment);
              },
            ),
          if (payment["status"] == "failed")
            QButton(
              label: "Retry Payment",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                _retryPayment(payment);
              },
            ),
        ],
      ),
    );
  }

  void _processRefund(Map<String, dynamic> payment) async {
    bool isConfirmed = await confirm("Process refund of \$${(payment["amount"] as double).currency}?");
    if (!isConfirmed) return;

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Refund processed successfully");
  }

  void _retryPayment(Map<String, dynamic> payment) async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Payment retry initiated");
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
              "${label}:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment) {
    Color statusColor = _getStatusColor("${payment["status"]}");
    IconData methodIcon = _getMethodIcon("${payment["payment_method"]}");
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
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
                        "${payment["customer_name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXxs),
                      Text(
                        "${payment["rma_number"]} • ${payment["payment_id"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: statusColor.withAlpha(40)),
                  ),
                  child: Text(
                    _getStatusLabel("${payment["status"]}"),
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            Text(
              "${payment["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(methodIcon, size: 16, color: disabledBoldColor),
                SizedBox(width: spXxs),
                Text(
                  _getMethodLabel("${payment["payment_method"]}"),
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (payment["card_last_four"] != null) ...[
                  SizedBox(width: spXs),
                  Text(
                    "•••• ${payment["card_last_four"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
                Spacer(),
                Text(
                  "\$${(payment["amount"] as double).currency}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                SizedBox(width: spXxs),
                Text(
                  "${payment["transaction_date"]} ${payment["transaction_time"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
                Icon(Icons.account_balance, size: 16, color: disabledBoldColor),
                SizedBox(width: spXxs),
                Text(
                  "${payment["gateway"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            if ((payment["fee"] as double) > 0) ...[
              SizedBox(height: spXs),
              Row(
                children: [
                  Text(
                    "Processing Fee: \$${(payment["fee"] as double).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Net: \$${(payment["net_amount"] as double).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ],
            
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Response: ${payment["processor_response"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewPaymentDetails(payment),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentsTab() {
    return Column(
      children: [
        // Search and Filters
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
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
                    icon: Icons.search,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
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
              
              SizedBox(height: spSm),
              QDropdownField(
                label: "Time Period",
                items: periodOptions,
                value: selectedPeriod,
                onChanged: (value, label) {
                  selectedPeriod = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Results Summary
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(40)),
          ),
          child: Row(
            children: [
              Icon(Icons.payment, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Showing ${filteredPayments.length} of ${payments.length} payments",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Payments List
        if (filteredPayments.isEmpty)
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
                SizedBox(height: spSm),
                Text(
                  "Try adjusting your search criteria or filters",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )
        else
          ...filteredPayments.map((payment) => _buildPaymentCard(payment)),
      ],
    );
  }

  Widget _buildStatisticsTab() {
    double totalCompleted = filteredPayments
        .where((payment) => payment["status"] == "completed")
        .fold(0.0, (sum, payment) => sum + (payment["amount"] as double));
    
    double totalPending = filteredPayments
        .where((payment) => payment["status"] == "pending" || payment["status"] == "processing")
        .fold(0.0, (sum, payment) => sum + (payment["amount"] as double));
    
    double totalRefunded = filteredPayments
        .where((payment) => payment["status"] == "refunded")
        .fold(0.0, (sum, payment) => sum + (payment["refund_amount"] as double));
    
    double totalFees = filteredPayments
        .fold(0.0, (sum, payment) => sum + (payment["fee"] as double));
    
    Map<String, int> statusCounts = {};
    Map<String, int> methodCounts = {};
    
    for (var payment in filteredPayments) {
      String status = "${payment["status"]}";
      String method = "${payment["payment_method"]}";
      
      statusCounts[status] = (statusCounts[status] ?? 0) + 1;
      methodCounts[method] = (methodCounts[method] ?? 0) + 1;
    }
    
    return Column(
      children: [
        // Payment Summary
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: [
                  _buildStatCard("Completed", totalCompleted, successColor, Icons.check_circle),
                  _buildStatCard("Pending", totalPending, warningColor, Icons.schedule),
                  _buildStatCard("Refunded", totalRefunded, secondaryColor, Icons.undo),
                  _buildStatCard("Processing Fees", totalFees, infoColor, Icons.account_balance),
                ],
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Status Distribution
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Status Distribution",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...statusCounts.entries.map((entry) => Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStatusColor(entry.key).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: _getStatusColor(entry.key).withAlpha(20)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _getStatusLabel(entry.key),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(entry.key),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor(entry.key),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${entry.value}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Payment Methods
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Methods",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...methodCounts.entries.map((entry) => Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(20)),
                ),
                child: Row(
                  children: [
                    Icon(_getMethodIcon(entry.key), color: primaryColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        _getMethodLabel(entry.key),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${entry.value}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, double value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                title == "Processing Fees" || title == "Completed" || title == "Pending" || title == "Refunded"
                    ? "\$${value.currency}"
                    : "$value",
                style: TextStyle(
                  fontSize: 18,
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
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "RMA Payment Processing",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Payments", icon: Icon(Icons.payment)),
        Tab(text: "Statistics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildPaymentsTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildStatisticsTab(),
        ),
      ],
    );
  }
}
