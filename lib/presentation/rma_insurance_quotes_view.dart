import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaInsuranceQuotesView extends StatefulWidget {
  const RmaInsuranceQuotesView({super.key});

  @override
  State<RmaInsuranceQuotesView> createState() => _RmaInsuranceQuotesViewState();
}

class _RmaInsuranceQuotesViewState extends State<RmaInsuranceQuotesView> {
  String selectedCoverage = "standard";
  String selectedDeductible = "1000";
  
  List<Map<String, dynamic>> coverageOptions = [
    {"label": "Basic Coverage", "value": "basic"},
    {"label": "Standard Coverage", "value": "standard"},
    {"label": "Premium Coverage", "value": "premium"},
    {"label": "Comprehensive", "value": "comprehensive"},
  ];
  
  List<Map<String, dynamic>> deductibleOptions = [
    {"label": "\$500", "value": "500"},
    {"label": "\$1,000", "value": "1000"},
    {"label": "\$2,500", "value": "2500"},
    {"label": "\$5,000", "value": "5000"},
  ];
  
  Map<String, dynamic> propertyInfo = {
    "value": 450000,
    "year_built": 1995,
    "sq_footage": 2100,
    "stories": 2,
    "bedrooms": 4,
    "bathrooms": 3,
    "garage": true,
    "pool": false,
    "security_system": true,
  };
  
  List<Map<String, dynamic>> insuranceQuotes = [
    {
      "company": "SafeHome Insurance",
      "rating": 4.8,
      "annual_premium": 1285.00,
      "monthly_premium": 107.08,
      "coverage_amount": 450000,
      "deductible": 1000,
      "personal_property": 337500,
      "liability": 300000,
      "additional_living": 90000,
      "discounts": ["Multi-policy", "Security system"],
      "features": ["24/7 Claims", "Local Agents", "Online Portal"],
      "logo_color": "primary",
    },
    {
      "company": "Guardian Property",
      "rating": 4.6,
      "annual_premium": 1395.00,
      "monthly_premium": 116.25,
      "coverage_amount": 450000,
      "deductible": 1000,
      "personal_property": 360000,
      "liability": 500000,
      "additional_living": 135000,
      "discounts": ["New customer", "Paperless billing"],
      "features": ["Mobile Claims", "Fast Settlements", "Replacement Cost"],
      "logo_color": "secondary",
    },
    {
      "company": "Shield Homeowners",
      "rating": 4.4,
      "annual_premium": 1195.00,
      "monthly_premium": 99.58,
      "coverage_amount": 450000,
      "deductible": 1000,
      "personal_property": 315000,
      "liability": 250000,
      "additional_living": 67500,
      "discounts": ["Loyalty program", "Auto bundle"],
      "features": ["Quick Claims", "24/7 Support", "Local Adjusters"],
      "logo_color": "success",
    },
    {
      "company": "Premier Home Coverage",
      "rating": 4.7,
      "annual_premium": 1450.00,
      "monthly_premium": 120.83,
      "coverage_amount": 450000,
      "deductible": 1000,
      "personal_property": 405000,
      "liability": 1000000,
      "additional_living": 180000,
      "discounts": ["Premium member", "Security system", "Claims-free"],
      "features": ["Concierge Claims", "Guaranteed Replacement", "Premium Support"],
      "logo_color": "warning",
    },
  ];
  
  List<Map<String, dynamic>> coverageTypes = [
    {
      "type": "Dwelling Coverage",
      "description": "Protects the structure of your home",
      "icon": Icons.home,
      "required": true,
    },
    {
      "type": "Personal Property",
      "description": "Covers belongings inside your home",
      "icon": Icons.inventory,
      "required": true,
    },
    {
      "type": "Liability Protection",
      "description": "Protects against lawsuits and injuries",
      "icon": Icons.shield,
      "required": true,
    },
    {
      "type": "Additional Living Expenses",
      "description": "Temporary housing if home is uninhabitable",
      "icon": Icons.hotel,
      "required": false,
    },
    {
      "type": "Medical Payments",
      "description": "Medical bills for injuries on your property",
      "icon": Icons.medical_services,
      "required": false,
    },
  ];
  
