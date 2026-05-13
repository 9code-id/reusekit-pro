import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPropertyInsuranceView extends StatefulWidget {
  const ReaPropertyInsuranceView({super.key});

  @override
  State<ReaPropertyInsuranceView> createState() => _ReaPropertyInsuranceViewState();
}

class _ReaPropertyInsuranceViewState extends State<ReaPropertyInsuranceView> {
  String selectedInsuranceType = "Home Insurance";
  String selectedCoverage = "Basic";
  String searchQuery = "";
  bool showComparison = false;

  List<Map<String, dynamic>> insuranceTypes = [
    {"label": "Home Insurance", "value": "Home Insurance"},
    {"label": "Renters Insurance", "value": "Renters Insurance"},
    {"label": "Condo Insurance", "value": "Condo Insurance"},
    {"label": "Landlord Insurance", "value": "Landlord Insurance"},
    {"label": "Commercial Property", "value": "Commercial Property"},
  ];

  List<Map<String, dynamic>> coverageTypes = [
    {"label": "Basic Coverage", "value": "Basic"},
    {"label": "Standard Coverage", "value": "Standard"},
    {"label": "Premium Coverage", "value": "Premium"},
    {"label": "Comprehensive Coverage", "value": "Comprehensive"},
  ];

  List<Map<String, dynamic>> insuranceProviders = [
    {
      "id": 1,
      "name": "SecureHome Insurance",
      "logo": "https://picsum.photos/100/100?random=1&keyword=insurance",
      "rating": 4.8,
      "reviews": 2456,
      "monthlyPremium": 125,
      "annualPremium": 1425,
      "deductible": 1000,
      "coverageAmount": 500000,
      "features": [
        "24/7 Claims Support",
        "Online Policy Management",
        "Disaster Recovery",
        "Personal Property Coverage"
      ],
      "coverage": {
        "dwelling": 500000,
        "personalProperty": 350000,
        "liability": 300000,
        "medicalPayments": 5000,
        "additionalLiving": 100000
      },
      "discounts": ["Multi-policy", "Security System", "Claims-free"],
      "contact": "(555) 123-4567",
      "website": "www.securehome.com"
    },
    {
      "id": 2,
      "name": "Guardian Property Insurance",
      "logo": "https://picsum.photos/100/100?random=2&keyword=shield",
      "rating": 4.6,
      "reviews": 1834,
      "monthlyPremium": 110,
      "annualPremium": 1254,
      "deductible": 1500,
      "coverageAmount": 450000,
      "features": [
        "Fast Claims Processing",
        "Mobile App",
        "Home Security Monitoring",
        "Replacement Cost Coverage"
      ],
      "coverage": {
        "dwelling": 450000,
        "personalProperty": 315000,
        "liability": 250000,
        "medicalPayments": 3000,
        "additionalLiving": 90000
      },
      "discounts": ["Bundling", "New Home", "Good Credit"],
      "contact": "(555) 234-5678",
      "website": "www.guardianproperty.com"
    },
    {
      "id": 3,
      "name": "Premier Property Protection",
      "logo": "https://picsum.photos/100/100?random=3&keyword=premium",
      "rating": 4.9,
      "reviews": 3127,
      "monthlyPremium": 155,
      "annualPremium": 1767,
      "deductible": 500,
      "coverageAmount": 750000,
      "features": [
        "Concierge Claims Service",
        "Premium Support",
        "Guaranteed Replacement Cost",
        "High-Value Item Coverage"
      ],
      "coverage": {
        "dwelling": 750000,
        "personalProperty": 525000,
        "liability": 500000,
        "medicalPayments": 10000,
        "additionalLiving": 150000
      },
      "discounts": ["Loyalty", "Professional", "Smart Home"],
      "contact": "(555) 345-6789",
      "website": "www.premierproperty.com"
    },
    {
      "id": 4,
      "name": "TrustShield Insurance",
      "logo": "https://picsum.photos/100/100?random=4&keyword=trust",
      "rating": 4.5,
      "reviews": 987,
      "monthlyPremium": 95,
      "annualPremium": 1083,
      "deductible": 2000,
      "coverageAmount": 400000,
      "features": [
        "Budget-Friendly Plans",
        "Simple Claims Process",
        "Basic Coverage Options",
        "Online Support"
      ],
      "coverage": {
        "dwelling": 400000,
        "personalProperty": 280000,
        "liability": 200000,
        "medicalPayments": 2500,
        "additionalLiving": 80000
      },
      "discounts": ["Online", "Auto-pay", "Referral"],
      "contact": "(555) 456-7890",
      "website": "www.trustshield.com"
    }
  ];

