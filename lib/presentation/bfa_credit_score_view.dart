import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaCreditScoreView extends StatefulWidget {
  const BfaCreditScoreView({super.key});

  @override
  State<BfaCreditScoreView> createState() => _BfaCreditScoreViewState();
}

class _BfaCreditScoreViewState extends State<BfaCreditScoreView> {
  int currentTab = 0;
  
  Map<String, dynamic> creditProfile = {
    "score": 750,
    "rating": "Excellent",
    "lastUpdated": "15 Dec 2024",
    "changeFromLastMonth": 25,
    "percentile": 85,
    "creditAge": "5 years 3 months",
    "utilization": 25,
    "paymentHistory": 98,
    "creditMix": "Good",
    "inquiries": 2,
  };
  
  List<Map<String, dynamic>> scoreFacts = [
    {
      "factor": "Payment History",
      "impact": "High",
      "percentage": 98,
      "status": "Excellent",
      "description": "You have never missed a payment",
      "color": Colors.green,
    },
    {
      "factor": "Credit Utilization",
      "impact": "High", 
      "percentage": 25,
      "status": "Good",
      "description": "Keep it below 30% for better score",
      "color": Colors.orange,
    },
    {
      "factor": "Credit Age",
      "impact": "Medium",
      "percentage": 75,
      "status": "Good",
      "description": "Average age of 5 years 3 months",
      "color": Colors.green,
    },
    {
      "factor": "Credit Mix",
      "impact": "Medium",
      "percentage": 80,
      "status": "Good",
      "description": "Good mix of secured and unsecured credit",
      "color": Colors.green,
    },
    {
      "factor": "Recent Inquiries",
      "impact": "Low",
      "percentage": 90,
      "status": "Excellent",
      "description": "Only 2 inquiries in last 2 years",
      "color": Colors.green,
    },
  ];
  
  List<Map<String, dynamic>> creditHistory = [
    {
      "date": "Dec 2024",
      "score": 750,
      "change": 25,
      "reason": "Credit utilization decreased",
    },
    {
      "date": "Nov 2024", 
      "score": 725,
      "change": -10,
      "reason": "New credit inquiry",
    },
    {
      "date": "Oct 2024",
      "score": 735,
      "change": 15,
      "reason": "On-time payments",
    },
    {
      "date": "Sep 2024",
      "score": 720,
      "change": 8,
      "reason": "Reduced debt amount",
    },
    {
      "date": "Aug 2024",
      "score": 712,
      "change": 0,
      "reason": "No significant changes",
    },
  ];
  
  List<Map<String, dynamic>> creditAccounts = [
    {
      "type": "Credit Card",
      "bank": "HDFC Bank",
      "accountName": "Regalia Credit Card",
      "limit": 500000,
      "used": 125000,
      "utilization": 25,
      "status": "Active",
      "paymentHistory": "Excellent",
      "accountAge": "3 years",
    },
    {
      "type": "Personal Loan",
      "bank": "SBI",
      "accountName": "Personal Loan",
      "limit": 800000,
      "used": 320000,
      "utilization": 40,
      "status": "Active",
      "paymentHistory": "Good",
      "accountAge": "2 years",
    },
    {
      "type": "Home Loan",
      "bank": "ICICI Bank",
      "accountName": "Home Loan",
      "limit": 5000000,
      "used": 3200000,
      "utilization": 64,
      "status": "Active",
      "paymentHistory": "Excellent",
      "accountAge": "5 years",
    },
    {
      "type": "Credit Card",
      "bank": "Axis Bank",
      "accountName": "Magnus Credit Card",
      "limit": 300000,
      "used": 45000,
      "utilization": 15,
      "status": "Active",
      "paymentHistory": "Excellent",
      "accountAge": "1.5 years",
    },
  ];
  
  List<Map<String, dynamic>> improvementTips = [
    {
      "title": "Reduce Credit Utilization",
      "description": "Keep your credit card usage below 30% of the limit",
      "impact": "High",
      "timeFrame": "1-2 months",
      "priority": "High",
      "icon": Icons.credit_card,
      "currentValue": "25%",
      "targetValue": "< 30%",
    },
    {
      "title": "Continue Timely Payments",
      "description": "Maintain your excellent payment history",
      "impact": "High",
      "timeFrame": "Ongoing",
      "priority": "High",
      "icon": Icons.schedule,
      "currentValue": "98%",
      "targetValue": "100%",
    },
    {
      "title": "Diversify Credit Mix",
      "description": "Consider adding a secured credit card",
      "impact": "Medium",
      "timeFrame": "3-6 months",
      "priority": "Medium",
      "icon": Icons.account_balance,
      "currentValue": "Good",
      "targetValue": "Excellent",
    },
    {
      "title": "Limit Credit Inquiries",
      "description": "Avoid applying for new credit frequently",
      "impact": "Low",
      "timeFrame": "6 months",
      "priority": "Low",
      "icon": Icons.search,
      "currentValue": "2 inquiries",
      "targetValue": "< 2 per year",
    },
  ];
  
  List<Map<String, dynamic>> offers = [
    {
      "type": "Credit Card",
      "provider": "HDFC Bank",
      "productName": "Millennia Credit Card",
      "features": ["5% cashback on online purchases", "No annual fee", "Welcome bonus"],
      "eligibility": "Pre-approved",
      "apr": "3.49% per month",
      "annualFee": 0,
      "limit": "Up to ₹2,00,000",
    },
    {
      "type": "Personal Loan",
      "provider": "SBI", 
      "productName": "Xpress Credit Personal Loan",
      "features": ["Instant approval", "No collateral", "Flexible tenure"],
      "eligibility": "Eligible",
      "apr": "10.50% per annum",
      "annualFee": 1000,
      "limit": "Up to ₹15,00,000",
    },
    {
      "type": "Credit Card",
      "provider": "American Express",
      "productName": "Gold Credit Card",
      "features": ["Reward points", "Airport lounge access", "Travel insurance"],
      "eligibility": "Apply now",
      "apr": "3.49% per month", 
      "annualFee": 4500,
      "limit": "Up to ₹5,00,000",
    },
  ];

