import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaAddAccountView extends StatefulWidget {
  const AbaAddAccountView({super.key});

  @override
  State<AbaAddAccountView> createState() => _AbaAddAccountViewState();
}

class _AbaAddAccountViewState extends State<AbaAddAccountView> {
  final formKey = GlobalKey<FormState>();
  
  // Form fields
  String accountName = "";
  String accountNumber = "";
  String accountType = "";
  String bankName = "";
  String branchCode = "";
  String routingNumber = "";
  double initialBalance = 0.0;
  String currency = "";
  String description = "";
  bool isActive = true;
  bool allowOverdraft = false;
  double overdraftLimit = 0.0;
  String accountPurpose = "";
  String managerName = "";
  String managerContact = "";

  List<Map<String, dynamic>> accountTypes = [
    {"label": "Checking Account", "value": "checking"},
    {"label": "Savings Account", "value": "savings"},
    {"label": "Business Account", "value": "business"},
    {"label": "Money Market", "value": "money_market"},
    {"label": "Certificate of Deposit", "value": "cd"},
    {"label": "Credit Line", "value": "credit_line"},
  ];

  List<Map<String, dynamic>> currencies = [
    {"label": "USD - US Dollar", "value": "USD"},
    {"label": "EUR - Euro", "value": "EUR"},
    {"label": "GBP - British Pound", "value": "GBP"},
    {"label": "JPY - Japanese Yen", "value": "JPY"},
    {"label": "CAD - Canadian Dollar", "value": "CAD"},
    {"label": "AUD - Australian Dollar", "value": "AUD"},
  ];

  List<Map<String, dynamic>> purposes = [
    {"label": "Operating Account", "value": "operating"},
    {"label": "Payroll Account", "value": "payroll"},
    {"label": "Tax Account", "value": "tax"},
    {"label": "Investment Account", "value": "investment"},
    {"label": "Emergency Fund", "value": "emergency"},
    {"label": "Petty Cash", "value": "petty_cash"},
  ];

  void _saveAccount() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      
      ss("Account created successfully!");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Account"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveAccount,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(height: spXs),
                    Text(
                      "Create a new bank account for your organization",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Basic Account Details
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Basic Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Account Name",
                      value: accountName,
                      hint: "Enter account display name",
                      validator: Validator.required,
                      onChanged: (value) {
                        accountName = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Account Number",
                      value: accountNumber,
                      hint: "Enter bank account number",
                      validator: Validator.required,
                      onChanged: (value) {
                        accountNumber = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Account Type",
                      items: accountTypes,
                      value: accountType,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        accountType = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Currency",
                      items: currencies,
                      value: currency,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        currency = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Bank Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bank Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Bank Name",
                      value: bankName,
                      hint: "Enter bank name",
                      validator: Validator.required,
                      onChanged: (value) {
                        bankName = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Branch Code",
                            value: branchCode,
                            hint: "Enter branch code",
                            onChanged: (value) {
                              branchCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Routing Number",
                            value: routingNumber,
                            hint: "Enter routing number",
                            onChanged: (value) {
                              routingNumber = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Account Configuration
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account Configuration",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QNumberField(
                      label: "Initial Balance",
                      value: initialBalance.toString(),
                      validator: Validator.required,
                      onChanged: (value) {
                        initialBalance = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Account Purpose",
                      items: purposes,
                      value: accountPurpose,
                      onChanged: (value, label) {
                        accountPurpose = value;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Account Active",
                          "value": true,
                          "checked": isActive,
                        }
                      ],
                      value: [
                        if (isActive)
                          {
                            "label": "Account Active",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        isActive = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Allow Overdraft",
                          "value": true,
                          "checked": allowOverdraft,
                        }
                      ],
                      value: [
                        if (allowOverdraft)
                          {
                            "label": "Allow Overdraft",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        allowOverdraft = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    if (allowOverdraft)
                      QNumberField(
                        label: "Overdraft Limit",
                        value: overdraftLimit.toString(),
                        onChanged: (value) {
                          overdraftLimit = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),

              // Account Manager
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account Manager",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Manager Name",
                      value: managerName,
                      hint: "Enter account manager name",
                      onChanged: (value) {
                        managerName = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Manager Contact",
                      value: managerContact,
                      hint: "Enter phone or email",
                      onChanged: (value) {
                        managerContact = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Description
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Additional Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Enter account description or notes",
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Container(
                width: double.infinity,
                child: Column(
                  spacing: spSm,
                  children: [
                    QButton(
                      label: "Create Account",
                      size: bs.md,
                      onPressed: _saveAccount,
                    ),
                    QButton(
                      label: "Cancel",
                      color: disabledBoldColor,
                      size: bs.md,
                      onPressed: () {
                        back();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
