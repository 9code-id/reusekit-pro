import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaTaxCalculatorView extends StatefulWidget {
  const ReaTaxCalculatorView({super.key});

  @override
  State<ReaTaxCalculatorView> createState() => _ReaTaxCalculatorViewState();
}

class _ReaTaxCalculatorViewState extends State<ReaTaxCalculatorView> {
  String selectedPropertyType = "Residential";
  String selectedState = "California";
  String selectedCity = "San Francisco";
  double propertyValue = 750000;
  double assessedValue = 700000;
  double exemptionAmount = 50000;
  bool isOwnerOccupied = true;
  bool isSeniorCitizen = false;
  bool isVeteran = false;
  
  final List<String> propertyTypes = [
    "Residential", "Commercial", "Industrial", "Agricultural", "Vacant Land"
  ];
  
  final List<String> states = [
    "California", "New York", "Texas", "Florida", "Illinois"
  ];
  
  final List<String> cities = [
    "San Francisco", "Los Angeles", "San Diego", "Sacramento"
  ];

  final Map<String, dynamic> taxRates = {
    "California": {
      "San Francisco": {
        "county": 0.75,
        "city": 0.25,
        "school": 0.45,
        "special": 0.15,
        "total": 1.60,
      },
      "Los Angeles": {
        "county": 0.72,
        "city": 0.20,
        "school": 0.38,
        "special": 0.10,
        "total": 1.40,
      },
    },
  };

  final List<Map<String, dynamic>> exemptions = [
    {
      "name": "Homestead Exemption",
      "amount": 50000,
      "description": "Primary residence exemption",
      "eligible": true,
    },
    {
      "name": "Senior Citizen Exemption",
      "amount": 25000,
      "description": "For residents 65 and older",
      "eligible": false,
    },
    {
      "name": "Veteran Exemption",
      "amount": 30000,
      "description": "For qualified veterans",
      "eligible": false,
    },
    {
      "name": "Disability Exemption",
      "amount": 20000,
      "description": "For disabled property owners",
      "eligible": false,
    },
  ];

  final List<Map<String, dynamic>> paymentSchedule = [
    {"quarter": "Q1 2024", "dueDate": "Apr 10, 2024", "amount": 3000, "status": "paid"},
    {"quarter": "Q2 2024", "dueDate": "Jun 10, 2024", "amount": 3000, "status": "paid"},
    {"quarter": "Q3 2024", "dueDate": "Sep 10, 2024", "amount": 3000, "status": "pending"},
    {"quarter": "Q4 2024", "dueDate": "Dec 10, 2024", "amount": 3000, "status": "upcoming"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Calculator"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveCalculation();
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareCalculation();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tax Summary Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(179)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Annual Property Tax",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(217),
                    ),
                  ),
                  
                  Text(
                    "\$${_calculateAnnualTax().toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryItem("Monthly", "\$${(_calculateAnnualTax() / 12).toStringAsFixed(0)}"),
                      ),
                      
                      Expanded(
                        child: _buildSummaryItem("Tax Rate", "${_getTotalTaxRate().toStringAsFixed(2)}%"),
                      ),
                      