  List<Map<String, dynamic>> discountOpportunities = [
    {
      "discount": "Multi-Policy Bundle",
      "description": "Combine home and auto insurance",
      "potential_savings": "10-25%",
      "icon": Icons.merge,
    },
    {
      "discount": "Security System",
      "description": "Monitored security system",
      "potential_savings": "5-15%",
      "icon": Icons.security,
    },
    {
      "discount": "Claims-Free History",
      "description": "No claims in past 3-5 years",
      "potential_savings": "5-10%",
      "icon": Icons.verified,
    },
    {
      "discount": "New Home",
      "description": "Home built within last 10 years",
      "potential_savings": "8-12%",
      "icon": Icons.new_releases,
    },
    {
      "discount": "Loyalty Discount",
      "description": "Long-term customer benefits",
      "potential_savings": "3-8%",
      "icon": Icons.favorite,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insurance Quotes"),
        actions: [
          IconButton(
            icon: Icon(Icons.compare),
            onPressed: () {
              // Compare selected quotes
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
            _buildPropertyOverview(),
            _buildCoverageSelector(),
            _buildInsuranceQuotes(),
            _buildCoverageExplanation(),
            _buildDiscountOpportunities(),
            _buildInsuranceTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyOverview() {
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
            "Property Insurance Overview",
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
                      "\$${((propertyInfo["value"] as int) / 1000).toStringAsFixed(0)}K Value",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Built ${propertyInfo["year_built"]} • ${propertyInfo["sq_footage"]} sq ft",
                      style: TextStyle(
                        fontSize: 12,
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
                    Icon(Icons.security, color: Colors.white, size: 20),
                    SizedBox(height: spXs),
                    Text(
                      "Protected",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "${propertyInfo["security_system"] ? "Yes" : "No"}",
                      style: TextStyle(
                        fontSize: 12,
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

  Widget _buildCoverageSelector() {
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
            "Coverage Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Coverage Level",
                  items: coverageOptions,
                  value: selectedCoverage,
                  onChanged: (value, label) {
                    selectedCoverage = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Deductible",
                  items: deductibleOptions,
                  value: selectedDeductible,
                  onChanged: (value, label) {
                    selectedDeductible = value;
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

  Widget _buildInsuranceQuotes() {
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
            "Insurance Quotes Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...insuranceQuotes.map((quote) => _buildQuoteCard(quote)),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(Map<String, dynamic> quote) {
    Color companyColor = _getCompanyColor(quote["logo_color"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: companyColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: companyColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: companyColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.shield,
                  color: companyColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${quote["company"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < (quote["rating"] as double).floor() ? Icons.star : Icons.star_border,
                              color: warningColor,
                              size: 12,
                            );
                          }),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${quote["rating"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${(quote["annual_premium"] as double).currency}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: companyColor,
                    ),
                  ),
                  Text(
                    "per year",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildCoverageDetail("Dwelling", "\$${((quote["coverage_amount"] as int) / 1000).toStringAsFixed(0)}K"),
              _buildCoverageDetail("Personal Property", "\$${((quote["personal_property"] as int) / 1000).toStringAsFixed(0)}K"),
              _buildCoverageDetail("Liability", "\$${((quote["liability"] as int) / 1000).toStringAsFixed(0)}K"),
              _buildCoverageDetail("Living Expenses", "\$${((quote["additional_living"] as int) / 1000).toStringAsFixed(0)}K"),
            ],
          ),
          
          if ((quote["discounts"] as List).isNotEmpty) ...[
            Text(
              "Available Discounts:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (quote["discounts"] as List).map((discount) => 
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    discount,
                    style: TextStyle(
                      fontSize: 9,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ).toList(),
            ),
          ],
          
          if ((quote["features"] as List).isNotEmpty) ...[
            Text(
              "Key Features:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (quote["features"] as List).map((feature) => 
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: companyColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    feature,
                    style: TextStyle(
                      fontSize: 9,
                      color: companyColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ).toList(),
            ),
          ],
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Get Quote",
                  size: bs.sm,
                  onPressed: () {
                    // Request detailed quote
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: companyColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Compare",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: companyColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCoverageDetail(String label, String amount) {
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: disabledBoldColor,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverageExplanation() {
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
            "Understanding Coverage Types",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...coverageTypes.map((coverage) => _buildCoverageTypeCard(coverage)),
        ],
      ),
    );
  }

  Widget _buildCoverageTypeCard(Map<String, dynamic> coverage) {
    Color cardColor = coverage["required"] ? infoColor : successColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: cardColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: cardColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(coverage["icon"] as IconData, color: cardColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${coverage["type"]}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: cardColor,
                      ),
                    ),
                    if (coverage["required"]) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Required",
                          style: TextStyle(
                            fontSize: 8,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  "${coverage["description"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountOpportunities() {
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
            "Potential Discounts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...discountOpportunities.map((discount) => _buildDiscountCard(discount)),
        ],
      ),
    );
  }

  Widget _buildDiscountCard(Map<String, dynamic> discount) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(discount["icon"] as IconData, color: successColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${discount["discount"]}",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
                Text(
                  "${discount["description"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${discount["potential_savings"]}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsuranceTips() {
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
            "Insurance Shopping Tips",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildTipItem(
            "Compare Coverage Limits",
            "Ensure you're comparing similar coverage amounts and deductibles",
            Icons.compare_arrows,
            infoColor,
          ),
          _buildTipItem(
            "Bundle Policies",
            "Combine home and auto insurance for significant savings",
            Icons.merge,
            successColor,
          ),
          _buildTipItem(
            "Review Annually",
            "Shop for new quotes every year or after major life changes",
            Icons.calendar_today,
            warningColor,
          ),
          _buildTipItem(
            "Check Company Ratings",
            "Research financial stability and customer service ratings",
            Icons.star,
            secondaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String title, String description, IconData icon, Color color) {
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
          Icon(icon, color: color, size: 20),
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
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getCompanyColor(String colorName) {
    switch (colorName) {
      case "primary":
        return primaryColor;
      case "secondary":
        return secondaryColor;
      case "success":
        return successColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      default:
        return primaryColor;
    }
  }
}
