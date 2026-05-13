import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:math' as Math;

class ReaOfferSubmissionView extends StatefulWidget {
  const ReaOfferSubmissionView({super.key});

  @override
  State<ReaOfferSubmissionView> createState() => _ReaOfferSubmissionViewState();
}

class _ReaOfferSubmissionViewState extends State<ReaOfferSubmissionView> {
  double offerAmount = 2200000.0;
  String financingType = "Home Loan";
  double downPayment = 550000.0;
  String loanTenure = "20 years";
  String moveInDate = "Immediate";
  String specialConditions = "";
  String buyerName = "";
  String buyerEmail = "";
  String buyerPhone = "";
  bool includeContingencies = true;
  bool inspectionContingency = true;
  bool financingContingency = true;
  bool appraisalContingency = false;
  String offerValidUntil = "";
  bool agreeToTerms = false;
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> financingOptions = [
    {"label": "Home Loan", "value": "Home Loan"},
    {"label": "Cash Purchase", "value": "Cash Purchase"},
    {"label": "Self-Financed", "value": "Self-Financed"},
    {"label": "Seller Financing", "value": "Seller Financing"},
  ];

  List<Map<String, dynamic>> loanTenureOptions = [
    {"label": "10 years", "value": "10 years"},
    {"label": "15 years", "value": "15 years"},
    {"label": "20 years", "value": "20 years"},
    {"label": "25 years", "value": "25 years"},
    {"label": "30 years", "value": "30 years"},
  ];