                      Expanded(
                        child: _buildSummaryItem("Effective Rate", "${(_calculateAnnualTax() / propertyValue * 100).toStringAsFixed(2)}%"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Property Information
            Text(
              "Property Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Property Type",
                          items: propertyTypes.map((type) => {"label": type, "value": type}).toList(),
                          value: selectedPropertyType,
                          onChanged: (value, label) {
                            selectedPropertyType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      Expanded(
                        child: QDropdownField(
                          label: "State",
                          items: states.map((state) => {"label": state, "value": state}).toList(),
                          value: selectedState,
                          onChanged: (value, label) {
                            selectedState = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  QDropdownField(
                    label: "City",
                    items: cities.map((city) => {"label": city, "value": city}).toList(),
                    value: selectedCity,
                    onChanged: (value, label) {
                      selectedCity = value;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Property Value (\$)",
                          value: propertyValue.toString(),
                          onChanged: (value) {
                            propertyValue = double.tryParse(value) ?? 0;
                            setState(() {});
                          },
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      Expanded(
                        child: QNumberField(
                          label: "Assessed Value (\$)",
                          value: assessedValue.toString(),
                          onChanged: (value) {
                            assessedValue = double.tryParse(value) ?? 0;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Tax Rate Breakdown
            Text(
              "Tax Rate Breakdown",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  _buildTaxRateRow("County Tax", _getCountyRate(), _calculateTaxComponent("county")),
                  _buildTaxRateRow("City Tax", _getCityRate(), _calculateTaxComponent("city")),
                  _buildTaxRateRow("School District", _getSchoolRate(), _calculateTaxComponent("school")),
                  _buildTaxRateRow("Special Assessments", _getSpecialRate(), _calculateTaxComponent("special")),
                  
                  Divider(),
                  
                  Row(
                    children: [
                      Text(
                        "Total Tax Rate",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      Spacer(),
                      
                      Text(
                        "${_getTotalTaxRate().toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(width: spMd),
                      
                      Text(
                        "\$${_calculateAnnualTax().toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Exemptions
            Text(
              "Available Exemptions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Owner Occupied",
                              "value": true,
                              "checked": isOwnerOccupied,
                            }
                          ],
                          value: [if (isOwnerOccupied) {"label": "Owner Occupied", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            isOwnerOccupied = values.isNotEmpty;
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
                        child: QSwitch(
                          items: [
                            {
                              "label": "Senior Citizen (65+)",
                              "value": true,
                              "checked": isSeniorCitizen,
                            }
                          ],
                          value: [if (isSeniorCitizen) {"label": "Senior Citizen (65+)", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            isSeniorCitizen = values.isNotEmpty;
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
                        child: QSwitch(
                          items: [
                            {
                              "label": "Veteran",
                              "value": true,
                              "checked": isVeteran,
                            }
                          ],
                          value: [if (isVeteran) {"label": "Veteran", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            isVeteran = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Divider(),
                  
                  ...exemptions.map((exemption) {
                    final isEligible = _isExemptionEligible(exemption["name"]);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isEligible ? successColor.withAlpha(25) : disabledColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isEligible ? Icons.check_circle : Icons.cancel,
                            color: isEligible ? successColor : disabledColor,
                            size: 20,
                          ),
                          
                          SizedBox(width: spSm),
                          
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${exemption["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isEligible ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                                
                                Text(
                                  "${exemption["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          Text(
                            "\$${(exemption["amount"] as int).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isEligible ? successColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  
                  if (_getTotalExemptions() > 0) ...[
                    Divider(),
                    
                    Row(
                      children: [
                        Text(
                          "Total Exemptions",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        Spacer(),
                        
                        Text(
                          "\$${_getTotalExemptions().toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Payment Schedule
            Text(
              "Payment Schedule",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: paymentSchedule.map((payment) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getPaymentStatusColor(payment["status"]).withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _getPaymentStatusColor(payment["status"]),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getPaymentStatusIcon(payment["status"]),
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${payment["quarter"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              
                              Text(
                                "Due: ${payment["dueDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${(payment["amount"] as int).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getPaymentStatusColor(payment["status"]),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${payment["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Action Buttons
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildActionCard(
                  "Tax History",
                  "View past payments",
                  Icons.history,
                  primaryColor,
                  () => _viewTaxHistory(),
                ),
                
                _buildActionCard(
                  "Appeal Assessment",
                  "Contest property value",
                  Icons.gavel,
                  warningColor,
                  () => _appealAssessment(),
                ),
                
                _buildActionCard(
                  "Pay Online",
                  "Make tax payment",
                  Icons.payment,
                  successColor,
                  () => _payOnline(),
                ),
                
                _buildActionCard(
                  "Download Report",
                  "Get detailed breakdown",
                  Icons.download,
                  infoColor,
                  () => _downloadReport(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(51),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withAlpha(217),
            ),
          ),
          
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxRateRow(String label, double rate, double amount) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          Text(
            "${rate.toStringAsFixed(2)}%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          
          SizedBox(width: spMd),
          
          Text(
            "\$${amount.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateAnnualTax() {
    final taxableValue = assessedValue - _getTotalExemptions();
    return taxableValue * _getTotalTaxRate() / 100;
  }

  double _getTotalTaxRate() {
    final rates = taxRates[selectedState]?[selectedCity];
    if (rates == null) return 1.5;
    return rates["total"] ?? 1.5;
  }

  double _getCountyRate() {
    final rates = taxRates[selectedState]?[selectedCity];
    if (rates == null) return 0.75;
    return rates["county"] ?? 0.75;
  }

  double _getCityRate() {
    final rates = taxRates[selectedState]?[selectedCity];
    if (rates == null) return 0.25;
    return rates["city"] ?? 0.25;
  }

  double _getSchoolRate() {
    final rates = taxRates[selectedState]?[selectedCity];
    if (rates == null) return 0.35;
    return rates["school"] ?? 0.35;
  }

  double _getSpecialRate() {
    final rates = taxRates[selectedState]?[selectedCity];
    if (rates == null) return 0.15;
    return rates["special"] ?? 0.15;
  }

  double _calculateTaxComponent(String component) {
    final taxableValue = assessedValue - _getTotalExemptions();
    final rate = component == "county" ? _getCountyRate() :
                 component == "city" ? _getCityRate() :
                 component == "school" ? _getSchoolRate() :
                 _getSpecialRate();
    return taxableValue * rate / 100;
  }

  bool _isExemptionEligible(String exemptionName) {
    switch (exemptionName) {
      case "Homestead Exemption":
        return isOwnerOccupied;
      case "Senior Citizen Exemption":
        return isSeniorCitizen;
      case "Veteran Exemption":
        return isVeteran;
      default:
        return false;
    }
  }

  double _getTotalExemptions() {
    double total = 0;
    for (var exemption in exemptions) {
      if (_isExemptionEligible(exemption["name"])) {
        total += exemption["amount"];
      }
    }
    return total;
  }

  Color _getPaymentStatusColor(String status) {
    switch (status) {
      case "paid":
        return successColor;
      case "pending":
        return warningColor;
      case "upcoming":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  IconData _getPaymentStatusIcon(String status) {
    switch (status) {
      case "paid":
        return Icons.check_circle;
      case "pending":
        return Icons.schedule;
      case "upcoming":
        return Icons.event;
      default:
        return Icons.help;
    }
  }

  void _saveCalculation() {
    ss("Tax calculation saved successfully");
  }

  void _shareCalculation() {
    ss("Tax calculation shared successfully");
  }

  void _viewTaxHistory() {
    ss("Opening tax history...");
  }

  void _appealAssessment() {
    ss("Opening assessment appeal form...");
  }

  void _payOnline() {
    ss("Redirecting to payment portal...");
  }

  void _downloadReport() {
    ss("Downloading tax report...");
  }
}
