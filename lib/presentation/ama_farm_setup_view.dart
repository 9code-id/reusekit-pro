import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaFarmSetupView extends StatefulWidget {
  const AmaFarmSetupView({super.key});

  @override
  State<AmaFarmSetupView> createState() => _AmaFarmSetupViewState();
}

class _AmaFarmSetupViewState extends State<AmaFarmSetupView> {
  final formKey = GlobalKey<FormState>();
  
  String farmName = "";
  String farmLocation = "";
  String farmSize = "";
  String farmType = "Crop";
  String ownerName = "";
  String phoneNumber = "";
  String email = "";
  bool organicCertified = false;
  String description = "";

  List<Map<String, dynamic>> farmTypeItems = [
    {"label": "Crop Farming", "value": "Crop"},
    {"label": "Livestock", "value": "Livestock"},
    {"label": "Mixed Farming", "value": "Mixed"},
    {"label": "Poultry", "value": "Poultry"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Aquaculture", "value": "Aquaculture"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farm Setup"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Need help? Contact our support team");
            },
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
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.agriculture,
                      color: successColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to Farm Management",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Set up your farm profile to get started with digital agriculture management",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QTextField(
                label: "Farm Name",
                value: farmName,
                validator: Validator.required,
                hint: "Enter your farm name",
                onChanged: (value) {
                  farmName = value;
                  setState(() {});
                },
              ),
              
              QTextField(
                label: "Farm Location",
                value: farmLocation,
                validator: Validator.required,
                hint: "City, State/Province, Country",
                onChanged: (value) {
                  farmLocation = value;
                  setState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Farm Size (Hectares)",
                      value: farmSize,
                      validator: Validator.required,
                      onChanged: (value) {
                        farmSize = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Farm Type",
                      items: farmTypeItems,
                      value: farmType,
                      onChanged: (value, label) {
                        farmType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              Text(
                "Owner Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QTextField(
                label: "Owner Name",
                value: ownerName,
                validator: Validator.required,
                hint: "Full name of farm owner",
                onChanged: (value) {
                  ownerName = value;
                  setState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Phone Number",
                      value: phoneNumber,
                      validator: Validator.required,
                      hint: "+1234567890",
                      onChanged: (value) {
                        phoneNumber = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Email",
                      value: email,
                      validator: Validator.email,
                      hint: "farm@example.com",
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              QSwitch(
                label: "Organic Certification",
                items: [
                  {
                    "label": "Farm has organic certification",
                    "value": true,
                    "checked": organicCertified,
                  }
                ],
                value: [
                  if (organicCertified)
                    {
                      "label": "Farm has organic certification",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  organicCertified = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              QMemoField(
                label: "Farm Description",
                value: description,
                hint: "Describe your farming practices, main crops, or specialties",
                onChanged: (value) {
                  description = value;
                  setState(() {});
                },
              ),
              
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "What's Next?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "After setting up your farm profile:",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "• Register your land parcels and fields",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "• Add crop varieties and planting schedules",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "• Set up monitoring and alert systems",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              QButton(
                label: "Complete Farm Setup",
                size: bs.md,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    showLoading();
                    Future.delayed(Duration(seconds: 2), () {
                      hideLoading();
                      ss("Farm profile created successfully!");
                      // navigateTo(AmaDashboardView());
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
