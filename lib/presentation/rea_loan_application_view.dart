import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaLoanApplicationView extends StatefulWidget {
  const ReaLoanApplicationView({super.key});

  @override
  State<ReaLoanApplicationView> createState() => _ReaLoanApplicationViewState();
}

class _ReaLoanApplicationViewState extends State<ReaLoanApplicationView> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;
  bool isSubmitting = false;

  // Personal Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String dateOfBirth = "";
  String gender = "";
  String maritalStatus = "";

  // Employment Information
  String employmentType = "";
  String companyName = "";
  String designation = "";
  String workExperience = "";
  String monthlyIncome = "";
  String additionalIncome = "";

  // Financial Information
  String existingLoans = "";
  String creditCardDebt = "";
  String bankName = "";
  String accountNumber = "";
  String savingsBalance = "";

  // Property Information
  String propertyType = "";
  String propertyValue = "";
  String propertyAddress = "";
  String propertyCity = "";
  String propertyState = "";
  String propertyZip = "";
  String constructionStage = "";

  // Loan Details
  String loanAmount = "";
  String loanTenure = "";
  String loanPurpose = "";
  String downPayment = "";
  String preferredBank = "";

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> maritalOptions = [
    {"label": "Single", "value": "single"},
    {"label": "Married", "value": "married"},
    {"label": "Divorced", "value": "divorced"},
    {"label": "Widowed", "value": "widowed"},
  ];

  List<Map<String, dynamic>> employmentTypes = [
    {"label": "Salaried", "value": "salaried"},
    {"label": "Self-Employed Business", "value": "business"},
    {"label": "Self-Employed Professional", "value": "professional"},
    {"label": "Government Employee", "value": "government"},
  ];

  List<Map<String, dynamic>> propertyTypes = [
    {"label": "Apartment", "value": "apartment"},
    {"label": "Villa", "value": "villa"},
    {"label": "Independent House", "value": "house"},
    {"label": "Duplex", "value": "duplex"},
    {"label": "Plot", "value": "plot"},
  ];

  List<Map<String, dynamic>> constructionStages = [
    {"label": "Ready to Move", "value": "ready"},
    {"label": "Under Construction", "value": "construction"},
    {"label": "New Launch", "value": "launch"},
    {"label": "Resale", "value": "resale"},
  ];

  List<Map<String, dynamic>> loanPurposes = [
    {"label": "Purchase", "value": "purchase"},
    {"label": "Construction", "value": "construction"},
    {"label": "Renovation", "value": "renovation"},
    {"label": "Balance Transfer", "value": "transfer"},
  ];

  List<Map<String, dynamic>> tenureOptions = [
    {"label": "5 years", "value": "5"},
    {"label": "10 years", "value": "10"},
    {"label": "15 years", "value": "15"},
    {"label": "20 years", "value": "20"},
    {"label": "25 years", "value": "25"},
    {"label": "30 years", "value": "30"},
  ];

  List<Map<String, dynamic>> bankOptions = [
    {"label": "State Bank of America", "value": "sba"},
    {"label": "HDFC Home Loans", "value": "hdfc"},
    {"label": "ICICI Bank", "value": "icici"},
    {"label": "Axis Bank", "value": "axis"},
    {"label": "LIC Housing Finance", "value": "lic"},
  ];

  List<String> stepTitles = [
    "Personal Info",
    "Employment",
    "Financial Info", 
    "Property Details",
    "Loan Details",
    "Review & Submit"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Application"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Save as draft
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
              children: [
                Row(
                  children: [
                    Text(
                      "Step ${currentStep + 1} of ${stepTitles.length}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      stepTitles[currentStep],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: (currentStep + 1) / stepTitles.length,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ],
            ),
          ),
          
          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: _buildCurrentStep(),
              ),
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
                      size: bs.sm,
                      onPressed: () {
                        currentStep--;
                        setState(() {});
                      },
                    ),
                  ),
                if (currentStep > 0) SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: currentStep == stepTitles.length - 1 
                      ? (isSubmitting ? "Submitting..." : "Submit Application")
                      : "Next",
                    size: bs.sm,
                    onPressed: isSubmitting ? null : _handleNext,
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
        return _buildPersonalInfoStep();
      case 1:
        return _buildEmploymentStep();
      case 2:
        return _buildFinancialStep();
      case 3:
        return _buildPropertyStep();
      case 4:
        return _buildLoanDetailsStep();
      case 5:
        return _buildReviewStep();
      default:
        return Container();
    }
  }

  Widget _buildPersonalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Personal Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spLg),
        
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "First Name",
                value: firstName,
                validator: Validator.required,
                onChanged: (value) {
                  firstName = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "Last Name",
                value: lastName,
                validator: Validator.required,
                onChanged: (value) {
                  lastName = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Email Address",
          value: email,
          validator: Validator.email,
          onChanged: (value) {
            email = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Phone Number",
          value: phone,
          validator: Validator.required,
          onChanged: (value) {
            phone = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QDatePicker(
          label: "Date of Birth",
          value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now(),
          onChanged: (value) {
            dateOfBirth = value.toString().split(' ')[0];
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Gender",
                items: genderOptions,
                value: gender,
                validator: Validator.required,
                onChanged: (value, label) {
                  gender = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Marital Status",
                items: maritalOptions,
                value: maritalStatus,
                validator: Validator.required,
                onChanged: (value, label) {
                  maritalStatus = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmploymentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Employment Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spLg),
        
        QDropdownField(
          label: "Employment Type",
          items: employmentTypes,
          value: employmentType,
          validator: Validator.required,
          onChanged: (value, label) {
            employmentType = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Company Name",
          value: companyName,
          validator: Validator.required,
          onChanged: (value) {
            companyName = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Designation",
          value: designation,
          validator: Validator.required,
          onChanged: (value) {
            designation = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QNumberField(
          label: "Work Experience (Years)",
          value: workExperience,
          validator: Validator.required,
          onChanged: (value) {
            workExperience = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        Row(
          children: [
            Expanded(
              child: QNumberField(
                label: "Monthly Income (\$)",
                value: monthlyIncome,
                validator: Validator.required,
                onChanged: (value) {
                  monthlyIncome = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QNumberField(
                label: "Additional Income (\$)",
                value: additionalIncome,
                onChanged: (value) {
                  additionalIncome = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFinancialStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Financial Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spLg),
        
        Row(
          children: [
            Expanded(
              child: QNumberField(
                label: "Existing Loan EMIs (\$)",
                value: existingLoans,
                onChanged: (value) {
                  existingLoans = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QNumberField(
                label: "Credit Card Debt (\$)",
                value: creditCardDebt,
                onChanged: (value) {
                  creditCardDebt = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Primary Bank Name",
          value: bankName,
          validator: Validator.required,
          onChanged: (value) {
            bankName = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Account Number",
                value: accountNumber,
                validator: Validator.required,
                onChanged: (value) {
                  accountNumber = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QNumberField(
                label: "Savings Balance (\$)",
                value: savingsBalance,
                validator: Validator.required,
                onChanged: (value) {
                  savingsBalance = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPropertyStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Property Details",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spLg),
        
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Property Type",
                items: propertyTypes,
                value: propertyType,
                validator: Validator.required,
                onChanged: (value, label) {
                  propertyType = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QNumberField(
                label: "Property Value (\$)",
                value: propertyValue,
                validator: Validator.required,
                onChanged: (value) {
                  propertyValue = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Property Address",
          value: propertyAddress,
          validator: Validator.required,
          onChanged: (value) {
            propertyAddress = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "City",
                value: propertyCity,
                validator: Validator.required,
                onChanged: (value) {
                  propertyCity = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "State",
                value: propertyState,
                validator: Validator.required,
                onChanged: (value) {
                  propertyState = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "ZIP Code",
                value: propertyZip,
                validator: Validator.required,
                onChanged: (value) {
                  propertyZip = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        QDropdownField(
          label: "Construction Stage",
          items: constructionStages,
          value: constructionStage,
          validator: Validator.required,
          onChanged: (value, label) {
            constructionStage = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildLoanDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Loan Details",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spLg),
        
        Row(
          children: [
            Expanded(
              child: QNumberField(
                label: "Loan Amount (\$)",
                value: loanAmount,
                validator: Validator.required,
                onChanged: (value) {
                  loanAmount = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Loan Tenure",
                items: tenureOptions,
                value: loanTenure,
                validator: Validator.required,
                onChanged: (value, label) {
                  loanTenure = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Loan Purpose",
                items: loanPurposes,
                value: loanPurpose,
                validator: Validator.required,
                onChanged: (value, label) {
                  loanPurpose = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QNumberField(
                label: "Down Payment (\$)",
                value: downPayment,
                validator: Validator.required,
                onChanged: (value) {
                  downPayment = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        QDropdownField(
          label: "Preferred Bank/Lender",
          items: bankOptions,
          value: preferredBank,
          validator: Validator.required,
          onChanged: (value, label) {
            preferredBank = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Review Your Application",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spLg),
        
        _buildReviewSection("Personal Information", [
          "Name: $firstName $lastName",
          "Email: $email",
          "Phone: $phone",
          "Date of Birth: $dateOfBirth",
          "Gender: $gender",
          "Marital Status: $maritalStatus",
        ]),
        
        _buildReviewSection("Employment Information", [
          "Employment Type: $employmentType",
          "Company: $companyName",
          "Designation: $designation",
          "Experience: $workExperience years",
          "Monthly Income: \$$monthlyIncome",
          if (additionalIncome.isNotEmpty) "Additional Income: \$$additionalIncome",
        ]),
        
        _buildReviewSection("Financial Information", [
          "Existing Loans: \$$existingLoans",
          "Credit Card Debt: \$$creditCardDebt",
          "Primary Bank: $bankName",
          "Savings Balance: \$$savingsBalance",
        ]),
        
        _buildReviewSection("Property Details", [
          "Property Type: $propertyType",
          "Property Value: \$$propertyValue",
          "Address: $propertyAddress, $propertyCity, $propertyState $propertyZip",
          "Construction Stage: $constructionStage",
        ]),
        
        _buildReviewSection("Loan Details", [
          "Loan Amount: \$$loanAmount",
          "Loan Tenure: $loanTenure",
          "Loan Purpose: $loanPurpose",
          "Down Payment: \$$downPayment",
          "Preferred Bank: $preferredBank",
        ]),
        
        SizedBox(height: spLg),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: warningColor.withAlpha(100)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info,
                    color: warningColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Important Information",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "• This application will be submitted to multiple lenders for competitive offers\n"
                "• Document verification will be required for final approval\n"
                "• Processing time may vary between 5-15 business days\n"
                "• Credit score check will be performed",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSection(String title, List<String> items) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...items.map((item) {
            return Padding(
              padding: EdgeInsets.only(bottom: spXs),
              child: Text(
                item,
                style: TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _handleNext() async {
    if (currentStep < stepTitles.length - 1) {
      if (formKey.currentState!.validate()) {
        currentStep++;
        setState(() {});
      }
    } else {
      // Submit application
      await _submitApplication();
    }
  }

  Future<void> _submitApplication() async {
    isSubmitting = true;
    setState(() {});
    
    // Simulate submission
    await Future.delayed(Duration(seconds: 3));
    
    isSubmitting = false;
    setState(() {});
    
    // Show success message
    ss("Application submitted successfully!");
    
    // Navigate back or to confirmation page
    back();
  }
}
