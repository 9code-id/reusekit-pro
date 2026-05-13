import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaAddSupplierView extends StatefulWidget {
  const ImaAddSupplierView({super.key});

  @override
  State<ImaAddSupplierView> createState() => _ImaAddSupplierViewState();
}

class _ImaAddSupplierViewState extends State<ImaAddSupplierView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String supplierName = "";
  String supplierCode = "";
  String contactPerson = "";
  String email = "";
  String phone = "";
  String website = "";
  
  // Address Information
  String address = "";
  String city = "";
  String state = "";
  String postalCode = "";
  String country = "";
  
  // Business Information
  String selectedType = "";
  String selectedCategory = "";
  String paymentTerms = "";
  String leadTimeMin = "";
  String leadTimeMax = "";
  String minimumOrder = "";
  String currency = "USD";
  
  // Additional Information
  String taxId = "";
  String businessLicense = "";
  String notes = "";
  List<String> certifications = [];
  String newCertification = "";
  
  // Status
  bool isActive = true;
  bool isPreferred = false;
  
  List<Map<String, dynamic>> supplierTypes = [
    {"label": "Standard", "value": "standard"},
    {"label": "Premium", "value": "premium"},
    {"label": "Strategic", "value": "strategic"},
    {"label": "Emergency", "value": "emergency"},
  ];
  
  List<Map<String, dynamic>> categories = [
    {"label": "Electronics", "value": "electronics"},
    {"label": "Components", "value": "components"},
    {"label": "Raw Materials", "value": "raw_materials"},
    {"label": "Packaging", "value": "packaging"},
    {"label": "Office Supplies", "value": "office_supplies"},
    {"label": "Industrial Equipment", "value": "industrial_equipment"},
  ];
  
  List<Map<String, dynamic>> paymentTermsList = [
    {"label": "Net 15", "value": "net_15"},
    {"label": "Net 30", "value": "net_30"},
    {"label": "Net 45", "value": "net_45"},
    {"label": "Net 60", "value": "net_60"},
    {"label": "Cash on Delivery", "value": "cod"},
    {"label": "Advance Payment", "value": "advance"},
  ];
  
  List<Map<String, dynamic>> currencies = [
    {"label": "USD - US Dollar", "value": "USD"},
    {"label": "EUR - Euro", "value": "EUR"},
    {"label": "GBP - British Pound", "value": "GBP"},
    {"label": "JPY - Japanese Yen", "value": "JPY"},
    {"label": "CAD - Canadian Dollar", "value": "CAD"},
  ];
  
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Supplier"),
        actions: [
          IconButton(
            onPressed: () {
              _saveDraft();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            _buildStepIndicator(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: _buildStepContent(),
              ),
            ),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    List<String> steps = ["Basic Info", "Address", "Business", "Additional"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: List.generate(steps.length, (index) {
          bool isActive = index == currentStep;
          bool isCompleted = index < currentStep;
          
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isCompleted || isActive ? primaryColor : disabledColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isCompleted ? Icons.check : Icons.circle,
                          color: Colors.white,
                          size: isCompleted ? 18 : 8,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        steps[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: isCompleted || isActive ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (index < steps.length - 1)
                  Container(
                    height: 2,
                    width: 20,
                    color: index < currentStep ? primaryColor : disabledColor,
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildAddressStep();
      case 2:
        return _buildBusinessStep();
      case 3:
        return _buildAdditionalStep();
      default:
        return Container();
    }
  }

  Widget _buildBasicInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Basic Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        QTextField(
          label: "Supplier Name *",
          value: supplierName,
          hint: "Enter supplier company name",
          validator: Validator.required,
          onChanged: (value) {
            supplierName = value;
            setState(() {});
          },
        ),
        SizedBox(height: spMd),
        QTextField(
          label: "Supplier Code *",
          value: supplierCode,
          hint: "Enter unique supplier code",
          validator: Validator.required,
          onChanged: (value) {
            supplierCode = value;
            setState(() {});
          },
        ),
        SizedBox(height: spMd),
        QTextField(
          label: "Contact Person *",
          value: contactPerson,
          hint: "Enter primary contact person",
          validator: Validator.required,
          onChanged: (value) {
            contactPerson = value;
            setState(() {});
          },
        ),
        SizedBox(height: spMd),
        QTextField(
          label: "Email Address *",
          value: email,
          hint: "Enter contact email",
          validator: Validator.email,
          onChanged: (value) {
            email = value;
            setState(() {});
          },
        ),
        SizedBox(height: spMd),
        QTextField(
          label: "Phone Number *",
          value: phone,
          hint: "Enter contact phone number",
          validator: Validator.required,
          onChanged: (value) {
            phone = value;
            setState(() {});
          },
        ),
        SizedBox(height: spMd),
        QTextField(
          label: "Website",
          value: website,
          hint: "Enter supplier website (optional)",
          onChanged: (value) {
            website = value;
            setState(() {});
          },
        ),
        SizedBox(height: spMd),
        Row(
          children: [
            Expanded(
              child: QSwitch(
                items: [
                  {
                    "label": "Active Status",
                    "value": true,
                    "checked": isActive,
                  }
                ],
                value: [if (isActive) {"label": "Active Status", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  isActive = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddressStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Address Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        QTextField(
          label: "Street Address *",
          value: address,
          hint: "Enter street address",
          validator: Validator.required,
          onChanged: (value) {
            address = value;
            setState(() {});
          },
        ),
        SizedBox(height: spMd),
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "City *",
                value: city,
                hint: "Enter city",
                validator: Validator.required,
                onChanged: (value) {
                  city = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QTextField(
                label: "State/Province *",
                value: state,
                hint: "Enter state",
                validator: Validator.required,
                onChanged: (value) {
                  state = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Postal Code *",
                value: postalCode,
                hint: "Enter postal code",
                validator: Validator.required,
                onChanged: (value) {
                  postalCode = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QTextField(
                label: "Country *",
                value: country,
                hint: "Enter country",
                validator: Validator.required,
                onChanged: (value) {
                  country = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBusinessStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Business Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        QDropdownField(
          label: "Supplier Type *",
          items: supplierTypes,
          value: selectedType,
          validator: Validator.required,
          onChanged: (value, label) {
            selectedType = value;
            setState(() {});
          },
        ),
        SizedBox(height: spMd),
        QDropdownField(
          label: "Primary Category *",
          items: categories,
          value: selectedCategory,
          validator: Validator.required,
          onChanged: (value, label) {
            selectedCategory = value;
            setState(() {});
          },
        ),
        SizedBox(height: spMd),
        QDropdownField(
          label: "Payment Terms *",
          items: paymentTermsList,
          value: paymentTerms,
          validator: Validator.required,
          onChanged: (value, label) {
            paymentTerms = value;
            setState(() {});
          },
        ),
        SizedBox(height: spMd),
        Text(
          "Lead Time (Days)",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QNumberField(
                label: "Minimum *",
                value: leadTimeMin,
                validator: Validator.required,
                onChanged: (value) {
                  leadTimeMin = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QNumberField(
                label: "Maximum *",
                value: leadTimeMax,
                validator: Validator.required,
                onChanged: (value) {
                  leadTimeMax = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        Row(
          children: [
            Expanded(
              child: QNumberField(
                label: "Minimum Order Value *",
                value: minimumOrder,
                validator: Validator.required,
                onChanged: (value) {
                  minimumOrder = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QDropdownField(
                label: "Currency",
                items: currencies,
                value: currency,
                onChanged: (value, label) {
                  currency = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        Row(
          children: [
            Expanded(
              child: QSwitch(
                items: [
                  {
                    "label": "Preferred Supplier",
                    "value": true,
                    "checked": isPreferred,
                  }
                ],
                value: [if (isPreferred) {"label": "Preferred Supplier", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  isPreferred = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdditionalStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Additional Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        QTextField(
          label: "Tax ID/VAT Number",
          value: taxId,
          hint: "Enter tax identification number",
          onChanged: (value) {
            taxId = value;
            setState(() {});
          },
        ),
        SizedBox(height: spMd),
        QTextField(
          label: "Business License Number",
          value: businessLicense,
          hint: "Enter business license number",
          onChanged: (value) {
            businessLicense = value;
            setState(() {});
          },
        ),
        SizedBox(height: spMd),
        Text(
          "Certifications",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Add Certification",
                value: newCertification,
                hint: "Enter certification name",
                onChanged: (value) {
                  newCertification = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              label: "Add",
              size: bs.sm,
              onPressed: () {
                if (newCertification.isNotEmpty) {
                  certifications.add(newCertification);
                  newCertification = "";
                  setState(() {});
                }
              },
            ),
          ],
        ),
        if (certifications.isNotEmpty) ...[
          SizedBox(height: spMd),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: certifications.map((cert) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      cert,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    GestureDetector(
                      onTap: () {
                        certifications.remove(cert);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close,
                        size: 14,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
        SizedBox(height: spMd),
        QMemoField(
          label: "Notes",
          value: notes,
          hint: "Enter any additional notes or special instructions",
          onChanged: (value) {
            notes = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
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
                color: disabledBoldColor,
                onPressed: () {
                  currentStep--;
                  setState(() {});
                },
              ),
            ),
          if (currentStep > 0) SizedBox(width: spMd),
          Expanded(
            child: QButton(
              label: currentStep < 3 ? "Next" : "Create Supplier",
              size: bs.md,
              onPressed: () {
                if (currentStep < 3) {
                  if (_validateCurrentStep()) {
                    currentStep++;
                    setState(() {});
                  }
                } else {
                  _createSupplier();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        return supplierName.isNotEmpty && 
               supplierCode.isNotEmpty && 
               contactPerson.isNotEmpty && 
               email.isNotEmpty && 
               phone.isNotEmpty;
      case 1:
        return address.isNotEmpty && 
               city.isNotEmpty && 
               state.isNotEmpty && 
               postalCode.isNotEmpty && 
               country.isNotEmpty;
      case 2:
        return selectedType.isNotEmpty && 
               selectedCategory.isNotEmpty && 
               paymentTerms.isNotEmpty && 
               leadTimeMin.isNotEmpty && 
               leadTimeMax.isNotEmpty && 
               minimumOrder.isNotEmpty;
      case 3:
        return true; // Additional info is optional
      default:
        return false;
    }
  }

  void _createSupplier() {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Supplier created successfully!");
        back();
      });
    }
  }

  void _saveDraft() {
    si("Draft saved successfully!");
  }
}
