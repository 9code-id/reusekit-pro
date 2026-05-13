import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaPaymentReceiptView extends StatefulWidget {
  const BfaPaymentReceiptView({super.key});

  @override
  State<BfaPaymentReceiptView> createState() => _BfaPaymentReceiptViewState();
}

class _BfaPaymentReceiptViewState extends State<BfaPaymentReceiptView> {
  // Sample receipt data - in real app this would come from parameters
  Map<String, dynamic> receiptData = {
    "transactionId": "PAY789456123",
    "type": "Credit Card Payment",
    "merchant": "Chase Bank",
    "merchantLogo": "https://picsum.photos/60/60?random=1&bank",
    "description": "Chase Sapphire Preferred Card Payment",
    "amount": 500.00,
    "fee": 0.00,
    "totalAmount": 500.00,
    "date": "2025-01-15T14:30:00",
    "status": "Success",
    "paymentMethod": "Bank Account ****1234",
    "accountHolder": "John Doe",
    "referenceNumber": "REF123456789",
    "processingTime": "Instant",
    "currency": "USD",
    "fromAccount": {
      "type": "Checking Account",
      "bank": "Wells Fargo",
      "accountNumber": "****1234",
      "routingNumber": "****5678"
    },
    "toAccount": {
      "type": "Credit Card",
      "bank": "Chase Bank",
      "cardNumber": "****9012",
      "cardType": "Visa"
    },
    "breakdown": [
      {"label": "Principal Payment", "amount": 450.00},
      {"label": "Interest Payment", "amount": 50.00},
      {"label": "Processing Fee", "amount": 0.00}
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Receipt"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share receipt
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Download PDF
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Receipt Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  // Success Icon
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 64,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Payment Successful!",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Your payment has been processed successfully",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Text(
                      "Transaction ID: ${receiptData["transactionId"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Payment Details
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
                    "Payment Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Merchant Info
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${receiptData["merchantLogo"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${receiptData["merchant"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${receiptData["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${receiptData["type"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  Divider(color: disabledOutlineBorderColor),
                  SizedBox(height: spMd),
                  
                  // Amount Details
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Amount Paid",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(receiptData["amount"] as double).currency}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
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
                            "Date & Time",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(receiptData["date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(receiptData["date"]).kkmm}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  if (receiptData["breakdown"] != null) ...[
                    SizedBox(height: spMd),
                    Divider(color: disabledOutlineBorderColor),
                    SizedBox(height: spMd),
                    Text(
                      "Payment Breakdown",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(receiptData["breakdown"] as List).map((item) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${item["label"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Text(
                              "\$${(item["amount"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ],
              ),
            ),

            // Account Information
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
                    "Account Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // From Account
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "From Account",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${receiptData["fromAccount"]["type"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${receiptData["fromAccount"]["bank"]} • ${receiptData["fromAccount"]["accountNumber"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Arrow Icon
                  Center(
                    child: Icon(
                      Icons.arrow_downward,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // To Account
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.credit_card,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "To Account",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${receiptData["toAccount"]["type"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${receiptData["toAccount"]["bank"]} • ${receiptData["toAccount"]["cardNumber"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Transaction Summary
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
                    "Transaction Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  _buildSummaryRow("Transaction ID", "${receiptData["transactionId"]}"),
                  _buildSummaryRow("Reference Number", "${receiptData["referenceNumber"]}"),
                  _buildSummaryRow("Account Holder", "${receiptData["accountHolder"]}"),
                  _buildSummaryRow("Payment Method", "${receiptData["paymentMethod"]}"),
                  _buildSummaryRow("Processing Time", "${receiptData["processingTime"]}"),
                  _buildSummaryRow("Currency", "${receiptData["currency"]}"),
                  _buildSummaryRow("Status", "${receiptData["status"]}", isStatus: true),
                ],
              ),
            ),

            // Important Notice
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(128)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Important Notice",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Please save this receipt for your records\n• It may take 1-3 business days for the payment to reflect in your account\n• For any disputes, please contact customer support with the transaction ID\n• This is an electronic receipt and is valid for all purposes",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Download PDF",
                    icon: Icons.download,
                    onPressed: () {
                      // Download PDF receipt
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Share Receipt",
                    icon: Icons.share,
                    onPressed: () {
                      // Share receipt
                    },
                  ),
                ),
              ],
            ),

            // Back to Home
            Container(
              width: double.infinity,
              child: QButton(
                label: "Back to Payment History",
                icon: Icons.history,
                onPressed: () {
                  back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          if (isStatus)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: spXs,
              ),
              decoration: BoxDecoration(
                color: successColor.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            )
          else
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
