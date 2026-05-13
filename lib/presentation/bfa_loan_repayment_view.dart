import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaLoanRepaymentView extends StatefulWidget {
  const BfaLoanRepaymentView({super.key});

  @override
  State<BfaLoanRepaymentView> createState() => _BfaLoanRepaymentViewState();
}

class _BfaLoanRepaymentViewState extends State<BfaLoanRepaymentView> {
  Map<String, dynamic> loanData = {
    "id": "LN001234",
    "type": "Personal Loan",
    "monthlyEmi": 5125.0,
    "nextDueDate": "2025-07-15",
    "outstanding": 75000.0,
    "remainingEmis": 18,
  };

  String selectedPaymentMethod = "auto_debit";
  String paymentAmount = "5125";
  String selectedPaymentType = "emi";
  bool agreeTerms = false;
  bool loading = false;

  List<Map<String, dynamic>> paymentMethods = [
    {
      "label": "Auto Debit",
      "value": "auto_debit",
      "icon": Icons.account_balance,
      "description": "Automatic deduction from your bank account"
    },
    {
      "label": "Net Banking",
      "value": "net_banking",
      "icon": Icons.computer,
      "description": "Pay using internet banking"
    },
    {
      "label": "UPI",
      "value": "upi",
      "icon": Icons.phone_android,
      "description": "Pay using UPI apps like GPay, PhonePe"
    },
    {
      "label": "Debit Card",
      "value": "debit_card",
      "icon": Icons.credit_card,
      "description": "Pay using your debit card"
    },
  ];

  List<Map<String, dynamic>> paymentTypes = [
    {
      "label": "Regular EMI",
      "value": "emi",
      "amount": 5125.0,
      "description": "Pay your monthly EMI amount"
    },
    {
      "label": "Partial Prepayment",
      "value": "partial_prepayment",
      "amount": 10000.0,
      "description": "Make additional payment to reduce principal"
    },
    {
      "label": "Full Prepayment",
      "value": "full_prepayment",
      "amount": 75000.0,
      "description": "Pay off the entire outstanding amount"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Repayment"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildLoanSummaryCard(),
            _buildPaymentTypeCard(),
            _buildPaymentAmountCard(),
            _buildPaymentMethodCard(),
            _buildCalculationCard(),
            _buildTermsCard(),
            _buildPaymentButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanSummaryCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${loanData["type"]}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "ID: ${loanData["id"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Outstanding Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "₹${((loanData["outstanding"] as double)).currency}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                      "Monthly EMI",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "₹${((loanData["monthlyEmi"] as double)).currency}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Next Due Date:",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
                Text(
                  "${DateTime.parse("2025-07-15").dMMMy}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTypeCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate(paymentTypes.length, (index) {
            final type = paymentTypes[index];
            bool isSelected = selectedPaymentType == type["value"];
            
            return GestureDetector(
              onTap: () {
                selectedPaymentType = type["value"];
                paymentAmount = type["amount"].toString();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(25) : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledBoldColor,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor,
                                ),
                              ),
                            )
                          : null,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${type["label"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${type["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "₹${((type["amount"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPaymentAmountCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Amount",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Amount (₹)",
            value: paymentAmount,
            validator: Validator.required,
            onChanged: (value) {
              paymentAmount = value;
              setState(() {});
            },
          ),
          if (selectedPaymentType == "partial_prepayment") ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Benefits of Partial Prepayment:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  Text(
                    "• Reduces total interest payable\n• Shortens loan tenure\n• Saves money in the long run",
                    style: TextStyle(
                      fontSize: 11,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (selectedPaymentType == "full_prepayment") ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Full Prepayment Benefits:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "• No more monthly EMIs\n• Complete loan closure\n• Improved credit score",
                    style: TextStyle(
                      fontSize: 11,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: List.generate(paymentMethods.length, (index) {
              final method = paymentMethods[index];
              bool isSelected = selectedPaymentMethod == method["value"];
              
              return GestureDetector(
                onTap: () {
                  selectedPaymentMethod = method["value"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(25) : disabledColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Icon(
                        method["icon"],
                        color: isSelected ? primaryColor : disabledBoldColor,
                        size: 24,
                      ),
                      Text(
                        "${method["label"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? primaryColor : disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${method["description"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculationCard() {
    double amount = double.tryParse(paymentAmount) ?? 0;
    double remainingAfterPayment = selectedPaymentType == "full_prepayment" 
        ? 0 
        : (loanData["outstanding"] as double) - amount;
    int savedEmis = selectedPaymentType == "partial_prepayment" 
        ? (amount / (loanData["monthlyEmi"] as double)).floor()
        : selectedPaymentType == "full_prepayment" 
            ? (loanData["remainingEmis"] as int)
            : 0;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment Amount:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "₹${amount.currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                if (selectedPaymentType != "emi") ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Outstanding After Payment:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "₹${remainingAfterPayment.currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: remainingAfterPayment > 0 ? warningColor : successColor,
                        ),
                      ),
                    ],
                  ),
                  if (savedEmis > 0) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "EMIs Saved:",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "$savedEmis months",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ],
            ),
          ),
          if (selectedPaymentType != "emi") ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.savings,
                    color: successColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Interest Saved: ₹${(savedEmis * (loanData["monthlyEmi"] as double) * 0.3).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTermsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Terms & Conditions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Important Notes:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "• Prepayment charges may apply as per loan agreement\n• Processing may take 1-2 business days\n• Payment confirmation will be sent via SMS/Email\n• Auto-debit will be processed on due date",
                  style: TextStyle(
                    fontSize: 11,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  agreeTerms = !agreeTerms;
                  setState(() {});
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: agreeTerms ? primaryColor : Colors.transparent,
                    border: Border.all(
                      color: agreeTerms ? primaryColor : disabledBoldColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: agreeTerms
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        )
                      : null,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "I agree to the terms and conditions of loan repayment and authorize the bank to process this payment.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton() {
    bool canProceed = agreeTerms && 
                     (double.tryParse(paymentAmount) ?? 0) > 0 &&
                     selectedPaymentMethod.isNotEmpty;
    
    return Container(
      width: double.infinity,
      child: QButton(
        label: loading 
            ? "Processing..." 
            : "Proceed to Payment - ₹${(double.tryParse(paymentAmount) ?? 0).currency}",
        size: bs.md,
        onPressed: canProceed && !loading ? _processPayment : null,
      ),
    );
  }

  void _processPayment() async {
    loading = true;
    setState(() {});
    
    // Simulate payment processing
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    // Show success message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Initiated"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your payment has been initiated successfully."),
            SizedBox(height: spSm),
            Text(
              "Payment Details:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Amount: ₹${(double.tryParse(paymentAmount) ?? 0).currency}"),
            Text("Method: ${paymentMethods.firstWhere((m) => m["value"] == selectedPaymentMethod)["label"]}"),
            Text("Reference: PAY${DateTime.now().millisecondsSinceEpoch}"),
          ],
        ),
        actions: [
          QButton(
            label: "Continue",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate back or to success page
            },
          ),
        ],
      ),
    );
  }
}