  Widget _buildCreditScoreCard() {
    int score = creditProfile["score"] as int;
    String rating = creditProfile["rating"] as String;
    int change = creditProfile["changeFromLastMonth"] as int;
    
    Color scoreColor = score >= 750 ? Colors.green :
                      score >= 650 ? Colors.orange : Colors.red;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scoreColor, scoreColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Credit Score",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(179),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "$score",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Padding(
                          padding: EdgeInsets.only(bottom: spSm),
                          child: Text(
                            "/ 900",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withAlpha(179),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      rating,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        change >= 0 ? Icons.trending_up : Icons.trending_down,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${change >= 0 ? '+' : ''}$change",
                        style: TextStyle(
                          fontSize: 14,
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
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Last updated: ${creditProfile["lastUpdated"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withAlpha(179),
                  ),
                ),
                Text(
                  "${creditProfile["percentile"]}th percentile",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreFactors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Score Factors",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...scoreFacts.map((factor) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${factor["factor"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${factor["description"]}",
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: (factor["color"] as Color).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${factor["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: factor["color"] as Color,
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${factor["impact"]} Impact",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                LinearProgressIndicator(
                  value: (factor["percentage"] as int) / 100,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(factor["color"] as Color),
                ),
                SizedBox(height: spXs),
                Text(
                  "${factor["percentage"]}%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: factor["color"] as Color,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildCreditHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Credit History",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: creditHistory.map((history) {
              int change = history["change"] as int;
              bool isPositive = change >= 0;
              
              return Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: disabledColor,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: isPositive ? successColor : dangerColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${history["date"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${history["score"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isPositive ? successColor.withAlpha(51) : dangerColor.withAlpha(51),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${isPositive ? '+' : ''}$change",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isPositive ? successColor : dangerColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${history["reason"]}",
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
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCreditAccounts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Credit Accounts",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...creditAccounts.map((account) {
          double utilization = (account["utilization"] as int).toDouble();
          Color utilizationColor = utilization > 70 ? dangerColor :
                                  utilization > 30 ? warningColor : successColor;
          
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
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        account["type"] == "Credit Card" ? Icons.credit_card :
                        account["type"] == "Personal Loan" ? Icons.person :
                        Icons.home,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${account["accountName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${account["bank"]} • ${account["accountAge"]}",
                            style: TextStyle(
                              fontSize: 12,
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
                        "${account["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Used Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "₹${((account["used"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
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
                            "Total Limit",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "₹${((account["limit"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
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
                            "Utilization",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${utilization.toInt()}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: utilizationColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                LinearProgressIndicator(
                  value: utilization / 100,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(utilizationColor),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildImprovementTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Score Improvement Tips",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...improvementTips.map((tip) {
          Color priorityColor = tip["priority"] == "High" ? dangerColor :
                               tip["priority"] == "Medium" ? warningColor : infoColor;
          
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
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        tip["icon"] as IconData,
                        color: priorityColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${tip["title"]}",
                            style: TextStyle(
                              fontSize: 16,
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${tip["priority"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: priorityColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildTipMetric("Current", "${tip["currentValue"]}"),
                    ),
                    Expanded(
                      child: _buildTipMetric("Target", "${tip["targetValue"]}"),
                    ),
                    Expanded(
                      child: _buildTipMetric("Timeline", "${tip["timeFrame"]}"),
                    ),
                    Expanded(
                      child: _buildTipMetric("Impact", "${tip["impact"]}"),
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

  Widget _buildOffers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pre-approved Offers",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...offers.map((offer) {
          Color eligibilityColor = offer["eligibility"] == "Pre-approved" ? successColor :
                                  offer["eligibility"] == "Eligible" ? infoColor : warningColor;
          
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
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        offer["type"] == "Credit Card" ? Icons.credit_card : Icons.account_balance,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${offer["productName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${offer["provider"]} • ${offer["limit"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: eligibilityColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${offer["eligibility"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: eligibilityColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Key Features:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...(offer["features"] as List<String>).map((feature) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 14,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                feature,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildOfferDetail("APR", "${offer["apr"]}"),
                    ),
                    Expanded(
                      child: _buildOfferDetail("Annual Fee", "₹${((offer["annualFee"] as int).toDouble()).currency}"),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: offer["eligibility"] == "Pre-approved" ? "Apply Now" : "Learn More",
                    size: bs.sm,
                    onPressed: () {
                      ss("Application started for ${offer["productName"]}");
                    },
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTipMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: 2),
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

  Widget _buildOfferDetail(String label, String value) {
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Credit Score",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Score", icon: Icon(Icons.assessment)),
        Tab(text: "Factors", icon: Icon(Icons.pie_chart)),
        Tab(text: "History", icon: Icon(Icons.timeline)),
        Tab(text: "Accounts", icon: Icon(Icons.account_balance_wallet)),
        Tab(text: "Tips", icon: Icon(Icons.lightbulb)),
        Tab(text: "Offers", icon: Icon(Icons.local_offer)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              _buildCreditScoreCard(),
              SizedBox(height: spMd),
              _buildScoreFactors(),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildScoreFactors(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildCreditHistory(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildCreditAccounts(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildImprovementTips(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildOffers(),
        ),
      ],
    );
  }
}
