import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaAccountDetailsView extends StatefulWidget {
  const BfaAccountDetailsView({super.key});

  @override
  State<BfaAccountDetailsView> createState() => _BfaAccountDetailsViewState();
}

class _BfaAccountDetailsViewState extends State<BfaAccountDetailsView> {
  int currentTab = 0;
  
  Map<String, dynamic> accountInfo = {
    "accountNumber": "1234567890",
    "accountType": "Savings Account",
    "accountHolder": "John Doe",
    "balance": 125450.75,
    "availableBalance": 125450.75,
    "ifscCode": "BANK0001234",
    "branchName": "Main Branch, Downtown",
    "openingDate": "2020-03-15",
    "status": "Active",
    "currency": "USD",
    "minimumBalance": 1000.0,
    "interestRate": 2.5,
    "lastStatementDate": "2024-01-01"
  };
  
  List<Map<String, dynamic>> accountFeatures = [
    {
      "title": "Mobile Banking",
      "description": "Access your account 24/7",
      "icon": Icons.phone_android,
      "status": "Active",
      "color": successColor
    },
    {
      "title": "Internet Banking",
      "description": "Online banking portal",
      "icon": Icons.computer,
      "status": "Active",
      "color": successColor
    },
    {
      "title": "Debit Card",
      "description": "Visa Debit Card",
      "icon": Icons.credit_card,
      "status": "Active",
      "color": successColor
    },
    {
      "title": "Cheque Book",
      "description": "25 leaves remaining",
      "icon": Icons.receipt_long,
      "status": "Available",
      "color": warningColor
    },
    {
      "title": "SMS Alerts",
      "description": "Transaction notifications",
      "icon": Icons.sms,
      "status": "Active",
      "color": successColor
    },
    {
      "title": "Auto Sweep",
      "description": "Automatic fund transfer",
      "icon": Icons.autorenew,
      "status": "Inactive",
      "color": disabledBoldColor
    },
  ];
  
  List<Map<String, dynamic>> beneficiaries = [
    {
      "name": "Jane Smith",
      "accountNumber": "9876543210",
      "bankName": "First National Bank",
      "ifsc": "FNBL0001234",
      "type": "IMPS",
      "addedDate": "2024-01-10"
    },
    {
      "name": "Michael Johnson",
      "accountNumber": "5555666677",
      "bankName": "Central Bank",
      "ifsc": "CBANK001235",
      "type": "NEFT",
      "addedDate": "2024-01-08"
    },
    {
      "name": "Sarah Wilson",
      "accountNumber": "1111222233",
      "bankName": "Metro Bank",
      "ifsc": "METRO001236",
      "type": "RTGS",
      "addedDate": "2024-01-05"
    },
  ];
  
  List<Map<String, dynamic>> nomineeDetails = [
    {
      "name": "Emily Doe",
      "relationship": "Spouse",
      "dateOfBirth": "1985-06-20",
      "share": 50.0,
      "contactNumber": "+1-555-0123"
    },
    {
      "name": "Robert Doe",
      "relationship": "Son",
      "dateOfBirth": "2010-12-15",
      "share": 50.0,
      "contactNumber": "Minor"
    },
  ];
  