  List<Map<String, dynamic>> get filteredProviders {
    return insuranceProviders.where((provider) {
      bool matchesSearch = "${provider["name"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search insurance providers...",
            value: searchQuery,
            hint: "Enter provider name",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Insurance Type",
                  items: insuranceTypes,
                  value: selectedInsuranceType,
                  onChanged: (value, label) {
                    selectedInsuranceType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Coverage Level",
                  items: coverageTypes,
                  value: selectedCoverage,
                  onChanged: (value, label) {
                    selectedCoverage = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Get Quotes",
                  icon: Icons.request_quote,
                  size: bs.md,
                  onPressed: () {
                    // Get quotes
                  },
                ),
              ),
              SizedBox(width: spSm),
              Container(
                decoration: BoxDecoration(
                  color: showComparison ? primaryColor : Colors.grey[200],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.compare,
                    color: showComparison ? Colors.white : disabledBoldColor,
                  ),
                  onPressed: () {
                    showComparison = !showComparison;
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

  Widget _buildInsuranceCard(Map<String, dynamic> provider) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with logo and rating
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor.withAlpha(25), Colors.white],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("${provider["logo"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${provider["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star, color: Colors.white, size: 12),
                                SizedBox(width: spXs),
                                Text(
                                  "${provider["rating"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${provider["reviews"]} reviews",
                            style: TextStyle(
                              fontSize: 12,
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
                      "\$${provider["monthlyPremium"]}/mo",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${provider["annualPremium"]}/year",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spSm,
              children: [
                // Coverage Summary
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Coverage Summary",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: _buildCoverageItem("Dwelling", "\$${((provider["coverage"]["dwelling"] as int) / 1000).toInt()}K"),
                          ),
                          Expanded(
                            child: _buildCoverageItem("Deductible", "\$${((provider["deductible"] as int)).toString()}"),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Expanded(
                            child: _buildCoverageItem("Personal Property", "\$${((provider["coverage"]["personalProperty"] as int) / 1000).toInt()}K"),
                          ),
                          Expanded(
                            child: _buildCoverageItem("Liability", "\$${((provider["coverage"]["liability"] as int) / 1000).toInt()}K"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Features
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(12),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Key Features",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...(provider["features"] as List).map((feature) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, color: successColor, size: 16),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${feature}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),

                // Discounts
                if ((provider["discounts"] as List).isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.local_offer, color: successColor, size: 16),
                            SizedBox(width: spSm),
                            Text(
                              "Available Discounts",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (provider["discounts"] as List).map((discount) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${discount}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],

                // Contact Information
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.phone, color: primaryColor, size: 16),
                          SizedBox(width: spSm),
                          Text(
                            "${provider["contact"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.language, color: disabledBoldColor, size: 16),
                          SizedBox(width: spSm),
                          Text(
                            "${provider["website"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Get Quote",
                        icon: Icons.request_quote,
                        size: bs.sm,
                        onPressed: () {
                          // Get quote
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Compare",
                        icon: Icons.compare,
                        size: bs.sm,
                        onPressed: () {
                          // Add to comparison
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Details",
                        icon: Icons.info,
                        size: bs.sm,
                        onPressed: () {
                          // View details
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverageItem(String label, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonView() {
    final selectedProviders = filteredProviders.take(3).toList();
    
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            ),
            child: Row(
              children: [
                Icon(Icons.compare, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Compare Insurance Plans",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: selectedProviders.map((provider) {
                  return Container(
                    width: 200,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "${provider["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        _buildComparisonRow("Monthly Premium", "\$${provider["monthlyPremium"]}"),
                        _buildComparisonRow("Deductible", "\$${provider["deductible"]}"),
                        _buildComparisonRow("Dwelling Coverage", "\$${((provider["coverage"]["dwelling"] as int) / 1000).toInt()}K"),
                        _buildComparisonRow("Rating", "${provider["rating"]}/5"),
                        QButton(
                          label: "Select",
                          size: bs.sm,
                          onPressed: () {
                            // Select plan
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Insurance"),
        actions: [
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              // Insurance calculator
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          if (showComparison) _buildComparisonView(),
          Expanded(
            child: filteredProviders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.security,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No insurance providers found",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Try adjusting your search criteria",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: spMd),
                    itemCount: filteredProviders.length,
                    itemBuilder: (context, index) {
                      return _buildInsuranceCard(filteredProviders[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
