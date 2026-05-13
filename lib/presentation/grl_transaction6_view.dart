import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTransaction6View extends StatefulWidget {
  @override
  State<GrlTransaction6View> createState() => _GrlTransaction6ViewState();
}

class _GrlTransaction6ViewState extends State<GrlTransaction6View> {
  String disputeReason = "";
  String disputeDescription = "";
  bool agreeTerms = false;
  bool loading = false;

  Map<String, dynamic> transactionDetails = {
    "id": "TXN-2024-0001",
    "amount": 299.99,
    "currency": "USD",
    "description": "Premium Wireless Headphones - Sony WH-1000XM5",
    "merchant": "AudioTech Store",
    "date": "2024-06-15T14:30:00Z",
    "status": "completed",
    "paymentMethod": "Visa •••• 1234",
    "canDispute": true,
    "disputeDeadline": "2024-07-15",
  };

  List<Map<String, dynamic>> disputeReasons = [
    {
      "id": "unauthorized",
      "title": "Unauthorized Transaction",
      "subtitle": "I did not authorize this transaction",
      "description": "Use this if you believe the transaction was made without your permission or if your card was used fraudulently.",
    },
    {
      "id": "not_received",
      "title": "Product/Service Not Received",
      "subtitle": "I paid but didn't receive what I ordered",
      "description": "Select this if you paid for goods or services but never received them within the expected timeframe.",
    },
    {
      "id": "defective",
      "title": "Defective or Damaged Product",
      "subtitle": "The product I received was defective or damaged",
      "description": "Use this if the item you received was broken, damaged, or significantly different from what was advertised.",
    },
    {
      "id": "cancelled_not_refunded",
      "title": "Cancelled but Not Refunded",
      "subtitle": "I cancelled the order but wasn't refunded",
      "description": "Select this if you properly cancelled an order or subscription but didn't receive the expected refund.",
    },
    {
      "id": "duplicate",
      "title": "Duplicate Charge",
      "subtitle": "I was charged multiple times for the same purchase",
      "description": "Use this if you were charged more than once for a single transaction or purchase.",
    },
    {
      "id": "refund_not_processed",
      "title": "Refund Not Processed",
      "subtitle": "Merchant promised a refund but it wasn't processed",
      "description": "Select this if the merchant agreed to refund your purchase but failed to process it within the agreed timeframe.",
    },
    {
      "id": "subscription_issues",
      "title": "Subscription Issues",
      "subtitle": "Problems with recurring subscription charges",
      "description": "Use this for issues with subscription services, including unwanted renewals or inability to cancel.",
    },
    {
      "id": "other",
      "title": "Other Reason",
      "subtitle": "My dispute reason is not listed above",
      "description": "Select this if your dispute doesn't fit into any of the above categories and provide detailed explanation.",
    },
  ];

  List<Map<String, dynamic>> disputeSteps = [
    {
      "step": 1,
      "title": "Submit Dispute",
      "description": "Provide reason and evidence for your dispute",
      "duration": "Immediate",
    },
    {
      "step": 2,
      "title": "Initial Review",
      "description": "Bank reviews your dispute claim and documentation",
      "duration": "2-3 business days",
    },
    {
      "step": 3,
      "title": "Merchant Response",
      "description": "Merchant is notified and can provide counter-evidence",
      "duration": "7-14 business days",
    },
    {
      "step": 4,
      "title": "Investigation",
      "description": "Detailed investigation of all evidence and documentation",
      "duration": "30-60 business days",
    },
    {
      "step": 5,
      "title": "Final Decision",
      "description": "Bank makes final decision and processes resolution",
      "duration": "1-2 business days",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dispute Transaction"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction details
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.report_problem,
                          color: dangerColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Transaction to Dispute",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${transactionDetails["id"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${(transactionDetails["amount"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "${transactionDetails["description"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${DateTime.parse(transactionDetails["date"]).dMMMy}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
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
                              "Merchant",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${transactionDetails["merchant"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
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
                              "Payment",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${transactionDetails["paymentMethod"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Dispute deadline: ${DateTime.parse(transactionDetails["disputeDeadline"]).dMMMy}",
                            style: TextStyle(
                              color: warningColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Dispute process explanation
            Text(
              "Dispute Process",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(disputeSteps.length, (index) {
                  final step = disputeSteps[index];
                  final isLast = index == disputeSteps.length - 1;
                  
                  return Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(color: primaryColor, width: 2),
                              ),
                              child: Center(
                                child: Text(
                                  "${step["step"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            if (!isLast)
                              Container(
                                width: 2,
                                height: 40,
                                color: disabledColor,
                                margin: EdgeInsets.symmetric(vertical: spSm),
                              ),
                          ],
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: isLast ? 0 : spMd),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${step["title"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${step["description"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${step["duration"]}",
                                    style: TextStyle(
                                      color: infoColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Dispute reason selection
            Text(
              "Select Dispute Reason",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ...List.generate(disputeReasons.length, (index) {
              final reason = disputeReasons[index];
              final isSelected = disputeReason == reason["id"];
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: GestureDetector(
                  onTap: () {
                    disputeReason = reason["id"] as String;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: isSelected 
                          ? Border.all(color: primaryColor, width: 2)
                          : Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                                color: isSelected ? primaryColor : Colors.transparent,
                              ),
                              child: isSelected
                                  ? Icon(Icons.check, color: Colors.white, size: 12)
                                  : null,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${reason["title"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${reason["subtitle"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (isSelected) ...[
                          SizedBox(height: spSm),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${reason["description"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }),
            
            SizedBox(height: spMd),
            
            // Additional details
            Text(
              "Additional Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Please provide additional details about your dispute. Include any relevant information that supports your claim.",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QMemoField(
                    label: "Dispute Description",
                    value: disputeDescription,
                    hint: "Describe the issue in detail, including dates, communications with merchant, and any attempts to resolve the issue...",
                    onChanged: (value) {
                      disputeDescription = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Important information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor),
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
                        "Important Information",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Disputing a transaction may take 30-60 business days to resolve\n• You may be asked to provide additional documentation\n• False dispute claims may result in account restrictions\n• Try contacting the merchant first to resolve the issue\n• Temporary credit may be issued during investigation",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Agreement checkbox
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "I understand the dispute process and confirm that the information provided is accurate",
                        "value": true,
                        "checked": agreeTerms,
                      }
                    ],
                    value: [if (agreeTerms) {"label": "I understand the dispute process and confirm that the information provided is accurate", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      agreeTerms = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.md,
                    color: disabledBoldColor,
                    onPressed: () {
                      // Go back
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: loading ? "Submitting..." : "Submit Dispute",
                    size: bs.md,
                    onPressed: (disputeReason.isNotEmpty && disputeDescription.isNotEmpty && agreeTerms && !loading) ? () async {
                      bool isConfirmed = await confirm("Are you sure you want to submit this dispute? This action cannot be undone.");
                      if (isConfirmed) {
                        loading = true;
                        setState(() {});
                        
                        // Simulate dispute submission
                        await Future.delayed(Duration(seconds: 3));
                        
                        loading = false;
                        setState(() {});
                        
                        ss("Dispute submitted successfully. You will receive updates via email.");
                        // Navigate back or to dispute status page
                      }
                    } : null,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            Center(
              child: Text(
                "Need help? Contact our support team for assistance",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
