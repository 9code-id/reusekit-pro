import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaIncomeVerificationView extends StatefulWidget {
  const ReaIncomeVerificationView({super.key});

  @override
  State<ReaIncomeVerificationView> createState() => _ReaIncomeVerificationViewState();
}

class _ReaIncomeVerificationViewState extends State<ReaIncomeVerificationView> {
  String employmentType = "employed";
  String employerName = "";
  String jobTitle = "";
  String monthlyIncome = "";
  String workExperience = "";
  String employerAddress = "";
  String employerPhone = "";
  String selectedIncomeProof = "salary_slip";
  String verificationStatus = "pending";
  bool isProcessing = false;

  List<String> uploadedDocuments = [];
  
  List<Map<String, dynamic>> employmentTypes = [
    {
      "value": "employed",
      "label": "Employed",
      "icon": Icons.business,
      "description": "Full-time or part-time employee",
    },
    {
      "value": "self_employed",
      "label": "Self Employed",
      "icon": Icons.person_outline,
      "description": "Business owner or freelancer",
    },
    {
      "value": "retired",
      "label": "Retired",
      "icon": Icons.elderly,
      "description": "Receiving pension or retirement benefits",
    },
    {
      "value": "unemployed",
      "label": "Unemployed",
      "icon": Icons.work_off,
      "description": "Currently not employed",
    },
  ];

  List<Map<String, dynamic>> incomeProofTypes = [
    {
      "value": "salary_slip",
      "label": "Salary Slips",
      "description": "Last 3 months salary slips",
      "icon": Icons.receipt_long,
    },
    {
      "value": "bank_statement",
      "label": "Bank Statements",
      "description": "Last 6 months bank statements",
      "icon": Icons.account_balance,
    },
    {
      "value": "tax_return",
      "label": "Tax Returns",
      "description": "Last year's tax return documents",
      "icon": Icons.description,
    },
    {
      "value": "employment_letter",
      "label": "Employment Letter",
      "description": "Official letter from employer",
      "icon": Icons.work,
    },
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Income Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              _buildStatusCard(),
              _buildEmploymentTypeSelection(),
              if (employmentType == "employed") _buildEmploymentDetails(),
              if (employmentType == "self_employed") _buildSelfEmploymentDetails(),
              if (employmentType == "retired") _buildRetirementDetails(),
              _buildIncomeDetails(),
              _buildIncomeProofSelection(),
              _buildDocumentUpload(),
              _buildVerificationTips(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    Color statusColor = _getStatusColor();
    IconData statusIcon = _getStatusIcon();
    String statusText = _getStatusText();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: statusColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            statusIcon,
            color: statusColor,
            size: 24,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Income Verification Status",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  statusText,
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
    );
  }

