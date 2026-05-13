import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmProposalBuilderView extends StatefulWidget {
  const CrmProposalBuilderView({super.key});

  @override
  State<CrmProposalBuilderView> createState() => _CrmProposalBuilderViewState();
}

class _CrmProposalBuilderViewState extends State<CrmProposalBuilderView> {
  int currentStep = 0;
  
  // Basic Information
  String proposalTitle = "";
  String clientName = "";
  String clientEmail = "";
  String proposalType = "Standard";
  String proposalTemplate = "Professional";
  String dueDate = DateTime.now().add(Duration(days: 30)).toString().split(' ')[0];
  
  // Executive Summary
  String executiveSummary = "";
  String problemStatement = "";
  String proposedSolution = "";
  String keyBenefits = "";
  
  // Services/Products
  List<Map<String, dynamic>> proposalItems = [];
  
  // Pricing
  double totalAmount = 0.0;
  double discountPercentage = 0.0;
  double taxPercentage = 8.5;
  String paymentTerms = "Net 30";
  
  // Terms & Conditions
  String termsConditions = "";
  String deliveryTimeline = "";
  String warrantyInfo = "";
  
  // Documents & Media
  List<String> attachedDocuments = [];
  List<String> proposalImages = [];
  
  List<Map<String, dynamic>> proposalTypeOptions = [
    {"label": "Standard", "value": "Standard"},
    {"label": "Technical", "value": "Technical"},
    {"label": "Consulting", "value": "Consulting"},
    {"label": "Service", "value": "Service"},
    {"label": "Product", "value": "Product"},
  ];

  List<Map<String, dynamic>> templateOptions = [
    {"label": "Professional", "value": "Professional"},
    {"label": "Modern", "value": "Modern"},
    {"label": "Creative", "value": "Creative"},
    {"label": "Corporate", "value": "Corporate"},
    {"label": "Minimal", "value": "Minimal"},
  ];

  List<Map<String, dynamic>> paymentTermsOptions = [
    {"label": "Net 15", "value": "Net 15"},
    {"label": "Net 30", "value": "Net 30"},
    {"label": "Net 45", "value": "Net 45"},
    {"label": "Net 60", "value": "Net 60"},
    {"label": "Due on Receipt", "value": "Due on Receipt"},
    {"label": "50% Upfront, 50% on Completion", "value": "50% Upfront, 50% on Completion"},
  ];

  final List<String> steps = [
    "Basic Info",
    "Executive Summary",
    "Services/Products",
    "Pricing",
    "Terms & Timeline",
    "Documents",
    "Review & Send"
  ];

  @override
  void initState() {
    super.initState();
    _addDefaultProposalItem();
  }

  void _addDefaultProposalItem() {
    proposalItems.add({
      "name": "",
      "description": "",
      "quantity": 1,
      "unitPrice": 0.0,
      "total": 0.0,
    });
  }

