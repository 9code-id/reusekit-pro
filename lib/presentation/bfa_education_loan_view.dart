import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaEducationLoanView extends StatefulWidget {
  const BfaEducationLoanView({super.key});

  @override
  State<BfaEducationLoanView> createState() => _BfaEducationLoanViewState();
}

class _BfaEducationLoanViewState extends State<BfaEducationLoanView> {
  int selectedTab = 0;
  String selectedStudyType = "domestic";

  List<Map<String, dynamic>> educationLoanOffers = [
    {
      "bankName": "Education Finance Bank",
      "logo": "https://picsum.photos/60/60?random=31",
      "interestRate": 9.5,
      "maxAmount": 2000000,
      "tenure": "5-15 years",
      "processingFee": "Nil",
      "moratorium": "Course + 6 months",
      "features": ["No collateral up to ₹7.5L", "Tax benefits", "Flexible repayment"],
      "rating": 4.7,
      "totalReviews": 2100
    },
    {
      "bankName": "Student Loan Corp",
      "logo": "https://picsum.photos/60/60?random=32",
      "interestRate": 10.2,
      "maxAmount": 1500000,
      "tenure": "3-12 years",
      "processingFee": "1%",
      "moratorium": "Course period",
      "features": ["Quick approval", "Online process", "Competitive rates"],
      "rating": 4.4,
      "totalReviews": 1650
    },
    {
      "bankName": "Academic Finance Ltd",
      "logo": "https://picsum.photos/60/60?random=33",
      "interestRate": 11.0,
      "maxAmount": 1000000,
      "tenure": "5-10 years",
      "processingFee": "0.5%",
      "moratorium": "Course + 1 year",
      "features": ["Simple documentation", "Branch support", "Career guidance"],
      "rating": 4.2,
      "totalReviews": 980
    },
  ];