  List<Map<String, dynamic>> moveInOptions = [
    {"label": "Immediate", "value": "Immediate"},
    {"label": "30 days", "value": "30 days"},
    {"label": "60 days", "value": "60 days"},
    {"label": "90 days", "value": "90 days"},
    {"label": "Flexible", "value": "Flexible"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submit Offer"),
        actions: [
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: () {
              si("Offer saved as draft");
            },
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showOfferTips();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Property Summary Card
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://picsum.photos/120/120?random=501&keyword=apartment"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Luxury 3BHK Apartment",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Downtown Paradise, Mumbai",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Asking Price: ₹2.5 Crores",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: infoColor, size: 16),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Property has been on market for 45 days. This could be a good negotiation opportunity.",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Offer Details
              Text(
                "Offer Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QNumberField(
                label: "Offer Amount (₹)",
                value: offerAmount.toString(),
                validator: Validator.required,
                onChanged: (value) {
                  offerAmount = double.tryParse(value) ?? 0.0;
                  setState(() {});
                },
              ),

              // Offer Analysis
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Offer Analysis",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Asking Price:",
                            style: TextStyle(color: disabledBoldColor)),
                        Text("₹${(25000000 / 100000).toStringAsFixed(1)}L",
                            style: TextStyle(color: disabledBoldColor)),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Your Offer:",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600)),
                        Text("₹${(offerAmount / 100000).toStringAsFixed(1)}L",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Difference:",
                            style: TextStyle(
                                color: offerAmount < 25000000
                                    ? successColor
                                    : dangerColor)),
                        Text(
                          "${offerAmount < 25000000 ? '-' : '+'}₹${((25000000 - offerAmount).abs() / 100000).toStringAsFixed(1)}L",
                          style: TextStyle(
                            color: offerAmount < 25000000
                                ? successColor
                                : dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (offerAmount / 25000000 >= 0.9
                                ? successColor
                                : offerAmount / 25000000 >= 0.8
                                    ? warningColor
                                    : dangerColor)
                            .withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        offerAmount / 25000000 >= 0.9
                            ? "Strong offer! High chance of acceptance."
                            : offerAmount / 25000000 >= 0.8
                                ? "Reasonable offer. May require negotiation."
                                : "Low offer. Expect counter-offer from seller.",
                        style: TextStyle(
                          color: offerAmount / 25000000 >= 0.9
                              ? successColor
                              : offerAmount / 25000000 >= 0.8
                                  ? warningColor
                                  : dangerColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Financing Details
              Text(
                "Financing Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QDropdownField(
                label: "Financing Type",
                items: financingOptions,
                value: financingType,
                onChanged: (value, label) {
                  financingType = value;
                  setState(() {});
                },
              ),

              if (financingType == "Home Loan") ...[
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Down Payment (₹)",
                        value: downPayment.toString(),
                        onChanged: (value) {
                          downPayment = double.tryParse(value) ?? 0.0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Loan Tenure",
                        items: loanTenureOptions,
                        value: loanTenure,
                        onChanged: (value, label) {
                          loanTenure = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                // EMI Calculator
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estimated EMI Calculation",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Loan Amount:",
                              style: TextStyle(
                                  color: disabledBoldColor, fontSize: 12)),
                          Text(
                              "₹${((offerAmount - downPayment) / 100000).toStringAsFixed(1)}L",
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Interest Rate (Est.):",
                              style: TextStyle(
                                  color: disabledBoldColor, fontSize: 12)),
                          Text("8.5% p.a.", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "₹${((offerAmount - downPayment) * 0.0078 / (1 - Math.pow(1 + 0.0078, -240)) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],

              // Timeline & Conditions
              Text(
                "Timeline & Conditions",
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
                      label: "Preferred Move-in",
                      items: moveInOptions,
                      value: moveInDate,
                      onChanged: (value, label) {
                        moveInDate = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDatePicker(
                      label: "Offer Valid Until",
                      value: DateTime.now().add(Duration(days: 7)),
                      onChanged: (value) {
                        offerValidUntil = value.toString();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              QMemoField(
                label: "Special Conditions",
                value: specialConditions,
                hint: "Any special terms or conditions for your offer...",
                onChanged: (value) {
                  specialConditions = value;
                  setState(() {});
                },
              ),

              // Contingencies
              Text(
                "Contingencies",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    QSwitch(
                      items: [
                        {
                          "label": "Include contingencies in offer",
                          "value": true,
                          "checked": includeContingencies,
                        }
                      ],
                      value: [
                        if (includeContingencies)
                          {
                            "label": "Include contingencies in offer",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        includeContingencies = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    if (includeContingencies) ...[
                      SizedBox(height: spMd),
                      QSwitch(
                        items: [
                          {
                            "label": "Property Inspection Contingency",
                            "value": true,
                            "checked": inspectionContingency,
                          }
                        ],
                        value: [
                          if (inspectionContingency)
                            {
                              "label": "Property Inspection Contingency",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          inspectionContingency = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                      QSwitch(
                        items: [
                          {
                            "label": "Loan Approval Contingency",
                            "value": true,
                            "checked": financingContingency,
                          }
                        ],
                        value: [
                          if (financingContingency)
                            {
                              "label": "Loan Approval Contingency",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          financingContingency = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                      QSwitch(
                        items: [
                          {
                            "label": "Property Appraisal Contingency",
                            "value": true,
                            "checked": appraisalContingency,
                          }
                        ],
                        value: [
                          if (appraisalContingency)
                            {
                              "label": "Property Appraisal Contingency",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          appraisalContingency = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),

              // Buyer Information
              Text(
                "Buyer Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Full Name",
                value: buyerName,
                validator: Validator.required,
                onChanged: (value) {
                  buyerName = value;
                  setState(() {});
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Email Address",
                      value: buyerEmail,
                      validator: Validator.email,
                      onChanged: (value) {
                        buyerEmail = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Phone Number",
                      value: buyerPhone,
                      validator: Validator.required,
                      onChanged: (value) {
                        buyerPhone = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Legal Agreement
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(40)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Legal Notice",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "This offer submission constitutes a legally binding agreement. Please review all terms carefully before submitting.",
                      style: TextStyle(
                        color: warningColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              QSwitch(
                items: [
                  {
                    "label":
                        "I agree to the Terms & Conditions and understand this is a legally binding offer",
                    "value": true,
                    "checked": agreeToTerms,
                  }
                ],
                value: [
                  if (agreeToTerms)
                    {
                      "label":
                          "I agree to the Terms & Conditions and understand this is a legally binding offer",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  agreeToTerms = values.isNotEmpty;
                  setState(() {});
                },
              ),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save Draft",
                      icon: Icons.save_alt,
                      size: bs.md,
                      onPressed: () {
                        si("Offer saved as draft");
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: "Submit Offer",
                      icon: Icons.send,
                      size: bs.md,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (!agreeToTerms) {
                            se("Please agree to Terms & Conditions");
                            return;
                          }

                          bool isConfirmed = await confirm(
                              "Are you sure you want to submit this offer? This action cannot be undone.");
                          if (isConfirmed) {
                            showLoading();
                            await Future.delayed(Duration(seconds: 3));
                            hideLoading();

                            ss("Offer submitted successfully! The seller will be notified immediately.");
                            back();
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: spLg),
            ],
          ),
        ),
      ),
    );
  }

  void _showOfferTips() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Offer Submission Tips"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("• Research comparable sales in the area"),
              SizedBox(height: spXs),
              Text("• Consider property condition and market trends"),
              SizedBox(height: spXs),
              Text("• Include reasonable contingencies for protection"),
              SizedBox(height: spXs),
              Text("• Set a realistic timeline for closing"),
              SizedBox(height: spXs),
              Text("• Get pre-approved for financing first"),
              SizedBox(height: spXs),
              Text("• Consider making a personal letter to seller"),
              SizedBox(height: spXs),
              Text("• Be prepared for counter-offers"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }
}
