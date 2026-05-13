import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCaseDetailView extends StatefulWidget {
  const LcaCaseDetailView({Key? key}) : super(key: key);

  @override
  State<LcaCaseDetailView> createState() => _LcaCaseDetailViewState();
}

class _LcaCaseDetailViewState extends State<LcaCaseDetailView> {
  int currentTab = 0;

  Map<String, dynamic> caseData = {
    "id": "LCA-2024-001",
    "title": "Smith vs. Johnson Construction",
    "type": "Civil Litigation",
    "priority": "High",
    "status": "Active",
    "client": "John Smith",
    "opposing_party": "Johnson Construction LLC",
    "court": "Superior Court of California",
    "judge": "Hon. Sarah Martinez",
    "case_value": 250000.0,
    "filing_date": "2024-01-15",
    "next_hearing": "2024-07-25",
    "description": "Personal injury case involving construction site accident. Client suffered multiple injuries due to unsafe working conditions and equipment failure.",
    "documents": [
      {"name": "Initial Complaint", "date": "2024-01-15", "type": "PDF", "size": "2.3 MB"},
      {"name": "Medical Records", "date": "2024-01-20", "type": "PDF", "size": "5.1 MB"},
      {"name": "Police Report", "date": "2024-01-16", "type": "PDF", "size": "1.8 MB"},
      {"name": "Witness Statements", "date": "2024-01-25", "type": "PDF", "size": "3.2 MB"},
    ],
    "events": [
      {"date": "2024-01-15", "event": "Case filed", "description": "Initial complaint filed with court"},
      {"date": "2024-02-01", "event": "Discovery phase", "description": "Document discovery process initiated"},
      {"date": "2024-03-15", "event": "Deposition scheduled", "description": "Client deposition scheduled for March 25"},
      {"date": "2024-04-10", "event": "Settlement offer", "description": "Defendant offered \$150,000 settlement"},
    ],
    "billing": [
      {"date": "2024-01-15", "description": "Case consultation", "hours": 2.5, "rate": 350.0},
      {"date": "2024-01-20", "description": "Document review", "hours": 4.0, "rate": 350.0},
      {"date": "2024-02-01", "description": "Court filing", "hours": 1.5, "rate": 350.0},
      {"date": "2024-02-15", "description": "Client meeting", "hours": 2.0, "rate": 350.0},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Case Details",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.info)),
        Tab(text: "Documents", icon: Icon(Icons.folder)),
        Tab(text: "Timeline", icon: Icon(Icons.timeline)),
        Tab(text: "Billing", icon: Icon(Icons.receipt)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildDocumentsTab(),
        _buildTimelineTab(),
        _buildBillingTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildCaseHeader(),
          _buildCaseDetails(),
          _buildParties(),
          _buildCourtInfo(),
          _buildCaseActions(),
        ],
      ),
    );
  }

  Widget _buildCaseHeader() {
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.gavel, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${caseData["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${caseData["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(caseData["status"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${caseData["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: _getStatusColor(caseData["status"]),
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
              _buildInfoChip("Type", caseData["type"], Icons.category),
              SizedBox(width: spSm),
              _buildInfoChip("Priority", caseData["priority"], Icons.priority_high),
              SizedBox(width: spSm),
              _buildInfoChip("Value", "\$${((caseData["case_value"] as double)).currency}", Icons.attach_money),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCaseDetails() {
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
            "Case Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem("Filing Date", caseData["filing_date"], Icons.calendar_today),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: _buildDetailItem("Next Hearing", caseData["next_hearing"], Icons.schedule),
              ),
            ],
          ),
          _buildDetailItem("Client", caseData["client"], Icons.person),
          _buildDetailItem("Opposing Party", caseData["opposing_party"], Icons.business),
        ],
      ),
    );
  }

  Widget _buildParties() {
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
            "Parties Involved",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.person, color: successColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Plaintiff",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${caseData["client"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.contact_page,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.business, color: dangerColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Defendant",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${caseData["opposing_party"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.contact_page,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourtInfo() {
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
            "Court Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildDetailItem("Court", caseData["court"], Icons.account_balance),
          _buildDetailItem("Presiding Judge", caseData["judge"], Icons.person_pin),
        ],
      ),
    );
  }

  Widget _buildCaseActions() {
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
                  label: "Edit Case",
                  icon: Icons.edit,
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add Note",
                  icon: Icons.note_add,
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Schedule Event",
                  icon: Icons.event,
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Generate Report",
                  icon: Icons.description,
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Case Documents",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...List.generate((caseData["documents"] as List).length, (index) {
            final document = (caseData["documents"] as List)[index];
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(Icons.description, color: primaryColor, size: 20),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${document["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${document["type"]} • ${document["size"]} • ${document["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.download,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTimelineTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Case Timeline",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate((caseData["events"] as List).length, (index) {
            final event = (caseData["events"] as List)[index];
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(Icons.event, color: Colors.white, size: 20),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Container(
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
                              Expanded(
                                child: Text(
                                  "${event["event"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${event["date"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${event["description"]}",
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
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBillingTab() {
    double totalAmount = (caseData["billing"] as List)
        .fold(0.0, (sum, item) => sum + ((item["hours"] as double) * (item["rate"] as double)));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.attach_money, color: primaryColor, size: 24),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Billed",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "\$${(totalAmount).currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Billing History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate((caseData["billing"] as List).length, (index) {
            final billing = (caseData["billing"] as List)[index];
            double amount = (billing["hours"] as double) * (billing["rate"] as double);
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${billing["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${billing["date"]} • ${billing["hours"]} hrs @ \$${((billing["rate"] as double)).currency}/hr",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$${(amount).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
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

  Widget _buildInfoChip(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: primaryColor.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 16),
            SizedBox(height: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
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
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'pending':
        return warningColor;
      case 'closed':
        return disabledBoldColor;
      case 'on hold':
        return infoColor;
      default:
        return primaryColor;
    }
  }
}
