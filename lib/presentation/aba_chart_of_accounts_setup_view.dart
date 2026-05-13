import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaChartOfAccountsSetupView extends StatefulWidget {
  const AbaChartOfAccountsSetupView({super.key});

  @override
  State<AbaChartOfAccountsSetupView> createState() => _AbaChartOfAccountsSetupViewState();
}

class _AbaChartOfAccountsSetupViewState extends State<AbaChartOfAccountsSetupView> {
  String selectedBusinessType = "retail";
  List<Map<String, dynamic>> selectedAccounts = [];
  
  List<Map<String, dynamic>> businessTypes = [
    {"label": "Retail Business", "value": "retail"},
    {"label": "Service Business", "value": "service"},
    {"label": "Manufacturing", "value": "manufacturing"},
    {"label": "Restaurant", "value": "restaurant"},
    {"label": "Consulting", "value": "consulting"},
    {"label": "E-commerce", "value": "ecommerce"},
  ];

  Map<String, List<Map<String, dynamic>>> chartTemplates = {
    "retail": [
      {"name": "Cash", "type": "Asset", "code": "1000", "selected": true},
      {"name": "Accounts Receivable", "type": "Asset", "code": "1200", "selected": true},
      {"name": "Inventory", "type": "Asset", "code": "1300", "selected": true},
      {"name": "Equipment", "type": "Asset", "code": "1500", "selected": true},
      {"name": "Accounts Payable", "type": "Liability", "code": "2000", "selected": true},
      {"name": "Sales Tax Payable", "type": "Liability", "code": "2200", "selected": true},
      {"name": "Owner's Equity", "type": "Equity", "code": "3000", "selected": true},
      {"name": "Sales Revenue", "type": "Revenue", "code": "4000", "selected": true},
      {"name": "Cost of Goods Sold", "type": "Expense", "code": "5000", "selected": true},
      {"name": "Rent Expense", "type": "Expense", "code": "6000", "selected": true},
      {"name": "Utilities Expense", "type": "Expense", "code": "6100", "selected": false},
      {"name": "Marketing Expense", "type": "Expense", "code": "6200", "selected": false},
    ],
    "service": [
      {"name": "Cash", "type": "Asset", "code": "1000", "selected": true},
      {"name": "Accounts Receivable", "type": "Asset", "code": "1200", "selected": true},
      {"name": "Office Equipment", "type": "Asset", "code": "1500", "selected": true},
      {"name": "Accounts Payable", "type": "Liability", "code": "2000", "selected": true},
      {"name": "Owner's Equity", "type": "Equity", "code": "3000", "selected": true},
      {"name": "Service Revenue", "type": "Revenue", "code": "4000", "selected": true},
      {"name": "Professional Fees", "type": "Expense", "code": "5000", "selected": true},
      {"name": "Office Rent", "type": "Expense", "code": "6000", "selected": true},
      {"name": "Phone & Internet", "type": "Expense", "code": "6100", "selected": false},
      {"name": "Professional Development", "type": "Expense", "code": "6200", "selected": false},
    ],
  };

  @override
  void initState() {
    super.initState();
    updateSelectedAccounts();
  }

  void updateSelectedAccounts() {
    selectedAccounts = chartTemplates[selectedBusinessType] ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chart of Accounts Setup"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(100)),
              ),
              child: Column(
                children: [
                  Icon(Icons.account_tree, color: successColor, size: 40),
                  SizedBox(height: spSm),
                  Text(
                    "Set Up Your Chart of Accounts",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Choose a template based on your business type, then customize as needed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Business Type Selection
            Text(
              "Select Your Business Type",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            QCategoryPicker(
              items: businessTypes,
              value: selectedBusinessType,
              onChanged: (index, label, value, item) {
                selectedBusinessType = value;
                updateSelectedAccounts();
              },
            ),
            
            SizedBox(height: spLg),
            
            // Account Template Preview
            Text(
              "Recommended Accounts",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Select the accounts you want to include in your chart of accounts",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Accounts by Type
            ...["Asset", "Liability", "Equity", "Revenue", "Expense"].map((accountType) {
              List<Map<String, dynamic>> accountsOfType = selectedAccounts
                  .where((account) => account["type"] == accountType)
                  .toList();
              
              if (accountsOfType.isEmpty) return SizedBox.shrink();
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spMd),
                    decoration: BoxDecoration(
                      color: _getAccountTypeColor(accountType).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$accountType Accounts",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _getAccountTypeColor(accountType),
                      ),
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  ...accountsOfType.map((account) => _buildAccountItem(account)),
                  
                  SizedBox(height: spMd),
                ],
              );
            }).toList(),
            
            // Custom Account Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_circle, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Add Custom Account",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Need additional accounts? You can add custom accounts after setup or modify existing ones.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Add Custom Account",
                      size: bs.sm,
                      onPressed: () {
                        _showAddAccountDialog();
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.summarize, color: infoColor, size: 24),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Setup Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryItem("Total Accounts", "${selectedAccounts.where((a) => a["selected"]).length}"),
                      _buildSummaryItem("Assets", "${selectedAccounts.where((a) => a["type"] == "Asset" && a["selected"]).length}"),
                      _buildSummaryItem("Revenue", "${selectedAccounts.where((a) => a["type"] == "Revenue" && a["selected"]).length}"),
                      _buildSummaryItem("Expenses", "${selectedAccounts.where((a) => a["type"] == "Expense" && a["selected"]).length}"),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Complete Setup Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Complete Setup & Start Using ABA",
                size: bs.md,
                onPressed: () {
                  ss("Chart of accounts created successfully!");
                  //navigateTo('AbaHomeView')
                },
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Use Default Template
            Center(
              child: GestureDetector(
                onTap: () {
                  //navigateTo('AbaHomeView')
                },
                child: Text(
                  "Use default template",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountItem(Map<String, dynamic> account) {
    bool isSelected = account["selected"] ?? false;
    
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? primaryColor : disabledOutlineBorderColor,
        ),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: CheckboxListTile(
        title: Text(
          "${account["name"]}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        subtitle: Text(
          "Code: ${account["code"]}",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        value: isSelected,
        onChanged: (value) {
          setState(() {
            account["selected"] = value ?? false;
          });
        },
        controlAffinity: ListTileControlAffinity.trailing,
        activeColor: primaryColor,
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getAccountTypeColor(String type) {
    switch (type) {
      case "Asset":
        return successColor;
      case "Liability":
        return dangerColor;
      case "Equity":
        return infoColor;
      case "Revenue":
        return primaryColor;
      case "Expense":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showAddAccountDialog() {
    String accountName = "";
    String accountCode = "";
    String accountType = "Asset";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Custom Account"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Account Name"),
              onChanged: (value) => accountName = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Account Code"),
              onChanged: (value) => accountCode = value,
            ),
            SizedBox(height: spSm),
            DropdownButtonFormField<String>(
              value: accountType,
              decoration: InputDecoration(labelText: "Account Type"),
              items: ["Asset", "Liability", "Equity", "Revenue", "Expense"]
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) => accountType = value ?? "Asset",
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (accountName.isNotEmpty && accountCode.isNotEmpty) {
                setState(() {
                  selectedAccounts.add({
                    "name": accountName,
                    "code": accountCode,
                    "type": accountType,
                    "selected": true,
                  });
                });
                Navigator.pop(context);
                ss("Custom account added successfully!");
              }
            },
            child: Text("Add Account"),
          ),
        ],
      ),
    );
  }
}
