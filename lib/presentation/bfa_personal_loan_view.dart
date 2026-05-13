import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaPersonalLoanView extends StatefulWidget {
  const BfaPersonalLoanView({super.key});

  @override
  State<BfaPersonalLoanView> createState() => _BfaPersonalLoanViewState();
}

class _BfaPersonalLoanViewState extends State<BfaPersonalLoanView> {
  int selectedTab = 0;
  bool loading = false;

  List<Map<String, dynamic>> loanOffers = [
    {
      "bankName": "State Bank",
      "logo": "https://picsum.photos/60/60?random=1",
      "interestRate": 10.5,
      "maxAmount": 2000000,
      "tenure": "12-84 months",
      "processingFee": "1.5%",
      "approval": "24 hours",
      "features": ["No collateral", "Flexible tenure", "Quick approval"],
      "rating": 4.5,
      "totalReviews": 1250
    },
    {
      "bankName": "Private Bank",
      "logo": "https://picsum.photos/60/60?random=2",
      "interestRate": 11.2,
      "maxAmount": 1500000,
      "tenure": "12-60 months",
      "processingFee": "2%",
      "approval": "48 hours",
      "features": ["Digital process", "No hidden charges", "Pre-approved"],
      "rating": 4.3,
      "totalReviews": 890
    },
    {
      "bankName": "National Bank",
      "logo": "https://picsum.photos/60/60?random=3",
      "interestRate": 12.0,
      "maxAmount": 1000000,
      "tenure": "12-72 months",
      "processingFee": "1%",
      "approval": "3-5 days",
      "features": ["Low processing fee", "Competitive rates", "Branch support"],
      "rating": 4.1,
      "totalReviews": 2100
    },
  ];

  List<Map<String, dynamic>> loanPurposes = [
    {
      "title": "Medical Emergency",
      "icon": Icons.medical_services,
      "description": "Cover medical expenses and treatments",
      "color": dangerColor
    },
    {
      "title": "Home Renovation",
      "icon": Icons.home_repair_service,
      "description": "Upgrade and renovate your home",
      "color": primaryColor
    },
    {
      "title": "Wedding Expenses",
      "icon": Icons.celebration,
      "description": "Make your special day memorable",
      "color": warningColor
    },
    {
      "title": "Education",
      "icon": Icons.school,
      "description": "Invest in your education and skills",
      "color": infoColor
    },
    {
      "title": "Travel",
      "icon": Icons.flight,
      "description": "Plan your dream vacation",
      "color": successColor
    },
    {
      "title": "Debt Consolidation",
      "icon": Icons.account_balance,
      "description": "Consolidate multiple debts",
      "color": disabledBoldColor
    },
  ];

