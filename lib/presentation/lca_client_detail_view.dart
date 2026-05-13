import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaClientDetailView extends StatefulWidget {
  const LcaClientDetailView({super.key});

  @override
  State<LcaClientDetailView> createState() => _LcaClientDetailViewState();
}

class _LcaClientDetailViewState extends State<LcaClientDetailView> {
  int selectedTab = 0;

  final Map<String, dynamic> clientData = {
    "id": "CL001",
    "name": "Sarah Johnson",
    "email": "sarah.johnson@email.com",
    "phone": "+1 (555) 123-4567",
    "company": "Johnson Enterprises LLC",
    "type": "Corporate",
    "status": "Active",
    "priority": "High",
    "joinedDate": "2023-01-15",
    "lastContact": "2024-03-15",
    "totalCases": 5,
    "activeCases": 2,
    "completedCases": 3,
    "totalBilled": 125000.0,
    "outstandingBills": 15000.0,
    "address": "123 Business Avenue, Suite 400\nNew York, NY 10001",
    "notes": "Key corporate client with ongoing compliance matters. Requires immediate response to inquiries.",
    "primaryContact": "Sarah Johnson, CEO",
    "secondaryContact": "Mike Davis, Legal Counsel",
    "retainerAmount": 50000.0,
    "hourlyRate": 450.0,
    "preferredCommunication": "Email",
    "industry": "Technology",
    "referralSource": "Bar Association",
  };

  List<Map<String, dynamic>> cases = [
    {
      "id": "CASE001",
      "title": "Corporate Merger Review",
      "type": "Corporate Law",
      "status": "Active",
      "priority": "High",
      "assignedLawyer": "John Smith",
      "dateOpened": "2024-02-01",
      "nextHearing": "2024-04-15",
      "description": "Merger and acquisition due diligence review",
      "billedHours": 45.5,
      "estimatedCompletion": "2024-05-30",
    },
    {
      "id": "CASE002", 
      "title": "Employment Contract Dispute",
      "type": "Labor Law",
      "status": "In Review",
      "priority": "Medium",
      "assignedLawyer": "Emily Davis",
      "dateOpened": "2024-01-20",
      "nextHearing": "2024-04-10",
      "description": "Executive employment agreement dispute resolution",
      "billedHours": 28.0,
      "estimatedCompletion": "2024-04-25",
    },
    {
      "id": "CASE003",
      "title": "Intellectual Property Protection",
      "type": "IP Law",
      "status": "Completed",
      "priority": "High", 
      "assignedLawyer": "Michael Brown",
      "dateOpened": "2023-10-15",
      "dateClosed": "2024-02-28",
      "description": "Patent application and trademark registration",
      "billedHours": 35.0,
      "totalBilled": 15750.0,
    },
  ];

  List<Map<String, dynamic>> billingHistory = [
    {
      "id": "INV001",
      "date": "2024-03-01",
      "amount": 12500.0,
      "status": "Paid",
      "dueDate": "2024-03-15",
      "description": "Legal services for February 2024",
      "hours": 27.5,
    },
    {
      "id": "INV002", 
      "date": "2024-02-01",
      "amount": 15000.0,
      "status": "Paid",
      "dueDate": "2024-02-15", 
      "description": "Legal services for January 2024",
      "hours": 33.0,
    },
    {
      "id": "INV003",
      "date": "2024-04-01",
      "amount": 15000.0,
      "status": "Outstanding",
      "dueDate": "2024-04-15",
      "description": "Legal services for March 2024",
      "hours": 33.5,
    },
  ];

