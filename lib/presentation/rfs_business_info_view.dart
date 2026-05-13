import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsBusinessInfoView extends StatefulWidget {
  const RfsBusinessInfoView({super.key});

  @override
  State<RfsBusinessInfoView> createState() => _RfsBusinessInfoViewState();
}

class _RfsBusinessInfoViewState extends State<RfsBusinessInfoView> {
  final formKey = GlobalKey<FormState>();
  String businessName = "";
  String businessType = "";
  String taxId = "";
  String licenseNumber = "";
  String selectedPaymentMethod = "";
  bool acceptsCash = true;
  bool acceptsCard = true;
  bool acceptsDigital = false;
  String businessOwner = "";
  String ownerEmail = "";
  String ownerPhone = "";
  String businessBank = "";
  String accountNumber = "";
  String routingNumber = "";
  bool loading = false;

  List<Map<String, dynamic>> businessTypes = [
    {"label": "Sole Proprietorship", "value": "Sole Proprietorship"},
    {"label": "Partnership", "value": "Partnership"},
    {"label": "LLC", "value": "LLC"},
    {"label": "Corporation", "value": "Corporation"},
    {"label": "S Corporation", "value": "S Corporation"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {"label": "Stripe", "value": "Stripe"},
    {"label": "Square", "value": "Square"},
    {"label": "PayPal", "value": "PayPal"},
    {"label": "Toast", "value": "Toast"},
    {"label": "Clover", "value": "Clover"},
    {"label": "Other", "value": "Other"},
  ];

  void _handleNext() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      loading = false;
      setState(() {});
      
      ss("Business information saved successfully!");
      // Navigate to operating hours setup
      //navigateTo(RfsOperatingHoursView());
    }
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          _buildStepItem("1", "Restaurant", false, true),
          Expanded(child: Container(height: 2, color: successColor)),
          _buildStepItem("2", "Location", false, true),
          Expanded(child: Container(height: 2, color: successColor)),
          _buildStepItem("3", "Business", true, false),
          Expanded(child: Container(height: 2, color: disabledColor)),
          _buildStepItem("4", "Hours", false, false),
        ],
      ),
    );
  }

  Widget _buildStepItem(String number, String label, bool isActive, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : (isCompleted ? successColor : disabledColor),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    number,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? primaryColor : disabledBoldColor,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Information"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step Indicator
              _buildStepIndicator(),
              
              SizedBox(height: spLg),
              
              // Header
              Text(
                "Business & Legal Information",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "This information is required for payments and compliance",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Business Details Section
              Container(
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
                    
                    Column(
                      spacing: spMd,
                      children: [
                        QTextField(
                          label: "Legal Business Name",
                          value: businessName,
                          validator: Validator.required,
                          onChanged: (value) {
                            businessName = value;
                            setState(() {});
                          },
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
                          children: [
                            Expanded(
                              child: QTextField(
                                label: "Tax ID / EIN",
                                value: taxId,
                                validator: Validator.required,
                                onChanged: (value) {
                                  taxId = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "Business License #",
                                value: licenseNumber,
                                onChanged: (value) {
                                  licenseNumber = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Owner Information Section
              Container(
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
                      "Business Owner Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Column(
                      spacing: spMd,
                      children: [
                        QTextField(
                          label: "Owner Full Name",
                          value: businessOwner,
                          validator: Validator.required,
                          onChanged: (value) {
                            businessOwner = value;
                            setState(() {});
                          },
                        ),
                        
                        Row(
                          children: [
                            Expanded(
                              child: QTextField(
                                label: "Owner Email",
                                value: ownerEmail,
                                validator: Validator.email,
                                onChanged: (value) {
                                  ownerEmail = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "Owner Phone",
                                value: ownerPhone,
                                validator: Validator.required,
                                onChanged: (value) {
                                  ownerPhone = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Payment Processing Section
              Container(
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
                      "Payment Processing",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Column(
                      spacing: spMd,
                      children: [
                        QDropdownField(
                          label: "Payment Processor",
                          items: paymentMethods,
                          value: selectedPaymentMethod,
                          onChanged: (value, label) {
                            selectedPaymentMethod = value;
                            setState(() {});
                          },
                        ),
                        
                        Text(
                          "Accepted Payment Methods",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        
                        Column(
                          spacing: spSm,
                          children: [
                            QSwitch(
                              items: [
                                {
                                  "label": "Cash payments",
                                  "value": "cash",
                                  "checked": acceptsCash,
                                }
                              ],
                              value: [
                                if (acceptsCash)
                                  {
                                    "label": "Cash payments",
                                    "value": "cash",
                                    "checked": true
                                  }
                              ],
                              onChanged: (values, ids) {
                                acceptsCash = values.any((v) => v["value"] == "cash");
                                setState(() {});
                              },
                            ),
                            
                            QSwitch(
                              items: [
                                {
                                  "label": "Credit/Debit cards",
                                  "value": "card",
                                  "checked": acceptsCard,
                                }
                              ],
                              value: [
                                if (acceptsCard)
                                  {
                                    "label": "Credit/Debit cards",
                                    "value": "card",
                                    "checked": true
                                  }
                              ],
                              onChanged: (values, ids) {
                                acceptsCard = values.any((v) => v["value"] == "card");
                                setState(() {});
                              },
                            ),
                            
                            QSwitch(
                              items: [
                                {
                                  "label": "Digital wallets (Apple Pay, Google Pay)",
                                  "value": "digital",
                                  "checked": acceptsDigital,
                                }
                              ],
                              value: [
                                if (acceptsDigital)
                                  {
                                    "label": "Digital wallets (Apple Pay, Google Pay)",
                                    "value": "digital",
                                    "checked": true
                                  }
                              ],
                              onChanged: (values, ids) {
                                acceptsDigital = values.any((v) => v["value"] == "digital");
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Banking Information Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Banking Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.security,
                          size: 16,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Secure",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    Column(
                      spacing: spMd,
                      children: [
                        QTextField(
                          label: "Bank Name",
                          value: businessBank,
                          validator: Validator.required,
                          onChanged: (value) {
                            businessBank = value;
                            setState(() {});
                          },
                        ),
                        
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
                              child: QTextField(
                                label: "Routing Number",
                                value: routingNumber,
                                validator: Validator.required,
                                onChanged: (value) {
                                  routingNumber = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Security Notice
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: infoColor.withAlpha(30),
                    width: 1,
                  ),
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
                        "All sensitive information is encrypted and stored securely. We comply with PCI DSS standards for payment processing.",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Next Button
              Container(
                width: double.infinity,
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : QButton(
                        label: "Continue to Operating Hours",
                        size: bs.md,
                        onPressed: _handleNext,
                      ),
              ),
              
              SizedBox(height: spMd),
              
              // Back Button
              Center(
                child: GestureDetector(
                  onTap: () {
                    back();
                  },
                  child: Text(
                    "Go Back",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
