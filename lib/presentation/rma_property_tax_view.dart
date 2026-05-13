import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPropertyTaxView extends StatefulWidget {
  const RmaPropertyTaxView({super.key});

  @override
  State<RmaPropertyTaxView> createState() => _RmaPropertyTaxViewState();
}

class _RmaPropertyTaxViewState extends State<RmaPropertyTaxView> {
  String selectedYear = "2024";
  String propertyValue = "450000";
  String homesteadExemption = "50000";
  
  List<Map<String, dynamic>> yearOptions = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
    {"label": "2021", "value": "2021"},
    {"label": "2020", "value": "2020"},
  ];
  
  Map<String, dynamic> taxData = {
    "annual_tax": 5850.00,
    "effective_rate": 1.30,
    "millage_rate": 13.0,
    "taxable_value": 400000.00,
    "exemptions": 50000.00,
    "last_assessment": "2024-01-15",
  };
  
  List<Map<String, dynamic>> taxBreakdown = [
    {
      "entity": "County General",
      "rate": 4.25,
      "amount": 1700.00,
      "percentage": 29.1,
    },
    {
      "entity": "School District",
      "rate": 6.15,
      "amount": 2460.00,
      "percentage": 42.1,
    },
    {
      "entity": "City Services",
      "rate": 1.85,
      "amount": 740.00,
      "percentage": 12.6,
    },
    {
      "entity": "Fire District",
      "rate": 0.75,
      "amount": 300.00,
      "percentage": 5.1,
    },
    {
      "entity": "Special Assessments",
      "rate": 0.65,
      "amount": 260.00,
      "percentage": 4.4,
    },
    {
      "entity": "Library District",
      "rate": 0.35,
      "amount": 140.00,
      "percentage": 2.4,
    },
    {
      "entity": "Parks & Recreation",
      "rate": 0.25,
      "amount": 100.00,
      "percentage": 1.7,
    },
    {
      "entity": "Other",
      "rate": 0.75,
      "amount": 150.00,
      "percentage": 2.6,
    },
  ];
  
  List<Map<String, dynamic>> paymentSchedule = [
    {
      "installment": "1st Quarter",
      "due_date": "March 31, 2024",
      "amount": 1462.50,
      "status": "paid",
    },
    {
      "installment": "2nd Quarter", 
      "due_date": "June 30, 2024",
      "amount": 1462.50,
      "status": "paid",
    },
    {
      "installment": "3rd Quarter",
      "due_date": "September 30, 2024",
      "amount": 1462.50,
      "status": "pending",
    },
    {
      "installment": "4th Quarter",
      "due_date": "December 31, 2024",
      "amount": 1462.50,
      "status": "pending",
    },
  ];
  
  List<Map<String, dynamic>> historicalData = [
    {"year": "2024", "tax": 5850.00, "rate": 1.30, "value": 450000},
    {"year": "2023", "tax": 5640.00, "rate": 1.28, "value": 440000},
    {"year": "2022", "tax": 5320.00, "rate": 1.25, "value": 425000},
    {"year": "2021", "tax": 5080.00, "rate": 1.22, "value": 415000},
    {"year": "2020", "tax": 4920.00, "rate": 1.20, "value": 410000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Tax Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              // Navigate to tax calculator
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTaxOverview(),
            _buildTaxCalculator(),
            _buildTaxBreakdown(),
            _buildPaymentSchedule(),
            _buildHistoricalTrends(),
            _buildExemptionsInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildTaxOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Annual Property Tax",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${(taxData["annual_tax"] as double).currency}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Effective Rate: ${(taxData["effective_rate"] as double).toStringAsFixed(2)}%",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(Icons.home, color: Colors.white, size: 24),
                    SizedBox(height: spXs),
                    Text(
                      "Monthly",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "\$${((taxData["annual_tax"] as double) / 12).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaxCalculator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tax Calculator",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Tax Year",
            items: yearOptions,
            value: selectedYear,
            onChanged: (value, label) {
              selectedYear = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Property Value (\$)",
            value: propertyValue,
            onChanged: (value) {
              propertyValue = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Homestead Exemption (\$)",
            value: homesteadExemption,
            onChanged: (value) {
              homesteadExemption = value;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Calculate Tax",
              size: bs.md,
              onPressed: () {
                // Calculate tax based on inputs
                ss("Tax calculated successfully!");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxBreakdown() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tax Breakdown by Entity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...taxBreakdown.map((entity) => _buildTaxEntityCard(entity)),
        ],
      ),
    );
  }

  Widget _buildTaxEntityCard(Map<String, dynamic> entity) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${entity["entity"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Rate: ${(entity["rate"] as double).toStringAsFixed(2)} mills",
                  style: TextStyle(
                    fontSize: 11,
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
                "\$${(entity["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${(entity["percentage"] as double).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSchedule() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Schedule",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...paymentSchedule.map((payment) => _buildPaymentCard(payment)),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment) {
    Color statusColor = payment["status"] == "paid" ? successColor : warningColor;
    IconData statusIcon = payment["status"] == "paid" ? Icons.check_circle : Icons.schedule;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${payment["installment"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Due: ${payment["due_date"]}",
                  style: TextStyle(
                    fontSize: 11,
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
                "\$${(payment["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${payment["status"]}",
                  style: TextStyle(
                    fontSize: 9,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoricalTrends() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Historical Tax Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...historicalData.map((data) => _buildHistoricalCard(data)),
        ],
      ),
    );
  }

  Widget _buildHistoricalCard(Map<String, dynamic> data) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Center(
              child: Text(
                "${data["year"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tax: \$${(data["tax"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Rate: ${(data["rate"] as double).toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$${((data["value"] as int) / 1000).toStringAsFixed(0)}K",
                  style: TextStyle(
                    fontSize: 12,
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

  Widget _buildExemptionsInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available Exemptions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildExemptionItem(
            "Homestead Exemption",
            "Primary residence qualification",
            "\$50,000",
            successColor,
            true,
          ),
          _buildExemptionItem(
            "Senior Citizen Exemption",
            "Age 65+ additional savings",
            "\$25,000",
            infoColor,
            false,
          ),
          _buildExemptionItem(
            "Veteran Exemption",
            "Military service benefits",
            "\$15,000",
            warningColor,
            false,
          ),
          _buildExemptionItem(
            "Disability Exemption",
            "Qualifying disability status",
            "\$20,000",
            secondaryColor,
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildExemptionItem(String title, String description, String amount, Color color, bool isApplied) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(
            isApplied ? Icons.check_circle : Icons.info,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
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
                amount,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              if (isApplied)
                Text(
                  "Applied",
                  style: TextStyle(
                    fontSize: 9,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
