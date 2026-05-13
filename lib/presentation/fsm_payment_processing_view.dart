import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmPaymentProcessingView extends StatefulWidget {
  const FsmPaymentProcessingView({super.key});

  @override
  State<FsmPaymentProcessingView> createState() => _FsmPaymentProcessingViewState();
}

class _FsmPaymentProcessingViewState extends State<FsmPaymentProcessingView> {
  final formKey = GlobalKey<FormState>();
  
  String selectedPaymentMethod = "Credit Card";
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardHolderName = "";
  String billingAddress = "";
  String zipCode = "";
  bool savePaymentMethod = false;
  bool processing = false;
  
  List<Map<String, dynamic>> paymentMethods = [
    {
      "label": "Credit Card",
      "value": "Credit Card",
    },
    {
      "label": "Debit Card",
      "value": "Debit Card",
    },
    {
      "label": "PayPal",
      "value": "PayPal",
    },
    {
      "label": "Bank Transfer",
      "value": "Bank Transfer",
    },
    {
      "label": "Digital Wallet",
      "value": "Digital Wallet",
    },
  ];

  List<Map<String, dynamic>> recentTransactions = [
    {
      "id": "TXN-001",
      "customer": "ABC Services Ltd",
      "amount": 1250.00,
      "status": "Completed",
      "date": "2024-01-15",
      "method": "Credit Card",
      "reference": "REF-12345",
    },
    {
      "id": "TXN-002",
      "customer": "XYZ Corporation",
      "amount": 875.50,
      "status": "Processing",
      "date": "2024-01-14",
      "method": "Bank Transfer",
      "reference": "REF-12346",
    },
    {
      "id": "TXN-003",
      "customer": "Tech Solutions Inc",
      "amount": 2100.00,
      "status": "Failed",
      "date": "2024-01-13",
      "method": "PayPal",
      "reference": "REF-12347",
    },
    {
      "id": "TXN-004",
      "customer": "Global Industries",
      "amount": 650.25,
      "status": "Completed",
      "date": "2024-01-12",
      "method": "Digital Wallet",
      "reference": "REF-12348",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Processing"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to payment history
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to payment settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              _buildPaymentMethodSection(),
              _buildPaymentFormSection(),
              _buildTransactionSummary(),
              _buildRecentTransactions(),
              _buildProcessButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
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
            "Payment Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Select Payment Method",
            items: paymentMethods,
            value: selectedPaymentMethod,
            onChanged: (value, label) {
              selectedPaymentMethod = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentFormSection() {
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
            "Payment Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (selectedPaymentMethod == "Credit Card" || selectedPaymentMethod == "Debit Card") ...[
            QTextField(
              label: "Card Number",
              value: cardNumber,
              hint: "1234 5678 9012 3456",
              validator: Validator.required,
              onChanged: (value) {
                cardNumber = value;
                setState(() {});
              },
            ),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Expiry Date",
                    value: expiryDate,
                    hint: "MM/YY",
                    validator: Validator.required,
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
                    hint: "123",
                    validator: Validator.required,
                    onChanged: (value) {
                      cvv = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            QTextField(
              label: "Card Holder Name",
              value: cardHolderName,
              validator: Validator.required,
              onChanged: (value) {
                cardHolderName = value;
                setState(() {});
              },
            ),
          ],
          QTextField(
            label: "Billing Address",
            value: billingAddress,
            validator: Validator.required,
            onChanged: (value) {
              billingAddress = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "ZIP Code",
            value: zipCode,
            validator: Validator.required,
            onChanged: (value) {
              zipCode = value;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Save payment method for future use",
                "value": true,
                "checked": savePaymentMethod,
              }
            ],
            value: [
              if (savePaymentMethod)
                {
                  "label": "Save payment method for future use",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                savePaymentMethod = values.isNotEmpty;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionSummary() {
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
            "Transaction Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Service Amount:",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$850.00",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tax (8.5%):",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$72.25",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Processing Fee:",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$2.50",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$924.75",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
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
                "Recent Transactions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to all transactions
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...recentTransactions.take(3).map((transaction) => _buildTransactionItem(transaction)),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    Color statusColor;
    switch (transaction["status"]) {
      case "Completed":
        statusColor = successColor;
        break;
      case "Processing":
        statusColor = warningColor;
        break;
      case "Failed":
        statusColor = dangerColor;
        break;
      default:
        statusColor = disabledBoldColor;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.payment,
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
                  "${transaction["customer"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${transaction["id"]} • ${transaction["method"]}",
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
                "\$${((transaction["amount"] as num).toDouble()).currency}",
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
                  "${transaction["status"]}",
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
    );
  }

  Widget _buildProcessButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: processing ? "Processing..." : "Process Payment",
        size: bs.md,
        onPressed: processing ? null : _processPayment,
      ),
    );
  }

  void _processPayment() async {
    if (formKey.currentState!.validate()) {
      processing = true;
      setState(() {});

      // Simulate payment processing
      await Future.delayed(Duration(seconds: 3));

      processing = false;
      setState(() {});

      ss("Payment processed successfully!");
    }
  }
}
