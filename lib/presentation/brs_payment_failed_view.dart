import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsPaymentFailedView extends StatefulWidget {
  const BrsPaymentFailedView({super.key});

  @override
  State<BrsPaymentFailedView> createState() => _BrsPaymentFailedViewState();
}

class _BrsPaymentFailedViewState extends State<BrsPaymentFailedView> {
  Map<String, dynamic> failedPayment = {
    "bookingId": "BRS-001234",
    "transactionId": "TXN-789012345",
    "amount": 50.0,
    "paymentMethod": "Credit Card (**** 4532)",
    "errorCode": "CARD_DECLINED",
    "errorMessage": "Your card was declined. Please try a different payment method or contact your bank.",
    "timestamp": DateTime.now(),
    "retryAttempts": 1,
    "maxRetryAttempts": 3
  };

  List<Map<String, dynamic>> commonIssues = [
    {
      "title": "Insufficient Funds",
      "description": "Make sure your account has enough balance",
      "icon": Icons.account_balance_wallet,
      "solution": "Check your account balance or try a different card"
    },
    {
      "title": "Card Expired",
      "description": "Your card may have expired",
      "icon": Icons.credit_card_off,
      "solution": "Update your card details or use a different payment method"
    },
    {
      "title": "Incorrect Details",
      "description": "Card number, CVV, or expiry date may be wrong",
      "icon": Icons.error,
      "solution": "Double-check your card information and try again"
    },
    {
      "title": "Bank Security",
      "description": "Your bank may have blocked the transaction",
      "icon": Icons.security,
      "solution": "Contact your bank to authorize the payment"
    }
  ];

  @override
  Widget build(BuildContext context) {
    double amount = failedPayment["amount"] as double;
    int retryAttempts = failedPayment["retryAttempts"] as int;
    int maxRetryAttempts = failedPayment["maxRetryAttempts"] as int;
    bool canRetry = retryAttempts < maxRetryAttempts;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: spMd,
          children: [
            SizedBox(height: spXl),
            
            // Error Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                shape: BoxShape.circle,
                border: Border.all(color: dangerColor, width: 3),
              ),
              child: Icon(
                Icons.error,
                size: 80,
                color: dangerColor,
              ),
            ),

            // Error Message
            Column(
              spacing: spSm,
              children: [
                Text(
                  "Payment Failed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "We couldn't process your payment",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Text(
                    "Booking ID: ${failedPayment["bookingId"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                ),
              ],
            ),

            // Error Details
            Container(
              width: double.infinity,
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
                    "Error Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: dangerColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Error Code: ${failedPayment["errorCode"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "${failedPayment["errorMessage"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Transaction ID",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "${failedPayment["transactionId"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Amount",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${amount.currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Payment Method",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "${failedPayment["paymentMethod"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  if (!canRetry)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning, color: warningColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Maximum retry attempts reached. Please try a different payment method.",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Common Issues & Solutions
            Container(
              width: double.infinity,
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
                    "Common Issues & Solutions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...commonIssues.map((issue) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: infoColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              issue["icon"] as IconData,
                              color: infoColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${issue["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${issue["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Solution: ${issue["solution"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Help & Support
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.support_agent, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Need Help?",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Our support team is here to help you resolve payment issues. Contact us for assistance.",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Call Support",
                          size: bs.sm,
                          onPressed: () {
                            ss("Calling support");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Live Chat",
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening live chat");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Buttons
            Column(
              spacing: spSm,
              children: [
                if (canRetry)
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Try Again",
                      size: bs.md,
                      onPressed: () {
                        ss("Retrying payment");
                      },
                    ),
                  ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Change Payment Method",
                    size: bs.md,
                    onPressed: () {
                      ss("Changing payment method");
                    },
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Save for Later",
                        size: bs.md,
                        onPressed: () {
                          ss("Saving booking for later");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Cancel Booking",
                        size: bs.md,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Are you sure you want to cancel this booking?");
                          if (isConfirmed) {
                            ss("Booking cancelled");
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Back to Home",
                    size: bs.md,
                    onPressed: () {
                      ss("Returning to home");
                    },
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
