import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaTransferConfirmationView extends StatefulWidget {
  const BfaTransferConfirmationView({super.key});

  @override
  State<BfaTransferConfirmationView> createState() => _BfaTransferConfirmationViewState();
}

class _BfaTransferConfirmationViewState extends State<BfaTransferConfirmationView> {
  // Sample transfer data
  Map<String, dynamic> transferData = {
    "fromAccount": "Savings Account (****5678)",
    "fromBalance": 125750.0,
    "toName": "John Williams",
    "toAccount": "****1234",
    "bankName": "ABC Bank",
    "amount": 500.0,
    "transferFee": 5.0,
    "totalAmount": 505.0,
    "transferType": "Bank Transfer",
    "description": "Monthly allowance transfer",
    "timing": "Immediate",
    "scheduledDate": null,
    "exchangeRate": 1.0,
    "currency": "USD",
    "estimatedArrival": "Within 24 hours",
    "referenceNumber": "REF${DateTime.now().millisecondsSinceEpoch}",
  };

  String verificationMethod = "sms";
  String otpCode = "";
  bool isOtpSent = false;
  bool isOtpVerified = false;
  bool agreeToTerms = false;
  bool notifyRecipient = true;
  bool loading = false;
  int countdown = 60;

  List<Map<String, dynamic>> verificationMethods = [
    {"label": "SMS Code", "value": "sms", "icon": Icons.message},
    {"label": "Email Code", "value": "email", "icon": Icons.email},
    {"label": "Authenticator App", "value": "app", "icon": Icons.security},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Transfer"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showHelpDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Transfer Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.swap_horiz,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Transfer Confirmation",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Please review your transfer details",
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
                          "Transfer Amount",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${(transferData["amount"] as double).currency}",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Transfer Details
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
                    "Transfer Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  _buildDetailRow("From Account", "${transferData["fromAccount"]}"),
                  _buildDetailRow("To", "${transferData["toName"]}"),
                  _buildDetailRow("Account Number", "${transferData["toAccount"]}"),
                  _buildDetailRow("Bank", "${transferData["bankName"]}"),
                  _buildDetailRow("Transfer Type", "${transferData["transferType"]}"),
                  _buildDetailRow("Description", "${transferData["description"]}"),
                  _buildDetailRow("Timing", "${transferData["timing"]}"),
                  _buildDetailRow("Reference #", "${transferData["referenceNumber"]}"),
                  _buildDetailRow("Estimated Arrival", "${transferData["estimatedArrival"]}"),
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
                  Text(
                    "Amount Breakdown",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  _buildAmountRow("Transfer Amount", "${transferData["amount"]}", false),
                  _buildAmountRow("Transfer Fee", "${transferData["transferFee"]}", false),
                  if ((transferData["exchangeRate"] as double) != 1.0) ...[
                    _buildAmountRow("Exchange Rate", "${transferData["exchangeRate"]}", false),
                  ],
                  Divider(color: disabledOutlineBorderColor),
                  _buildAmountRow("Total Amount", "${transferData["totalAmount"]}", true),
                  
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          color: infoColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Remaining Balance: \$${((transferData["fromBalance"] as double) - (transferData["totalAmount"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Verification Method
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
                    "Security Verification",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Text(
                    "Choose your verification method to complete the transfer",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),

                  QCategoryPicker(
                    items: verificationMethods.map((method) => {
                      "label": method["label"],
                      "value": method["value"],
                    }).toList(),
                    value: verificationMethod,
                    onChanged: (index, label, value, item) {
                      verificationMethod = value;
                      isOtpSent = false;
                      isOtpVerified = false;
                      otpCode = "";
                      setState(() {});
                    },
                  ),

                  if (!isOtpSent) ...[
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Send Verification Code",
                        icon: Icons.send,
                        size: bs.sm,
                        onPressed: () {
                          _sendOtpCode();
                        },
                      ),
                    ),
                  ] else ...[
                    QTextField(
                      label: "Enter Verification Code",
                      value: otpCode,
                      hint: "Enter 6-digit code",
                      onChanged: (value) {
                        otpCode = value;
                        if (value.length == 6) {
                          _verifyOtpCode();
                        }
                        setState(() {});
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          countdown > 0 ? "Resend in ${countdown}s" : "Didn't receive code?",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (countdown == 0) ...[
                          GestureDetector(
                            onTap: () {
                              _sendOtpCode();
                            },
                            child: Text(
                              "Resend Code",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),

                    if (isOtpVerified) ...[
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Verification successful",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),

            // Transfer Options
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
                    "Transfer Options",
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
                              "label": "Notify Recipient",
                              "value": true,
                              "checked": notifyRecipient,
                            }
                          ],
                          value: [
                            if (notifyRecipient)
                              {
                                "label": "Notify Recipient",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            notifyRecipient = values.isNotEmpty;
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
                              "label": "I agree to the terms and conditions",
                              "value": true,
                              "checked": agreeToTerms,
                            }
                          ],
                          value: [
                            if (agreeToTerms)
                              {
                                "label": "I agree to the terms and conditions",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            agreeToTerms = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Confirm Transfer Button
            Container(
              width: double.infinity,
              child: QButton(
                label: loading ? "Processing Transfer..." : "Confirm Transfer",
                icon: Icons.check_circle,
                size: bs.md,
                onPressed: (loading || !isOtpVerified || !agreeToTerms) ? null : () async {
                  loading = true;
                  setState(() {});
                  
                  // Simulate transfer processing
                  await Future.delayed(Duration(seconds: 3));
                  
                  loading = false;
                  setState(() {});
                  
                  //navigateTo('BfaTransferReceiptView')
                  ss("Transfer completed successfully");
                },
              ),
            ),

            // Security Notice
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
                    Icons.security,
                    color: warningColor,
                    size: 32,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Security Notice",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "• All transfers are encrypted and secure\n• You will receive a confirmation email\n• Transfers cannot be reversed once confirmed\n• Contact support if you notice any issues",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
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

  Widget _buildAmountRow(String label, String amount, bool isBold) {
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
          "\$${(double.parse(amount)).currency}",
          style: TextStyle(
            fontSize: 14,
            color: isBold ? primaryColor : disabledBoldColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _sendOtpCode() {
    isOtpSent = true;
    countdown = 60;
    setState(() {});
    
    // Start countdown timer
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (countdown > 0) {
        countdown--;
        setState(() {});
        return true;
      }
      return false;
    });
    
    String method = verificationMethod == "sms" ? "SMS" : 
                   verificationMethod == "email" ? "Email" : "Authenticator App";
    
    ss("Verification code sent via $method");
  }

  void _verifyOtpCode() {
    // Simulate OTP verification
    if (otpCode == "123456") {
      isOtpVerified = true;
      setState(() {});
      ss("Verification successful");
    } else {
      se("Invalid verification code");
    }
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Transfer Help"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Transfer Information:", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spXs),
              Text("• Transfers are processed within 24 hours"),
              Text("• Fees vary based on transfer type"),
              Text("• International transfers may take 3-5 business days"),
              Text("• All transfers require security verification"),
              SizedBox(height: spSm),
              Text("Need more help?", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spXs),
              Text("Contact our 24/7 customer support at 1-800-BANKING"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => back(),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
