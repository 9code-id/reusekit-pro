import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaOnboardingView extends StatefulWidget {
  const LtaOnboardingView({super.key});

  @override
  State<LtaOnboardingView> createState() => _LtaOnboardingViewState();
}

class _LtaOnboardingViewState extends State<LtaOnboardingView> {
  int currentStep = 0;
  
  // Form data
  String companyName = "";
  String contactPerson = "";
  String email = "";
  String phone = "";
  String address = "";
  String businessType = "";
  String companySize = "";
  String annualShipments = "";
  
  // Documents
  List<String> businessLicense = [];
  List<String> insuranceDocuments = [];
  List<String> taxDocuments = [];
  
  // Services
  List<Map<String, dynamic>> selectedServices = [];
  String preferredPaymentMethod = "";
  String billingCycle = "";
  
  // Agreement
  bool termsAccepted = false;
  bool privacyAccepted = false;
  bool marketingConsent = false;

  List<Map<String, dynamic>> businessTypes = [
    {"label": "Manufacturing", "value": "Manufacturing"},
    {"label": "Retail", "value": "Retail"},
    {"label": "E-commerce", "value": "E-commerce"},
    {"label": "Healthcare", "value": "Healthcare"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> companySizes = [
    {"label": "1-10 employees", "value": "1-10"},
    {"label": "11-50 employees", "value": "11-50"},
    {"label": "51-200 employees", "value": "51-200"},
    {"label": "201-500 employees", "value": "201-500"},
    {"label": "500+ employees", "value": "500+"},
  ];

  List<Map<String, dynamic>> shipmentVolumes = [
    {"label": "1-10 per month", "value": "1-10"},
    {"label": "11-50 per month", "value": "11-50"},
    {"label": "51-200 per month", "value": "51-200"},
    {"label": "201-500 per month", "value": "201-500"},
    {"label": "500+ per month", "value": "500+"},
  ];

  List<Map<String, dynamic>> availableServices = [
    {
      "id": "domestic_shipping",
      "name": "Domestic Shipping",
      "description": "Nationwide delivery within 1-3 business days",
      "price": 15.99,
      "selected": false,
    },
    {
      "id": "international_shipping",
      "name": "International Shipping",
      "description": "Global delivery with customs handling",
      "price": 45.99,
      "selected": false,
    },
    {
      "id": "express_delivery",
      "name": "Express Delivery",
      "description": "Same-day and next-day delivery options",
      "price": 29.99,
      "selected": false,
    },
    {
      "id": "freight_services",
      "name": "Freight Services",
      "description": "Large cargo and bulk shipments",
      "price": 125.99,
      "selected": false,
    },
    {
      "id": "warehouse_storage",
      "name": "Warehouse Storage",
      "description": "Secure storage solutions",
      "price": 8.99,
      "selected": false,
    },
    {
      "id": "packaging_services",
      "name": "Packaging Services",
      "description": "Professional packaging and handling",
      "price": 12.99,
      "selected": false,
    },
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "Bank Transfer", "value": "bank_transfer"},
    {"label": "Monthly Invoice", "value": "monthly_invoice"},
    {"label": "Pay per Shipment", "value": "pay_per_shipment"},
  ];

  List<Map<String, dynamic>> billingCycles = [
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Annually", "value": "annually"},
  ];

  List<Map<String, dynamic>> onboardingSteps = [
    {
      "title": "Company Information",
      "description": "Basic company details and contact information",
      "icon": Icons.business,
    },
    {
      "title": "Business Profile",
      "description": "Business type, size, and shipping requirements",
      "icon": Icons.domain,
    },
    {
      "title": "Documents Upload",
      "description": "Required business documents and certifications",
      "icon": Icons.upload_file,
    },
    {
      "title": "Service Selection",
      "description": "Choose logistics services and pricing plans",
      "icon": Icons.local_shipping,
    },
    {
      "title": "Payment Setup",
      "description": "Configure billing and payment preferences",
      "icon": Icons.payment,
    },
    {
      "title": "Terms & Agreement",
      "description": "Review and accept service agreements",
      "icon": Icons.gavel,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Onboarding"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              ss("Opening help documentation");
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
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "Step ${currentStep + 1} of ${onboardingSteps.length}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(((currentStep + 1) / onboardingSteps.length) * 100).toStringAsFixed(0)}% Complete",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (currentStep + 1) / onboardingSteps.length,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        onboardingSteps[currentStep]["icon"] as IconData,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${onboardingSteps[currentStep]["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${onboardingSteps[currentStep]["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
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
          
          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildCurrentStep(),
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
              spacing: spSm,
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
                Expanded(
                  flex: currentStep == 0 ? 1 : 1,
                  child: QButton(
                    label: currentStep == onboardingSteps.length - 1 ? "Complete Onboarding" : "Next",
                    size: bs.md,
                    onPressed: () {
                      if (currentStep == onboardingSteps.length - 1) {
                        _completeOnboarding();
                      } else {
                        if (_validateCurrentStep()) {
                          currentStep++;
                          setState(() {});
                        }
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

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildCompanyInfoStep();
      case 1:
        return _buildBusinessProfileStep();
      case 2:
        return _buildDocumentsStep();
      case 3:
        return _buildServiceSelectionStep();
      case 4:
        return _buildPaymentSetupStep();
      case 5:
        return _buildTermsAgreementStep();
      default:
        return Container();
    }
  }

  Widget _buildCompanyInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Company Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QTextField(
          label: "Company Name",
          value: companyName,
          validator: Validator.required,
          hint: "Enter your company name",
          onChanged: (value) {
            companyName = value;
            setState(() {});
          },
        ),
        
        QTextField(
          label: "Contact Person",
          value: contactPerson,
          validator: Validator.required,
          hint: "Primary contact person",
          onChanged: (value) {
            contactPerson = value;
            setState(() {});
          },
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QTextField(
                label: "Email Address",
                value: email,
                validator: Validator.email,
                hint: "company@example.com",
                onChanged: (value) {
                  email = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QTextField(
                label: "Phone Number",
                value: phone,
                validator: Validator.required,
                hint: "+1 (555) 123-4567",
                onChanged: (value) {
                  phone = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        QMemoField(
          label: "Business Address",
          value: address,
          validator: Validator.required,
          hint: "Complete business address including city, state, and zip code",
          onChanged: (value) {
            address = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildBusinessProfileStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Business Profile",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QDropdownField(
          label: "Business Type",
          items: businessTypes,
          value: businessType,
          onChanged: (value, label) {
            businessType = value;
            setState(() {});
          },
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QDropdownField(
                label: "Company Size",
                items: companySizes,
                value: companySize,
                onChanged: (value, label) {
                  companySize = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QDropdownField(
                label: "Annual Shipments",
                items: shipmentVolumes,
                value: annualShipments,
                onChanged: (value, label) {
                  annualShipments = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusXs),
            border: Border.all(color: infoColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "This information helps us customize our services to match your business needs and provide accurate pricing.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Required Documents",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Please upload the following documents to verify your business:",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        
        QMultiImagePicker(
          label: "Business License",
          value: businessLicense,
          hint: "Upload business registration documents",
          maxImages: 3,
          onChanged: (value) {
            businessLicense = value;
            setState(() {});
          },
        ),
        
        QMultiImagePicker(
          label: "Insurance Documents",
          value: insuranceDocuments,
          hint: "Upload liability insurance certificates",
          maxImages: 2,
          onChanged: (value) {
            insuranceDocuments = value;
            setState(() {});
          },
        ),
        
        QMultiImagePicker(
          label: "Tax Documents",
          value: taxDocuments,
          hint: "Upload tax ID and related documents",
          maxImages: 2,
          onChanged: (value) {
            taxDocuments = value;
            setState(() {});
          },
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusXs),
            border: Border.all(color: warningColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.security,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "All documents are encrypted and stored securely. Our compliance team will review within 2-3 business days.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceSelectionStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Select Services",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Choose the logistics services that best fit your business needs:",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        
        Column(
          spacing: spSm,
          children: availableServices.map((service) {
            bool isSelected = selectedServices.any((s) => s["id"] == service["id"]);
            
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: CheckboxListTile(
                title: Text(
                  "${service["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${service["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Starting from \$${((service["price"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                value: isSelected,
                onChanged: (bool? value) {
                  if (value == true) {
                    selectedServices.add(service);
                  } else {
                    selectedServices.removeWhere((s) => s["id"] == service["id"]);
                  }
                  setState(() {});
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            );
          }).toList(),
        ),
        
        if (selectedServices.isNotEmpty)
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
              border: Border.all(color: successColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Selected Services:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                ...selectedServices.map((service) {
                  return Text(
                    "• ${service["name"]} - \$${((service["price"] as double).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPaymentSetupStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Payment Setup",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QDropdownField(
          label: "Preferred Payment Method",
          items: paymentMethods,
          value: preferredPaymentMethod,
          onChanged: (value, label) {
            preferredPaymentMethod = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Billing Cycle",
          items: billingCycles,
          value: billingCycle,
          onChanged: (value, label) {
            billingCycle = value;
            setState(() {});
          },
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(5),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Payment Method Details:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              
              if (preferredPaymentMethod == "credit_card")
                Text(
                  "• Credit card payments are processed securely\n• 2.9% processing fee applies\n• Automatic billing on cycle date",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              
              if (preferredPaymentMethod == "bank_transfer")
                Text(
                  "• Direct bank transfers (ACH)\n• No processing fees\n• 3-5 business days processing time",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              
              if (preferredPaymentMethod == "monthly_invoice")
                Text(
                  "• Monthly invoice sent via email\n• Net 30 payment terms\n• Late payment fees may apply",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              
              if (preferredPaymentMethod == "pay_per_shipment")
                Text(
                  "• Pay only when you ship\n• Immediate payment required\n• Flexible for variable volume",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAgreementStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Terms & Agreement",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Please review and accept the following agreements to complete your onboarding:",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              QSwitch(
                items: [
                  {
                    "label": "I accept the Terms of Service",
                    "value": "terms",
                    "checked": termsAccepted,
                  }
                ],
                value: termsAccepted ? [{"label": "I accept the Terms of Service", "value": "terms", "checked": true}] : [],
                onChanged: (values, ids) {
                  termsAccepted = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "I accept the Privacy Policy",
                    "value": "privacy",
                    "checked": privacyAccepted,
                  }
                ],
                value: privacyAccepted ? [{"label": "I accept the Privacy Policy", "value": "privacy", "checked": true}] : [],
                onChanged: (values, ids) {
                  privacyAccepted = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "I consent to marketing communications (optional)",
                    "value": "marketing",
                    "checked": marketingConsent,
                  }
                ],
                value: marketingConsent ? [{"label": "I consent to marketing communications (optional)", "value": "marketing", "checked": true}] : [],
                onChanged: (values, ids) {
                  marketingConsent = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: successColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusXs),
            border: Border.all(color: successColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Once completed, your account will be activated within 24 hours. You'll receive a welcome email with your account details and next steps.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        if (companyName.isEmpty || contactPerson.isEmpty || email.isEmpty || phone.isEmpty || address.isEmpty) {
          se("Please fill in all required fields");
          return false;
        }
        break;
      case 1:
        if (businessType.isEmpty || companySize.isEmpty || annualShipments.isEmpty) {
          se("Please complete your business profile");
          return false;
        }
        break;
      case 2:
        if (businessLicense.isEmpty) {
          se("Business license is required");
          return false;
        }
        break;
      case 3:
        if (selectedServices.isEmpty) {
          se("Please select at least one service");
          return false;
        }
        break;
      case 4:
        if (preferredPaymentMethod.isEmpty || billingCycle.isEmpty) {
          se("Please complete payment setup");
          return false;
        }
        break;
      case 5:
        if (!termsAccepted || !privacyAccepted) {
          se("Please accept the required agreements");
          return false;
        }
        break;
    }
    return true;
  }

  void _completeOnboarding() {
    if (!_validateCurrentStep()) return;
    
    ss("Onboarding completed successfully! Welcome to our logistics platform.");
    // Navigate to dashboard or next screen
  }
}