  Widget _buildEmploymentTypeSelection() {
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
            "Employment Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: employmentTypes.map((empType) {
              return _buildEmploymentTypeItem(empType);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmploymentTypeItem(Map<String, dynamic> empType) {
    bool isSelected = employmentType == empType["value"];

    return GestureDetector(
      onTap: () {
        setState(() {
          employmentType = empType["value"];
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                empType["icon"],
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    empType["label"],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    empType["description"],
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: primaryColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmploymentDetails() {
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
            "Employment Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Employer Name",
            value: employerName,
            hint: "Enter your company name",
            validator: Validator.required,
            onChanged: (value) {
              employerName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Job Title",
            value: jobTitle,
            hint: "Enter your job position",
            validator: Validator.required,
            onChanged: (value) {
              jobTitle = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Work Experience",
            value: workExperience,
            hint: "e.g., 3 years 6 months",
            validator: Validator.required,
            onChanged: (value) {
              workExperience = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Employer Address",
            value: employerAddress,
            hint: "Enter company address",
            validator: Validator.required,
            onChanged: (value) {
              employerAddress = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Employer Phone",
            value: employerPhone,
            hint: "Enter company phone number",
            validator: Validator.required,
            onChanged: (value) {
              employerPhone = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSelfEmploymentDetails() {
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
            "Business Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Business Name",
            value: employerName,
            hint: "Enter your business name",
            validator: Validator.required,
            onChanged: (value) {
              employerName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Business Type",
            value: jobTitle,
            hint: "e.g., Consulting, Retail, Services",
            validator: Validator.required,
            onChanged: (value) {
              jobTitle = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Years in Business",
            value: workExperience,
            hint: "e.g., 5 years",
            validator: Validator.required,
            onChanged: (value) {
              workExperience = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Business Address",
            value: employerAddress,
            hint: "Enter business address",
            validator: Validator.required,
            onChanged: (value) {
              employerAddress = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRetirementDetails() {
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
            "Retirement Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Previous Employer",
            value: employerName,
            hint: "Enter your last employer",
            validator: Validator.required,
            onChanged: (value) {
              employerName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Pension Provider",
            value: jobTitle,
            hint: "Enter pension fund/provider name",
            validator: Validator.required,
            onChanged: (value) {
              jobTitle = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Years of Service",
            value: workExperience,
            hint: "Total working years",
            validator: Validator.required,
            onChanged: (value) {
              workExperience = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeDetails() {
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
            "Income Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QNumberField(
            label: employmentType == "retired" ? "Monthly Pension (\$)" : "Monthly Income (\$)",
            value: monthlyIncome,
            hint: "Enter your monthly income",
            validator: Validator.required,
            onChanged: (value) {
              monthlyIncome = value;
              setState(() {});
            },
          ),
          if (monthlyIncome.isNotEmpty) ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: infoColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calculate,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Income Summary",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Monthly Income:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(double.tryParse(monthlyIncome) ?? 0).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Annual Income:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${((double.tryParse(monthlyIncome) ?? 0) * 12).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIncomeProofSelection() {
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
            "Income Proof Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: incomeProofTypes.map((proofType) {
              return _buildIncomeProofItem(proofType);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeProofItem(Map<String, dynamic> proofType) {
    bool isSelected = selectedIncomeProof == proofType["value"];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIncomeProof = proofType["value"];
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              proofType["icon"],
              color: isSelected ? primaryColor : disabledBoldColor,
              size: 24,
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    proofType["label"],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    proofType["description"],
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: primaryColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentUpload() {
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
            "Upload Documents",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          GestureDetector(
            onTap: _uploadDocument,
            child: Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: disabledOutlineBorderColor,
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.cloud_upload,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Upload Income Documents",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "PDF, JPG, PNG (max 10MB each)",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (uploadedDocuments.isNotEmpty) ...[
            SizedBox(height: spMd),
            Column(
              children: uploadedDocuments.map((doc) {
                return _buildUploadedDocumentItem(doc);
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUploadedDocumentItem(String documentName) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: successColor.withAlpha(30),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.description,
            color: successColor,
            size: 20,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Text(
              documentName,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                uploadedDocuments.remove(documentName);
              });
            },
            child: Icon(
              Icons.close,
              color: dangerColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationTips() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: warningColor.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Verification Tips",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildTipItem("Ensure all documents are clear and readable"),
          _buildTipItem("Documents should be recent (within last 3 months)"),
          _buildTipItem("Include all pages of multi-page documents"),
          _buildTipItem("Personal information should match your profile"),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: warningColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    bool canSubmit = monthlyIncome.isNotEmpty && 
                    uploadedDocuments.isNotEmpty &&
                    (employmentType == "unemployed" || 
                     (employerName.isNotEmpty && jobTitle.isNotEmpty));

    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: isProcessing ? "Processing..." : "Submit Income Verification",
            onPressed: canSubmit && !isProcessing ? _submitVerification : null,
          ),
        ),
        Text(
          "Verification typically takes 1-2 business days",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (verificationStatus) {
      case "verified":
        return successColor;
      case "processing":
        return warningColor;
      case "rejected":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  IconData _getStatusIcon() {
    switch (verificationStatus) {
      case "verified":
        return Icons.verified;
      case "processing":
        return Icons.hourglass_empty;
      case "rejected":
        return Icons.error;
      default:
        return Icons.info;
    }
  }

  String _getStatusText() {
    switch (verificationStatus) {
      case "verified":
        return "Your income has been successfully verified";
      case "processing":
        return "Your income verification is being processed";
      case "rejected":
        return "Income verification was rejected. Please resubmit";
      default:
        return "Complete the form below to verify your income";
    }
  }

  void _uploadDocument() async {
    String docName = "income_document_${uploadedDocuments.length + 1}.pdf";
    setState(() {
      uploadedDocuments.add(docName);
    });
    ss("Document uploaded successfully");
  }

  void _submitVerification() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isProcessing = true;
        verificationStatus = "processing";
      });

      showLoading();
      await Future.delayed(Duration(seconds: 3));
      hideLoading();

      setState(() {
        isProcessing = false;
        verificationStatus = "verified";
      });

      ss("Income verification submitted successfully!");
      back();
    }
  }
}
