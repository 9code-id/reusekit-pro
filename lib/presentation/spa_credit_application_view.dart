import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaCreditApplicationView extends StatefulWidget {
  const SpaCreditApplicationView({super.key});

  @override
  State<SpaCreditApplicationView> createState() => _SpaCreditApplicationViewState();
}

class _SpaCreditApplicationViewState extends State<SpaCreditApplicationView> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;
  
  // Personal Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String dateOfBirth = "";
  String ssn = "";
  
  // Address Information
  String streetAddress = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String residenceType = "own";
  String monthsAtAddress = "";
  
  // Employment Information
  String employmentStatus = "employed";
  String employerName = "";
  String jobTitle = "";
  String workPhone = "";
  String monthsEmployed = "";
  String annualIncome = "";
  
  // Financial Information
  String monthlyHousingPayment = "";
  String otherMonthlyDebt = "";
  String bankName = "";
  String accountType = "checking";
  
  // Credit Application Details
  String requestedCreditLimit = "5000";
  String primaryCardUsage = "purchases";

  List<Map<String, dynamic>> residenceTypes = [
    {"label": "Own", "value": "own"},
    {"label": "Rent", "value": "rent"},
    {"label": "Live with family/friends", "value": "family"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> employmentStatusOptions = [
    {"label": "Employed", "value": "employed"},
    {"label": "Self-employed", "value": "self_employed"},
    {"label": "Unemployed", "value": "unemployed"},
    {"label": "Retired", "value": "retired"},
    {"label": "Student", "value": "student"},
  ];

  List<Map<String, dynamic>> accountTypes = [
    {"label": "Checking", "value": "checking"},
    {"label": "Savings", "value": "savings"},
  ];

  List<Map<String, dynamic>> creditLimitOptions = [
    {"label": "\$2,500", "value": "2500"},
    {"label": "\$5,000", "value": "5000"},
    {"label": "\$10,000", "value": "10000"},
    {"label": "\$15,000", "value": "15000"},
    {"label": "\$25,000", "value": "25000"},
  ];

  List<Map<String, dynamic>> cardUsageOptions = [
    {"label": "Everyday purchases", "value": "purchases"},
    {"label": "Build credit history", "value": "credit_building"},
    {"label": "Balance transfers", "value": "balance_transfer"},
    {"label": "Business expenses", "value": "business"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Credit Application"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            _buildProgressIndicator(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: _buildCurrentStep(),
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(5, (index) {
              bool isCompleted = index < currentStep;
              bool isCurrent = index == currentStep;
              
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isCompleted || isCurrent ? primaryColor : disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: spSm),
          Text(
            "Step ${currentStep + 1} of 5",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            _getStepTitle(currentStep),
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return "Personal Information";
      case 1:
        return "Address Information";
      case 2:
        return "Employment Information";
      case 3:
        return "Financial Information";
      case 4:
        return "Application Review";
      default:
        return "";
    }
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildPersonalInformation();
      case 1:
        return _buildAddressInformation();
      case 2:
        return _buildEmploymentInformation();
      case 3:
        return _buildFinancialInformation();
      case 4:
        return _buildApplicationReview();
      default:
        return Container();
    }
  }

  Widget _buildPersonalInformation() {
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
            "Personal Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Please provide your personal details exactly as they appear on your government-issued ID.",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
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
          QTextField(
            label: "Email Address",
            value: email,
            validator: Validator.email,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Phone Number",
            value: phone,
            validator: Validator.required,
            onChanged: (value) {
              phone = value;
              setState(() {});
            },
          ),
          QDatePicker(
            label: "Date of Birth",
            value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : null,
            onChanged: (value) {
              dateOfBirth = value.toIso8601String();
              setState(() {});
            },
          ),
          QTextField(
            label: "Social Security Number",
            value: ssn,
            validator: Validator.required,
            onChanged: (value) {
              ssn = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.security,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Your personal information is encrypted and secure",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
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

  Widget _buildAddressInformation() {
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
            "Address Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Please provide your current residential address.",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          QTextField(
            label: "Street Address",
            value: streetAddress,
            validator: Validator.required,
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
                  onChanged: (value) {
                    state = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "ZIP Code",
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
          QDropdownField(
            label: "Residence Type",
            items: residenceTypes,
            value: residenceType,
            onChanged: (value, label) {
              residenceType = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Months at Current Address",
            value: monthsAtAddress,
            onChanged: (value) {
              monthsAtAddress = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmploymentInformation() {
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
            "Employment Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Please provide details about your current employment status.",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          QDropdownField(
            label: "Employment Status",
            items: employmentStatusOptions,
            value: employmentStatus,
            onChanged: (value, label) {
              employmentStatus = value;
              setState(() {});
            },
          ),
          if (employmentStatus == "employed" || employmentStatus == "self_employed") ...[
            QTextField(
              label: "Employer Name",
              value: employerName,
              validator: Validator.required,
              onChanged: (value) {
                employerName = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Job Title",
              value: jobTitle,
              validator: Validator.required,
              onChanged: (value) {
                jobTitle = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Work Phone Number",
              value: workPhone,
              onChanged: (value) {
                workPhone = value;
                setState(() {});
              },
            ),
            QNumberField(
              label: "Months with Current Employer",
              value: monthsEmployed,
              onChanged: (value) {
                monthsEmployed = value;
                setState(() {});
              },
            ),
          ],
          QNumberField(
            label: "Annual Income (\$)",
            value: annualIncome,
            validator: Validator.required,
            onChanged: (value) {
              annualIncome = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialInformation() {
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
            "Financial Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Please provide your monthly expenses and banking information.",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          QNumberField(
            label: "Monthly Housing Payment (\$)",
            value: monthlyHousingPayment,
            validator: Validator.required,
            onChanged: (value) {
              monthlyHousingPayment = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Other Monthly Debt Payments (\$)",
            value: otherMonthlyDebt,
            onChanged: (value) {
              otherMonthlyDebt = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Bank Name",
            value: bankName,
            validator: Validator.required,
            onChanged: (value) {
              bankName = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Account Type",
            items: accountTypes,
            value: accountType,
            onChanged: (value, label) {
              accountType = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Requested Credit Limit",
            items: creditLimitOptions,
            value: requestedCreditLimit,
            onChanged: (value, label) {
              requestedCreditLimit = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Primary Card Usage",
            items: cardUsageOptions,
            value: primaryCardUsage,
            onChanged: (value, label) {
              primaryCardUsage = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationReview() {
    return Column(
      spacing: spMd,
      children: [
        _buildReviewSection("Personal Information", [
          "Name: $firstName $lastName",
          "Email: $email",
          "Phone: $phone",
          "Date of Birth: ${dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth).dMMMy : 'Not provided'}",
        ]),
        _buildReviewSection("Address Information", [
          "Address: $streetAddress",
          "City: $city, $state $zipCode",
          "Residence: ${residenceTypes.firstWhere((type) => type["value"] == residenceType)["label"]}",
          "Months at address: ${monthsAtAddress.isNotEmpty ? monthsAtAddress : 'Not provided'}",
        ]),
        _buildReviewSection("Employment Information", [
          "Status: ${employmentStatusOptions.firstWhere((status) => status["value"] == employmentStatus)["label"]}",
          if (employerName.isNotEmpty) "Employer: $employerName",
          if (jobTitle.isNotEmpty) "Job Title: $jobTitle",
          "Annual Income: \$${annualIncome.isNotEmpty ? annualIncome : 'Not provided'}",
        ]),
        _buildReviewSection("Financial Information", [
          "Monthly Housing: \$${monthlyHousingPayment.isNotEmpty ? monthlyHousingPayment : 'Not provided'}",
          "Other Monthly Debt: \$${otherMonthlyDebt.isNotEmpty ? otherMonthlyDebt : '0'}",
          "Bank: ${bankName.isNotEmpty ? bankName : 'Not provided'}",
          "Requested Credit Limit: \$${creditLimitOptions.firstWhere((limit) => limit["value"] == requestedCreditLimit)["label"]}",
        ]),
        _buildTermsAndConditions(),
      ],
    );
  }

  Widget _buildReviewSection(String title, List<String> items) {
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
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...items.map((item) => Text(
            item,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Terms and Conditions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: infoColor,
            ),
          ),
          Text(
            "By submitting this application, you agree to:",
            style: TextStyle(
              fontSize: 14,
              color: infoColor,
            ),
          ),
          Text(
            "• Credit check and verification of information provided",
            style: TextStyle(fontSize: 12, color: infoColor),
          ),
          Text(
            "• Terms and conditions of the credit card agreement",
            style: TextStyle(fontSize: 12, color: infoColor),
          ),
          Text(
            "• Privacy policy and data usage terms",
            style: TextStyle(fontSize: 12, color: infoColor),
          ),
          Text(
            "• Automatic enrollment in account alerts and notifications",
            style: TextStyle(fontSize: 12, color: infoColor),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
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
                onPressed: () {
                  currentStep--;
                  setState(() {});
                },
              ),
            ),
          if (currentStep > 0) SizedBox(width: spSm),
          Expanded(
            flex: currentStep == 0 ? 1 : 2,
            child: QButton(
              label: currentStep == 4 ? "Submit Application" : "Next",
              size: bs.md,
              onPressed: _nextStep,
            ),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (currentStep == 4) {
      _submitApplication();
      return;
    }

    if (_validateCurrentStep()) {
      currentStep++;
      setState(() {});
    }
  }

  bool _validateCurrentStep() {
    // Basic validation for each step
    switch (currentStep) {
      case 0:
        return firstName.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty && phone.isNotEmpty;
      case 1:
        return streetAddress.isNotEmpty && city.isNotEmpty && state.isNotEmpty && zipCode.isNotEmpty;
      case 2:
        return annualIncome.isNotEmpty;
      case 3:
        return monthlyHousingPayment.isNotEmpty && bankName.isNotEmpty;
      default:
        return true;
    }
  }

  void _submitApplication() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Submit Application"),
        content: Text("Are you ready to submit your credit card application? This will initiate a credit check."),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => back(),
          ),
          QButton(
            label: "Submit",
            size: bs.sm,
            onPressed: () {
              back();
              _processApplication();
            },
          ),
        ],
      ),
    );
  }

  void _processApplication() async {
    showLoading();
    
    // Simulate application processing
    await Future.delayed(Duration(seconds: 4));
    
    hideLoading();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Application Submitted"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: successColor,
              size: 48,
            ),
            SizedBox(height: spSm),
            Text(
              "Your credit card application has been submitted successfully!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: spSm),
            Text(
              "You will receive a decision within 1-2 business days via email.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Done",
            size: bs.sm,
            onPressed: () {
              back();
              back();
            },
          ),
        ],
      ),
    );
  }
}
