import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaHomeLoanView extends StatefulWidget {
  const BfaHomeLoanView({super.key});

  @override
  State<BfaHomeLoanView> createState() => _BfaHomeLoanViewState();
}

class _BfaHomeLoanViewState extends State<BfaHomeLoanView> {
  int selectedTab = 0;

  List<Map<String, dynamic>> loanOffers = [
    {
      "bankName": "Housing Finance Corp",
      "logo": "https://picsum.photos/60/60?random=11",
      "interestRate": 8.5,
      "maxAmount": 10000000,
      "tenure": "5-30 years",
      "processingFee": "0.5%",
      "ltvRatio": "90%",
      "features": ["No prepayment charges", "Flexible tenure", "Quick approval"],
      "rating": 4.6,
      "totalReviews": 2400,
      "specialOffer": "0.25% rate reduction for women borrowers"
    },
    {
      "bankName": "National Housing Bank",
      "logo": "https://picsum.photos/60/60?random=12",
      "interestRate": 8.8,
      "maxAmount": 7500000,
      "tenure": "10-25 years",
      "processingFee": "0.75%",
      "ltvRatio": "85%",
      "features": ["Government backed", "Subsidies available", "Branch support"],
      "rating": 4.4,
      "totalReviews": 1800,
      "specialOffer": "PMAY subsidy eligible"
    },
    {
      "bankName": "Private Housing Ltd",
      "logo": "https://picsum.photos/60/60?random=13",
      "interestRate": 9.2,
      "maxAmount": 5000000,
      "tenure": "5-20 years",
      "processingFee": "1%",
      "ltvRatio": "80%",
      "features": ["Digital process", "Fast approval", "Competitive rates"],
      "rating": 4.2,
      "totalReviews": 950,
      "specialOffer": "Balance transfer available"
    },
  ];

