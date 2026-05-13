import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaTransactionDetailView extends StatefulWidget {
  const BfaTransactionDetailView({super.key});

  @override
  State<BfaTransactionDetailView> createState() => _BfaTransactionDetailViewState();
}

class _BfaTransactionDetailViewState extends State<BfaTransactionDetailView> {
  // Sample transaction data
  Map<String, dynamic> transaction = {
    "id": "TXN123456789",
    "type": "Transfer",
    "amount": 50000.0,
    "recipientName": "John Williams",
    "recipientAccount": "****1234",
    "bank": "ABC Bank",
    "date": "2024-12-15T10:30:00Z",
    "status": "Completed",
    "description": "Monthly allowance transfer",
    "fee": 2500.0,
    "refNumber": "REF987654321",
    "category": "Personal Transfer"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share transaction receipt
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Download receipt
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Transaction Status Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: transaction["status"] == "Completed" ? successColor : warningColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Icon(
                    transaction["status"] == "Completed" ? Icons.check_circle : Icons.pending,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${transaction["status"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Transaction ${transaction["status"] == "Completed" ? "completed successfully" : "is being processed"}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),

            // Transaction Amount
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "Amount",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "\$${(transaction["amount"] as double).currency}",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  if ((transaction["fee"] as double) > 0) ...[
                    SizedBox(height: spXs),
                    Text(
                      "Fee: \$${(transaction["fee"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
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
                  Text(
                    "Transaction Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  _buildDetailRow("Transaction ID", "${transaction["id"]}"),
                  _buildDetailRow("Reference Number", "${transaction["refNumber"]}"),
                  _buildDetailRow("Type", "${transaction["type"]}"),
                  _buildDetailRow("Category", "${transaction["category"]}"),
                  _buildDetailRow("Date & Time", "${DateTime.parse(transaction["date"]).dMMMykkss}"),
                  _buildDetailRow("Description", "${transaction["description"]}"),
                ],
              ),
            ),

            // Recipient Details
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
                    "Recipient Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  _buildDetailRow("Name", "${transaction["recipientName"]}"),
                  _buildDetailRow("Account", "${transaction["recipientAccount"]}"),
                  _buildDetailRow("Bank", "${transaction["bank"]}"),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Download Receipt",
                    icon: Icons.download,
                    size: bs.md,
                    onPressed: () {
                      ss("Receipt downloaded successfully");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Share",
                    icon: Icons.share,
                    size: bs.md,
                    onPressed: () {
                      ss("Transaction details shared");
                    },
                  ),
                ),
              ],
            ),

            // Repeat Transaction Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Repeat This Transaction",
                icon: Icons.refresh,
                size: bs.md,
                onPressed: () {
                  //navigateTo('BfaTransferMoneyView')
                },
              ),
            ),

            // Need Help Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.help_outline,
                    color: infoColor,
                    size: 32,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Need Help?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Contact our customer support if you have any questions about this transaction.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Contact Support",
                    icon: Icons.phone,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('SupportView')
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
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
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
