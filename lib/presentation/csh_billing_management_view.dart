import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CshBillingManagementView extends StatefulWidget {
  const CshBillingManagementView({super.key});

  @override
  State<CshBillingManagementView> createState() => _CshBillingManagementViewState();
}

class _CshBillingManagementViewState extends State<CshBillingManagementView> {
  String currentPlan = "Pro Plan";
  String billingCycle = "Monthly";
  String paymentMethod = "Credit Card";
  bool autoRenewal = true;
  bool invoiceReminders = true;
  bool paymentNotifications = true;
  String nextBillingDate = "2024-02-15";
  
  List<Map<String, dynamic>> cycleOptions = [
    {"label": "Monthly", "value": "Monthly"},
    {"label": "Annually", "value": "Annually"},
  ];
  
  List<Map<String, dynamic>> paymentMethodOptions = [
    {"label": "Credit Card", "value": "Credit Card"},
    {"label": "Bank Transfer", "value": "Bank Transfer"},
    {"label": "PayPal", "value": "PayPal"},
    {"label": "Cryptocurrency", "value": "Cryptocurrency"},
  ];

  List<Map<String, dynamic>> plans = [
    {
      "name": "Basic Plan",
      "price": 29.99,
      "billing": "Monthly",
      "features": ["Up to 10 users", "5GB storage", "Email support", "Basic analytics"],
      "current": false,
    },
    {
      "name": "Pro Plan",
      "price": 79.99,
      "billing": "Monthly",
      "features": ["Up to 50 users", "50GB storage", "Priority support", "Advanced analytics", "API access"],
      "current": true,
    },
    {
      "name": "Enterprise Plan",
      "price": 199.99,
      "billing": "Monthly",
      "features": ["Unlimited users", "500GB storage", "24/7 phone support", "Custom integrations", "Dedicated account manager"],
      "current": false,
    },
  ];

