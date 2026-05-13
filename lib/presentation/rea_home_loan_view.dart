import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaHomeLoanView extends StatefulWidget {
  const ReaHomeLoanView({super.key});

  @override
  State<ReaHomeLoanView> createState() => _ReaHomeLoanViewState();
}

class _ReaHomeLoanViewState extends State<ReaHomeLoanView> {
  int currentTab = 0;
  String loanType = "Home Purchase";
  String propertyPrice = "";
  String downPayment = "";
  String loanTerm = "30";
  String creditScore = "750";
  String monthlyIncome = "";
  String monthlyDebt = "";
  bool isFirstTimeBuyer = false;
  bool hasMortgage = false;
  
  List<Map<String, dynamic>> loanPrograms = [
    {
      "id": "conv30",
      "name": "Conventional 30-Year Fixed",
      "rate": 6.75,
      "apr": 6.85,
      "payment": 2500,
      "description": "Traditional mortgage with fixed rate",
      "minDownPayment": 3,
      "features": ["No PMI with 20% down", "Flexible terms", "Rate lock options"]
    },
    {
      "id": "fha30",
      "name": "FHA 30-Year Fixed",
      "rate": 6.25,
      "apr": 6.45,
      "payment": 2350,
      "description": "Government-backed loan with lower down payment",
      "minDownPayment": 3.5,
      "features": ["Low down payment", "Flexible credit requirements", "Assumable loan"]
    },
    {
      "id": "va30",
      "name": "VA 30-Year Fixed",
      "rate": 6.50,
      "apr": 6.60,
      "payment": 2400,
      "description": "For eligible veterans and service members",
      "minDownPayment": 0,
      "features": ["No down payment", "No PMI", "No prepayment penalty"]
    },
    {
      "id": "arm51",
      "name": "5/1 Adjustable Rate",
      "rate": 5.95,
      "apr": 6.75,
      "payment": 2200,
      "description": "Fixed rate for 5 years, then adjusts annually",
      "minDownPayment": 5,
      "features": ["Lower initial rate", "Rate caps", "Conversion options"]
    }
  ];

  List<Map<String, dynamic>> loanOfficers = [
    {
      "id": "1",
      "name": "Sarah Mitchell",
      "title": "Senior Loan Officer",
      "experience": "12 years",
      "rating": 4.9,
      "reviews": 156,
      "phone": "(555) 123-4567",
      "email": "sarah.mitchell@lender.com",
      "image": "https://picsum.photos/100/100?random=1&keyword=woman",
      "specialties": ["First-time buyers", "FHA loans", "VA loans"],
      "languages": ["English", "Spanish"]
    },
    {
      "id": "2", 
      "name": "Michael Rodriguez",
      "title": "Mortgage Specialist",
      "experience": "8 years",
      "rating": 4.8,
      "reviews": 203,
      "phone": "(555) 234-5678",
      "email": "michael.rodriguez@lender.com",
      "image": "https://picsum.photos/100/100?random=2&keyword=man",
      "specialties": ["Conventional loans", "Jumbo loans", "Investment properties"],
      "languages": ["English", "Portuguese"]
    }
  ];

  List<Map<String, dynamic>> documents = [
    {
      "category": "Income Verification",
      "items": [
        {"name": "W-2 Forms (2 years)", "required": true, "uploaded": false},
        {"name": "Pay Stubs (30 days)", "required": true, "uploaded": false},
        {"name": "Tax Returns (2 years)", "required": true, "uploaded": false},
        {"name": "Bank Statements (2 months)", "required": true, "uploaded": false}
      ]
    },
    {
      "category": "Asset Documentation",
      "items": [
        {"name": "Checking Account Statements", "required": true, "uploaded": false},
        {"name": "Savings Account Statements", "required": true, "uploaded": false},
        {"name": "Investment Account Statements", "required": false, "uploaded": false},
        {"name": "Gift Letter (if applicable)", "required": false, "uploaded": false}
      ]
    },
    {
      "category": "Property Information",
      "items": [
        {"name": "Purchase Agreement", "required": true, "uploaded": false},
        {"name": "Property Appraisal", "required": true, "uploaded": false},
        {"name": "Homeowners Insurance", "required": true, "uploaded": false},
        {"name": "HOA Documents", "required": false, "uploaded": false}
      ]
    }
  ];

