import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPreApprovalView extends StatefulWidget {
  const RmaPreApprovalView({super.key});

  @override
  State<RmaPreApprovalView> createState() => _RmaPreApprovalViewState();
}

class _RmaPreApprovalViewState extends State<RmaPreApprovalView> {
  String selectedLoanType = "conventional";
  String creditScore = "740";
  String annualIncome = "85000";
  String monthlyDebts = "1200";
  String downPayment = "20";
  String employmentType = "full-time";
  String employmentYears = "3";
  bool hasStudentLoans = false;
  bool hasCreditCardDebt = true;
  bool hasAutoLoan = false;
  bool hasOtherMortgage = false;
  
  List<Map<String, dynamic>> preApprovalHistory = [
    {
      "lender": "Chase Bank",
      "amount": 425000,
      "rate": 6.75,
      "date": "2024-03-15",
      "status": "approved",
      "expiryDate": "2024-06-15",
      "type": "Conventional 30-Year"
    },
    {
      "lender": "Wells Fargo",
      "amount": 400000,
      "rate": 6.85,
      "date": "2024-03-10",
      "status": "approved",
      "expiryDate": "2024-06-10",
      "type": "Conventional 30-Year"
    },
    {
      "lender": "Bank of America",
      "amount": 380000,
      "rate": 6.95,
      "date": "2024-03-08",
      "status": "pending",
      "expiryDate": "2024-06-08",
      "type": "FHA 30-Year"
    },
    {
      "lender": "Quicken Loans",
      "amount": 450000,
      "rate": 6.65,
      "date": "2024-03-12",
      "status": "approved",
      "expiryDate": "2024-06-12",
      "type": "Conventional 15-Year"
    }
  ];

  List<Map<String, dynamic>> requiredDocuments = [
    {
      "document": "Pay Stubs",
      "description": "Last 2 pay stubs",
      "status": "completed",
      "uploaded": true
    },
    {
      "document": "Tax Returns",
      "description": "Last 2 years W-2 forms",
      "status": "completed",
      "uploaded": true
    },
    {
      "document": "Bank Statements",
      "description": "Last 3 months statements",
      "status": "pending",
      "uploaded": false
    },
    {
      "document": "Employment Letter",
      "description": "Letter of employment verification",
      "status": "completed",
      "uploaded": true
    },
    {
      "document": "Credit Report",
      "description": "Recent credit report",
      "status": "pending",
      "uploaded": false
    },
    {
      "document": "Asset Statements",
      "description": "Investment and retirement accounts",
      "status": "not_started",
      "uploaded": false
    }
  ];

  List<Map<String, dynamic>> lenderOptions = [
    {
      "name": "Chase Bank",
      "rating": 4.5,
      "avgRate": 6.75,
      "minCredit": 620,
      "maxLTV": 97,
      "processingTime": "15-30 days",
      "specialties": ["Conventional", "Jumbo", "FHA"]
    },
    {
      "name": "Wells Fargo",
      "rating": 4.3,
      "avgRate": 6.85,
      "minCredit": 640,
      "maxLTV": 95,
      "processingTime": "20-35 days",
      "specialties": ["Conventional", "VA", "FHA"]
    },
    {
      "name": "Quicken Loans",
      "rating": 4.7,
      "avgRate": 6.65,
      "minCredit": 580,
      "maxLTV": 97,
      "processingTime": "10-25 days",
      "specialties": ["FHA", "VA", "USDA"]
    },
    {
      "name": "Bank of America",
      "rating": 4.2,
      "avgRate": 6.95,
      "minCredit": 660,
      "maxLTV": 90,
      "processingTime": "25-40 days",
      "specialties": ["Conventional", "Jumbo"]
    }
  ];

  List<Map<String, dynamic>> preApprovalTips = [
    {
      "title": "Check Your Credit Score",
      "description": "Review your credit report for errors and pay down debt to improve your score before applying.",
      "icon": Icons.credit_score,
      "priority": "high"
    },
    {
      "title": "Gather Financial Documents",
      "description": "Prepare all required documents in advance to speed up the pre-approval process.",
      "icon": Icons.folder,
      "priority": "high"
    },
    {
      "title": "Calculate Debt-to-Income",
      "description": "Ensure your debt-to-income ratio is below 43% for better approval chances.",
      "icon": Icons.calculate,
      "priority": "medium"
    },
    {
      "title": "Save for Down Payment",
      "description": "A larger down payment can help you get better rates and terms.",
      "icon": Icons.savings,
      "priority": "medium"
    },
    {
      "title": "Shop Multiple Lenders",
      "description": "Compare rates and terms from different lenders within a 14-45 day window.",
      "icon": Icons.compare,
      "priority": "low"
    },
    {
      "title": "Avoid Large Purchases",
      "description": "Don't make major purchases or open new credit accounts during the process.",
      "icon": Icons.warning,
      "priority": "high"
    }
  ];