  List<Map<String, dynamic>> invoiceHistory = [
    {
      "invoiceNumber": "INV-2024-001",
      "date": "2024-01-15",
      "amount": 79.99,
      "status": "Paid",
      "dueDate": "2024-01-15",
      "plan": "Pro Plan",
      "period": "Jan 15 - Feb 14, 2024",
    },
    {
      "invoiceNumber": "INV-2023-012",
      "date": "2023-12-15",
      "amount": 79.99,
      "status": "Paid",
      "dueDate": "2023-12-15",
      "plan": "Pro Plan",
      "period": "Dec 15, 2023 - Jan 14, 2024",
    },
    {
      "invoiceNumber": "INV-2023-011",
      "date": "2023-11-15",
      "amount": 79.99,
      "status": "Paid",
      "dueDate": "2023-11-15",
      "plan": "Pro Plan",
      "period": "Nov 15 - Dec 14, 2023",
    },
    {
      "invoiceNumber": "INV-2023-010",
      "date": "2023-10-15",
      "amount": 29.99,
      "status": "Paid",
      "dueDate": "2023-10-15",
      "plan": "Basic Plan",
      "period": "Oct 15 - Nov 14, 2023",
    },
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "type": "Credit Card",
      "details": "**** **** **** 4532",
      "expiry": "12/26",
      "primary": true,
      "icon": Icons.credit_card,
    },
    {
      "type": "Bank Account",
      "details": "**** **** 8901",
      "expiry": "",
      "primary": false,
      "icon": Icons.account_balance,
    },
    {
      "type": "PayPal",
      "details": "john.smith@email.com",
      "expiry": "",
      "primary": false,
      "icon": Icons.payment,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Billing Management"),
        actions: [
          IconButton(
            onPressed: () {
              _downloadInvoice();
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Current Plan Overview Section
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
                    "Current Plan",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentPlan,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "\$79.99/month",
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: successColor.withAlpha(100)),
                        ),
                        child: Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    spacing: spLg,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Next Billing",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Feb 15, 2024",
                              style: TextStyle(
                                fontSize: 14,
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
                              "Payment Method",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "**** 4532",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Billing Settings Section
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
                    "Billing Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Billing Cycle",
                    items: cycleOptions,
                    value: billingCycle,
                    onChanged: (value, label) {
                      billingCycle = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Payment Method",
                    items: paymentMethodOptions,
                    value: paymentMethod,
                    onChanged: (value, label) {
                      paymentMethod = value;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Auto Renewal",
                    items: [
                      {
                        "label": "Automatically renew subscription",
                        "value": true,
                        "checked": autoRenewal,
                      }
                    ],
                    value: [if (autoRenewal) {"label": "Automatically renew subscription", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      autoRenewal = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Invoice Reminders",
                    items: [
                      {
                        "label": "Send invoice reminder emails",
                        "value": true,
                        "checked": invoiceReminders,
                      }
                    ],
                    value: [if (invoiceReminders) {"label": "Send invoice reminder emails", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      invoiceReminders = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    label: "Payment Notifications",
                    items: [
                      {
                        "label": "Send payment confirmation emails",
                        "value": true,
                        "checked": paymentNotifications,
                      }
                    ],
                    value: [if (paymentNotifications) {"label": "Send payment confirmation emails", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      paymentNotifications = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Available Plans Section
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
                    "Available Plans",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...List.generate(plans.length, (index) {
                    final plan = plans[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: (plan["current"] as bool) ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: (plan["current"] as bool) ? primaryColor : Colors.grey.withAlpha(100),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${plan["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              if (plan["current"] as bool)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Current",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Text(
                            "\$${((plan["price"] as double)).currency}/${plan["billing"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          ...(plan["features"] as List<String>).map((feature) {
                            return Row(
                              children: [
                                Icon(Icons.check, color: successColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  feature,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            );
                          }),
                          if (!(plan["current"] as bool))
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: spSm),
                              child: QButton(
                                label: "Upgrade to ${plan["name"]}",
                                size: bs.sm,
                                onPressed: () {
                                  _upgradePlan(plan);
                                },
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Payment Methods Section
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
                    children: [
                      Text(
                        "Payment Methods",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          _addPaymentMethod();
                        },
                        child: Text(
                          "Add New",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...List.generate(paymentMethods.length, (index) {
                    final method = paymentMethods[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: (method["primary"] as bool) ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: (method["primary"] as bool) ? primaryColor.withAlpha(100) : Colors.grey.withAlpha(100),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            method["icon"] as IconData,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${method["type"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${method["details"]}${method["expiry"].isNotEmpty ? " • Exp: ${method["expiry"]}" : ""}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (method["primary"] as bool)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Primary",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {
                              _editPaymentMethod(method);
                            },
                            child: Icon(
                              Icons.edit,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Invoice History Section
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
                    children: [
                      Text(
                        "Invoice History",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          _viewAllInvoices();
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
                  ...List.generate(invoiceHistory.take(3).length, (index) {
                    final invoice = invoiceHistory[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(100)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.receipt, color: successColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${invoice["invoiceNumber"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "\$${((invoice["amount"] as double)).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${invoice["date"]} • ${invoice["plan"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${invoice["period"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _downloadInvoiceFile(invoice);
                            },
                            child: Icon(
                              Icons.download,
                              color: primaryColor,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Action Buttons Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Change Plan",
                          icon: Icons.upgrade,
                          size: bs.md,
                          onPressed: () {
                            _changePlan();
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Cancel Subscription",
                          icon: Icons.cancel,
                          size: bs.md,
                          onPressed: () {
                            _cancelSubscription();
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Save Billing Settings",
                      icon: Icons.save,
                      size: bs.md,
                      onPressed: () {
                        _saveBillingSettings();
                      },
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

  void _downloadInvoice() {
    ss("Latest invoice downloaded");
  }

  void _upgradePlan(Map<String, dynamic> plan) async {
    bool isConfirmed = await confirm("Upgrade to ${plan["name"]} for \$${((plan["price"] as double)).currency}/month?");
    if (isConfirmed) {
      ss("Plan upgrade initiated");
    }
  }

  void _addPaymentMethod() {
    ss("Add payment method dialog opened");
  }

  void _editPaymentMethod(Map<String, dynamic> method) {
    ss("Edit payment method dialog opened");
  }

  void _viewAllInvoices() {
    ss("Full invoice history opened");
  }

  void _downloadInvoiceFile(Map<String, dynamic> invoice) {
    ss("Invoice ${invoice["invoiceNumber"]} downloaded");
  }

  void _changePlan() {
    ss("Plan selection dialog opened");
  }

  void _cancelSubscription() async {
    bool isConfirmed = await confirm("Are you sure you want to cancel your subscription?");
    if (isConfirmed) {
      ss("Subscription cancellation initiated");
    }
  }

  void _saveBillingSettings() {
    ss("Billing settings saved successfully");
  }
}
