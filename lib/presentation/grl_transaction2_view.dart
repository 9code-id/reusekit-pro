import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTransaction2View extends StatefulWidget {
  const GrlTransaction2View({Key? key}) : super(key: key);

  @override
  State<GrlTransaction2View> createState() => _GrlTransaction2ViewState();
}

class _GrlTransaction2ViewState extends State<GrlTransaction2View> {
  int currentStep = 0;
  String transactionId = "TRX-20241220-001";
  
  List<Map<String, dynamic>> steps = [
    {
      "title": "Transaction Initiated",
      "description": "Payment request created",
      "time": "2024-12-20 09:15:00",
      "status": "completed",
      "icon": Icons.payment,
    },
    {
      "title": "Processing Payment",
      "description": "Verifying payment details",
      "time": "2024-12-20 09:16:30",
      "status": "completed",
      "icon": Icons.hourglass_empty,
    },
    {
      "title": "Bank Authorization",
      "description": "Awaiting bank confirmation",
      "time": "2024-12-20 09:18:45",
      "status": "active",
      "icon": Icons.account_balance,
    },
    {
      "title": "Transaction Complete",
      "description": "Payment successfully processed",
      "time": "",
      "status": "pending",
      "icon": Icons.check_circle,
    },
  ];

  Map<String, dynamic> transactionDetails = {
    "id": "TRX-20241220-001",
    "amount": 245.80,
    "recipient": "John Smith",
    "recipientAccount": "**** 1234",
    "description": "Payment for services",
    "paymentMethod": "Bank Transfer",
    "processingFee": 2.50,
    "totalAmount": 248.30,
    "estimatedTime": "2-3 business days",
    "reference": "REF123456789",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Transaction Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.payment,
                    size: 48,
                    color: primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Transaction ID",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    transactionId,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${(transactionDetails["totalAmount"] as double).currency}",
                    style: TextStyle(
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "PROCESSING",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Progress Steps
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                    "Transaction Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...List.generate(steps.length, (index) {
                    final step = steps[index];
                    final isCompleted = step["status"] == "completed";
                    final isActive = step["status"] == "active";
                    final isPending = step["status"] == "pending";
                    
                    Color stepColor = disabledColor;
                    if (isCompleted) stepColor = successColor;
                    if (isActive) stepColor = warningColor;
                    
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isCompleted 
                                    ? successColor
                                    : isActive 
                                        ? warningColor
                                        : disabledColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(
                                  color: stepColor,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                isCompleted 
                                    ? Icons.check
                                    : step["icon"] as IconData,
                                size: 16,
                                color: isCompleted || isActive 
                                    ? Colors.white 
                                    : disabledColor,
                              ),
                            ),
                            if (index < steps.length - 1)
                              Container(
                                width: 2,
                                height: 40,
                                color: isCompleted 
                                    ? successColor.withAlpha(50)
                                    : disabledColor.withAlpha(50),
                              ),
                          ],
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${step["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isCompleted || isActive 
                                      ? primaryColor
                                      : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${step["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (step["time"].toString().isNotEmpty)
                                Text(
                                  "${DateTime.parse(step["time"]).dMMMykkss}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              if (index < steps.length - 1)
                                SizedBox(height: spSm),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),

            // Transaction Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
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
                  SizedBox(height: spSm),
                  _buildDetailRow("Recipient", "${transactionDetails["recipient"]}"),
                  _buildDetailRow("Account", "${transactionDetails["recipientAccount"]}"),
                  _buildDetailRow("Description", "${transactionDetails["description"]}"),
                  _buildDetailRow("Payment Method", "${transactionDetails["paymentMethod"]}"),
                  _buildDetailRow("Amount", "\$${(transactionDetails["amount"] as double).currency}"),
                  _buildDetailRow("Processing Fee", "\$${(transactionDetails["processingFee"] as double).currency}"),
                  Divider(color: disabledOutlineBorderColor),
                  _buildDetailRow(
                    "Total Amount", 
                    "\$${(transactionDetails["totalAmount"] as double).currency}",
                    isTotal: true,
                  ),
                  _buildDetailRow("Reference", "${transactionDetails["reference"]}"),
                  _buildDetailRow("Estimated Time", "${transactionDetails["estimatedTime"]}"),
                ],
              ),
            ),

            // Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel Transaction",
                    color: dangerColor,
                    size: bs.md,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Are you sure you want to cancel this transaction?");
                      if (isConfirmed) {
                        ss("Transaction cancelled successfully");
                      }
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Contact Support",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // Help Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Need Help?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "If you have any questions about this transaction, please contact our support team. We're available 24/7 to assist you.",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Get Help",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? primaryColor : primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
