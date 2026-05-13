import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaRegistrationFeesView extends StatefulWidget {
  const ReaRegistrationFeesView({super.key});

  @override
  State<ReaRegistrationFeesView> createState() => _ReaRegistrationFeesViewState();
}

class _ReaRegistrationFeesViewState extends State<ReaRegistrationFeesView> {
  final formKey = GlobalKey<FormState>();
  
  String propertyValue = "";
  String propertyType = "Residential";
  String state = "New York";
  String mortgageAmount = "";
  bool hasLegalRepresentation = false;
  bool requiresInspection = true;
  bool isFirstTimeBuyer = false;
  
  List<Map<String, dynamic>> propertyTypes = [
    {"label": "Residential", "value": "Residential"},
    {"label": "Commercial", "value": "Commercial"},
    {"label": "Condominium", "value": "Condominium"},
    {"label": "Land Only", "value": "Land"},
    {"label": "Multi-family", "value": "Multi-family"},
  ];
  
  List<Map<String, dynamic>> states = [
    {"label": "New York", "value": "New York"},
    {"label": "California", "value": "California"},
    {"label": "Texas", "value": "Texas"},
    {"label": "Florida", "value": "Florida"},
    {"label": "Illinois", "value": "Illinois"},
  ];

  Map<String, dynamic> calculateFees() {
    double propValue = double.tryParse(propertyValue) ?? 0;
    double mortgage = double.tryParse(mortgageAmount) ?? 0;
    
    if (propValue <= 0) return {};
    
    // Recording Fee (varies by state)
    double recordingFee = 150;
    if (state == "California") recordingFee = 225;
    if (state == "New York") recordingFee = 300;
    
    // Transfer Tax (percentage of property value)
    double transferTaxRate = 0.005; // 0.5%
    if (state == "New York") transferTaxRate = 0.008;
    if (state == "California") transferTaxRate = 0.0055;
    
    double transferTax = propValue * transferTaxRate;
    
    // Stamp Duty (varies by property type and state)
    double stampDutyRate = 0.003;
    if (propertyType == "Commercial") stampDutyRate = 0.005;
    if (state == "New York") stampDutyRate += 0.001;
    
    double stampDuty = propValue * stampDutyRate;
    
    // Registration Fee (base fee + percentage)
    double registrationBaseFee = 200;
    double registrationPercentage = propValue * 0.001;
    double registrationFee = registrationBaseFee + registrationPercentage;
    
    // Title Search Fee
    double titleSearchFee = 350;
    if (propValue > 500000) titleSearchFee = 500;
    if (propertyType == "Commercial") titleSearchFee += 200;
    
    // Legal Documentation Fee
    double legalDocFee = hasLegalRepresentation ? 800 : 400;
    
    // Inspection Fee
    double inspectionFee = requiresInspection ? 300 : 0;
    if (propertyType == "Commercial" && requiresInspection) inspectionFee = 600;
    
    // Mortgage Registration Fee
    double mortgageRegFee = mortgage > 0 ? 100 + (mortgage * 0.001) : 0;
    
    // First-time buyer discount
    double discount = 0;
    if (isFirstTimeBuyer) {
      discount = (transferTax + stampDuty) * 0.1; // 10% discount on transfer tax and stamp duty
    }
    
    double totalFees = recordingFee + transferTax + stampDuty + registrationFee + 
                      titleSearchFee + legalDocFee + inspectionFee + mortgageRegFee - discount;
    
    return {
      "recordingFee": recordingFee,
      "transferTax": transferTax,
      "stampDuty": stampDuty,
      "registrationFee": registrationFee,
      "titleSearchFee": titleSearchFee,
      "legalDocFee": legalDocFee,
      "inspectionFee": inspectionFee,
      "mortgageRegFee": mortgageRegFee,
      "discount": discount,
      "totalFees": totalFees,
    };
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> fees = calculateFees();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration Fees"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              si("Registration fees vary by state and property type. Contact a real estate attorney for precise calculations.");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.assignment,
                        color: primaryColor,
                        size: 32,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Property Registration Calculator",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Calculate all fees required for property registration",
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
              
              // Property Information
              Text(
                "Property Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              QNumberField(
                label: "Property Value (\$)",
                value: propertyValue,
                validator: Validator.required,
                onChanged: (value) {
                  propertyValue = value;
                  setState(() {});
                },
              ),
              
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Property Type",
                      items: propertyTypes,
                      value: propertyType,
                      onChanged: (value, label) {
                        propertyType = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QDropdownField(
                      label: "State",
                      items: states,
                      value: state,
                      onChanged: (value, label) {
                        state = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              QNumberField(
                label: "Mortgage Amount (\$)",
                value: mortgageAmount,
                hint: "Enter 0 if paying cash",
                onChanged: (value) {
                  mortgageAmount = value;
                  setState(() {});
                },
              ),
              
              // Additional Options
              Text(
                "Additional Services",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "Legal representation required",
                    "value": true,
                    "checked": hasLegalRepresentation,
                  }
                ],
                value: [
                  if (hasLegalRepresentation)
                    {
                      "label": "Legal representation required",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  hasLegalRepresentation = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "Property inspection required",
                    "value": true,
                    "checked": requiresInspection,
                  }
                ],
                value: [
                  if (requiresInspection)
                    {
                      "label": "Property inspection required",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  requiresInspection = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "First-time buyer (eligible for discounts)",
                    "value": true,
                    "checked": isFirstTimeBuyer,
                  }
                ],
                value: [
                  if (isFirstTimeBuyer)
                    {
                      "label": "First-time buyer (eligible for discounts)",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  isFirstTimeBuyer = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              // Fee Breakdown
              if (fees.isNotEmpty) ...[
                Text(
                  "Fee Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                // Recording Fee
                _buildFeeItem(
                  "Recording Fee",
                  "Government fee for recording the deed",
                  fees["recordingFee"],
                  Icons.folder,
                  primaryColor,
                ),
                
                // Transfer Tax
                _buildFeeItem(
                  "Transfer Tax",
                  "State tax on property transfer",
                  fees["transferTax"],
                  Icons.account_balance,
                  warningColor,
                ),
                
                // Stamp Duty
                _buildFeeItem(
                  "Stamp Duty",
                  "Legal document validation fee",
                  fees["stampDuty"],
                  Icons.verified,
                  infoColor,
                ),
                
                // Registration Fee
                _buildFeeItem(
                  "Registration Fee",
                  "Property registration processing",
                  fees["registrationFee"],
                  Icons.app_registration,
                  successColor,
                ),
                
                // Title Search Fee
                _buildFeeItem(
                  "Title Search Fee",
                  "Property title verification",
                  fees["titleSearchFee"],
                  Icons.search,
                  primaryColor,
                ),
                
                // Legal Documentation Fee
                if (fees["legalDocFee"] > 0)
                  _buildFeeItem(
                    "Legal Documentation",
                    hasLegalRepresentation ? "Attorney services" : "Basic legal docs",
                    fees["legalDocFee"],
                    Icons.gavel,
                    warningColor,
                  ),
                
                // Inspection Fee
                if (fees["inspectionFee"] > 0)
                  _buildFeeItem(
                    "Property Inspection",
                    "Professional property inspection",
                    fees["inspectionFee"],
                    Icons.home_repair_service,
                    infoColor,
                  ),
                
                // Mortgage Registration Fee
                if (fees["mortgageRegFee"] > 0)
                  _buildFeeItem(
                    "Mortgage Registration",
                    "Mortgage document registration",
                    fees["mortgageRegFee"],
                    Icons.description,
                    successColor,
                  ),
                
                // First-time buyer discount
                if (fees["discount"] > 0)
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(30)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.discount,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "First-time Buyer Discount",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "10% off transfer tax and stamp duty",
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "-\$${(fees["discount"]).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                
                // Total Fees
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: primaryColor.withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.calculate,
                          color: primaryColor,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Registration Fees",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "All fees required for property registration",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${(fees["totalFees"]).currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                        label: "Save Calculation",
                        size: bs.md,
                        onPressed: () {
                          ss("Fee calculation saved");
                        },
                      ),
                    ),
                    QButton(
                      icon: Icons.share,
                      size: bs.md,
                      onPressed: () {
                        ss("Fee breakdown shared");
                      },
                    ),
                    QButton(
                      icon: Icons.print,
                      size: bs.md,
                      onPressed: () {
                        ss("Fee breakdown printed");
                      },
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeeItem(String title, String description, double amount, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${amount.currency}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
