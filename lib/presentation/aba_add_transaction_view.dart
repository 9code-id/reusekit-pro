import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaAddTransactionView extends StatefulWidget {
  const AbaAddTransactionView({super.key});

  @override
  State<AbaAddTransactionView> createState() => _AbaAddTransactionViewState();
}

class _AbaAddTransactionViewState extends State<AbaAddTransactionView> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  // Form Fields
  String transactionType = "Expense";
  String accountId = "";
  String categoryId = "";
  String description = "";
  String amount = "";
  DateTime transactionDate = DateTime.now();
  String reference = "";
  String notes = "";
  String paymentMethod = "Cash";
  List<String> attachments = [];
  bool isRecurring = false;
  String recurringFrequency = "Monthly";

  List<Map<String, dynamic>> transactionTypes = [
    {"label": "Income", "value": "Income"},
    {"label": "Expense", "value": "Expense"},
    {"label": "Transfer", "value": "Transfer"},
    {"label": "Deposit", "value": "Deposit"},
    {"label": "Withdrawal", "value": "Withdrawal"},
  ];

  List<Map<String, dynamic>> accounts = [
    {"label": "Cash on Hand", "value": "1001"},
    {"label": "Bank Account - Checking", "value": "1002"},
    {"label": "Bank Account - Savings", "value": "1003"},
    {"label": "Credit Card", "value": "2100"},
    {"label": "Petty Cash", "value": "1010"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "Office Supplies", "value": "office_supplies"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Travel", "value": "travel"},
    {"label": "Utilities", "value": "utilities"},
    {"label": "Rent", "value": "rent"},
    {"label": "Insurance", "value": "insurance"},
    {"label": "Professional Services", "value": "professional_services"},
    {"label": "Equipment", "value": "equipment"},
    {"label": "Software", "value": "software"},
    {"label": "Sales Revenue", "value": "sales_revenue"},
    {"label": "Service Revenue", "value": "service_revenue"},
    {"label": "Interest Income", "value": "interest_income"},
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {"label": "Cash", "value": "Cash"},
    {"label": "Check", "value": "Check"},
    {"label": "Credit Card", "value": "Credit Card"},
    {"label": "Bank Transfer", "value": "Bank Transfer"},
    {"label": "Online Payment", "value": "Online Payment"},
    {"label": "Mobile Payment", "value": "Mobile Payment"},
  ];

  List<Map<String, dynamic>> recurringFrequencies = [
    {"label": "Daily", "value": "Daily"},
    {"label": "Weekly", "value": "Weekly"},
    {"label": "Monthly", "value": "Monthly"},
    {"label": "Quarterly", "value": "Quarterly"},
    {"label": "Yearly", "value": "Yearly"},
  ];

  Color _getTransactionTypeColor(String type) {
    switch (type) {
      case "Income":
      case "Deposit":
        return successColor;
      case "Expense":
      case "Withdrawal":
        return dangerColor;
      case "Transfer":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData _getTransactionTypeIcon(String type) {
    switch (type) {
      case "Income":
        return Icons.arrow_upward;
      case "Expense":
        return Icons.arrow_downward;
      case "Transfer":
        return Icons.swap_horiz;
      case "Deposit":
        return Icons.add_circle;
      case "Withdrawal":
        return Icons.remove_circle;
      default:
        return Icons.receipt;
    }
  }

  Future<void> _saveTransaction() async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    setState(() {});

    try {
      // Simulated API call
      await Future.delayed(Duration(seconds: 2));

      ss("Transaction saved successfully");
      back();
    } catch (e) {
      se("Failed to save transaction: ${e.toString()}");
    } finally {
      loading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Transaction"),
        actions: [
          IconButton(
            onPressed: () {
              //navigateTo('TransactionTemplatesView')
            },
            icon: Icon(Icons.bookmark),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Transaction Type Section
                    Container(
                      padding: EdgeInsets.all(spSm),
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
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: _getTransactionTypeColor(transactionType).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getTransactionTypeIcon(transactionType),
                                  color: _getTransactionTypeColor(transactionType),
                                  size: 18,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Transaction Details",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          QDropdownField(
                            label: "Transaction Type",
                            items: transactionTypes,
                            value: transactionType,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              transactionType = value;
                              setState(() {});
                            },
                          ),
                          QDropdownField(
                            label: "Account",
                            items: accounts,
                            value: accountId,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              accountId = value;
                              setState(() {});
                            },
                          ),
                          QDropdownField(
                            label: "Category",
                            items: categories,
                            value: categoryId,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              categoryId = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Amount and Description Section
                    Container(
                      padding: EdgeInsets.all(spSm),
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
                              Icon(
                                Icons.attach_money,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Amount & Description",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          QNumberField(
                            label: "Amount (\$)",
                            value: amount,
                            validator: Validator.required,
                            onChanged: (value) {
                              amount = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Description",
                            value: description,
                            hint: "What is this transaction for?",
                            validator: Validator.required,
                            onChanged: (value) {
                              description = value;
                              setState(() {});
                            },
                          ),
                          QTextField(
                            label: "Reference Number",
                            value: reference,
                            hint: "Invoice number, check number, etc.",
                            onChanged: (value) {
                              reference = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Date and Payment Section
                    Container(
                      padding: EdgeInsets.all(spSm),
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
                              Icon(
                                Icons.calendar_today,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Date & Payment Method",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          QDatePicker(
                            label: "Transaction Date",
                            value: transactionDate,
                            onChanged: (value) {
                              transactionDate = value;
                              setState(() {});
                            },
                          ),
                          QDropdownField(
                            label: "Payment Method",
                            items: paymentMethods,
                            value: paymentMethod,
                            onChanged: (value, label) {
                              paymentMethod = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Recurring Transaction Section
                    Container(
                      padding: EdgeInsets.all(spSm),
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
                              Icon(
                                Icons.repeat,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Recurring Transaction",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          QSwitch(
                            items: [
                              {
                                "label": "Make this a recurring transaction",
                                "value": true,
                                "checked": isRecurring,
                              }
                            ],
                            value: [
                              if (isRecurring)
                                {
                                  "label": "Make this a recurring transaction",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              isRecurring = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                          if (isRecurring) ...[
                            QDropdownField(
                              label: "Frequency",
                              items: recurringFrequencies,
                              value: recurringFrequency,
                              onChanged: (value, label) {
                                recurringFrequency = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Notes and Attachments Section
                    Container(
                      padding: EdgeInsets.all(spSm),
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
                              Icon(
                                Icons.note,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Additional Information",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          QMemoField(
                            label: "Notes",
                            value: notes,
                            hint: "Additional details about this transaction",
                            onChanged: (value) {
                              notes = value;
                              setState(() {});
                            },
                          ),
                          QAttachmentPicker(
                            label: "Attachments",
                            value: attachments,
                            hint: "Add receipts, invoices, or other documents",
                            helper: "Supports images and PDF files",
                            maxAttachments: 5,
                            allowedTypes: ['image', 'document'],
                            onChanged: (value) {
                              attachments = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Summary Section
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getTransactionTypeColor(transactionType).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: _getTransactionTypeColor(transactionType).withAlpha(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.summarize,
                                color: _getTransactionTypeColor(transactionType),
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Transaction Summary",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: _getTransactionTypeColor(transactionType),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Type: $transactionType",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    if (amount.isNotEmpty) ...[
                                      SizedBox(height: spXs),
                                      Text(
                                        "Amount: \$${(double.tryParse(amount) ?? 0.0).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                    if (description.isNotEmpty) ...[
                                      SizedBox(height: spXs),
                                      Text(
                                        "Description: $description",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: _getTransactionTypeColor(transactionType).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getTransactionTypeIcon(transactionType),
                                  color: _getTransactionTypeColor(transactionType),
                                  size: 24,
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
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Save Transaction",
                            onPressed: _saveTransaction,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Save as Template",
                            onPressed: () {
                              //navigateTo('SaveTransactionTemplateView')
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
