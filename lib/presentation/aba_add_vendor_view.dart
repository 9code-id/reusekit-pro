import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaAddVendorView extends StatefulWidget {
  const AbaAddVendorView({super.key});

  @override
  State<AbaAddVendorView> createState() => _AbaAddVendorViewState();
}

class _AbaAddVendorViewState extends State<AbaAddVendorView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String vendorName = "";
  String category = "";
  String website = "";
  String businessType = "";
  
  // Primary Contact
  String contactPerson = "";
  String contactTitle = "";
  String contactEmail = "";
  String contactPhone = "";
  
  // Alternate Contact
  String altContactPerson = "";
  String altContactTitle = "";
  String altContactEmail = "";
  String altContactPhone = "";
  
  // Business Address
  String address = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "USA";
  
  // Business Details
  String taxId = "";
  String paymentTerms = "Net 30";
  String businessHours = "";
  String notes = "";
  
  // Certifications
  String certifications = "";
  
  // Bank Details
  String bankName = "";
  String accountNumber = "";
  String routingNumber = "";
  String accountType = "Checking";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Select Category", "value": ""},
    {"label": "Office Supplies", "value": "Office Supplies"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Professional Services", "value": "Professional Services"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Food & Beverage", "value": "Food & Beverage"},
    {"label": "Transportation", "value": "Transportation"},
    {"label": "Utilities", "value": "Utilities"},
    {"label": "Other", "value": "Other"}
  ];

  List<Map<String, dynamic>> businessTypeOptions = [
    {"label": "Select Business Type", "value": ""},
    {"label": "Corporation", "value": "Corporation"},
    {"label": "LLC", "value": "LLC"},
    {"label": "Partnership", "value": "Partnership"},
    {"label": "Sole Proprietorship", "value": "Sole Proprietorship"},
    {"label": "Non-Profit", "value": "Non-Profit"},
    {"label": "Government", "value": "Government"}
  ];

  List<Map<String, dynamic>> stateOptions = [
    {"label": "Select State", "value": ""},
    {"label": "Alabama", "value": "AL"},
    {"label": "Alaska", "value": "AK"},
    {"label": "Arizona", "value": "AZ"},
    {"label": "Arkansas", "value": "AR"},
    {"label": "California", "value": "CA"},
    {"label": "Colorado", "value": "CO"},
    {"label": "Connecticut", "value": "CT"},
    {"label": "Delaware", "value": "DE"},
    {"label": "Florida", "value": "FL"},
    {"label": "Georgia", "value": "GA"},
    {"label": "Hawaii", "value": "HI"},
    {"label": "Idaho", "value": "ID"},
    {"label": "Illinois", "value": "IL"},
    {"label": "Indiana", "value": "IN"},
    {"label": "Iowa", "value": "IA"},
    {"label": "Kansas", "value": "KS"},
    {"label": "Kentucky", "value": "KY"},
    {"label": "Louisiana", "value": "LA"},
    {"label": "Maine", "value": "ME"},
    {"label": "Maryland", "value": "MD"},
    {"label": "Massachusetts", "value": "MA"},
    {"label": "Michigan", "value": "MI"},
    {"label": "Minnesota", "value": "MN"},
    {"label": "Mississippi", "value": "MS"},
    {"label": "Missouri", "value": "MO"},
    {"label": "Montana", "value": "MT"},
    {"label": "Nebraska", "value": "NE"},
    {"label": "Nevada", "value": "NV"},
    {"label": "New Hampshire", "value": "NH"},
    {"label": "New Jersey", "value": "NJ"},
    {"label": "New Mexico", "value": "NM"},
    {"label": "New York", "value": "NY"},
    {"label": "North Carolina", "value": "NC"},
    {"label": "North Dakota", "value": "ND"},
    {"label": "Ohio", "value": "OH"},
    {"label": "Oklahoma", "value": "OK"},
    {"label": "Oregon", "value": "OR"},
    {"label": "Pennsylvania", "value": "PA"},
    {"label": "Rhode Island", "value": "RI"},
    {"label": "South Carolina", "value": "SC"},
    {"label": "South Dakota", "value": "SD"},
    {"label": "Tennessee", "value": "TN"},
    {"label": "Texas", "value": "TX"},
    {"label": "Utah", "value": "UT"},
    {"label": "Vermont", "value": "VT"},
    {"label": "Virginia", "value": "VA"},
    {"label": "Washington", "value": "WA"},
    {"label": "West Virginia", "value": "WV"},
    {"label": "Wisconsin", "value": "WI"},
    {"label": "Wyoming", "value": "WY"}
  ];

  List<Map<String, dynamic>> paymentTermsOptions = [
    {"label": "Net 15", "value": "Net 15"},
    {"label": "Net 30", "value": "Net 30"},
    {"label": "Net 45", "value": "Net 45"},
    {"label": "Net 60", "value": "Net 60"},
    {"label": "Due on Receipt", "value": "Due on Receipt"},
    {"label": "2/10 Net 30", "value": "2/10 Net 30"},
    {"label": "Cash on Delivery", "value": "Cash on Delivery"}
  ];

  List<Map<String, dynamic>> accountTypeOptions = [
    {"label": "Checking", "value": "Checking"},
    {"label": "Savings", "value": "Savings"},
    {"label": "Business Checking", "value": "Business Checking"},
    {"label": "Business Savings", "value": "Business Savings"}
  ];

  void _saveVendor() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      
      // Show success message
      ss("Vendor '${vendorName}' has been successfully added!");
      
      // Navigate back or reset form
      back();
    }
  }

  void _saveAsDraft() async {
    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    ss("Vendor information saved as draft");
  }

  void _resetForm() async {
    bool isConfirmed = await confirm("Are you sure you want to reset all form data? This action cannot be undone.");
    if (isConfirmed) {
      setState(() {
        vendorName = "";
        category = "";
        website = "";
        businessType = "";
        contactPerson = "";
        contactTitle = "";
        contactEmail = "";
        contactPhone = "";
        altContactPerson = "";
        altContactTitle = "";
        altContactEmail = "";
        altContactPhone = "";
        address = "";
        city = "";
        state = "";
        zipCode = "";
        country = "USA";
        taxId = "";
        paymentTerms = "Net 30";
        businessHours = "";
        notes = "";
        certifications = "";
        bankName = "";
        accountNumber = "";
        routingNumber = "";
        accountType = "Checking";
      });
      ss("Form has been reset");
    }
  }

  Widget _buildBasicInfoSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
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
            label: "Vendor Name",
            hint: "Enter company or business name",
            value: vendorName,
            validator: Validator.required,
            onChanged: (value) {
              vendorName = value;
              setState(() {});
            },
          ),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: category,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    category = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Business Type",
                  items: businessTypeOptions,
                  value: businessType,
                  onChanged: (value, label) {
                    businessType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          QTextField(
            label: "Website",
            hint: "www.company.com",
            value: website,
            onChanged: (value) {
              website = value;
              setState(() {});
            },
          ),
          
          QTextField(
            label: "Tax ID / EIN",
            hint: "12-3456789",
            value: taxId,
            validator: Validator.required,
            onChanged: (value) {
              taxId = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Primary Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Contact Person",
                  hint: "Full name",
                  value: contactPerson,
                  validator: Validator.required,
                  onChanged: (value) {
                    contactPerson = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Title/Position",
                  hint: "Job title",
                  value: contactTitle,
                  onChanged: (value) {
                    contactTitle = value;
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
                  label: "Email Address",
                  hint: "contact@company.com",
                  value: contactEmail,
                  validator: Validator.email,
                  onChanged: (value) {
                    contactEmail = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  hint: "+1 (555) 123-4567",
                  value: contactPhone,
                  validator: Validator.required,
                  onChanged: (value) {
                    contactPhone = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          Divider(color: disabledOutlineBorderColor),
          
          Text(
            "Alternate Contact (Optional)",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Contact Person",
                  hint: "Full name",
                  value: altContactPerson,
                  onChanged: (value) {
                    altContactPerson = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Title/Position",
                  hint: "Job title",
                  value: altContactTitle,
                  onChanged: (value) {
                    altContactTitle = value;
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
                  label: "Email Address",
                  hint: "alternate@company.com",
                  value: altContactEmail,
                  onChanged: (value) {
                    altContactEmail = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  hint: "+1 (555) 123-4568",
                  value: altContactPhone,
                  onChanged: (value) {
                    altContactPhone = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Business Address",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          QTextField(
            label: "Street Address",
            hint: "123 Business Avenue, Suite 100",
            value: address,
            validator: Validator.required,
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
          
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "City",
                  hint: "City name",
                  value: city,
                  validator: Validator.required,
                  onChanged: (value) {
                    city = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "State",
                  items: stateOptions,
                  value: state,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    state = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "ZIP Code",
                  hint: "12345",
                  value: zipCode,
                  validator: Validator.required,
                  onChanged: (value) {
                    zipCode = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          QTextField(
            label: "Country",
            value: country,
            validator: Validator.required,
            onChanged: (value) {
              country = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessDetailsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Business Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
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
          
          QTextField(
            label: "Business Hours",
            hint: "Mon-Fri: 8:00 AM - 6:00 PM",
            value: businessHours,
            onChanged: (value) {
              businessHours = value;
              setState(() {});
            },
          ),
          
          QTextField(
            label: "Certifications",
            hint: "ISO 9001, Green Certified, etc. (comma separated)",
            value: certifications,
            onChanged: (value) {
              certifications = value;
              setState(() {});
            },
          ),
          
          QMemoField(
            label: "Notes",
            hint: "Additional notes about this vendor...",
            value: notes,
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Banking Information (Optional)",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "Required for ACH payments and direct deposits",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
          
          QTextField(
            label: "Bank Name",
            hint: "First National Bank",
            value: bankName,
            onChanged: (value) {
              bankName = value;
              setState(() {});
            },
          ),
          
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Account Number",
                  hint: "1234567890",
                  value: accountNumber,
                  onChanged: (value) {
                    accountNumber = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Routing Number",
                  hint: "123456789",
                  value: routingNumber,
                  onChanged: (value) {
                    routingNumber = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          QDropdownField(
            label: "Account Type",
            items: accountTypeOptions,
            value: accountType,
            onChanged: (value, label) {
              accountType = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Vendor"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Instructions
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Vendor Setup Instructions",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Fill out the required information to add a new vendor to your system. Required fields are marked with *. You can save as draft and complete later if needed.",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Form Sections
              _buildBasicInfoSection(),
              _buildContactInfoSection(),
              _buildAddressSection(),
              _buildBusinessDetailsSection(),
              _buildBankDetailsSection(),

              // Action Buttons
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    Text(
                      "Form Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Save as Draft",
                            icon: Icons.save,
                            size: bs.sm,
                            onPressed: _saveAsDraft,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Reset Form",
                            icon: Icons.refresh,
                            size: bs.sm,
                            onPressed: _resetForm,
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Add Vendor",
                        icon: Icons.add_business,
                        size: bs.md,
                        onPressed: _saveVendor,
                      ),
                    ),
                  ],
                ),
              ),

              // Helper Information
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Need Help?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "• All vendor information is encrypted and stored securely",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "• Banking information is optional and only used for ACH payments",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "• You can update vendor information anytime after creation",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "• Contact support if you need assistance with vendor setup",
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
        ),
      ),
    );
  }
}