  List<Map<String, dynamic>> eligibilityFactors = [
    {
      "factor": "Age",
      "requirement": "21-65 years",
      "icon": Icons.person,
      "status": "check"
    },
    {
      "factor": "Income",
      "requirement": "₹25,000+ per month",
      "icon": Icons.monetization_on,
      "status": "check"
    },
    {
      "factor": "Employment",
      "requirement": "Salaried/Self-employed",
      "icon": Icons.work,
      "status": "check"
    },
    {
      "factor": "Credit Score",
      "requirement": "700+ preferred",
      "icon": Icons.credit_score,
      "status": "warning"
    },
    {
      "factor": "Work Experience",
      "requirement": "2+ years",
      "icon": Icons.timeline,
      "status": "check"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Personal Loan",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Offers", icon: Icon(Icons.local_offer)),
        Tab(text: "Apply", icon: Icon(Icons.assignment)),
        Tab(text: "Eligibility", icon: Icon(Icons.fact_check)),
      ],
      tabChildren: [
        _buildOffersTab(),
        _buildApplyTab(),
        _buildEligibilityTab(),
      ],
    );
  }

  Widget _buildOffersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderCard(),
          _buildLoanPurposesSection(),
          _buildOffersSection(),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
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
          Text(
            "Personal Loan",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "Quick and hassle-free personal loans for all your needs",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "Up to ₹20 Lakh",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Interest Rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "Starting 10.5%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Approval",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "In 24 hours",
                      style: TextStyle(
                        fontSize: 16,
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

  Widget _buildLoanPurposesSection() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What do you need the loan for?",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: List.generate(loanPurposes.length, (index) {
            final purpose = loanPurposes[index];
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (purpose["color"] as Color).withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      purpose["icon"],
                      color: purpose["color"],
                      size: 24,
                    ),
                  ),
                  Text(
                    "${purpose["title"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${purpose["description"]}",
                    textAlign: TextAlign.center,
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

  Widget _buildOffersSection() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Best Offers for You",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Sort or filter offers
              },
              child: Row(
                children: [
                  Icon(
                    Icons.tune,
                    color: primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Filter",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
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
                Row(
                  children: [
                    Expanded(
                      child: _buildOfferDetail("Max Amount", "₹${((offer["maxAmount"] as int) / 100000).toStringAsFixed(0)} L"),
                    ),
                    Expanded(
                      child: _buildOfferDetail("Tenure", "${offer["tenure"]}"),
                    ),
                    Expanded(
                      child: _buildOfferDetail("Processing", "${offer["processingFee"]}"),
                    ),
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
                        label: "Compare",
                        size: bs.sm,
                        onPressed: () {
                          // Compare loans
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Apply Now",
                        size: bs.sm,
                        onPressed: () {
                          selectedTab = 1;
                          setState(() {});
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
    return Column(
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
    );
  }

  Widget _buildApplyTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildApplicationSteps(),
          _buildQuickApplicationCard(),
          _buildRequiredDocuments(),
        ],
      ),
    );
  }

  Widget _buildApplicationSteps() {
    List<Map<String, dynamic>> steps = [
      {
        "step": "1",
        "title": "Fill Application",
        "description": "Complete the online application form",
        "icon": Icons.edit_document,
        "completed": false
      },
      {
        "step": "2",
        "title": "Upload Documents",
        "description": "Submit required documents",
        "icon": Icons.cloud_upload,
        "completed": false
      },
      {
        "step": "3",
        "title": "Verification",
        "description": "Document and identity verification",
        "icon": Icons.verified,
        "completed": false
      },
      {
        "step": "4",
        "title": "Approval",
        "description": "Loan approval and disbursal",
        "icon": Icons.check_circle,
        "completed": false
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
          Text(
            "Application Process",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate(steps.length, (index) {
            final step = steps[index];
            bool isLast = index == steps.length - 1;
            
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: step["completed"] 
                            ? successColor 
                            : index == 0 
                                ? primaryColor 
                                : disabledColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        step["completed"] 
                            ? Icons.check 
                            : step["icon"],
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 40,
                        color: disabledColor,
                      ),
                  ],
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${step["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${step["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (!isLast) SizedBox(height: spSm),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildQuickApplicationCard() {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.flash_on,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Quick Pre-Approval",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "Get instant pre-approval with just basic details. No documents needed for initial check.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Response Time",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "2 minutes",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Credit Check",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "Soft inquiry",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Start Quick Application",
              size: bs.md,
              onPressed: () {
                // Start application process
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequiredDocuments() {
    List<Map<String, dynamic>> documents = [
      {
        "type": "Identity Proof",
        "examples": ["Aadhaar Card", "PAN Card", "Passport", "Voter ID"],
        "icon": Icons.credit_card,
        "required": true
      },
      {
        "type": "Address Proof",
        "examples": ["Utility Bill", "Bank Statement", "Rent Agreement"],
        "icon": Icons.home,
        "required": true
      },
      {
        "type": "Income Proof",
        "examples": ["Salary Slips", "Bank Statement", "ITR", "Form 16"],
        "icon": Icons.receipt_long,
        "required": true
      },
      {
        "type": "Employment Proof",
        "examples": ["Offer Letter", "Employment Certificate", "Business License"],
        "icon": Icons.work,
        "required": false
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
          Text(
            "Required Documents",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate(documents.length, (index) {
            final doc = documents[index];
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      doc["icon"],
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${doc["type"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            if (doc["required"]) ...[
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Required",
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        Text(
                          "Any one: ${(doc["examples"] as List).join(", ")}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "All documents should be clear, valid, and in JPG/PDF format. Max file size: 5MB per document.",
                    style: TextStyle(
                      fontSize: 11,
                      color: infoColor,
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

  Widget _buildEligibilityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildEligibilityChecker(),
          _buildEligibilityFactors(),
          _buildEligibilityTips(),
        ],
      ),
    );
  }

  Widget _buildEligibilityChecker() {
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
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.quiz,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Check Your Eligibility",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "Quick eligibility check without affecting your credit score",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Check Eligibility",
              size: bs.md,
              onPressed: () {
                // Navigate to eligibility form
              },
            ),
          ),
          Text(
            "• No impact on credit score\n• Instant results\n• Multiple lender comparison",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEligibilityFactors() {
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
          Text(
            "Eligibility Criteria",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate(eligibilityFactors.length, (index) {
            final factor = eligibilityFactors[index];
            Color statusColor = factor["status"] == "check" 
                ? successColor 
                : factor["status"] == "warning" 
                    ? warningColor 
                    : dangerColor;
            IconData statusIcon = factor["status"] == "check" 
                ? Icons.check_circle 
                : factor["status"] == "warning" 
                    ? Icons.warning 
                    : Icons.cancel;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: statusColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    factor["icon"],
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${factor["factor"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${factor["requirement"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    statusIcon,
                    color: statusColor,
                    size: 20,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEligibilityTips() {
    List<Map<String, dynamic>> tips = [
      {
        "title": "Improve Credit Score",
        "description": "Pay bills on time and maintain low credit utilization",
        "icon": Icons.trending_up
      },
      {
        "title": "Stable Income",
        "description": "Maintain steady employment for better approval chances",
        "icon": Icons.work_history
      },
      {
        "title": "Reduce Existing Debt",
        "description": "Lower debt-to-income ratio improves eligibility",
        "icon": Icons.trending_down
      },
      {
        "title": "Complete Documentation",
        "description": "Keep all required documents ready for quick processing",
        "icon": Icons.folder_shared
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
          Text(
            "Tips to Improve Eligibility",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate(tips.length, (index) {
            final tip = tips[index];
            
            return Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    tip["icon"],
                    color: successColor,
                    size: 16,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${tip["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${tip["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