  List<Map<String, dynamic>> communications = [
    {
      "date": "2024-03-15",
      "type": "Email",
      "subject": "Merger Documentation Review",
      "from": "Sarah Johnson",
      "to": "John Smith",
      "priority": "High",
      "status": "Responded",
    },
    {
      "date": "2024-03-12",
      "type": "Phone Call",
      "subject": "Employment Contract Update",
      "from": "Mike Davis",
      "to": "Emily Davis", 
      "priority": "Medium",
      "status": "Completed",
    },
    {
      "date": "2024-03-10",
      "type": "Meeting",
      "subject": "Quarterly Legal Review",
      "from": "Sarah Johnson",
      "to": "John Smith",
      "priority": "Medium",
      "status": "Completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit client
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Show options menu
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildClientHeader(),
            _buildQuickStats(),
            _buildTabSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildClientHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: primaryColor.withAlpha(51),
                child: Text(
                  "${clientData["name"]}".split(" ").map((e) => e[0]).join(""),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${clientData["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${clientData["company"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: clientData["status"] == "Active" ? successColor : warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${clientData["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: clientData["priority"] == "High" ? dangerColor : 
                                  clientData["priority"] == "Medium" ? warningColor : infoColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${clientData["priority"]} Priority",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${clientData["email"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${clientData["phone"]}",
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
              QButton(
                label: "Contact",
                icon: Icons.message,
                size: bs.sm,
                onPressed: () {
                  // Contact client
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "${clientData["totalCases"]}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Cases",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "${clientData["activeCases"]}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Active Cases",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "\$${((clientData["totalBilled"] as num) / 1000).toStringAsFixed(0)}K",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Total Billed",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "\$${((clientData["outstandingBills"] as num) / 1000).toStringAsFixed(0)}K",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "Outstanding",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabSection() {
    return Column(
      children: [
        Row(
          children: [
            _buildTabButton("Overview", 0),
            _buildTabButton("Cases", 1),
            _buildTabButton("Billing", 2),
            _buildTabButton("Communications", 3),
          ],
        ),
        SizedBox(height: spMd),
        if (selectedTab == 0) _buildOverviewTab(),
        if (selectedTab == 1) _buildCasesTab(),
        if (selectedTab == 2) _buildBillingTab(),
        if (selectedTab == 3) _buildCommunicationsTab(),
      ],
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: isSelected ? [shadowSm] : null,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : disabledBoldColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Client Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildInfoRow("Client ID", "${clientData["id"]}"),
          _buildInfoRow("Client Type", "${clientData["type"]}"),
          _buildInfoRow("Industry", "${clientData["industry"]}"),
          _buildInfoRow("Joined Date", "${clientData["joinedDate"]}"),
          _buildInfoRow("Last Contact", "${clientData["lastContact"]}"),
          _buildInfoRow("Referral Source", "${clientData["referralSource"]}"),
          _buildInfoRow("Primary Contact", "${clientData["primaryContact"]}"),
          _buildInfoRow("Secondary Contact", "${clientData["secondaryContact"]}"),
          SizedBox(height: spSm),
          Text(
            "Address",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${clientData["address"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Notes",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${clientData["notes"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Financial Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildInfoRow("Retainer Amount", "\$${(clientData["retainerAmount"] as num).currency}"),
          _buildInfoRow("Hourly Rate", "\$${(clientData["hourlyRate"] as num).currency}"),
          _buildInfoRow("Preferred Communication", "${clientData["preferredCommunication"]}"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ),
        Text(
          ": ",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCasesTab() {
    return Column(
      spacing: spSm,
      children: cases.map((caseData) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${caseData["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${caseData["type"]} • ${caseData["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: caseData["status"] == "Active" ? successColor :
                            caseData["status"] == "In Review" ? warningColor : primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${caseData["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "${caseData["description"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.person, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${caseData["assignedLawyer"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${(caseData["billedHours"] as num).toStringAsFixed(1)}h",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              if (caseData["nextHearing"] != null)
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: warningColor),
                    SizedBox(width: spXs),
                    Text(
                      "Next Hearing: ${caseData["nextHearing"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        // View case details
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {
                      // Case options
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBillingTab() {
    return Column(
      spacing: spSm,
      children: billingHistory.map((bill) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${bill["id"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${bill["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: bill["status"] == "Paid" ? successColor : dangerColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${bill["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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
                          "Amount: \$${(bill["amount"] as num).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Hours: ${(bill["hours"] as num).toStringAsFixed(1)}",
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
                      Text(
                        "Date: ${bill["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Due: ${bill["dueDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: bill["status"] == "Outstanding" ? dangerColor : disabledBoldColor,
                          fontWeight: bill["status"] == "Outstanding" ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (bill["status"] == "Outstanding")
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Send Reminder",
                        size: bs.sm,
                        onPressed: () {
                          // Send payment reminder
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Mark Paid",
                      size: bs.sm,
                      onPressed: () {
                        // Mark as paid
                      },
                    ),
                  ],
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCommunicationsTab() {
    return Column(
      spacing: spSm,
      children: communications.map((comm) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    comm["type"] == "Email" ? Icons.email :
                    comm["type"] == "Phone Call" ? Icons.phone :
                    Icons.meeting_room,
                    size: 20,
                    color: primaryColor,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${comm["subject"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${comm["type"]} • ${comm["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: comm["status"] == "Completed" ? successColor :
                            comm["status"] == "Responded" ? primaryColor : warningColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${comm["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "From: ${comm["from"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Text(
                    "To: ${comm["to"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: comm["priority"] == "High" ? dangerColor :
                            comm["priority"] == "Medium" ? warningColor : infoColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${comm["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  QButton(
                    label: "Reply",
                    size: bs.sm,
                    onPressed: () {
                      // Reply to communication
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "View Full",
                    size: bs.sm,
                    onPressed: () {
                      // View full communication
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
