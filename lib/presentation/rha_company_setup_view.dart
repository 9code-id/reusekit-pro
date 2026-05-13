import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaCompanySetupView extends StatefulWidget {
  const RhaCompanySetupView({super.key});

  @override
  State<RhaCompanySetupView> createState() => _RhaCompanySetupViewState();
}

class _RhaCompanySetupViewState extends State<RhaCompanySetupView> {
  final formKey = GlobalKey<FormState>();
  String companyName = "";
  String industry = "";
  String companySize = "";
  String website = "";
  String address = "";
  String companyLogo = "";
  bool loading = false;
  int currentStep = 0;

  List<Map<String, dynamic>> industryOptions = [
    {"label": "Technology", "value": "technology"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Finance", "value": "finance"},
    {"label": "Education", "value": "education"},
    {"label": "Manufacturing", "value": "manufacturing"},
    {"label": "Retail", "value": "retail"},
    {"label": "Consulting", "value": "consulting"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> sizeOptions = [
    {"label": "1-10 employees", "value": "1-10"},
    {"label": "11-50 employees", "value": "11-50"},
    {"label": "51-200 employees", "value": "51-200"},
    {"label": "201-500 employees", "value": "201-500"},
    {"label": "500+ employees", "value": "500+"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Setup"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.business,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Setup Your Company Profile",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Let's get your organization set up in our HR system. This information will help us personalize your experience.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  // Progress Indicator
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Step 1 of 2 - Company Information",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Company Logo Upload
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Company Logo",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  QImagePicker(
                    label: "Upload Company Logo",
                    value: companyLogo,
                    hint: "Choose your company logo",
                    onChanged: (value) {
                      companyLogo = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Company Details Form
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Company Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Company Name",
                      value: companyName,
                      hint: "Enter your company name",
                      validator: Validator.required,
                      onChanged: (value) {
                        companyName = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Industry",
                      items: industryOptions,
                      value: industry,
                      onChanged: (value, label) {
                        industry = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Company Size",
                      items: sizeOptions,
                      value: companySize,
                      onChanged: (value, label) {
                        companySize = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Website",
                      value: website,
                      hint: "https://www.company.com",
                      onChanged: (value) {
                        website = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Company Address",
                      value: address,
                      hint: "Enter complete company address",
                      validator: Validator.required,
                      onChanged: (value) {
                        address = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Features Preview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: successColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "What's Next?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "After setup, you'll have access to:\n• Employee management dashboard\n• Recruitment and hiring tools\n• HR analytics and reports\n• Performance tracking\n• Payroll integration",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Skip for Now",
                    size: bs.md,
                    color: disabledBoldColor,
                    onPressed: () {
                      // ss('Next page'));
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: loading ? "Saving..." : "Continue",
                    size: bs.md,
                    onPressed: loading ? null : _saveCompanyInfo,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveCompanyInfo() async {
    if (!formKey.currentState!.validate()) return;

    if (companyName.isEmpty) {
      se("Company name is required");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Company profile saved successfully!");
    // ss('Next page'));
  }
}
