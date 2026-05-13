import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaLoanDetailsView extends StatefulWidget {
  const BfaLoanDetailsView({super.key});

  @override
  State<BfaLoanDetailsView> createState() => _BfaLoanDetailsViewState();
}

class _BfaLoanDetailsViewState extends State<BfaLoanDetailsView> {
  Map<String, dynamic> loanData = {
    "id": "LN001234",
    "type": "Personal Loan",
    "amount": 150000.0,
    "remaining": 75000.0,
    "interestRate": 12.5,
    "tenure": 36,
    "monthlyEmi": 5125.0,
    "nextDueDate": "2025-07-15",
    "status": "Active",
    "applicationDate": "2023-01-15",
    "disbursalDate": "2023-02-01",
    "purpose": "Home Renovation",
    "paidEmis": 18,
    "remainingEmis": 18,
    "totalInterest": 34500.0,
    "processingFee": 2000.0,
    "prepaymentCharges": "2% of outstanding amount",
    "lateFee": 500.0
  };

  List<Map<String, dynamic>> emiHistory = [
    {
      "date": "2025-06-15",
      "amount": 5125.0,
      "principal": 3850.0,
      "interest": 1275.0,
      "status": "Paid",
      "paymentMethod": "Auto Debit"
    },
    {
      "date": "2025-05-15",
      "amount": 5125.0,
      "principal": 3820.0,
      "interest": 1305.0,
      "status": "Paid",
      "paymentMethod": "Net Banking"
    },
    {
      "date": "2025-04-15",
      "amount": 5125.0,
      "principal": 3790.0,
      "interest": 1335.0,
      "status": "Paid",
      "paymentMethod": "Auto Debit"
    },
    {
      "date": "2025-03-15",
      "amount": 5125.0,
      "principal": 3760.0,
      "interest": 1365.0,
      "status": "Paid",
      "paymentMethod": "UPI"
    }
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Loan Details",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "EMI History", icon: Icon(Icons.history)),
        Tab(text: "Documents", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildEmiHistoryTab(),
        _buildDocumentsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLoanSummaryCard(),
          _buildProgressCard(),
          _buildLoanDetailsCard(),
          _buildNextPaymentCard(),
          _buildActionsCard(),
        ],
      ),
    );
  }

  Widget _buildLoanSummaryCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${loanData["type"]}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${loanData["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Loan ID: ${loanData["id"]}",
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
                      "Loan Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "₹${((loanData["amount"] as double)).currency}",
                      style: TextStyle(
                        fontSize: fsH4,
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
                      "Outstanding",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "₹${((loanData["remaining"] as double)).currency}",
                      style: TextStyle(
                        fontSize: fsH4,
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

  Widget _buildProgressCard() {
    double progress = (((loanData["amount"] as double) - (loanData["remaining"] as double)) / (loanData["amount"] as double));
    
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
            "Loan Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${(loanData["paidEmis"] as int)} of ${(loanData["tenure"] as int)} EMIs paid",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${(progress * 100).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            ],
          ),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(successColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Paid: ₹${(((loanData["amount"] as double) - (loanData["remaining"] as double))).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Remaining: ₹${((loanData["remaining"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoanDetailsCard() {
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
            "Loan Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildDetailRow("Interest Rate", "${(loanData["interestRate"] as double).toStringAsFixed(1)}% p.a."),
          _buildDetailRow("Tenure", "${loanData["tenure"]} months"),
          _buildDetailRow("Monthly EMI", "₹${((loanData["monthlyEmi"] as double)).currency}"),
          _buildDetailRow("Purpose", "${loanData["purpose"]}"),
          _buildDetailRow("Application Date", "${DateTime.parse("2023-01-15").dMMMy}"),
          _buildDetailRow("Disbursal Date", "${DateTime.parse("2023-02-01").dMMMy}"),
          _buildDetailRow("Processing Fee", "₹${((loanData["processingFee"] as double)).currency}"),
          _buildDetailRow("Total Interest", "₹${((loanData["totalInterest"] as double)).currency}"),
          _buildDetailRow("Prepayment Charges", "${loanData["prepaymentCharges"]}"),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildNextPaymentCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor, width: 1),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Next Payment Due",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Due Date",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${DateTime.parse("2025-07-15").dMMMy}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Amount",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "₹${((loanData["monthlyEmi"] as double)).currency}",
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
          Container(
            width: double.infinity,
            child: QButton(
              label: "Pay Now",
              size: bs.md,
              onPressed: () {
                // Navigate to payment
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsCard() {
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
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Prepayment",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to prepayment
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Foreclosure",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to foreclosure
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "EMI Calculator",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to EMI calculator
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "NOC Request",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to NOC request
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmiHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor, width: 1),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Showing last 4 EMI payments. For complete history, download statement.",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(emiHistory.length, (index) {
            final emi = emiHistory[index];
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${DateTime.parse(emi["date"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${emi["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "EMI Amount",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "₹${((emi["amount"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Principal",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "₹${((emi["principal"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Interest",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "₹${((emi["interest"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Method",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${emi["paymentMethod"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Download Full Statement",
              size: bs.md,
              onPressed: () {
                // Download statement
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab() {
    List<Map<String, dynamic>> documents = [
      {
        "name": "Loan Agreement",
        "type": "PDF",
        "size": "2.3 MB",
        "uploadDate": "2023-02-01",
        "status": "Verified"
      },
      {
        "name": "Salary Certificate",
        "type": "PDF",
        "size": "1.1 MB",
        "uploadDate": "2023-01-25",
        "status": "Verified"
      },
      {
        "name": "Bank Statement",
        "type": "PDF",
        "size": "4.2 MB",
        "uploadDate": "2023-01-20",
        "status": "Verified"
      },
      {
        "name": "Identity Proof",
        "type": "PDF",
        "size": "1.8 MB",
        "uploadDate": "2023-01-18",
        "status": "Verified"
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          ...List.generate(documents.length, (index) {
            final doc = documents[index];
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.picture_as_pdf,
                      color: dangerColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${doc["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${doc["type"]} • ${doc["size"]} • ${DateTime.parse(doc["uploadDate"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: spXs),
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${doc["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.download,
                    size: bs.sm,
                    onPressed: () {
                      // Download document
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
