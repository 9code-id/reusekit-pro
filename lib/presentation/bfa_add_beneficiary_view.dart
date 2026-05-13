import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaAddBeneficiaryView extends StatefulWidget {
  const BfaAddBeneficiaryView({super.key});

  @override
  State<BfaAddBeneficiaryView> createState() => _BfaAddBeneficiaryViewState();
}

class _BfaAddBeneficiaryViewState extends State<BfaAddBeneficiaryView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Details
  String beneficiaryName = "";
  String nickName = "";
  String relationship = "";
  String category = "personal";
  
  // Account Details
  String accountNumber = "";
  String confirmAccountNumber = "";
  String routingNumber = "";
  String swiftCode = "";
  String bankName = "";
  String bankBranch = "";
  String accountType = "savings";
  
  // Contact Details
  String emailAddress = "";
  String phoneNumber = "";
  String address = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "US";
  
  // Transfer Limits
  String dailyLimit = "";
  String monthlyLimit = "";
  
  // Verification
  bool requireOtpVerification = true;
  bool notifyBeneficiary = false;
  bool allowRecurringTransfers = true;
  
  // Sample relationship options
  List<Map<String, dynamic>> relationshipItems = [
    {"label": "Family Member", "value": "family"},
    {"label": "Friend", "value": "friend"},
    {"label": "Business Partner", "value": "business"},
    {"label": "Vendor/Supplier", "value": "vendor"},
    {"label": "Employee", "value": "employee"},
    {"label": "Other", "value": "other"},
  ];

  // Sample category options
  List<Map<String, dynamic>> categoryItems = [
    {"label": "Personal", "value": "personal"},
    {"label": "Business", "value": "business"},
    {"label": "Family", "value": "family"},
  ];

  // Sample account type options
  List<Map<String, dynamic>> accountTypeItems = [
    {"label": "Savings Account", "value": "savings"},
    {"label": "Checking Account", "value": "checking"},
    {"label": "Business Account", "value": "business"},
    {"label": "Joint Account", "value": "joint"},
  ];

  // Sample country options
  List<Map<String, dynamic>> countryItems = [
    {"label": "United States", "value": "US"},
    {"label": "Canada", "value": "CA"},
    {"label": "United Kingdom", "value": "UK"},
    {"label": "Australia", "value": "AU"},
    {"label": "Germany", "value": "DE"},
    {"label": "France", "value": "FR"},
  ];

  bool loading = false;
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Beneficiary"),
        actions: [
          if (currentStep > 0) ...[
            TextButton(
              onPressed: () {
                currentStep--;
                setState(() {});
              },
              child: Text(
                "Previous",
                style: TextStyle(color: primaryColor),
              ),
            ),
          ],
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Progress Indicator
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStepIndicator(0, "Basic Details", Icons.person),
                        _buildStepIndicator(1, "Account Info", Icons.account_balance),
                        _buildStepIndicator(2, "Contact Info", Icons.contact_phone),
                        _buildStepIndicator(3, "Verification", Icons.security),
                      ],
                    ),
                    SizedBox(height: spSm),
                    LinearProgressIndicator(
                      value: (currentStep + 1) / 4,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ],
                ),
              ),

              // Step Content
              if (currentStep == 0) ...[
                _buildBasicDetailsStep(),
              ] else if (currentStep == 1) ...[
                _buildAccountInfoStep(),
              ] else if (currentStep == 2) ...[
                _buildContactInfoStep(),
              ] else if (currentStep == 3) ...[
                _buildVerificationStep(),
              ],

              // Navigation Buttons
              Row(
                spacing: spSm,
                children: [
                  if (currentStep > 0) ...[
                    Expanded(
                      child: QButton(
                        label: "Previous",
                        icon: Icons.arrow_back,
                        size: bs.md,
                        onPressed: () {
                          currentStep--;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                  Expanded(
                    child: QButton(
                      label: loading ? "Processing..." : (currentStep == 3 ? "Add Beneficiary" : "Next"),
                      icon: currentStep == 3 ? Icons.check : Icons.arrow_forward,
                      size: bs.md,
                      onPressed: loading ? null : () {
                        _handleNext();
                      },
                    ),
                  ),
                ],
              ),

              // Help Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.help_outline,
                      color: infoColor,
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Need Help?",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "All beneficiary information is encrypted and secure. Verification may take 24-48 hours for new accounts.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
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

  Widget _buildStepIndicator(int step, String title, IconData icon) {
    bool isActive = step == currentStep;
    bool isCompleted = step < currentStep;
    
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isCompleted ? successColor : (isActive ? primaryColor : disabledColor),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Icon(
            isCompleted ? Icons.check : icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? primaryColor : disabledBoldColor,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildBasicDetailsStep() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Basic Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Enter the basic information about the beneficiary",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          QTextField(
            label: "Full Name",
            value: beneficiaryName,
            validator: Validator.required,
            hint: "Enter beneficiary's full name",
            onChanged: (value) {
              beneficiaryName = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "Nickname (Optional)",
            value: nickName,
            hint: "Short name for easy identification",
            onChanged: (value) {
              nickName = value;
              setState(() {});
            },
          ),

          QDropdownField(
            label: "Relationship",
            items: relationshipItems,
            value: relationship,
            validator: Validator.required,
            onChanged: (value, label) {
              relationship = value;
              setState(() {});
            },
          ),

          QDropdownField(
            label: "Category",
            items: categoryItems,
            value: category,
            onChanged: (value, label) {
              category = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfoStep() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Account Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Enter the bank account details for transfers",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          QTextField(
            label: "Account Number",
            value: accountNumber,
            validator: Validator.required,
            hint: "Enter account number",
            onChanged: (value) {
              accountNumber = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "Confirm Account Number",
            value: confirmAccountNumber,
            validator: Validator.required,
            hint: "Re-enter account number",
            onChanged: (value) {
              confirmAccountNumber = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "Bank Name",
            value: bankName,
            validator: Validator.required,
            hint: "Enter bank name",
            onChanged: (value) {
              bankName = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "Bank Branch",
            value: bankBranch,
            hint: "Enter branch name or code",
            onChanged: (value) {
              bankBranch = value;
              setState(() {});
            },
          ),

          QDropdownField(
            label: "Account Type",
            items: accountTypeItems,
            value: accountType,
            onChanged: (value, label) {
              accountType = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "Routing Number",
            value: routingNumber,
            validator: Validator.required,
            hint: "Enter routing number",
            onChanged: (value) {
              routingNumber = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "SWIFT Code (International)",
            value: swiftCode,
            hint: "Enter SWIFT code if applicable",
            onChanged: (value) {
              swiftCode = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoStep() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Enter contact details for notifications (Optional)",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          QTextField(
            label: "Email Address",
            value: emailAddress,
            hint: "Enter email address",
            onChanged: (value) {
              emailAddress = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "Phone Number",
            value: phoneNumber,
            hint: "Enter phone number",
            onChanged: (value) {
              phoneNumber = value;
              setState(() {});
            },
          ),

          QMemoField(
            label: "Address",
            value: address,
            hint: "Enter complete address",
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),

          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "City",
                  value: city,
                  hint: "Enter city",
                  onChanged: (value) {
                    city = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "State",
                  value: state,
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
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "ZIP Code",
                  value: zipCode,
                  hint: "Enter ZIP code",
                  onChanged: (value) {
                    zipCode = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
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
    );
  }

  Widget _buildVerificationStep() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Verification & Limits",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Set transfer limits and verification preferences",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Daily Limit (\$)",
                  value: dailyLimit,
                  hint: "Enter daily transfer limit",
                  onChanged: (value) {
                    dailyLimit = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Monthly Limit (\$)",
                  value: monthlyLimit,
                  hint: "Enter monthly transfer limit",
                  onChanged: (value) {
                    monthlyLimit = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Require OTP Verification",
                      "value": true,
                      "checked": requireOtpVerification,
                    }
                  ],
                  value: [
                    if (requireOtpVerification)
                      {
                        "label": "Require OTP Verification",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    requireOtpVerification = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Notify Beneficiary",
                      "value": true,
                      "checked": notifyBeneficiary,
                    }
                  ],
                  value: [
                    if (notifyBeneficiary)
                      {
                        "label": "Notify Beneficiary",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    notifyBeneficiary = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Allow Recurring Transfers",
                      "value": true,
                      "checked": allowRecurringTransfers,
                    }
                  ],
                  value: [
                    if (allowRecurringTransfers)
                      {
                        "label": "Allow Recurring Transfers",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    allowRecurringTransfers = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Summary",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Name: $beneficiaryName",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "Bank: $bankName",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "Account: $accountNumber",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "Category: ${category.toUpperCase()}",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleNext() async {
    if (currentStep < 3) {
      if (_validateCurrentStep()) {
        currentStep++;
        setState(() {});
      }
    } else {
      // Final step - add beneficiary
      if (formKey.currentState!.validate()) {
        loading = true;
        setState(() {});
        
        // Simulate API call
        await Future.delayed(Duration(seconds: 2));
        
        loading = false;
        setState(() {});
        
        ss("Beneficiary added successfully");
        back();
      }
    }
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        return beneficiaryName.isNotEmpty && relationship.isNotEmpty;
      case 1:
        return accountNumber.isNotEmpty && 
               confirmAccountNumber.isNotEmpty && 
               accountNumber == confirmAccountNumber &&
               bankName.isNotEmpty &&
               routingNumber.isNotEmpty;
      case 2:
        return true; // Contact info is optional
      case 3:
        return true; // Verification step is optional
      default:
        return false;
    }
  }
}