  double calculateMonthlyPayment(double loanAmount, double rate, int years) {
    double monthlyRate = rate / 100 / 12;
    int numberOfPayments = years * 12;
    return loanAmount * (monthlyRate * pow(1 + monthlyRate, numberOfPayments)) / 
           (pow(1 + monthlyRate, numberOfPayments) - 1);
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Home Loan Center",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Calculator", icon: Icon(Icons.calculate)),
        Tab(text: "Programs", icon: Icon(Icons.home_work)),
        Tab(text: "Officers", icon: Icon(Icons.people)),
        Tab(text: "Documents", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildCalculatorTab(),
        _buildProgramsTab(),
        _buildOfficersTab(),
        _buildDocumentsTab(),
      ],
    );
  }

  Widget _buildCalculatorTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Loan Calculator Card
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Loan Calculator",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                // Loan Type Selection
                QDropdownField(
                  label: "Loan Type",
                  items: [
                    {"label": "Home Purchase", "value": "Home Purchase"},
                    {"label": "Refinance", "value": "Refinance"},
                    {"label": "Cash-Out Refinance", "value": "Cash-Out Refinance"},
                    {"label": "Home Equity Loan", "value": "Home Equity Loan"},
                  ],
                  value: loanType,
                  onChanged: (value, label) {
                    loanType = value;
                    setState(() {});
                  },
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Property Price (\$)",
                        value: propertyPrice,
                        onChanged: (value) {
                          propertyPrice = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Down Payment (\$)",
                        value: downPayment,
                        onChanged: (value) {
                          downPayment = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Loan Term",
                        items: [
                          {"label": "15 years", "value": "15"},
                          {"label": "20 years", "value": "20"},
                          {"label": "25 years", "value": "25"},
                          {"label": "30 years", "value": "30"},
                        ],
                        value: loanTerm,
                        onChanged: (value, label) {
                          loanTerm = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Credit Score",
                        items: [
                          {"label": "Excellent (750+)", "value": "750"},
                          {"label": "Good (700-749)", "value": "700"},
                          {"label": "Fair (650-699)", "value": "650"},
                          {"label": "Poor (600-649)", "value": "600"},
                        ],
                        value: creditScore,
                        onChanged: (value, label) {
                          creditScore = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Calculate Payment",
                    onPressed: () {
                      // Calculate and show results
                      ss("Payment calculated based on current inputs");
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Results Card
          if (propertyPrice.isNotEmpty && downPayment.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Estimated Monthly Payment",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "\$2,485",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  Divider(color: Colors.white.withAlpha(128)),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Principal & Interest",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(179),
                            ),
                          ),
                          Text(
                            "\$1,985",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Property Tax",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(179),
                            ),
                          ),
                          Text(
                            "\$350",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Insurance",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(179),
                            ),
                          ),
                          Text(
                            "\$150",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          
          // Affordability Assessment
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Affordability Assessment",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Monthly Income (\$)",
                        value: monthlyIncome,
                        onChanged: (value) {
                          monthlyIncome = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Monthly Debt (\$)",
                        value: monthlyDebt,
                        onChanged: (value) {
                          monthlyDebt = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "First-time buyer",
                            "value": true,
                            "checked": isFirstTimeBuyer,
                          }
                        ],
                        value: [
                          if (isFirstTimeBuyer)
                            {"label": "First-time buyer", "value": true, "checked": true}
                        ],
                        onChanged: (values, ids) {
                          isFirstTimeBuyer = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Current mortgage",
                            "value": true,
                            "checked": hasMortgage,
                          }
                        ],
                        value: [
                          if (hasMortgage)
                            {"label": "Current mortgage", "value": true, "checked": true}
                        ],
                        onChanged: (values, ids) {
                          hasMortgage = values.isNotEmpty;
                          setState(() {});
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

  Widget _buildProgramsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Program Comparison Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(179)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Loan Programs",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Compare different loan options to find the best fit for your needs",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
              ],
            ),
          ),
          
          // Loan Programs List
          ...loanPrograms.map((program) => Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${program["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${program["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${(program["minDownPayment"] as num)}% Down",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Interest Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(program["rate"] as num).toStringAsFixed(3)}%",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
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
                            "APR",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(program["apr"] as num).toStringAsFixed(3)}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
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
                            "Est. Payment",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(program["payment"] as int).toString()}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                Divider(color: disabledOutlineBorderColor),
                
                Text(
                  "Key Features:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                
                ...(program["features"] as List).map((feature) => Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: successColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "$feature",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                )),
                
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Get Quote",
                        size: bs.sm,
                        onPressed: () {
                          ss("Quote request submitted for ${program["name"]}");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        height: 36,
                        child: OutlinedButton(
                          onPressed: () {
                            // Show more details
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                          child: Text(
                            "Learn More",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildOfficersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.people,
                  color: primaryColor,
                  size: 28,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Loan Officers",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Connect with experienced professionals to guide your loan process",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Loan Officers List
          ...loanOfficers.map((officer) => Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusLg),
                        image: DecorationImage(
                          image: NetworkImage("${officer["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${officer["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${officer["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${officer["experience"]} experience",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              ...List.generate(5, (index) => Icon(
                                Icons.star,
                                size: 16,
                                color: index < (officer["rating"] as num).floor() 
                                    ? warningColor 
                                    : disabledColor,
                              )),
                              SizedBox(width: spXs),
                              Text(
                                "${(officer["rating"] as num)} (${officer["reviews"]} reviews)",
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
                  ],
                ),
                
                Divider(color: disabledOutlineBorderColor),
                
                Text(
                  "Specialties:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                
                Wrap(
                  spacing: spXs,
                  children: (officer["specialties"] as List).map((specialty) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$specialty",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  )).toList(),
                ),
                
                Text(
                  "Languages: ${(officer["languages"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Call",
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {
                          ss("Calling ${officer["name"]}...");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Email",
                        icon: Icons.email,
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening email to ${officer["name"]}...");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        height: 36,
                        child: OutlinedButton(
                          onPressed: () {
                            // Schedule consultation
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                          child: Text(
                            "Schedule",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Progress Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(179)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Document Checklist",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "2/12 Complete",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(77),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 2 / 12,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
                
                Text(
                  "Upload required documents to expedite your loan processing",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
              ],
            ),
          ),
          
          // Document Categories
          ...documents.map((category) => Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.folder,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${category["category"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                ...(category["items"] as List).map((item) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: (item["uploaded"] as bool) 
                        ? successColor.withAlpha(26) 
                        : disabledColor.withAlpha(13),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: (item["uploaded"] as bool) 
                          ? successColor 
                          : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        (item["uploaded"] as bool) ? Icons.check_circle : Icons.upload_file,
                        color: (item["uploaded"] as bool) ? successColor : primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                if (item["required"] as bool) ...[
                                  SizedBox(width: spXs),
                                  Text(
                                    "*",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: dangerColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            if (item["uploaded"] as bool)
                              Text(
                                "Uploaded successfully",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              )
                            else
                              Text(
                                (item["required"] as bool) ? "Required" : "Optional",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: (item["required"] as bool) ? dangerColor : disabledBoldColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (!(item["uploaded"] as bool))
                        GestureDetector(
                          onTap: () {
                            // Upload document
                            ss("Document upload started");
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Upload",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          )).toList(),
          
          // Action Buttons
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
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Upload Multiple Documents",
                    icon: Icons.cloud_upload,
                    onPressed: () {
                      ss("Bulk upload started");
                    },
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 44,
                        child: OutlinedButton(
                          onPressed: () {
                            // Save progress
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                          child: Text(
                            "Save Progress",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        height: 44,
                        child: OutlinedButton(
                          onPressed: () {
                            // Get help
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                          child: Text(
                            "Need Help?",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
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
}

double pow(double base, int exponent) {
  double result = 1;
  for (int i = 0; i < exponent; i++) {
    result *= base;
  }
  return result;
}