  List<Map<String, dynamic>> courseCategories = [
    {
      "category": "Engineering & Technology",
      "description": "Technical and engineering courses",
      "icon": Icons.engineering,
      "color": primaryColor,
      "maxLoan": "Up to ₹20 Lakh",
      "examples": ["B.Tech", "M.Tech", "Diploma Engineering"]
    },
    {
      "category": "Medical & Healthcare",
      "description": "Medical and health science courses",
      "icon": Icons.medical_services,
      "color": dangerColor,
      "maxLoan": "Up to ₹25 Lakh",
      "examples": ["MBBS", "BDS", "Nursing", "Pharmacy"]
    },
    {
      "category": "Management & Business",
      "description": "MBA and business management courses",
      "icon": Icons.business_center,
      "color": warningColor,
      "maxLoan": "Up to ₹15 Lakh",
      "examples": ["MBA", "PGDM", "BBA", "B.Com"]
    },
    {
      "category": "Arts & Humanities",
      "description": "Liberal arts and humanities courses",
      "icon": Icons.palette,
      "color": infoColor,
      "maxLoan": "Up to ₹10 Lakh",
      "examples": ["BA", "MA", "B.Ed", "Journalism"]
    },
    {
      "category": "Science & Research",
      "description": "Pure sciences and research programs",
      "icon": Icons.science,
      "color": successColor,
      "maxLoan": "Up to ₹12 Lakh",
      "examples": ["MSc", "PhD", "Research Programs"]
    },
    {
      "category": "Vocational & Skill",
      "description": "Skill development and vocational training",
      "icon": Icons.build,
      "color": disabledBoldColor,
      "maxLoan": "Up to ₹5 Lakh",
      "examples": ["ITI", "Polytechnic", "Skill Courses"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Education Loan",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Offers", icon: Icon(Icons.local_offer)),
        Tab(text: "Courses", icon: Icon(Icons.school)),
        Tab(text: "Eligibility", icon: Icon(Icons.fact_check)),
      ],
      tabChildren: [
        _buildOffersTab(),
        _buildCoursesTab(),
        _buildEligibilityTab(),
      ],
    );
  }

  Widget _buildOffersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildEducationLoanHeader(),
          _buildStudyTypeSelector(),
          _buildBenefitsSection(),
          _buildLoanOffers(),
        ],
      ),
    );
  }

  Widget _buildEducationLoanHeader() {
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
                Icons.school,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Text(
                "Education Loan",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "Invest in your future with our comprehensive education loan solutions",
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
                  child: _buildHeaderStat("Loan Amount", "Up to ₹25 L", Icons.currency_rupee),
                ),
                Container(width: 1, height: 50, color: Colors.white.withAlpha(100)),
                Expanded(
                  child: _buildHeaderStat("Interest Rate", "Starting 9.5%", Icons.percent),
                ),
                Container(width: 1, height: 50, color: Colors.white.withAlpha(100)),
                Expanded(
                  child: _buildHeaderStat("Moratorium", "Course + 6 months", Icons.schedule),
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

  Widget _buildStudyTypeSelector() {
    List<Map<String, dynamic>> options = [
      {"label": "Domestic Studies", "value": "domestic"},
      {"label": "International Studies", "value": "international"},
    ];

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
            "Study Destination",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: List.generate(options.length, (index) {
              final option = options[index];
              bool isSelected = selectedStudyType == option["value"];
              
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedStudyType = option["value"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: index < options.length - 1 ? spSm : 0),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      "${option["label"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsSection() {
    List<Map<String, dynamic>> benefits = [
      {
        "title": "Tax Benefits",
        "description": "Deduction under Section 80E",
        "icon": Icons.savings,
        "color": successColor
      },
      {
        "title": "Moratorium Period",
        "description": "No EMI during study period",
        "icon": Icons.schedule,
        "color": infoColor
      },
      {
        "title": "Simple Interest",
        "description": "Simple interest during moratorium",
        "icon": Icons.percent,
        "color": warningColor
      },
      {
        "title": "Collateral Free",
        "description": "No security up to ₹7.5 Lakh",
        "icon": Icons.security,
        "color": primaryColor
      },
    ];

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Key Benefits",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: List.generate(benefits.length, (index) {
            final benefit = benefits[index];
            
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
                      color: (benefit["color"] as Color).withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      benefit["icon"],
                      color: benefit["color"],
                      size: 20,
                    ),
                  ),
                  Text(
                    "${benefit["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${benefit["description"]}",
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
        Text(
          "${selectedStudyType == "domestic" ? "Domestic" : "International"} Education Loan Offers",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...List.generate(educationLoanOffers.length, (index) {
          final offer = educationLoanOffers[index];
          double adjustedRate = selectedStudyType == "international" 
              ? (offer["interestRate"] as double) + 1.0 
              : (offer["interestRate"] as double);
          int adjustedAmount = selectedStudyType == "international" 
              ? ((offer["maxAmount"] as int) * 1.5).toInt() 
              : (offer["maxAmount"] as int);
          
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
                        "${adjustedRate.toStringAsFixed(1)}% p.a.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildOfferDetail("Max Amount", "₹${(adjustedAmount / 100000).toStringAsFixed(0)} L"),
                    _buildOfferDetail("Tenure", "${offer["tenure"]}"),
                    _buildOfferDetail("Processing Fee", "${offer["processingFee"]}"),
                    _buildOfferDetail("Moratorium", "${offer["moratorium"]}"),
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

  Widget _buildCoursesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCoursesHeader(),
          _buildCourseCategories(),
          _buildCoverageDetails(),
        ],
      ),
    );
  }

  Widget _buildCoursesHeader() {
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
                Icons.school,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Covered Courses",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "Wide range of courses and programs covered under education loan",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCategories() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Course Categories",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: List.generate(courseCategories.length, (index) {
            final category = courseCategories[index];
            
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
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (category["color"] as Color).withAlpha(25),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          category["icon"],
                          color: category["color"],
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${category["category"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${category["description"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${category["maxLoan"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ),
                  Text(
                    "Examples: ${(category["examples"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
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

  Widget _buildCoverageDetails() {
    List<Map<String, dynamic>> coverageItems = [
      {
        "category": "Tuition Fees",
        "description": "Complete course fee coverage",
        "icon": Icons.school,
        "included": true
      },
      {
        "category": "Hostel Accommodation",
        "description": "Boarding and lodging expenses",
        "icon": Icons.hotel,
        "included": true
      },
      {
        "category": "Books & Equipment",
        "description": "Study materials and equipment",
        "icon": Icons.library_books,
        "included": true
      },
      {
        "category": "Travel Expenses",
        "description": "Travel for international studies",
        "icon": Icons.flight,
        "included": true
      },
      {
        "category": "Living Expenses",
        "description": "Monthly living and food expenses",
        "icon": Icons.home,
        "included": true
      },
      {
        "category": "Exam/Lab Fees",
        "description": "Examination and laboratory fees",
        "icon": Icons.science,
        "included": true
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
            "What's Covered",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate(coverageItems.length, (index) {
            final item = coverageItems[index];
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    item["icon"],
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item["category"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "${item["description"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 16,
                  ),
                ],
              ),
            );
          }),
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
          _buildEligibilityHeader(),
          _buildStudentEligibility(),
          _buildCoApplicantDetails(),
          _buildRequiredDocuments(),
        ],
      ),
    );
  }

  Widget _buildEligibilityHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [warningColor, warningColor.withAlpha(200)],
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
                Icons.fact_check,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Eligibility Criteria",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "Check if you meet the requirements for education loan approval",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentEligibility() {
    List<Map<String, dynamic>> studentCriteria = [
      {
        "criteria": "Age",
        "requirement": "18-35 years",
        "icon": Icons.person,
        "status": "required"
      },
      {
        "criteria": "Academic Score",
        "requirement": "Minimum 50% in qualifying exam",
        "icon": Icons.grade,
        "status": "required"
      },
      {
        "criteria": "Admission Confirmation",
        "requirement": "Admission letter from recognized institution",
        "icon": Icons.school,
        "status": "required"
      },
      {
        "criteria": "Course Duration",
        "requirement": "Minimum 6 months course duration",
        "icon": Icons.schedule,
        "status": "required"
      },
      {
        "criteria": "Nationality",
        "requirement": "Indian citizen",
        "icon": Icons.flag,
        "status": "required"
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
            "Student Eligibility",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate(studentCriteria.length, (index) {
            final criteria = studentCriteria[index];
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    criteria["icon"],
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${criteria["criteria"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${criteria["requirement"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
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
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCoApplicantDetails() {
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
            "Co-Applicant Requirements",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mandatory Co-Applicant:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "• Parent/Guardian (for loans above ₹7.5 Lakh)\n• Spouse (for married applicants)\n• Sibling (in certain cases)",
                  style: TextStyle(
                    fontSize: 11,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Co-Applicant Income:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "• Minimum ₹2 Lakh per annum\n• Stable employment/business\n• Good credit history",
                  style: TextStyle(
                    fontSize: 11,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequiredDocuments() {
    List<Map<String, dynamic>> documentCategories = [
      {
        "category": "Student Documents",
        "documents": ["Mark sheets", "Admission letter", "Fee structure", "Identity proof"],
        "icon": Icons.person,
        "color": primaryColor
      },
      {
        "category": "Co-Applicant Documents",
        "documents": ["Income proof", "Employment certificate", "Bank statements", "Identity proof"],
        "icon": Icons.family_restroom,
        "color": successColor
      },
      {
        "category": "Additional Documents",
        "documents": ["Property papers (if any)", "Other loan statements", "Academic transcripts"],
        "icon": Icons.description,
        "color": infoColor
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
          ...List.generate(documentCategories.length, (index) {
            final docCategory = documentCategories[index];
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (docCategory["color"] as Color).withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        docCategory["icon"],
                        color: docCategory["color"],
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${docCategory["category"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: docCategory["color"],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Required: ${(docCategory["documents"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 11,
                      color: docCategory["color"],
                    ),
                  ),
                ],
              ),
            );
          }),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: dangerColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "All documents should be original or certified copies. Additional documents may be required based on the course and institution.",
                    style: TextStyle(
                      fontSize: 11,
                      color: dangerColor,
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
}
