import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaPaymentProcessingView extends StatefulWidget {
  const HhaPaymentProcessingView({super.key});

  @override
  State<HhaPaymentProcessingView> createState() => _HhaPaymentProcessingViewState();
}

class _HhaPaymentProcessingViewState extends State<HhaPaymentProcessingView> {
  int currentTab = 0;
  
  // Form fields
  String paymentAmount = "";
  String paymentMethod = "";
  String cardNumber = "";
  String cardHolderName = "";
  String expiryDate = "";
  String cvv = "";
  String guestName = "";
  String roomNumber = "";
  String description = "";
  String searchQuery = "";
  String filterStatus = "";
  String filterMethod = "";
  
  // Sample payment data
  List<Map<String, dynamic>> payments = [
    {
      "id": "PAY-2024-001",
      "transactionId": "TXN-789456123",
      "guestName": "John Smith",
      "roomNumber": "101",
      "amount": 275.00,
      "method": "Credit Card",
      "cardLastFour": "4242",
      "status": "Completed",
      "processedAt": "2024-01-15 14:30",
      "description": "Room charges payment",
      "currency": "USD",
      "gateway": "Stripe",
      "receiptUrl": "https://example.com/receipt/PAY-2024-001"
    },
    {
      "id": "PAY-2024-002",
      "transactionId": "TXN-789456124",
      "guestName": "Sarah Johnson",
      "roomNumber": "205",
      "amount": 93.50,
      "method": "Debit Card",
      "cardLastFour": "8765",
      "status": "Processing",
      "processedAt": "2024-01-14 18:45",
      "description": "Restaurant bill payment",
      "currency": "USD",
      "gateway": "Square",
      "receiptUrl": ""
    },
    {
      "id": "PAY-2024-003",
      "transactionId": "CASH-001",
      "guestName": "Michael Brown",
      "roomNumber": "304",
      "amount": 50.00,
      "method": "Cash",
      "cardLastFour": "",
      "status": "Completed",
      "processedAt": "2024-01-13 12:15",
      "description": "Spa services payment",
      "currency": "USD",
      "gateway": "Manual",
      "receiptUrl": ""
    },
    {
      "id": "PAY-2024-004",
      "transactionId": "TXN-789456125",
      "guestName": "Emma Wilson",
      "roomNumber": "102",
      "amount": 125.75,
      "method": "Credit Card",
      "cardLastFour": "1234",
      "status": "Failed",
      "processedAt": "2024-01-12 09:30",
      "description": "Transportation service",
      "currency": "USD",
      "gateway": "PayPal",
      "receiptUrl": "",
      "failureReason": "Insufficient funds"
    },
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "credit_card",
      "name": "Credit Card",
      "icon": Icons.credit_card,
      "isActive": true,
      "processingFee": 2.9,
      "gateway": "Stripe"
    },
    {
      "id": "debit_card", 
      "name": "Debit Card",
      "icon": Icons.payment,
      "isActive": true,
      "processingFee": 1.5,
      "gateway": "Square"
    },
    {
      "id": "cash",
      "name": "Cash",
      "icon": Icons.money,
      "isActive": true,
      "processingFee": 0.0,
      "gateway": "Manual"
    },
    {
      "id": "bank_transfer",
      "name": "Bank Transfer",
      "icon": Icons.account_balance,
      "isActive": false,
      "processingFee": 0.5,
      "gateway": "ACH"
    },
  ];

  List<Map<String, dynamic>> get filteredPayments {
    var filtered = payments.where((payment) {
      final matchesSearch = searchQuery.isEmpty ||
          (payment["guestName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (payment["roomNumber"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (payment["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (payment["transactionId"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = filterStatus.isEmpty || payment["status"] == filterStatus;
      final matchesMethod = filterMethod.isEmpty || payment["method"] == filterMethod;
      
      return matchesSearch && matchesStatus && matchesMethod;
    }).toList();
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'processing':
        return warningColor;
      case 'failed':
        return dangerColor;
      case 'cancelled':
        return disabledColor;
      case 'refunded':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  double get totalProcessedAmount {
    return payments
        .where((payment) => payment["status"] == "Completed")
        .fold(0.0, (sum, payment) => sum + (payment["amount"] as double));
  }

  double get totalPendingAmount {
    return payments
        .where((payment) => payment["status"] == "Processing")
        .fold(0.0, (sum, payment) => sum + (payment["amount"] as double));
  }

  int get totalFailedTransactions {
    return payments.where((payment) => payment["status"] == "Failed").length;
  }

  Widget _buildProcessPaymentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
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
                        children: [
                          Icon(Icons.payments, color: successColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Processed Today",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalProcessedAmount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                    color: Colors.white,
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
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$totalFailedTransactions",
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
            ],
          ),
          SizedBox(height: spLg),
          
          // Payment Form
          Text(
            "Process New Payment",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Guest Name",
                  value: guestName,
                  hint: "Enter guest name",
                  onChanged: (value) {
                    guestName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Room Number",
                  value: roomNumber,
                  hint: "Enter room number",
                  onChanged: (value) {
                    roomNumber = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          QNumberField(
            label: "Payment Amount (\$)",
            value: paymentAmount,
            hint: "Enter payment amount",
            onChanged: (value) {
              paymentAmount = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QDropdownField(
            label: "Payment Method",
            value: paymentMethod,
            items: paymentMethods.where((method) => method["isActive"] as bool).map((method) => {
              "label": "${method["name"]} (${(method["processingFee"] as double).toStringAsFixed(1)}% fee)",
              "value": method["id"],
            }).toList(),
            onChanged: (value, label) {
              paymentMethod = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QMemoField(
            label: "Description",
            value: description,
            hint: "Payment description or notes",
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          
          // Card Details (if credit/debit card selected)
          if (paymentMethod == "credit_card" || paymentMethod == "debit_card") ...[
            Text(
              "Card Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            QTextField(
              label: "Card Holder Name",
              value: cardHolderName,
              hint: "Enter card holder name",
              onChanged: (value) {
                cardHolderName = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            
            QTextField(
              label: "Card Number",
              value: cardNumber,
              hint: "Enter card number",
              onChanged: (value) {
                cardNumber = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Expiry Date",
                    value: expiryDate,
                    hint: "MM/YY",
                    onChanged: (value) {
                      expiryDate = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "CVV",
                    value: cvv,
                    hint: "Enter CVV",
                    onChanged: (value) {
                      cvv = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
          ],
          
          // Payment Summary
          if (paymentAmount.isNotEmpty && paymentMethod.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
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
                  SizedBox(height: spSm),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount:", style: TextStyle(fontSize: 14)),
                      Text("\$${paymentAmount}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: spXs),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Processing Fee:", style: TextStyle(fontSize: 14)),
                      Text(
                        "\$${_calculateProcessingFee()}",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  
                  Divider(),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total to Charge:",
                        style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$${_calculateTotalCharge()}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
          ],
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Process Payment",
              onPressed: paymentAmount.isNotEmpty && paymentMethod.isNotEmpty ? () {
                ss("Payment processed successfully");
              } : () {},
            ),
          ),
        ],
      ),
    );
  }

  String _calculateProcessingFee() {
    double amount = double.tryParse(paymentAmount) ?? 0.0;
    var method = paymentMethods.firstWhere((m) => m["id"] == paymentMethod, orElse: () => {"processingFee": 0.0});
    double fee = amount * (method["processingFee"] as double) / 100;
    return fee.toStringAsFixed(2);
  }

  String _calculateTotalCharge() {
    double amount = double.tryParse(paymentAmount) ?? 0.0;
    double fee = double.tryParse(_calculateProcessingFee()) ?? 0.0;
    return (amount + fee).toStringAsFixed(2);
  }

  Widget _buildTransactionHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filter
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Transactions",
                  value: searchQuery,
                  hint: "Search by guest name, transaction ID, or room",
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
                  label: "Filter by Status",
                  value: filterStatus,
                  items: [
                    {"label": "All Status", "value": ""},
                    {"label": "Completed", "value": "Completed"},
                    {"label": "Processing", "value": "Processing"},
                    {"label": "Failed", "value": "Failed"},
                    {"label": "Cancelled", "value": "Cancelled"},
                    {"label": "Refunded", "value": "Refunded"},
                  ],
                  onChanged: (value, label) {
                    filterStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Filter by Method",
                  value: filterMethod,
                  items: [
                    {"label": "All Methods", "value": ""},
                    {"label": "Credit Card", "value": "Credit Card"},
                    {"label": "Debit Card", "value": "Debit Card"},
                    {"label": "Cash", "value": "Cash"},
                    {"label": "Bank Transfer", "value": "Bank Transfer"},
                  ],
                  onChanged: (value, label) {
                    filterMethod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          
          // Transaction List
          Text(
            "Transaction History (${filteredPayments.length})",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...filteredPayments.map((payment) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getStatusColor(payment["status"] as String),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${payment["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(payment["status"] as String).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${payment["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(payment["status"] as String),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(Icons.person, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${payment["guestName"]}",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: spMd),
                    Icon(Icons.hotel, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Room ${payment["roomNumber"]}",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Icon(Icons.payment, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${payment["method"]}",
                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                    ),
                    if ((payment["cardLastFour"] as String).isNotEmpty) ...[
                      Text(
                        " ****${payment["cardLastFour"]}",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                    ],
                    Spacer(),
                    Text(
                      "\$${(payment["amount"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${payment["processedAt"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Spacer(),
                    Text(
                      "TXN: ${payment["transactionId"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
                
                if ((payment["description"] as String).isNotEmpty) ...[
                  SizedBox(height: spXs),
                  Text(
                    "${payment["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                
                if (payment["status"] == "Failed" && payment.containsKey("failureReason")) ...[
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error, size: 16, color: dangerColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Failure: ${payment["failureReason"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        si("Viewing transaction ${payment["id"]}");
                      },
                    ),
                    if ((payment["receiptUrl"] as String).isNotEmpty) ...[
                      SizedBox(width: spSm),
                      QButton(
                        label: "Receipt",
                        size: bs.sm,
                        onPressed: () {
                          si("Opening receipt for ${payment["id"]}");
                        },
                      ),
                    ],
                    if (payment["status"] == "Completed") ...[
                      SizedBox(width: spSm),
                      QButton(
                        label: "Refund",
                        size: bs.sm,
                        onPressed: () {
                          si("Processing refund for ${payment["id"]}");
                        },
                      ),
                    ],
                    if (payment["status"] == "Failed") ...[
                      SizedBox(width: spSm),
                      QButton(
                        label: "Retry",
                        size: bs.sm,
                        onPressed: () {
                          si("Retrying payment ${payment["id"]}");
                        },
                      ),
                    ],
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Methods Configuration",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...paymentMethods.map((method) => Container(
            margin: EdgeInsets.only(bottom: spMd),
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
                  children: [
                    Icon(
                      method["icon"] as IconData,
                      color: primaryColor,
                      size: 32,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${method["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Gateway: ${method["gateway"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: (method["isActive"] as bool ? successColor : disabledColor).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        method["isActive"] as bool ? "Active" : "Inactive",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: method["isActive"] as bool ? successColor : disabledColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Processing Fee:",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "${(method["processingFee"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    QButton(
                      label: "Configure",
                      size: bs.sm,
                      onPressed: () {
                        si("Configuring ${method["name"]}");
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: method["isActive"] as bool ? "Disable" : "Enable",
                      size: bs.sm,
                      onPressed: () {
                        method["isActive"] = !(method["isActive"] as bool);
                        setState(() {});
                        ss("${method["name"]} ${method["isActive"] as bool ? 'enabled' : 'disabled'}");
                      },
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
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
        Tab(text: "Process Payment", icon: Icon(Icons.payment)),
        Tab(text: "Transaction History", icon: Icon(Icons.history)),
        Tab(text: "Payment Methods", icon: Icon(Icons.credit_card)),
      ],
      tabChildren: [
        _buildProcessPaymentTab(),
        _buildTransactionHistoryTab(),
        _buildPaymentMethodsTab(),
      ],
    );
  }
}
