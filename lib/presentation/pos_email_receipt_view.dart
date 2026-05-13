import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosEmailReceiptView extends StatefulWidget {
  const PosEmailReceiptView({super.key});

  @override
  State<PosEmailReceiptView> createState() => _PosEmailReceiptViewState();
}

class _PosEmailReceiptViewState extends State<PosEmailReceiptView> {
  String recipientEmail = "john.doe@email.com";
  String senderEmail = "receipts@coffeeandmore.com";
  String emailSubject = "Your Receipt from Coffee & More";
  String emailMessage = "";
  bool includeStorePromo = true;
  bool requestFeedback = false;
  bool subscribeNewsletter = false;
  String emailFormat = "html";
  
  final List<Map<String, dynamic>> emailFormats = [
    {"label": "HTML (Rich)", "value": "html"},
    {"label": "Plain Text", "value": "plain"},
    {"label": "PDF Attachment", "value": "pdf"},
  ];

  final List<Map<String, dynamic>> emailTemplates = [
    {
      "name": "Standard",
      "subject": "Your Receipt from Coffee & More",
      "message": "Thank you for your purchase! Please find your receipt details below.",
    },
    {
      "name": "Promotional",
      "subject": "Your Receipt + Special Offers!",
      "message": "Thank you for your purchase! Check out our special offers and loyalty program below.",
    },
    {
      "name": "Feedback Request",
      "subject": "Your Receipt - We'd Love Your Feedback!",
      "message": "Thank you for your purchase! We'd appreciate your feedback about your experience today.",
    },
  ];

  final Map<String, dynamic> transactionDetails = {
    "transaction_id": "TXN-2024-001234",
    "date": DateTime.now(),
    "total_amount": 38.35,
    "payment_method": "Credit Card",
    "items_count": 8,
  };

  bool isLoading = false;
  String emailStatus = "";

  void _loadEmailTemplate(Map<String, dynamic> template) {
    emailSubject = "${template["subject"]}";
    emailMessage = "${template["message"]}";
    setState(() {});
  }

  void _previewEmail() {
    si("Email preview functionality");
    //navigateTo('email_preview')
  }

  void _sendEmail() async {
    if (recipientEmail.isEmpty) {
      se("Please enter recipient email address");
      return;
    }

    if (emailSubject.isEmpty) {
      se("Please enter email subject");
      return;
    }

    bool isConfirmed = await confirm("Send receipt via email to $recipientEmail?");
    if (!isConfirmed) return;

    setState(() {
      isLoading = true;
      emailStatus = "Preparing email...";
    });

    // Simulate email preparation
    await Future.delayed(Duration(seconds: 1));
    
    setState(() {
      emailStatus = "Sending email...";
    });

    // Simulate sending
    await Future.delayed(Duration(seconds: 3));
    
    setState(() {
      emailStatus = "Email sent successfully!";
    });

    // Simulate completion
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isLoading = false;
      emailStatus = "";
    });

    ss("Receipt emailed to $recipientEmail");
    back();
  }

  void _saveEmailTemplate() async {
    if (emailSubject.isEmpty || emailMessage.isEmpty) {
      se("Please complete subject and message");
      return;
    }

    bool isConfirmed = await confirm("Save this as a custom email template?");
    if (isConfirmed) {
      ss("Email template saved");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Receipt"),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: _previewEmail,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Transaction Summary
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Transaction Details",
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
                        "Transaction ID:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${transactionDetails["transaction_id"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date & Time:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(transactionDetails["date"] as DateTime).dMMMykkss}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(transactionDetails["total_amount"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Items:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${transactionDetails["items_count"]} items",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Email Configuration
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Email Configuration",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  QTextField(
                    label: "Recipient Email",
                    value: recipientEmail,
                    hint: "customer@email.com",
                    onChanged: (value) {
                      recipientEmail = value;
                      setState(() {});
                    },
                  ),

                  QTextField(
                    label: "Sender Email",
                    value: senderEmail,
                    hint: "receipts@store.com",
                    onChanged: (value) {
                      senderEmail = value;
                      setState(() {});
                    },
                  ),

                  QDropdownField(
                    label: "Email Format",
                    items: emailFormats,
                    value: emailFormat,
                    onChanged: (value, label) {
                      emailFormat = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Email Templates
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Email Templates",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 150,
                    children: emailTemplates.map((template) {
                      return GestureDetector(
                        onTap: () => _loadEmailTemplate(template),
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: primaryColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${template["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${template["subject"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Email Content
            Container(
              padding: EdgeInsets.all(spMd),
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
                        "Email Content",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "Save Template",
                        icon: Icons.save,
                        color: infoColor,
                        size: bs.sm,
                        onPressed: _saveEmailTemplate,
                      ),
                    ],
                  ),

                  QTextField(
                    label: "Email Subject",
                    value: emailSubject,
                    hint: "Enter email subject",
                    onChanged: (value) {
                      emailSubject = value;
                      setState(() {});
                    },
                  ),

                  QMemoField(
                    label: "Email Message",
                    value: emailMessage,
                    hint: "Enter your email message here...",
                    onChanged: (value) {
                      emailMessage = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Email Options
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Email Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Include Store Promotions",
                              "value": true,
                              "checked": includeStorePromo,
                            }
                          ],
                          value: [
                            if (includeStorePromo)
                              {
                                "label": "Include Store Promotions",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            includeStorePromo = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Request Customer Feedback",
                              "value": true,
                              "checked": requestFeedback,
                            }
                          ],
                          value: [
                            if (requestFeedback)
                              {
                                "label": "Request Customer Feedback",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            requestFeedback = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Subscribe to Newsletter",
                              "value": true,
                              "checked": subscribeNewsletter,
                            }
                          ],
                          value: [
                            if (subscribeNewsletter)
                              {
                                "label": "Subscribe to Newsletter",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            subscribeNewsletter = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Email Preview
            if (emailFormat == "html")
              Container(
                padding: EdgeInsets.all(spMd),
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
                      "Email Preview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "Subject: $emailSubject",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          
                          Text(
                            "From: $senderEmail",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          
                          Text(
                            "To: $recipientEmail",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          
                          Divider(),
                          
                          Text(
                            emailMessage.isNotEmpty 
                              ? emailMessage
                              : "Email message will appear here...",
                            style: TextStyle(
                              fontSize: 14,
                              color: emailMessage.isNotEmpty 
                                ? primaryColor 
                                : disabledBoldColor,
                            ),
                          ),
                          
                          if (includeStorePromo) ...[
                            Divider(),
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: warningColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "🎉 Special Offer: Get 10% off your next purchase!",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                          
                          if (requestFeedback) ...[
                            Divider(),
                            Text(
                              "We'd love to hear about your experience today! Please take a moment to leave us a review.",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Sending Status
            if (isLoading)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: infoColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      emailStatus,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
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
                    label: "Preview",
                    color: disabledBoldColor,
                    size: bs.md,
                    onPressed: isLoading ? null : _previewEmail,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: isLoading ? "Sending..." : "Send Email",
                    icon: isLoading ? null : Icons.send,
                    size: bs.md,
                    onPressed: isLoading ? null : _sendEmail,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