  List<Map<String, dynamic>> accountStatements = [
    {
      "month": "January 2024",
      "fromDate": "2024-01-01",
      "toDate": "2024-01-31",
      "transactions": 45,
      "openingBalance": 120350.25,
      "closingBalance": 125450.75,
      "status": "Available"
    },
    {
      "month": "December 2023",
      "fromDate": "2023-12-01",
      "toDate": "2023-12-31",
      "transactions": 38,
      "openingBalance": 115200.50,
      "closingBalance": 120350.25,
      "status": "Available"
    },
    {
      "month": "November 2023",
      "fromDate": "2023-11-01",
      "toDate": "2023-11-30",
      "transactions": 42,
      "openingBalance": 110450.75,
      "closingBalance": 115200.50,
      "status": "Available"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Account Details",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.account_balance)),
        Tab(text: "Features", icon: Icon(Icons.settings)),
        Tab(text: "Beneficiaries", icon: Icon(Icons.people)),
        Tab(text: "Statements", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Account Summary
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(150)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          size: 32,
                          color: Colors.white,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${accountInfo["accountType"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                              Text(
                                "****${(accountInfo["accountNumber"] as String).substring(6)}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${accountInfo["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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
                            children: [
                              Text(
                                "Available Balance",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "\$${((accountInfo["availableBalance"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.white.withAlpha(100),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Current Balance",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "\$${((accountInfo["balance"] as double).toDouble()).currency}",
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
              ),

              // Account Information
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
                      "Account Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    _buildInfoRow("Account Holder", "${accountInfo["accountHolder"]}"),
                    _buildInfoRow("Account Number", "${accountInfo["accountNumber"]}"),
                    _buildInfoRow("IFSC Code", "${accountInfo["ifscCode"]}"),
                    _buildInfoRow("Branch", "${accountInfo["branchName"]}"),
                    _buildInfoRow("Opening Date", "${DateTime.parse(accountInfo["openingDate"] as String).dMMMy}"),
                    _buildInfoRow("Interest Rate", "${accountInfo["interestRate"]}% p.a."),
                    _buildInfoRow("Minimum Balance", "\$${((accountInfo["minimumBalance"] as double).toDouble()).currency}"),
                  ],
                ),
              ),

              // Quick Actions
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
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        _buildQuickAction("Transfer Money", Icons.send, successColor),
                        _buildQuickAction("Download Statement", Icons.download, infoColor),
                        _buildQuickAction("Update KYC", Icons.verified_user, warningColor),
                        _buildQuickAction("Close Account", Icons.block, dangerColor),
                      ],
                    ),
                  ],
                ),
              ),

              // Nominee Details
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
                    Row(
                      children: [
                        Text(
                          "Nominee Details",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Edit",
                          size: bs.sm,
                          onPressed: () {
                            ss("Edit nominee details");
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    ...nomineeDetails.map((nominee) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${nominee["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${nominee["share"]}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Text(
                                  "Relationship: ",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${nominee["relationship"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "DOB: ${DateTime.parse(nominee["dateOfBirth"] as String).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Features Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
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
                      "Account Features & Services",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    ...accountFeatures.map((feature) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: (feature["color"] as Color).withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (feature["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                feature["icon"] as IconData,
                                color: feature["color"] as Color,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${feature["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${feature["description"]}",
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
                                color: (feature["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${feature["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: feature["color"] as Color,
                                  fontWeight: FontWeight.w600,
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
            ],
          ),
        ),

        // Beneficiaries Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
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
                    Row(
                      children: [
                        Text(
                          "Saved Beneficiaries",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Add New",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {
                            ss("Add new beneficiary");
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    ...beneficiaries.map((beneficiary) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Icon(
                                    Icons.account_circle,
                                    color: primaryColor,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${beneficiary["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${beneficiary["bankName"]}",
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
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${beneficiary["type"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
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
                                        "Account Number",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${beneficiary["accountNumber"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
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
                                        "IFSC Code",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${beneficiary["ifsc"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            Row(
                              children: [
                                Text(
                                  "Added: ${DateTime.parse(beneficiary["addedDate"] as String).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                QButton(
                                  label: "Transfer",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Transfer to ${beneficiary["name"]}");
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Statements Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
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
                    Row(
                      children: [
                        Text(
                          "Account Statements",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Request Custom",
                          size: bs.sm,
                          onPressed: () {
                            ss("Request custom statement");
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    ...accountStatements.map((statement) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.description,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${statement["month"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${DateTime.parse(statement["fromDate"] as String).dMMMy} to ${DateTime.parse(statement["toDate"] as String).dMMMy}",
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
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${statement["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
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
                                        "Transactions",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${statement["transactions"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
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
                                        "Opening Balance",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${((statement["openingBalance"] as double).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
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
                                        "Closing Balance",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${((statement["closingBalance"] as double).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: successColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Online",
                                    icon: Icons.visibility,
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Viewing ${statement["month"]} statement");
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "Download PDF",
                                    icon: Icons.download,
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Downloading ${statement["month"]} statement");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(50),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Open",
              size: bs.sm,
              color: color,
              onPressed: () {
                ss("Opening $title");
              },
            ),
          ),
        ],
      ),
    );
  }
}
