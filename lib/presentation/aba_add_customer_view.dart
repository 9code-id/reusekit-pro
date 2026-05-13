import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaAddCustomerView extends StatefulWidget {
  const AbaAddCustomerView({super.key});

  @override
  State<AbaAddCustomerView> createState() => _AbaAddCustomerViewState();
}

class _AbaAddCustomerViewState extends State<AbaAddCustomerView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String companyName = "";
  String contactPerson = "";
  String email = "";
  String phone = "";
  String website = "";
  
  // Address Information
  String streetAddress = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "United States";
  
  // Business Information
  String industry = "";
  String customerType = "Regular";
  String paymentTerms = "Net 30";
  String creditLimit = "";
  String taxId = "";
  
  // Additional Information
  String notes = "";
  bool isActive = true;
  bool sendWelcomeEmail = true;
  bool allowCreditPurchases = false;
  
  // Documents
  List<String> attachments = [];

  List<Map<String, dynamic>> customerTypeItems = [
    {"label": "Regular", "value": "Regular"},
    {"label": "Premium", "value": "Premium"},
    {"label": "VIP", "value": "VIP"},
    {"label": "Corporate", "value": "Corporate"},
  ];

  List<Map<String, dynamic>> industryItems = [
    {"label": "Technology", "value": "Technology"},
    {"label": "Healthcare", "value": "Healthcare"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Manufacturing", "value": "Manufacturing"},
    {"label": "Retail", "value": "Retail"},
    {"label": "Education", "value": "Education"},
    {"label": "Construction", "value": "Construction"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> paymentTermsItems = [
    {"label": "Net 15", "value": "Net 15"},
    {"label": "Net 30", "value": "Net 30"},
    {"label": "Net 45", "value": "Net 45"},
    {"label": "Net 60", "value": "Net 60"},
    {"label": "Due on Receipt", "value": "Due on Receipt"},
    {"label": "Cash on Delivery", "value": "Cash on Delivery"},
  ];

  List<Map<String, dynamic>> countryItems = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
    {"label": "Germany", "value": "Germany"},
    {"label": "France", "value": "France"},
    {"label": "Japan", "value": "Japan"},
    {"label": "Other", "value": "Other"},
  ];

  bool loading = false;

  void _saveCustomer() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Customer added successfully!");
    //navigateTo('CustomerListView')
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Customer"),
        actions: [
          if (loading)
            Container(
              margin: EdgeInsets.only(right: spMd),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
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
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information Section
              _buildSectionHeader("Basic Information", Icons.business),
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
                    QTextField(
                      label: "Company Name",
                      value: companyName,
                      validator: Validator.required,
                      hint: "Enter company name",
                      onChanged: (value) {
                        companyName = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Contact Person",
                      value: contactPerson,
                      validator: Validator.required,
                      hint: "Enter primary contact person",
                      onChanged: (value) {
                        contactPerson = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Email Address",
                            value: email,
                            validator: Validator.email,
                            hint: "Enter email address",
                            onChanged: (value) {
                              email = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: phone,
                            validator: Validator.required,
                            hint: "Enter phone number",
                            onChanged: (value) {
                              phone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Website",
                      value: website,
                      hint: "Enter company website (optional)",
                      onChanged: (value) {
                        website = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Address Information Section
              _buildSectionHeader("Address Information", Icons.location_on),
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
                    QTextField(
                      label: "Street Address",
                      value: streetAddress,
                      validator: Validator.required,
                      hint: "Enter street address",
                      onChanged: (value) {
                        streetAddress = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: QTextField(
                            label: "City",
                            value: city,
                            validator: Validator.required,
                            hint: "Enter city",
                            onChanged: (value) {
                              city = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "State",
                            value: state,
                            validator: Validator.required,
                            hint: "Enter state",
                            onChanged: (value) {
                              state = value;
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
                            label: "ZIP Code",
                            value: zipCode,
                            validator: Validator.required,
                            hint: "Enter ZIP code",
                            onChanged: (value) {
                              zipCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          flex: 2,
                          child: QDropdownField(
                            label: "Country",
                            items: countryItems,
                            value: country,
                            onChanged: (value, label) {
                              country = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Business Information Section
              _buildSectionHeader("Business Information", Icons.account_balance),
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
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Industry",
                            items: industryItems,
                            value: industry,
                            onChanged: (value, label) {
                              industry = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Customer Type",
                            items: customerTypeItems,
                            value: customerType,
                            onChanged: (value, label) {
                              customerType = value;
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
                            label: "Payment Terms",
                            items: paymentTermsItems,
                            value: paymentTerms,
                            onChanged: (value, label) {
                              paymentTerms = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Credit Limit (\$)",
                            value: creditLimit,
                            hint: "Enter credit limit",
                            onChanged: (value) {
                              creditLimit = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Tax ID / VAT Number",
                      value: taxId,
                      hint: "Enter tax identification number",
                      onChanged: (value) {
                        taxId = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Settings Section
              _buildSectionHeader("Customer Settings", Icons.settings),
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
                    QSwitch(
                      items: [
                        {
                          "label": "Active Customer",
                          "value": true,
                          "checked": isActive,
                        }
                      ],
                      value: [
                        if (isActive)
                          {
                            "label": "Active Customer",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          isActive = values.isNotEmpty;
                        });
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Send Welcome Email",
                          "value": true,
                          "checked": sendWelcomeEmail,
                        }
                      ],
                      value: [
                        if (sendWelcomeEmail)
                          {
                            "label": "Send Welcome Email",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          sendWelcomeEmail = values.isNotEmpty;
                        });
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Allow Credit Purchases",
                          "value": true,
                          "checked": allowCreditPurchases,
                        }
                      ],
                      value: [
                        if (allowCreditPurchases)
                          {
                            "label": "Allow Credit Purchases",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          allowCreditPurchases = values.isNotEmpty;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Additional Information Section
              _buildSectionHeader("Additional Information", Icons.description),
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
                    QMemoField(
                      label: "Notes",
                      value: notes,
                      hint: "Enter any additional notes about this customer",
                      onChanged: (value) {
                        notes = value;
                        setState(() {});
                      },
                    ),
                    QAttachmentPicker(
                      label: "Documents",
                      value: attachments,
                      hint: "Attach contracts, certificates, or other documents",
                      maxAttachments: 10,
                      allowedTypes: ['document', 'image'],
                      onChanged: (value) {
                        attachments = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Cancel",
                        color: disabledBoldColor,
                        size: bs.md,
                        onPressed: loading ? null : () {
                          //back()
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      flex: 2,
                      child: QButton(
                        label: loading ? "Adding Customer..." : "Add Customer",
                        size: bs.md,
                        onPressed: loading ? null : _saveCustomer,
                      ),
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

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(spXs),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
        ),
        SizedBox(width: spSm),
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
