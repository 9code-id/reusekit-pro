import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaAddExpenseView extends StatefulWidget {
  const AbaAddExpenseView({super.key});

  @override
  State<AbaAddExpenseView> createState() => _AbaAddExpenseViewState();
}

class _AbaAddExpenseViewState extends State<AbaAddExpenseView> {
  final formKey = GlobalKey<FormState>();
  
  String title = "";
  String description = "";
  String amount = "";
  String selectedCategory = "";
  String vendor = "";
  String paymentMethod = "";
  String clientReference = "";
  String fundingSource = "";
  String notes = "";
  String receiptImage = "";
  List<String> attachments = [];
  DateTime selectedDate = DateTime.now();
  bool billable = true;
  bool recurring = false;
  String recurringFrequency = "";
  
  List<Map<String, dynamic>> categories = [
    {"label": "Office Supplies", "value": "office_supplies", "color": primaryColor},
    {"label": "Equipment", "value": "equipment", "color": successColor},
    {"label": "Transportation", "value": "transportation", "color": infoColor},
    {"label": "Training", "value": "training", "color": warningColor},
    {"label": "Software", "value": "software", "color": secondaryColor},
    {"label": "Marketing", "value": "marketing", "color": dangerColor},
    {"label": "Utilities", "value": "utilities", "color": primaryColor},
    {"label": "Other", "value": "other", "color": disabledBoldColor},
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "Debit Card", "value": "debit_card"},
    {"label": "Cash", "value": "cash"},
    {"label": "Bank Transfer", "value": "bank_transfer"},
    {"label": "Check", "value": "check"},
    {"label": "Digital Wallet", "value": "digital_wallet"},
  ];

  List<Map<String, dynamic>> fundingSources = [
    {"label": "Insurance - Blue Cross", "value": "insurance_bc"},
    {"label": "Insurance - Aetna", "value": "insurance_aetna"},
    {"label": "Private Pay", "value": "private_pay"},
    {"label": "Medicaid", "value": "medicaid"},
    {"label": "Grant Funding", "value": "grant"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> recurringOptions = [
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense"),
        actions: [
          TextButton(
            onPressed: () => _saveAsDraft(),
            child: Text(
              "Save Draft",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              _buildBasicInfo(),
              _buildAmountSection(),
              _buildCategorySection(),
              _buildVendorInfo(),
              _buildReceiptSection(),
              _buildBillingInfo(),
              _buildRecurringSection(),
              _buildNotesSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildActionButtons(),
    );
  }

  Widget _buildBasicInfo() {
    return Container(
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
            "Basic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Expense Title",
            value: title,
            hint: "Enter a descriptive title",
            validator: Validator.required,
            onChanged: (value) {
              title = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: description,
            hint: "Describe the purpose of this expense",
            validator: Validator.required,
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          QDatePicker(
            label: "Expense Date",
            value: selectedDate,
            onChanged: (value) {
              selectedDate = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection() {
    return Container(
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
            "Amount Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Amount (\$)",
            value: amount,
            hint: "0.00",
            validator: Validator.required,
            onChanged: (value) {
              amount = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Enter the total amount including tax if applicable. You can add tax details separately in the notes.",
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
    );
  }

  Widget _buildCategorySection() {
    return Container(
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
            "Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Select Category",
            items: categories,
            value: selectedCategory,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
          if (selectedCategory.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: _getCategoryColor().withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: _getCategoryColor(),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    _getCategoryLabel(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _getCategoryColor(),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVendorInfo() {
    return Container(
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
            "Vendor Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Vendor/Store Name",
            value: vendor,
            hint: "Enter vendor name",
            onChanged: (value) {
              vendor = value;
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
    );
  }

  Widget _buildReceiptSection() {
    return Container(
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
            "Receipt & Attachments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QImagePicker(
            label: "Receipt Image",
            value: receiptImage,
            hint: "Take or upload receipt photo",
            onChanged: (value) {
              receiptImage = value;
              setState(() {});
            },
          ),
          QAttachmentPicker(
            label: "Additional Attachments",
            value: attachments,
            hint: "Add any supporting documents",
            maxAttachments: 5,
            onChanged: (value) {
              attachments = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBillingInfo() {
    return Container(
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
            "Billing Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "This expense is billable to clients",
                "value": true,
                "checked": billable,
              }
            ],
            value: [if (billable) {"label": "This expense is billable to clients", "value": true, "checked": true}],
            onChanged: (values, ids) {
              billable = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (billable)
            Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Client Reference",
                  value: clientReference,
                  hint: "Enter client name or reference",
                  onChanged: (value) {
                    clientReference = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Funding Source",
                  items: fundingSources,
                  value: fundingSource,
                  onChanged: (value, label) {
                    fundingSource = value;
                    setState(() {});
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildRecurringSection() {
    return Container(
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
            "Recurring Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "This is a recurring expense",
                "value": true,
                "checked": recurring,
              }
            ],
            value: [if (recurring) {"label": "This is a recurring expense", "value": true, "checked": true}],
            onChanged: (values, ids) {
              recurring = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (recurring)
            QDropdownField(
              label: "Frequency",
              items: recurringOptions,
              value: recurringFrequency,
              onChanged: (value, label) {
                recurringFrequency = value;
                setState(() {});
              },
            ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Container(
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
            "Additional Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Notes",
            value: notes,
            hint: "Add any additional information, tax details, or special notes",
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: QButton(
              label: "Save Draft",
              color: secondaryColor,
              onPressed: () => _saveAsDraft(),
            ),
          ),
          Expanded(
            flex: 2,
            child: QButton(
              label: "Submit Expense",
              onPressed: () => _submitExpense(),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor() {
    if (selectedCategory.isEmpty) return primaryColor;
    return categories.firstWhere((cat) => cat["value"] == selectedCategory)["color"];
  }

  String _getCategoryLabel() {
    if (selectedCategory.isEmpty) return "";
    return categories.firstWhere((cat) => cat["value"] == selectedCategory)["label"];
  }

  void _saveAsDraft() async {
    if (title.isEmpty) {
      se("Please enter at least a title to save as draft");
      return;
    }

    ss("Expense saved as draft");
    back();
  }

  void _submitExpense() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (amount.isEmpty || double.tryParse(amount) == null) {
      se("Please enter a valid amount");
      return;
    }

    if (selectedCategory.isEmpty) {
      se("Please select a category");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    ss("Expense submitted successfully");
    back();
  }


  Widget _buildPreviewRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
      ],
    );
  }
}