  String selectedTab = "application";
  bool isCalculating = false;
  double estimatedPreApproval = 0;

  void _calculatePreApproval() {
    setState(() {
      isCalculating = true;
    });

    // Simulate calculation
    Future.delayed(Duration(seconds: 2), () {
      double income = double.tryParse(annualIncome) ?? 0;
      double debts = double.tryParse(monthlyDebts) ?? 0;
      double monthlyIncome = income / 12;
      double dti = debts / monthlyIncome;
      
      // Simple calculation based on 28% front-end ratio
      double maxMonthlyPayment = monthlyIncome * 0.28;
      double loanAmount = maxMonthlyPayment * 300; // Rough estimate
      
      // Adjust based on credit score
      int credit = int.tryParse(creditScore) ?? 700;
      if (credit >= 740) {
        loanAmount *= 1.1;
      } else if (credit < 620) {
        loanAmount *= 0.8;
      }

      setState(() {
        estimatedPreApproval = loanAmount;
        isCalculating = false;
      });
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "approved":
        return successColor;
      case "pending":
        return warningColor;
      case "rejected":
        return dangerColor;
      case "completed":
        return successColor;
      case "not_started":
        return disabledColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildApplicationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pre-Approval Application",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        
        // Personal Information Section
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
                "Personal Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QDropdownField(
                label: "Loan Type",
                items: [
                  {"label": "Conventional", "value": "conventional"},
                  {"label": "FHA", "value": "fha"},
                  {"label": "VA", "value": "va"},
                  {"label": "USDA", "value": "usda"},
                  {"label": "Jumbo", "value": "jumbo"},
                ],
                value: selectedLoanType,
                onChanged: (value, label) {
                  selectedLoanType = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Credit Score",
                      value: creditScore,
                      hint: "Enter your credit score",
                      onChanged: (value) {
                        creditScore = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Annual Income (\$)",
                      value: annualIncome,
                      hint: "Gross annual income",
                      onChanged: (value) {
                        annualIncome = value;
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
                    child: QTextField(
                      label: "Monthly Debts (\$)",
                      value: monthlyDebts,
                      hint: "Total monthly debt payments",
                      onChanged: (value) {
                        monthlyDebts = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Down Payment (%)",
                      value: downPayment,
                      hint: "Down payment percentage",
                      onChanged: (value) {
                        downPayment = value;
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
                    child: QDropdownField(
                      label: "Employment Type",
                      items: [
                        {"label": "Full-time", "value": "full-time"},
                        {"label": "Part-time", "value": "part-time"},
                        {"label": "Self-employed", "value": "self-employed"},
                        {"label": "Contract", "value": "contract"},
                        {"label": "Retired", "value": "retired"},
                      ],
                      value: employmentType,
                      onChanged: (value, label) {
                        employmentType = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Years at Job",
                      value: employmentYears,
                      hint: "Years in current position",
                      onChanged: (value) {
                        employmentYears = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        
        // Debt Information Section
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
                "Existing Debt Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QSwitch(
                label: "Student Loans",
                items: [
                  {
                    "label": "I have student loans",
                    "value": true,
                    "checked": hasStudentLoans,
                  }
                ],
                value: [if (hasStudentLoans) {"label": "I have student loans", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  hasStudentLoans = values.isNotEmpty;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QSwitch(
                label: "Credit Card Debt",
                items: [
                  {
                    "label": "I have credit card debt",
                    "value": true,
                    "checked": hasCreditCardDebt,
                  }
                ],
                value: [if (hasCreditCardDebt) {"label": "I have credit card debt", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  hasCreditCardDebt = values.isNotEmpty;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QSwitch(
                label: "Auto Loan",
                items: [
                  {
                    "label": "I have an auto loan",
                    "value": true,
                    "checked": hasAutoLoan,
                  }
                ],
                value: [if (hasAutoLoan) {"label": "I have an auto loan", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  hasAutoLoan = values.isNotEmpty;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QSwitch(
                label: "Other Mortgage",
                items: [
                  {
                    "label": "I have another mortgage",
                    "value": true,
                    "checked": hasOtherMortgage,
                  }
                ],
                value: [if (hasOtherMortgage) {"label": "I have another mortgage", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  hasOtherMortgage = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        
        // Calculate Button
        Container(
          width: double.infinity,
          child: QButton(
            label: isCalculating ? "Calculating..." : "Calculate Pre-Approval",
            size: bs.md,
            onPressed: isCalculating ? null : _calculatePreApproval,
          ),
        ),
        
        if (estimatedPreApproval > 0) ...[
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(50)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 40,
                ),
                SizedBox(height: spSm),
                Text(
                  "Estimated Pre-Approval",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
                Text(
                  "\$${(estimatedPreApproval).currency}",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "This is an estimate. Actual pre-approval may vary based on lender criteria.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPreApprovalHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pre-Approval History",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        
        ...preApprovalHistory.map((approval) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getStatusColor("${approval["status"]}"),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${approval["lender"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${approval["status"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${approval["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor("${approval["status"]}"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
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
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((approval["amount"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 16,
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
                            "Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(approval["rate"] as double).toStringAsFixed(2)}%",
                            style: TextStyle(
                              fontSize: 16,
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
                            "Type",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${approval["type"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Applied: ${approval["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Expires: ${approval["expiryDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          ss("Viewing pre-approval details");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        child: QButton(
                          label: approval["status"] == "approved" ? "Use This" : "Reapply",
                          size: bs.sm,
                          onPressed: () {
                            ss(approval["status"] == "approved" ? "Using this pre-approval" : "Reapplying for pre-approval");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildDocuments() {
    return Column(
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
        SizedBox(height: spMd),
        
        ...requiredDocuments.map((doc) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getStatusColor("${doc["status"]}"),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _getStatusColor("${doc["status"]}").withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    doc["uploaded"] ? Icons.check_circle : Icons.file_present,
                    color: _getStatusColor("${doc["status"]}"),
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${doc["document"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${doc["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${doc["status"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${doc["status"]}".replaceAll("_", " ").toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor("${doc["status"]}"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Column(
                  children: [
                    QButton(
                      label: doc["uploaded"] ? "Replace" : "Upload",
                      size: bs.sm,
                      onPressed: () {
                        ss("${doc["uploaded"] ? "Replacing" : "Uploading"} ${doc["document"]}");
                      },
                    ),
                    if (doc["uploaded"]) ...[
                      SizedBox(height: spXs),
                      GestureDetector(
                        onTap: () {
                          ss("Viewing ${doc["document"]}");
                        },
                        child: Text(
                          "View",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildLenders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recommended Lenders",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        
        ...lenderOptions.map((lender) {
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
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
                    Expanded(
                      child: Text(
                        "${lender["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(lender["rating"] as double).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 120,
                  children: [
                    _buildLenderStat("Avg Rate", "${(lender["avgRate"] as double).toStringAsFixed(2)}%"),
                    _buildLenderStat("Min Credit", "${lender["minCredit"]}"),
                    _buildLenderStat("Max LTV", "${lender["maxLTV"]}%"),
                    _buildLenderStat("Processing", "${lender["processingTime"]}"),
                  ],
                ),
                SizedBox(height: spMd),
                
                Text(
                  "Specialties:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (lender["specialties"] as List).map((specialty) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$specialty",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Get Pre-Approved",
                        size: bs.sm,
                        onPressed: () {
                          ss("Starting pre-approval with ${lender["name"]}");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        child: QButton(
                          label: "Learn More",
                          size: bs.sm,
                          onPressed: () {
                            ss("Learning more about ${lender["name"]}");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildLenderStat(String label, String value) {
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
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pre-Approval Tips",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        
        ...preApprovalTips.map((tip) {
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getPriorityColor("${tip["priority"]}"),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _getPriorityColor("${tip["priority"]}").withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    tip["icon"],
                    color: _getPriorityColor("${tip["priority"]}"),
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${tip["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getPriorityColor("${tip["priority"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${tip["priority"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getPriorityColor("${tip["priority"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${tip["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pre-Approval Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              si("Pre-approval help information");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "application";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: selectedTab == "application" ? primaryColor : Colors.transparent,
                          ),
                        ),
                      ),
                      child: Text(
                        "Application",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "application" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "history";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: selectedTab == "history" ? primaryColor : Colors.transparent,
                          ),
                        ),
                      ),
                      child: Text(
                        "History",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "history" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "documents";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: selectedTab == "documents" ? primaryColor : Colors.transparent,
                          ),
                        ),
                      ),
                      child: Text(
                        "Documents",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "documents" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "lenders";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: selectedTab == "lenders" ? primaryColor : Colors.transparent,
                          ),
                        ),
                      ),
                      child: Text(
                        "Lenders",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "lenders" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "tips";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: selectedTab == "tips" ? primaryColor : Colors.transparent,
                          ),
                        ),
                      ),
                      child: Text(
                        "Tips",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "tips" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: selectedTab == "application"
                  ? _buildApplicationForm()
                  : selectedTab == "history"
                  ? _buildPreApprovalHistory()
                  : selectedTab == "documents"
                  ? _buildDocuments()
                  : selectedTab == "lenders"
                  ? _buildLenders()
                  : _buildTips(),
            ),
          ),
        ],
      ),
    );
  }
}
