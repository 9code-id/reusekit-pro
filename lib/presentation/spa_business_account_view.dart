import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaBusinessAccountView extends StatefulWidget {
  const SpaBusinessAccountView({super.key});

  @override
  State<SpaBusinessAccountView> createState() => _SpaBusinessAccountViewState();
}

class _SpaBusinessAccountViewState extends State<SpaBusinessAccountView> {
  String businessName = "Serenity Spa Downtown";
  String businessType = "LLC";
  String taxId = "TAX-123456789";
  String businessPhone = "+1 (555) 123-4567";
  String businessEmail = "business@serenityspa.com";
  String businessAddress = "123 Main Street, Downtown";
  String businessCity = "New York";
  String businessState = "NY";
  String businessZip = "10002";
  String contactPerson = "Sarah Johnson";
  String contactTitle = "Owner/Manager";
  String contactPhone = "+1 (555) 123-4567";
  String contactEmail = "sarah@serenityspa.com";
  
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool promotionalEmails = true;
  bool orderUpdates = true;
  bool invoiceReminders = true;
  bool paymentConfirmations = true;
  
  String preferredCurrency = "USD";
  String preferredLanguage = "English";
  String timeZone = "EST";
  String paymentTerms = "Net 30";
  
  List<String> currencies = ["USD", "EUR", "GBP", "CAD"];
  List<String> languages = ["English", "Spanish", "French"];
  List<String> timeZones = ["EST", "PST", "CST", "MST"];
  List<String> paymentTermsList = ["Net 15", "Net 30", "Net 45", "Due on Receipt"];
  
  Map<String, dynamic> accountStatus = {
    "status": "Active",
    "memberSince": "January 2022",
    "accountType": "Premium Business",
    "creditLimit": 50000.0,
    "creditUsed": 12450.75,
    "paymentStatus": "Current",
    "lastPayment": "December 15, 2024",
    "nextBillingDate": "January 15, 2025"
  };
  
  List<Map<String, dynamic>> paymentMethods = [
    {
      "type": "Credit Card",
      "details": "Visa ending in 1234",
      "isPrimary": true,
      "expiryDate": "12/26",
      "isActive": true
    },
    {
      "type": "Bank Account",
      "details": "First National Bank ****5678",
      "isPrimary": false,
      "isActive": true
    },
    {
      "type": "Business Credit Line",
      "details": "Credit Line - \$50,000 limit",
      "isPrimary": false,
      "isActive": true
    },
  ];
  
  List<Map<String, dynamic>> recentActivity = [
    {
      "activity": "Payment Processed",
      "details": "Invoice #INV-2024-0156 - \$1,840.93",
      "date": "Dec 15, 2024",
      "status": "Completed",
      "icon": Icons.payment
    },
    {
      "activity": "Order Placed",
      "details": "Order #SPA-ORD-2024-001 - \$519.96",
      "date": "Dec 14, 2024",
      "status": "Processing",
      "icon": Icons.shopping_cart
    },
    {
      "activity": "Profile Updated",
      "details": "Contact information updated",
      "date": "Dec 10, 2024",
      "status": "Completed",
      "icon": Icons.edit
    },
    {
      "activity": "Credit Approved",
      "details": "Credit limit increased to \$50,000",
      "date": "Nov 25, 2024",
      "status": "Completed",
      "icon": Icons.credit_card
    },
  ];