  List<Map<String, dynamic>> propertyTypes = [
    {
      "type": "Ready to Move",
      "description": "Already constructed properties",
      "icon": Icons.home,
      "color": primaryColor,
      "loanAmount": "Up to 90% of property value"
    },
    {
      "type": "Under Construction",
      "description": "Properties still being built",
      "icon": Icons.construction,
      "color": warningColor,
      "loanAmount": "Up to 80% of property value"
    },
    {
      "type": "Plot Purchase",
      "description": "Land/plot for construction",
      "icon": Icons.landscape,
      "color": successColor,
      "loanAmount": "Up to 70% of plot value"
    },
    {
      "type": "Home Improvement",
      "description": "Renovation and repairs",
      "icon": Icons.home_repair_service,
      "color": infoColor,
      "loanAmount": "Up to ₹15 Lakh"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Home Loan",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Offers", icon: Icon(Icons.local_offer)),
        Tab(text: "Calculator", icon: Icon(Icons.calculate)),
        Tab(text: "Property Types", icon: Icon(Icons.home_work)),
      ],
      tabChildren: [
        _buildOffersTab(),
        _buildCalculatorTab(),
        _buildPropertyTypesTab(),
      ],
    );
  }

  Widget _buildOffersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildHomeLoanHeader(),
          _buildFeaturesSection(),
          _buildLoanOffers(),
        ],
      ),
    );
  }

  Widget _buildHomeLoanHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
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
          Row(
            children: [
              Icon(
                Icons.home,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Text(
                "Home Loan",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "Turn your dream of owning a home into reality with our competitive home loan offers",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: spSm),
            child: Row(
              children: [
                Expanded(
                  child: _buildHeaderStat("Loan Amount", "Up to ₹1 Cr", Icons.currency_rupee),
                ),
                Container(width: 1, height: 50, color: Colors.white.withAlpha(100)),
                Expanded(
                  child: _buildHeaderStat("Interest Rate", "Starting 8.5%", Icons.percent),
                ),
                Container(width: 1, height: 50, color: Colors.white.withAlpha(100)),
                Expanded(
                  child: _buildHeaderStat("Tenure", "Up to 30 years", Icons.schedule),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withAlpha(200),
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection() {
    List<Map<String, dynamic>> features = [
      {
        "title": "Tax Benefits",
        "description": "Save up to ₹3.5L under Section 80C & 24B",
        "icon": Icons.savings,
        "color": successColor
      },
      {
        "title": "Flexible Repayment",
        "description": "Choose from multiple repayment options",
        "icon": Icons.payment,
        "color": infoColor
      },
      {
        "title": "Balance Transfer",
        "description": "Switch from existing lender for better rates",
        "icon": Icons.swap_horiz,
        "color": warningColor
      },
      {
        "title": "Top-up Loan",
        "description": "Additional funding for home improvement",
        "icon": Icons.add_circle,
        "color": primaryColor
      },
    ];

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Key Features & Benefits",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: List.generate(features.length, (index) {
            final feature = features[index];
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (feature["color"] as Color).withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      feature["icon"],
                      color: feature["color"],
                      size: 20,
                    ),
                  ),
                  Text(
                    "${feature["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${feature["description"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildLoanOffers() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Best Home Loan Offers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Compare all offers
              },
              child: Text(
                "Compare All",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        ...List.generate(loanOffers.length, (index) {
          final offer = loanOffers[index];
          
          return Container(
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${offer["logo"]}",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${offer["bankName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              ...List.generate(5, (starIndex) {
                                return Icon(
                                  starIndex < (offer["rating"] as double).floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: warningColor,
                                  size: 12,
                                );
                              }),
                              SizedBox(width: spXs),
                              Text(
                                "${offer["rating"]} (${offer["totalReviews"]})",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${offer["interestRate"]}% p.a.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if (offer["specialOffer"] != null) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_offer,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${offer["specialOffer"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildOfferDetail("Max Amount", "₹${((offer["maxAmount"] as int) / 1000000).toStringAsFixed(0)} Cr"),
                    _buildOfferDetail("Tenure", "${offer["tenure"]}"),
                    _buildOfferDetail("Processing Fee", "${offer["processingFee"]}"),
                    _buildOfferDetail("LTV Ratio", "${offer["ltvRatio"]}"),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Key Features:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (offer["features"] as List).map((feature) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$feature",
                              style: TextStyle(
                                fontSize: 10,
                                color: infoColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Check Eligibility",
                        size: bs.sm,
                        onPressed: () {
                          // Check eligibility
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Apply Now",
                        size: bs.sm,
                        onPressed: () {
                          // Apply for loan
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildOfferDetail(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorTab() {
    String propertyValue = "5000000";
    String downPayment = "1000000";
    String interestRate = "8.5";
    String tenure = "20";
    
    double loanAmount = (double.tryParse(propertyValue) ?? 0) - (double.tryParse(downPayment) ?? 0);
    double monthlyEmi = _calculateEmi(loanAmount, double.tryParse(interestRate) ?? 0, int.tryParse(tenure) ?? 0);
    double totalAmount = monthlyEmi * (int.tryParse(tenure) ?? 0) * 12;
    double totalInterest = totalAmount - loanAmount;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Home Loan EMI Calculator",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QNumberField(
                  label: "Property Value (₹)",
                  value: propertyValue,
                  onChanged: (value) {
                    propertyValue = value;
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Down Payment (₹)",
                  value: downPayment,
                  onChanged: (value) {
                    downPayment = value;
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Interest Rate (% per annum)",
                  value: interestRate,
                  onChanged: (value) {
                    interestRate = value;
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Loan Tenure (years)",
                  value: tenure,
                  onChanged: (value) {
                    tenure = value;
                    setState(() {});
                  },
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Calculate EMI",
                    size: bs.md,
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Text(
                  "Loan Calculation Results",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildResultCard("Loan Amount", "₹${loanAmount.currency}", Icons.account_balance),
                    ),
                    Container(width: 1, height: 60, color: Colors.white.withAlpha(100)),
                    Expanded(
                      child: _buildResultCard("Monthly EMI", "₹${monthlyEmi.currency}", Icons.payment),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildResultCard("Total Interest", "₹${totalInterest.currency}", Icons.trending_up),
                    ),
                    Container(width: 1, height: 60, color: Colors.white.withAlpha(100)),
                    Expanded(
                      child: _buildResultCard("Total Amount", "₹${totalAmount.currency}", Icons.account_balance_wallet),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildAffordabilityCard(monthlyEmi),
        ],
      ),
    );
  }

  Widget _buildResultCard(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withAlpha(200),
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildAffordabilityCard(double emi) {
    double recommendedIncome = emi / 0.4; // EMI should not exceed 40% of income
    
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
            "Affordability Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommended Monthly Income:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "₹${recommendedIncome.currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "EMI to Income Ratio:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "40% (Recommended)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            "💡 Tip: Your EMI should ideally not exceed 40% of your monthly income for comfortable repayment.",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyTypesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPropertyTypesHeader(),
          _buildPropertyTypesList(),
          _buildTaxBenefitsSection(),
        ],
      ),
    );
  }

  Widget _buildPropertyTypesHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [infoColor, infoColor.withAlpha(200)],
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
          Row(
            children: [
              Icon(
                Icons.home_work,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Property Types",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "Different loan options based on your property type and requirements",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyTypesList() {
    return Column(
      spacing: spSm,
      children: List.generate(propertyTypes.length, (index) {
        final property = propertyTypes[index];
        
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (property["color"] as Color).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  property["icon"],
                  color: property["color"],
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${property["type"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${property["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${property["loanAmount"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.arrow_forward,
                size: bs.sm,
                onPressed: () {
                  // View details
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTaxBenefitsSection() {
    List<Map<String, dynamic>> taxBenefits = [
      {
        "section": "Section 80C",
        "benefit": "Principal repayment",
        "limit": "₹1.5 Lakh per year",
        "description": "Deduction on principal amount repaid"
      },
      {
        "section": "Section 24B",
        "benefit": "Interest payment",
        "limit": "₹2 Lakh per year",
        "description": "Deduction on interest paid for home loan"
      },
      {
        "section": "Section 80EE",
        "benefit": "Additional interest",
        "limit": "₹50,000 per year",
        "description": "For first-time home buyers (conditions apply)"
      },
    ];

    return Container(
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
          Row(
            children: [
              Icon(
                Icons.savings,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Tax Benefits",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...List.generate(taxBenefits.length, (index) {
            final benefit = taxBenefits[index];
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${benefit["section"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "${benefit["limit"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${benefit["benefit"]} - ${benefit["description"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            );
          }),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: warningColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Total potential tax savings up to ₹3.5 Lakh per year. Consult a tax advisor for specific calculations.",
                    style: TextStyle(
                      fontSize: 11,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateEmi(double principal, double rate, int years) {
    if (principal <= 0 || rate <= 0 || years <= 0) return 0;
    
    double monthlyRate = rate / 100 / 12;
    int months = years * 12;
    
    if (monthlyRate == 0) return principal / months;
    
    double emi = principal * monthlyRate * (pow(1 + monthlyRate, months)) / 
                 ((pow(1 + monthlyRate, months)) - 1);
    return emi;
  }

  double pow(double base, int exponent) {
    double result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }
}
