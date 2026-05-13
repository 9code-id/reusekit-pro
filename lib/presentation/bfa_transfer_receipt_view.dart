import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaTransferReceiptView extends StatefulWidget {
  const BfaTransferReceiptView({super.key});

  @override
  State<BfaTransferReceiptView> createState() => _BfaTransferReceiptViewState();
}

class _BfaTransferReceiptViewState extends State<BfaTransferReceiptView> {
  // Sample transfer receipt data
  Map<String, dynamic> receiptData = {
    "transactionId": "TXN${DateTime.now().millisecondsSinceEpoch}",
    "referenceNumber": "REF${DateTime.now().millisecondsSinceEpoch}",
    "status": "Completed",
    "dateTime": DateTime.now().toIso8601String(),
    "fromAccount": "Savings Account",
    "fromAccountNumber": "****5678",
    "toName": "John Williams",
    "toAccount": "****1234",
    "bankName": "ABC Bank",
    "routingNumber": "****9876",
    "amount": 500.0,
    "transferFee": 5.0,
    "totalAmount": 505.0,
    "transferType": "Bank Transfer",
    "description": "Monthly allowance transfer",
    "timing": "Immediate",
    "currency": "USD",
    "exchangeRate": 1.0,
    "estimatedArrival": "Within 24 hours",
    "processingTime": "2 minutes",
    "customerName": "Sarah Johnson",
    "customerAccount": "****5678",
    "customerEmail": "sarah.johnson@email.com",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfer Receipt"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareReceipt();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _downloadReceipt();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Success Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Transfer Successful!",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Your money has been sent successfully",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  SizedBox(height: spLg),
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Amount Transferred",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${(receiptData["amount"] as double).currency}",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "to ${receiptData["toName"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Transaction Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_long,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Transaction Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  _buildDetailRow("Transaction ID", "${receiptData["transactionId"]}"),
                  _buildDetailRow("Reference Number", "${receiptData["referenceNumber"]}"),
                  _buildDetailRow("Status", "${receiptData["status"]}", 
                      valueColor: receiptData["status"] == "Completed" ? successColor : warningColor),
                  _buildDetailRow("Date & Time", "${DateTime.parse(receiptData["dateTime"]).dMMMykkss}"),
                  _buildDetailRow("Processing Time", "${receiptData["processingTime"]}"),
                  _buildDetailRow("Transfer Type", "${receiptData["transferType"]}"),
                  _buildDetailRow("Description", "${receiptData["description"]}"),
                ],
              ),
            ),

            // Account Information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Account Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  // From Account
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        _buildDetailRow("Account", "${receiptData["fromAccount"]} (${receiptData["fromAccountNumber"]})"),
                        _buildDetailRow("Account Holder", "${receiptData["customerName"]}"),
                      ],
                    ),
                  ),

                  // To Account
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "To",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        _buildDetailRow("Beneficiary", "${receiptData["toName"]}"),
                        _buildDetailRow("Account Number", "${receiptData["toAccount"]}"),
                        _buildDetailRow("Bank", "${receiptData["bankName"]}"),
                        _buildDetailRow("Routing Number", "${receiptData["routingNumber"]}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Amount Breakdown
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calculate,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Amount Breakdown",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  _buildAmountRow("Transfer Amount", (receiptData["amount"] as double)),
                  _buildAmountRow("Transfer Fee", (receiptData["transferFee"] as double)),
                  if ((receiptData["exchangeRate"] as double) != 1.0) ...[
                    _buildDetailRow("Exchange Rate", "${receiptData["exchangeRate"]}"),
                  ],
                  _buildDetailRow("Currency", "${receiptData["currency"]}"),
                  
                  Divider(color: disabledOutlineBorderColor, thickness: 2),
                  _buildAmountRow("Total Amount", (receiptData["totalAmount"] as double), isBold: true),
                ],
              ),
            ),

            // Delivery Information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Delivery Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  _buildDetailRow("Transfer Timing", "${receiptData["timing"]}"),
                  _buildDetailRow("Estimated Arrival", "${receiptData["estimatedArrival"]}"),
                  
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: infoColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "You will receive an SMS notification when the transfer is completed.",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Download PDF",
                    icon: Icons.download,
                    size: bs.md,
                    onPressed: () {
                      _downloadReceipt();
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Share Receipt",
                    icon: Icons.share,
                    size: bs.md,
                    onPressed: () {
                      _shareReceipt();
                    },
                  ),
                ),
              ],
            ),

            // Quick Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Transfer Again",
                          icon: Icons.refresh,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('BfaTransferMoneyView')
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Add to Favorites",
                          icon: Icons.favorite_border,
                          size: bs.sm,
                          onPressed: () {
                            ss("Transfer saved to favorites");
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View History",
                          icon: Icons.history,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('BfaTransferHistoryView')
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          icon: Icons.support_agent,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('SupportView')
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Important Notice
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: warningColor,
                    size: 32,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Important Notice",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "• Keep this receipt for your records\n• Transfers cannot be reversed once completed\n• Contact us immediately if you notice any discrepancies\n• Processing times may vary based on recipient bank",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Back to Home Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Back to Home",
                icon: Icons.home,
                size: bs.md,
                onPressed: () {
                  //navigateTo('HomeView')
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountRow(String label, double amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isBold ? primaryColor : disabledBoldColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          "\$${amount.currency}",
          style: TextStyle(
            fontSize: 14,
            color: isBold ? primaryColor : disabledBoldColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _downloadReceipt() {
    ss("Receipt downloaded successfully");
  }

  void _shareReceipt() {
    ss("Receipt shared successfully");
  }
}
