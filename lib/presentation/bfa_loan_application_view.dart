import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaLoanApplicationView extends StatefulWidget {
  const BfaLoanApplicationView({super.key});

  @override
  State<BfaLoanApplicationView> createState() => _BfaLoanApplicationViewState();
}

class _BfaLoanApplicationViewState extends State<BfaLoanApplicationView> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;
  
  // Personal Information
  String fullName = "";
  String mobileNumber = "";
  String emailAddress = "";
  String dateOfBirth = "";
  String panNumber = "";
  String aadharNumber = "";
  String maritalStatus = "Single";
  
  // Loan Details
  String loanType = "Personal Loan";
  String loanAmount = "";
  String loanTenure = "";
  String loanPurpose = "";
  String monthlyIncome = "";
  String existingLoans = "";
  
  // Employment Details
  String employmentType = "Salaried";
  String companyName = "";
  String designation = "";
  String workExperience = "";
  String officeAddress = "";
  
  // Documents
  String profilePhoto = "";
  String salarySlips = "";
  String bankStatements = "";
  String panCard = "";
  String aadharCard = "";
  String employmentProof = "";
  
  final List<Map<String, dynamic>> loanTypes = [
    {"label": "Personal Loan", "value": "Personal Loan"},
    {"label": "Home Loan", "value": "Home Loan"},
    {"label": "Car Loan", "value": "Car Loan"},
    {"label": "Education Loan", "value": "Education Loan"},
    {"label": "Business Loan", "value": "Business Loan"},
  ];
  
  final List<Map<String, dynamic>> maritalStatusOptions = [
    {"label": "Single", "value": "Single"},
    {"label": "Married", "value": "Married"},
    {"label": "Divorced", "value": "Divorced"},
    {"label": "Widowed", "value": "Widowed"},
  ];
  
  final List<Map<String, dynamic>> employmentTypes = [
    {"label": "Salaried", "value": "Salaried"},
    {"label": "Self Employed", "value": "Self Employed"},
    {"label": "Business Owner", "value": "Business Owner"},
    {"label": "Professional", "value": "Professional"},
  ];
  
  final List<Map<String, dynamic>> tenureOptions = [
    {"label": "12 Months", "value": "12"},
    {"label": "24 Months", "value": "24"},
    {"label": "36 Months", "value": "36"},
    {"label": "48 Months", "value": "48"},
    {"label": "60 Months", "value": "60"},
    {"label": "84 Months", "value": "84"},
    {"label": "120 Months", "value": "120"},
    {"label": "180 Months", "value": "180"},
    {"label": "240 Months", "value": "240"},
  ];

  final List<String> stepTitles = [
    "Personal Information",
    "Loan Details", 
    "Employment Details",
    "Document Upload",
    "Review & Submit"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Application"),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.all(spMd),
            color: primaryColor.withAlpha(20),
            child: Column(
              children: [
                Row(
                  children: List.generate(stepTitles.length, (index) {
                    final isCompleted = index < currentStep;
                    final isCurrent = index == currentStep;
                    final isUpcoming = index > currentStep;
                    
                    return Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isCompleted 
                                  ? successColor
                                  : isCurrent 
                                      ? primaryColor
                                      : disabledColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isCompleted 
                                  ? Icons.check
                                  : Icons.circle,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                          if (index < stepTitles.length - 1)
                            Expanded(
                              child: Container(
                                height: 2,
                                color: index < currentStep 
                                    ? successColor
                                    : disabledOutlineBorderColor,
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(height: spSm),
                Text(
                  stepTitles[currentStep],
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Form Content
          Expanded(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    if (currentStep == 0) _buildPersonalInformation(),
                    if (currentStep == 1) _buildLoanDetails(),
                    if (currentStep == 2) _buildEmploymentDetails(),
                    if (currentStep == 3) _buildDocumentUpload(),
                    if (currentStep == 4) _buildReviewSubmit(),
                  ],
                ),
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
                      color: disabledBoldColor,
                      size: bs.md,
                      onPressed: () {
                        currentStep--;
                        setState(() {});
                      },
                    ),
                  ),
                if (currentStep > 0) SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: currentStep == stepTitles.length - 1 ? "Submit Application" : "Next",
                    size: bs.md,
                    onPressed: () {
                      if (currentStep == stepTitles.length - 1) {
                        _submitApplication();
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

  Widget _buildPersonalInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Personal Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              QTextField(
                label: "Full Name",
                value: fullName,
                validator: Validator.required,
                onChanged: (value) {
                  fullName = value;
                  setState(() {});
                },
              ),
              QNumberField(
                label: "Mobile Number",
                value: mobileNumber,
                validator: Validator.required,
                onChanged: (value) {
                  mobileNumber = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Email Address",
                value: emailAddress,
                validator: Validator.email,
                onChanged: (value) {
                  emailAddress = value;
                  setState(() {});
                },
              ),
              QDatePicker(
                label: "Date of Birth",
                value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now(),
                onChanged: (value) {
                  dateOfBirth = value.toString();
                  setState(() {});
                },
              ),
              QTextField(
                label: "PAN Number",
                value: panNumber,
                validator: Validator.required,
                onChanged: (value) {
                  panNumber = value;
                  setState(() {});
                },
              ),
              QNumberField(
                label: "Aadhar Number",
                value: aadharNumber,
                validator: Validator.required,
                onChanged: (value) {
                  aadharNumber = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Marital Status",
                items: maritalStatusOptions,
                value: maritalStatus,
                onChanged: (value, label) {
                  maritalStatus = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoanDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Loan Details",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              QDropdownField(
                label: "Loan Type",
                items: loanTypes,
                value: loanType,
                onChanged: (value, label) {
                  loanType = value;
                  setState(() {});
                },
              ),
              QNumberField(
                label: "Loan Amount (₹)",
                value: loanAmount,
                validator: Validator.required,
                onChanged: (value) {
                  loanAmount = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Loan Tenure",
                items: tenureOptions,
                value: loanTenure,
                onChanged: (value, label) {
                  loanTenure = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Loan Purpose",
                value: loanPurpose,
                validator: Validator.required,
                onChanged: (value) {
                  loanPurpose = value;
                  setState(() {});
                },
              ),
              QNumberField(
                label: "Monthly Income (₹)",
                value: monthlyIncome,
                validator: Validator.required,
                onChanged: (value) {
                  monthlyIncome = value;
                  setState(() {});
                },
              ),
              QNumberField(
                label: "Existing Loan EMIs (₹)",
                value: existingLoans,
                hint: "Enter 0 if no existing loans",
                onChanged: (value) {
                  existingLoans = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmploymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Employment Details",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              QDropdownField(
                label: "Employment Type",
                items: employmentTypes,
                value: employmentType,
                onChanged: (value, label) {
                  employmentType = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Company/Organization Name",
                value: companyName,
                validator: Validator.required,
                onChanged: (value) {
                  companyName = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Designation",
                value: designation,
                validator: Validator.required,
                onChanged: (value) {
                  designation = value;
                  setState(() {});
                },
              ),
              QNumberField(
                label: "Work Experience (Years)",
                value: workExperience,
                validator: Validator.required,
                onChanged: (value) {
                  workExperience = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Office Address",
                value: officeAddress,
                validator: Validator.required,
                onChanged: (value) {
                  officeAddress = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Document Upload",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          "Upload clear photos or scans of required documents",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 14,
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              QImagePicker(
                label: "Profile Photo",
                value: profilePhoto,
                validator: Validator.required,
                onChanged: (value) {
                  profilePhoto = value;
                  setState(() {});
                },
              ),
              QImagePicker(
                label: "Latest 3 Months Salary Slips",
                value: salarySlips,
                validator: Validator.required,
                onChanged: (value) {
                  salarySlips = value;
                  setState(() {});
                },
              ),
              QImagePicker(
                label: "Bank Statements (6 Months)",
                value: bankStatements,
                validator: Validator.required,
                onChanged: (value) {
                  bankStatements = value;
                  setState(() {});
                },
              ),
              QImagePicker(
                label: "PAN Card",
                value: panCard,
                validator: Validator.required,
                onChanged: (value) {
                  panCard = value;
                  setState(() {});
                },
              ),
              QImagePicker(
                label: "Aadhar Card",
                value: aadharCard,
                validator: Validator.required,
                onChanged: (value) {
                  aadharCard = value;
                  setState(() {});
                },
              ),
              QImagePicker(
                label: "Employment Proof/Office ID",
                value: employmentProof,
                validator: Validator.required,
                onChanged: (value) {
                  employmentProof = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: warningColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Ensure all documents are clear and readable. Invalid documents may delay your application processing.",
                  style: TextStyle(
                    color: warningColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSubmit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Review & Submit",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          "Please review your application details before submitting",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 14,
          ),
        ),
        SizedBox(height: spMd),
        
        // Personal Information Summary
        _buildSummarySection(
          "Personal Information",
          [
            {"label": "Full Name", "value": fullName},
            {"label": "Mobile", "value": mobileNumber},
            {"label": "Email", "value": emailAddress},
            {"label": "PAN", "value": panNumber},
            {"label": "Marital Status", "value": maritalStatus},
          ],
        ),
        SizedBox(height: spMd),
        
        // Loan Details Summary
        _buildSummarySection(
          "Loan Details",
          [
            {"label": "Loan Type", "value": loanType},
            {"label": "Loan Amount", "value": "₹$loanAmount"},
            {"label": "Tenure", "value": "$loanTenure months"},
            {"label": "Monthly Income", "value": "₹$monthlyIncome"},
            {"label": "Purpose", "value": loanPurpose},
          ],
        ),
        SizedBox(height: spMd),
        
        // Employment Summary
        _buildSummarySection(
          "Employment Details",
          [
            {"label": "Employment Type", "value": employmentType},
            {"label": "Company", "value": companyName},
            {"label": "Designation", "value": designation},
            {"label": "Experience", "value": "$workExperience years"},
          ],
        ),
        SizedBox(height: spMd),
        
        // Terms and Conditions
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: primaryColor.withAlpha(50)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.verified_user,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "• I hereby confirm that all information provided is true and accurate\n"
                "• I authorize the bank to verify my details and credit history\n"
                "• I understand that false information may result in rejection\n"
                "• I agree to the bank's terms and conditions for loan processing",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection(String title, List<Map<String, String>> items) {
    return Container(
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...items.map((item) {
            return Padding(
              padding: EdgeInsets.only(bottom: spXs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "${item["label"]}:",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "${item["value"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  bool _validateCurrentStep() {
    return formKey.currentState!.validate();
  }

  void _submitApplication() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      
      // Show success message
      ss("Loan application submitted successfully! You will receive an update within 24 hours.");
      
      // Navigate back or to status page
      // ss('Next page'));
    }
  }
}