  void _calculateTotals() {
    double subtotal = proposalItems.fold(0.0, (sum, item) => sum + (item["total"] as double));
    double discount = subtotal * (discountPercentage / 100);
    double afterDiscount = subtotal - discount;
    double tax = afterDiscount * (taxPercentage / 100);
    totalAmount = afterDiscount + tax;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proposal Builder"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveProposal();
            },
          ),
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: () {
              _previewProposal();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Step ${currentStep + 1} of ${steps.length}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${((currentStep + 1) / steps.length * 100).toStringAsFixed(0)}% Complete",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  value: (currentStep + 1) / steps.length,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation(primaryColor),
                ),
                SizedBox(height: spSm),
                Text(
                  steps[currentStep],
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildStepContent(),
            ),
          ),

          // Navigation Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      size: bs.md,
                      onPressed: () {
                        currentStep--;
                        setState(() {});
                      },
                    ),
                  ),
                if (currentStep > 0) SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: currentStep == steps.length - 1 ? "Send Proposal" : "Next",
                    size: bs.md,
                    onPressed: () {
                      if (currentStep == steps.length - 1) {
                        _sendProposal();
                      } else {
                        currentStep++;
                        setState(() {});
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildExecutiveSummaryStep();
      case 2:
        return _buildServicesStep();
      case 3:
        return _buildPricingStep();
      case 4:
        return _buildTermsStep();
      case 5:
        return _buildDocumentsStep();
      case 6:
        return _buildReviewStep();
      default:
        return Container();
    }
  }

  Widget _buildBasicInfoStep() {
    return Container(
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
          Text(
            "Basic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Proposal Title",
            value: proposalTitle,
            hint: "Enter proposal title",
            validator: Validator.required,
            onChanged: (value) {
              proposalTitle = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Client Name",
                  value: clientName,
                  hint: "Enter client name",
                  validator: Validator.required,
                  onChanged: (value) {
                    clientName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Client Email",
                  value: clientEmail,
                  hint: "client@company.com",
                  validator: Validator.email,
                  onChanged: (value) {
                    clientEmail = value;
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
                  label: "Proposal Type",
                  items: proposalTypeOptions,
                  value: proposalType,
                  onChanged: (value, label) {
                    proposalType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Template Style",
                  items: templateOptions,
                  value: proposalTemplate,
                  onChanged: (value, label) {
                    proposalTemplate = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDatePicker(
            label: "Due Date",
            value: DateTime.parse(dueDate),
            onChanged: (value) {
              dueDate = value.toString().split(' ')[0];
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExecutiveSummaryStep() {
    return Container(
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
          Text(
            "Executive Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Executive Summary",
            value: executiveSummary,
            hint: "Provide a high-level overview of the proposal...",
            onChanged: (value) {
              executiveSummary = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Problem Statement",
            value: problemStatement,
            hint: "Describe the client's problem or challenge...",
            onChanged: (value) {
              problemStatement = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Proposed Solution",
            value: proposedSolution,
            hint: "Explain your proposed solution...",
            onChanged: (value) {
              proposedSolution = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Key Benefits",
            value: keyBenefits,
            hint: "List the key benefits and value proposition...",
            onChanged: (value) {
              keyBenefits = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServicesStep() {
    return Container(
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
              Expanded(
                child: Text(
                  "Services/Products",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Add Item",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  proposalItems.add({
                    "name": "",
                    "description": "",
                    "quantity": 1,
                    "unitPrice": 0.0,
                    "total": 0.0,
                  });
                  setState(() {});
                },
              ),
            ],
          ),
          ...proposalItems.asMap().entries.map((entry) => 
            _buildProposalItemCard(entry.key, entry.value)
          ),
        ],
      ),
    );
  }

  Widget _buildProposalItemCard(int index, Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Item ${index + 1}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              if (proposalItems.length > 1)
                QButton(
                  icon: Icons.delete,
                  size: bs.sm,
                  onPressed: () {
                    proposalItems.removeAt(index);
                    _calculateTotals();
                    setState(() {});
                  },
                ),
            ],
          ),
          QTextField(
            label: "Item Name",
            value: item["name"],
            hint: "Enter item name",
            onChanged: (value) {
              item["name"] = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: item["description"],
            hint: "Enter item description",
            onChanged: (value) {
              item["description"] = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Quantity",
                  value: item["quantity"].toString(),
                  onChanged: (value) {
                    item["quantity"] = int.tryParse(value) ?? 1;
                    item["total"] = (item["quantity"] as int) * (item["unitPrice"] as double);
                    _calculateTotals();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Unit Price (\$)",
                  value: item["unitPrice"].toString(),
                  onChanged: (value) {
                    item["unitPrice"] = double.tryParse(value) ?? 0.0;
                    item["total"] = (item["quantity"] as int) * (item["unitPrice"] as double);
                    _calculateTotals();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(item["total"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingStep() {
    double subtotal = proposalItems.fold(0.0, (sum, item) => sum + (item["total"] as double));
    double discount = subtotal * (discountPercentage / 100);
    double afterDiscount = subtotal - discount;
    double tax = afterDiscount * (taxPercentage / 100);
    double total = afterDiscount + tax;

    return Container(
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
          Text(
            "Pricing & Payment",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          // Pricing Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                _buildPricingRow("Subtotal", subtotal),
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Discount (%)",
                        value: discountPercentage.toString(),
                        onChanged: (value) {
                          discountPercentage = double.tryParse(value) ?? 0.0;
                          _calculateTotals();
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Discount Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "-\$${discount.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Tax (%)",
                        value: taxPercentage.toString(),
                        onChanged: (value) {
                          taxPercentage = double.tryParse(value) ?? 0.0;
                          _calculateTotals();
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Tax Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${tax.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                _buildPricingRow("Total Amount", total, isTotal: true),
              ],
            ),
          ),
          
          QDropdownField(
            label: "Payment Terms",
            items: paymentTermsOptions,
            value: paymentTerms,
            onChanged: (value, label) {
              paymentTerms = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPricingRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? primaryColor : disabledBoldColor,
          ),
        ),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.bold,
            color: isTotal ? successColor : primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsStep() {
    return Container(
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
          Text(
            "Terms & Timeline",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Terms & Conditions",
            value: termsConditions,
            hint: "Enter terms and conditions...",
            onChanged: (value) {
              termsConditions = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Delivery Timeline",
            value: deliveryTimeline,
            hint: "Describe the project timeline and milestones...",
            onChanged: (value) {
              deliveryTimeline = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Warranty & Support",
            value: warrantyInfo,
            hint: "Describe warranty and support terms...",
            onChanged: (value) {
              warrantyInfo = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsStep() {
    return Container(
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
          Text(
            "Documents & Media",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMultiImagePicker(
            label: "Proposal Images",
            value: proposalImages,
            hint: "Add images to enhance your proposal",
            maxImages: 10,
            onChanged: (value) {
              proposalImages = value;
              setState(() {});
            },
          ),
          QAttachmentPicker(
            label: "Supporting Documents",
            value: attachedDocuments,
            hint: "Attach relevant documents",
            maxAttachments: 20,
            onChanged: (value) {
              attachedDocuments = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStep() {
    return Container(
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
          Text(
            "Review & Send",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          // Proposal Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Proposal Summary",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text("Title: $proposalTitle"),
                Text("Client: $clientName"),
                Text("Type: $proposalType"),
                Text("Template: $proposalTemplate"),
                Text("Total Items: ${proposalItems.length}"),
                Text("Total Amount: \$${totalAmount.toStringAsFixed(2)}"),
                Text("Due Date: $dueDate"),
              ],
            ),
          ),

          // Action Options
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Ready to Send?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Save Draft",
                        size: bs.sm,
                        onPressed: () {
                          _saveProposal();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Preview",
                        size: bs.sm,
                        onPressed: () {
                          _previewProposal();
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
    );
  }

  void _saveProposal() {
    ss("Proposal saved as draft");
  }

  void _previewProposal() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Proposal Preview"),
          content: Container(
            width: double.maxFinite,
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    proposalTitle,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text("To: $clientName"),
                  Text("From: Your Company"),
                  Text("Date: ${DateTime.now().toString().split(' ')[0]}"),
                  Divider(),
                  if (executiveSummary.isNotEmpty) ...[
                    Text(
                      "Executive Summary",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(executiveSummary),
                    SizedBox(height: spSm),
                  ],
                  Text(
                    "Items",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...proposalItems.map((item) => Text(
                    "${item["name"]} - \$${(item["total"] as double).toStringAsFixed(2)}"
                  )),
                  Divider(),
                  Text(
                    "Total: \$${totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _sendProposal() {
    if (proposalTitle.isEmpty || clientName.isEmpty || clientEmail.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Proposal sent successfully to $clientName");
      Navigator.pop(context);
    });
  }
}
