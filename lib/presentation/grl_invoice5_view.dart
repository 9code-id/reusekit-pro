import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlInvoice5View extends StatefulWidget {
  @override
  State<GrlInvoice5View> createState() => _GrlInvoice5ViewState();
}

class _GrlInvoice5ViewState extends State<GrlInvoice5View> {
  final formKey = GlobalKey<FormState>();
  
  String companyName = "DesignCorp Solutions";
  String companyAddress = "123 Business Street, Suite 456";
  String companyCity = "New York, NY 10001";
  String companyPhone = "+1 (555) 123-4567";
  String companyEmail = "billing@designcorp.com";
  String companyWebsite = "www.designcorp.com";
  String companyTaxId = "123-45-6789";
  
  String bankName = "First National Bank";
  String accountNumber = "****1234";
  String routingNumber = "021000021";
  String accountType = "Business Checking";
  
  String paymentTerms = "Payment is due within 30 days of invoice date";
  String latePaymentFee = "1.5% per month";
  String currency = "USD";
  String taxRate = "10.0";
  String invoicePrefix = "INV";
  
  bool showCompanyLogo = true;
  bool autoReminder = true;
  bool requireSignature = false;
  bool enableOnlinePayment = true;

  List<Map<String, dynamic>> paymentMethods = [
    {"name": "Bank Transfer", "enabled": true, "icon": Icons.account_balance},
    {"name": "Credit Card", "enabled": true, "icon": Icons.credit_card},
    {"name": "PayPal", "enabled": false, "icon": Icons.payment},
    {"name": "Check", "enabled": true, "icon": Icons.check},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveSettings,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spLg,
            children: [
              _buildCompanyInfoSection(),
              _buildPaymentInfoSection(),
              _buildInvoiceSettingsSection(),
              _buildPaymentMethodsSection(),
              _buildNotificationSettings(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyInfoSection() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.business,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Company Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Company Name",
            value: companyName,
            validator: Validator.required,
            onChanged: (value) {
              companyName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Address",
            value: companyAddress,
            validator: Validator.required,
            onChanged: (value) {
              companyAddress = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "City, State, ZIP",
            value: companyCity,
            validator: Validator.required,
            onChanged: (value) {
              companyCity = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Phone",
                  value: companyPhone,
                  onChanged: (value) {
                    companyPhone = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Tax ID",
                  value: companyTaxId,
                  onChanged: (value) {
                    companyTaxId = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Email",
            value: companyEmail,
            validator: Validator.email,
            onChanged: (value) {
              companyEmail = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Website",
            value: companyWebsite,
            onChanged: (value) {
              companyWebsite = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfoSection() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.account_balance,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Banking Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Bank Name",
            value: bankName,
            validator: Validator.required,
            onChanged: (value) {
              bankName = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Account Number",
                  value: accountNumber,
                  onChanged: (value) {
                    accountNumber = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Routing Number",
                  value: routingNumber,
                  onChanged: (value) {
                    routingNumber = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Account Type",
            value: accountType,
            onChanged: (value) {
              accountType = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceSettingsSection() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.settings,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Invoice Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Invoice Prefix",
                  value: invoicePrefix,
                  onChanged: (value) {
                    invoicePrefix = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Currency",
                  value: currency,
                  onChanged: (value) {
                    currency = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Default Tax Rate (%)",
            value: taxRate,
            onChanged: (value) {
              taxRate = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Payment Terms",
            value: paymentTerms,
            onChanged: (value) {
              paymentTerms = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Late Payment Fee",
            value: latePaymentFee,
            onChanged: (value) {
              latePaymentFee = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsSection() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.payment,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Payment Methods",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Select which payment methods to display on invoices",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          ...paymentMethods.map((method) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    method["icon"],
                    color: method["enabled"] ? primaryColor : disabledColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${method["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: method["enabled"] ? Colors.black : disabledBoldColor,
                      ),
                    ),
                  ),
                  Switch(
                    value: method["enabled"],
                    onChanged: (value) {
                      method["enabled"] = value;
                      setState(() {});
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.notifications,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Notification Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildSettingToggle(
            "Show Company Logo",
            "Display company logo on invoices",
            showCompanyLogo,
            (value) {
              showCompanyLogo = value;
              setState(() {});
            },
          ),
          _buildSettingToggle(
            "Auto Reminder",
            "Send automatic payment reminders",
            autoReminder,
            (value) {
              autoReminder = value;
              setState(() {});
            },
          ),
          _buildSettingToggle(
            "Require Signature",
            "Require client signature for acceptance",
            requireSignature,
            (value) {
              requireSignature = value;
              setState(() {});
            },
          ),
          _buildSettingToggle(
            "Enable Online Payment",
            "Allow clients to pay online directly",
            enableOnlinePayment,
            (value) {
              enableOnlinePayment = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingToggle(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QButton(
                label: "Save Settings",
                size: bs.md,
                onPressed: _saveSettings,
              ),
            ),
            Expanded(
              child: QButton(
                label: "Reset to Default",
                size: bs.md,
                onPressed: _resetSettings,
              ),
            ),
          ],
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QButton(
                label: "Export Settings",
                size: bs.md,
                icon: Icons.download,
                onPressed: _exportSettings,
              ),
            ),
            Expanded(
              child: QButton(
                label: "Import Settings",
                size: bs.md,
                icon: Icons.upload,
                onPressed: _importSettings,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _saveSettings() {
    if (formKey.currentState!.validate()) {
      ss("Settings saved successfully");
    }
  }

  void _resetSettings() async {
    bool isConfirmed = await confirm("Are you sure you want to reset all settings to default?");
    if (isConfirmed) {
      // Reset to default values
      companyName = "Your Company Name";
      companyAddress = "";
      companyCity = "";
      companyPhone = "";
      companyEmail = "";
      companyWebsite = "";
      companyTaxId = "";
      
      bankName = "";
      accountNumber = "";
      routingNumber = "";
      accountType = "";
      
      paymentTerms = "Payment is due within 30 days of invoice date";
      latePaymentFee = "1.5% per month";
      currency = "USD";
      taxRate = "10.0";
      invoicePrefix = "INV";
      
      showCompanyLogo = true;
      autoReminder = true;
      requireSignature = false;
      enableOnlinePayment = true;
      
      // Reset payment methods
      for (var method in paymentMethods) {
        method["enabled"] = method["name"] == "Bank Transfer" || method["name"] == "Credit Card";
      }
      
      setState(() {});
      ss("Settings reset to default");
    }
  }

  void _exportSettings() {
    ss("Settings exported successfully");
  }

  void _importSettings() {
    ss("Settings imported successfully");
  }
}