  @override
  Widget build(BuildContext context) {
    double availableCredit = (accountStatus["creditLimit"] as double) - (accountStatus["creditUsed"] as double);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Account"),
        actions: [
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {
              _editAccount();
            },
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Account Status
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.business,
                          color: successColor,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              businessName,
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${accountStatus["accountType"]} • ${accountStatus["status"]}",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Member since ${accountStatus["memberSince"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${accountStatus["status"]}".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildStatusCard("Credit Limit", "\$${(accountStatus["creditLimit"] as double).currency}", primaryColor, Icons.credit_score),
                      _buildStatusCard("Credit Used", "\$${(accountStatus["creditUsed"] as double).currency}", warningColor, Icons.account_balance),
                      _buildStatusCard("Available Credit", "\$${availableCredit.currency}", successColor, Icons.account_balance_wallet),
                      _buildStatusCard("Payment Status", "${accountStatus["paymentStatus"]}", infoColor, Icons.payment),
                    ],
                  ),
                ],
              ),
            ),

            // Business Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Business Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Business Name",
                          value: businessName,
                          onChanged: (value) {
                            businessName = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QTextField(
                          label: "Business Type",
                          value: businessType,
                          onChanged: (value) {
                            businessType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Tax ID",
                          value: taxId,
                          onChanged: (value) {
                            taxId = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QTextField(
                          label: "Business Phone",
                          value: businessPhone,
                          onChanged: (value) {
                            businessPhone = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Business Email",
                    value: businessEmail,
                    onChanged: (value) {
                      businessEmail = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Address",
                    value: businessAddress,
                    onChanged: (value) {
                      businessAddress = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: QTextField(
                          label: "City",
                          value: businessCity,
                          onChanged: (value) {
                            businessCity = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QTextField(
                          label: "State",
                          value: businessState,
                          onChanged: (value) {
                            businessState = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QTextField(
                          label: "ZIP",
                          value: businessZip,
                          onChanged: (value) {
                            businessZip = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Contact Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Primary Contact",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Contact Person",
                          value: contactPerson,
                          onChanged: (value) {
                            contactPerson = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QTextField(
                          label: "Title/Role",
                          value: contactTitle,
                          onChanged: (value) {
                            contactTitle = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Contact Phone",
                          value: contactPhone,
                          onChanged: (value) {
                            contactPhone = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QTextField(
                          label: "Contact Email",
                          value: contactEmail,
                          onChanged: (value) {
                            contactEmail = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Payment Methods
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
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
                      QButton(
                        label: "Add Payment",
                        size: bs.sm,
                        icon: Icons.add,
                        onPressed: () {
                          _addPaymentMethod();
                        },
                      ),
                    ],
                  ),
                  ...paymentMethods.map((method) => _buildPaymentMethod(method)).toList(),
                ],
              ),
            ),

            // Account Preferences
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Account Preferences",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Currency",
                          items: currencies.map((currency) => {"label": currency, "value": currency}).toList(),
                          value: preferredCurrency,
                          onChanged: (value, label) {
                            preferredCurrency = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QDropdownField(
                          label: "Language",
                          items: languages.map((language) => {"label": language, "value": language}).toList(),
                          value: preferredLanguage,
                          onChanged: (value, label) {
                            preferredLanguage = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Time Zone",
                          items: timeZones.map((tz) => {"label": tz, "value": tz}).toList(),
                          value: timeZone,
                          onChanged: (value, label) {
                            timeZone = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QDropdownField(
                          label: "Payment Terms",
                          items: paymentTermsList.map((terms) => {"label": terms, "value": terms}).toList(),
                          value: paymentTerms,
                          onChanged: (value, label) {
                            paymentTerms = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Notification Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Notification Preferences",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {"label": "Email Notifications", "value": "email", "checked": emailNotifications},
                      {"label": "SMS Notifications", "value": "sms", "checked": smsNotifications},
                    ],
                    value: [
                      if (emailNotifications) {"label": "Email Notifications", "value": "email", "checked": true},
                      if (smsNotifications) {"label": "SMS Notifications", "value": "sms", "checked": true},
                    ],
                    onChanged: (values, ids) {
                      emailNotifications = values.any((v) => v["value"] == "email");
                      smsNotifications = values.any((v) => v["value"] == "sms");
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {"label": "Promotional Emails", "value": "promo", "checked": promotionalEmails},
                      {"label": "Order Updates", "value": "orders", "checked": orderUpdates},
                    ],
                    value: [
                      if (promotionalEmails) {"label": "Promotional Emails", "value": "promo", "checked": true},
                      if (orderUpdates) {"label": "Order Updates", "value": "orders", "checked": true},
                    ],
                    onChanged: (values, ids) {
                      promotionalEmails = values.any((v) => v["value"] == "promo");
                      orderUpdates = values.any((v) => v["value"] == "orders");
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {"label": "Invoice Reminders", "value": "invoices", "checked": invoiceReminders},
                      {"label": "Payment Confirmations", "value": "payments", "checked": paymentConfirmations},
                    ],
                    value: [
                      if (invoiceReminders) {"label": "Invoice Reminders", "value": "invoices", "checked": true},
                      if (paymentConfirmations) {"label": "Payment Confirmations", "value": "payments", "checked": true},
                    ],
                    onChanged: (values, ids) {
                      invoiceReminders = values.any((v) => v["value"] == "invoices");
                      paymentConfirmations = values.any((v) => v["value"] == "payments");
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Recent Activity
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Recent Activity",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...recentActivity.map((activity) => _buildActivityItem(activity)).toList(),
                ],
              ),
            ),

            // Action Buttons
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Save Changes",
                          size: bs.md,
                          icon: Icons.save,
                          onPressed: () {
                            _saveChanges();
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Download Statement",
                          size: bs.md,
                          icon: Icons.download,
                          color: infoColor,
                          onPressed: () {
                            _downloadStatement();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          size: bs.md,
                          icon: Icons.support_agent,
                          color: successColor,
                          onPressed: () {
                            _contactSupport();
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Account Settings",
                          size: bs.md,
                          icon: Icons.settings,
                          color: warningColor,
                          onPressed: () {
                            _accountSettings();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(Map<String, dynamic> method) {
    Color statusColor = method["isActive"] ? successColor : disabledColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(60)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              method["type"] == "Credit Card" ? Icons.credit_card :
              method["type"] == "Bank Account" ? Icons.account_balance :
              Icons.credit_score,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${method["type"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (method["isPrimary"]) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "PRIMARY",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  "${method["details"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (method["expiryDate"] != null)
                  Text(
                    "Expires: ${method["expiryDate"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                    ),
                  ),
              ],
            ),
          ),
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {
              _editPaymentMethod(method);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    Color statusColor = activity["status"] == "Completed" ? successColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              activity["icon"],
              color: statusColor,
              size: 16,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["activity"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["details"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${activity["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${activity["status"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _editAccount() {
    ss("Opening account editor...");
  }

  void _addPaymentMethod() {
    ss("Adding new payment method...");
  }

  void _editPaymentMethod(Map<String, dynamic> method) {
    ss("Editing ${method["type"]}...");
  }

  void _saveChanges() async {
    bool confirmed = await confirm("Save all account changes?");
    if (confirmed) {
      ss("Account information saved successfully");
    }
  }

  void _downloadStatement() {
    ss("Downloading account statement...");
  }

  void _contactSupport() {
    ss("Contacting business account support...");
  }

  void _accountSettings() {
    ss("Opening advanced account settings...");
  }
}
