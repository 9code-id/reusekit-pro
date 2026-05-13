import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmLeadDetailView extends StatefulWidget {
  const CrmLeadDetailView({super.key});

  @override
  State<CrmLeadDetailView> createState() => _CrmLeadDetailViewState();
}

class _CrmLeadDetailViewState extends State<CrmLeadDetailView> {
  bool loading = false;
  int selectedTab = 0;
  String notes = "";
  String followUpDate = DateTime.now().add(Duration(days: 7)).toString();
  String nextAction = "";
  String priority = "Medium";
  String assignedTo = "John Smith";

  Map<String, dynamic> leadData = {
    "id": "LEAD-2024-001",
    "name": "Sarah Johnson",
    "email": "sarah.johnson@email.com",
    "phone": "+1 (555) 123-4567",
    "company": "Tech Solutions Inc",
    "position": "IT Director",
    "source": "Website",
    "status": "Qualified",
    "score": 85,
    "value": 45000.0,
    "created_date": "2024-01-15",
    "last_contact": "2024-06-18",
    "assigned_to": "John Smith",
    "priority": "High",
    "tags": ["Enterprise", "SaaS", "High Value"],
    "address": "123 Business Ave, Tech City, TC 12345",
    "website": "www.techsolutions.com",
    "industry": "Technology",
    "employees": "100-500",
    "revenue": "5M-10M",
    "timezone": "EST",
    "social_linkedin": "linkedin.com/in/sarahjohnson",
    "social_twitter": "@sarahj_tech",
    "description": "Interested in enterprise software solutions for their growing IT department. Looking for scalable solutions that can grow with their business.",
  };

  List<Map<String, dynamic>> activities = [
    {
      "id": 1,
      "type": "Email",
      "subject": "Follow-up on Demo Request",
      "description": "Sent follow-up email regarding product demo discussion",
      "date": "2024-06-18 14:30",
      "user": "John Smith",
      "status": "Completed",
      "outcome": "Positive response - demo scheduled",
    },
    {
      "id": 2,
      "type": "Call",
      "subject": "Product Demo",
      "description": "Conducted 45-minute product demonstration",
      "date": "2024-06-17 10:00",
      "user": "John Smith",
      "status": "Completed",
      "outcome": "Very interested - requesting proposal",
    },
    {
      "id": 3,
      "type": "Meeting",
      "subject": "Initial Consultation",
      "description": "Discovery meeting to understand requirements",
      "date": "2024-06-15 15:00",
      "user": "John Smith",
      "status": "Completed",
      "outcome": "Qualified lead - good fit for our solution",
    },
    {
      "id": 4,
      "type": "Email",
      "subject": "Welcome & Introduction",
      "description": "Initial contact and company introduction",
      "date": "2024-06-10 09:00",
      "user": "John Smith",
      "status": "Completed",
      "outcome": "Replied with interest",
    },
  ];

  List<Map<String, dynamic>> documents = [
    {
      "id": 1,
      "name": "Company Profile.pdf",
      "type": "PDF",
      "size": "2.5 MB",
      "uploaded_date": "2024-06-15",
      "uploaded_by": "John Smith",
    },
    {
      "id": 2,
      "name": "Requirements Document.docx",
      "type": "DOCX",
      "size": "1.2 MB",
      "uploaded_date": "2024-06-17",
      "uploaded_by": "Sarah Johnson",
    },
    {
      "id": 3,
      "name": "Budget Approval.pdf",
      "type": "PDF",
      "size": "800 KB",
      "uploaded_date": "2024-06-18",
      "uploaded_by": "Sarah Johnson",
    },
  ];

  List<Map<String, dynamic>> opportunities = [
    {
      "id": 1,
      "name": "Enterprise Software License",
      "value": 45000.0,
      "stage": "Proposal",
      "probability": 75,
      "close_date": "2024-07-15",
      "products": ["Enterprise Suite", "Support Package"],
    },
    {
      "id": 2,
      "name": "Training & Implementation",
      "value": 15000.0,
      "stage": "Discovery",
      "probability": 60,
      "close_date": "2024-08-01",
      "products": ["Training Program", "Implementation"],
    },
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  List<Map<String, dynamic>> assigneeItems = [
    {"label": "John Smith", "value": "John Smith"},
    {"label": "Jane Doe", "value": "Jane Doe"},
    {"label": "Mike Johnson", "value": "Mike Johnson"},
    {"label": "Sarah Wilson", "value": "Sarah Wilson"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lead Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editLead,
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: _showMoreOptions,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : QTabBar(
              withoutAppBar: true,
              selectedIndex: selectedTab,
              tabs: [
                Tab(text: "Overview", icon: Icon(Icons.person)),
                Tab(text: "Activities", icon: Icon(Icons.history)),
                Tab(text: "Documents", icon: Icon(Icons.folder)),
                Tab(text: "Opportunities", icon: Icon(Icons.trending_up)),
              ],
              tabChildren: [
                _buildOverviewTab(),
                _buildActivitiesTab(),
                _buildDocumentsTab(),
                _buildOpportunitiesTab(),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addActivity,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildLeadInfoCard(),
          _buildContactInfoCard(),
          _buildCompanyInfoCard(),
          _buildLeadDetailsCard(),
          _buildQuickActionsCard(),
        ],
      ),
    );
  }

  Widget _buildLeadInfoCard() {
    return Container(
      width: double.infinity,
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
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${leadData["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${leadData["position"]} at ${leadData["company"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${leadData["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Score",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${leadData["score"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem("Potential Value", "\$${((leadData["value"] as double) / 1000).toStringAsFixed(0)}K"),
              _buildStatItem("Source", "${leadData["source"]}"),
              _buildStatItem("Priority", "${leadData["priority"]}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
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
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfoCard() {
    return Container(
      width: double.infinity,
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
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildContactItem(Icons.email, "Email", "${leadData["email"]}"),
          _buildContactItem(Icons.phone, "Phone", "${leadData["phone"]}"),
          _buildContactItem(Icons.location_on, "Address", "${leadData["address"]}"),
          _buildContactItem(Icons.language, "Website", "${leadData["website"]}"),
          _buildContactItem(Icons.work, "LinkedIn", "${leadData["social_linkedin"]}"),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: primaryColor,
        ),
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
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyInfoCard() {
    return Container(
      width: double.infinity,
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
            "Company Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildCompanyDetailItem("Industry", "${leadData["industry"]}"),
              ),
              Expanded(
                child: _buildCompanyDetailItem("Employees", "${leadData["employees"]}"),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildCompanyDetailItem("Revenue", "${leadData["revenue"]}"),
              ),
              Expanded(
                child: _buildCompanyDetailItem("Timezone", "${leadData["timezone"]}"),
              ),
            ],
          ),
          Text(
            "Description",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${leadData["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyDetailItem(String label, String value) {
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
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildLeadDetailsCard() {
    return Container(
      width: double.infinity,
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
            "Lead Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem("Created", "${leadData["created_date"]}"),
              ),
              Expanded(
                child: _buildDetailItem("Last Contact", "${leadData["last_contact"]}"),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem("Assigned To", "${leadData["assigned_to"]}"),
              ),
              Expanded(
                child: _buildDetailItem("Lead ID", "${leadData["id"]}"),
              ),
            ],
          ),
          Text(
            "Tags",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (leadData["tags"] as List).map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$tag",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
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
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
          QMemoField(
            label: "Add Notes",
            value: notes,
            hint: "Add notes about this lead...",
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: priorityItems,
                  value: priority,
                  onChanged: (value, label) {
                    priority = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Assigned To",
                  items: assigneeItems,
                  value: assignedTo,
                  onChanged: (value, label) {
                    assignedTo = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDatePicker(
            label: "Follow-up Date",
            value: DateTime.parse(followUpDate),
            onChanged: (value) {
              followUpDate = value.toString();
              setState(() {});
            },
          ),
          QTextField(
            label: "Next Action",
            value: nextAction,
            hint: "Schedule next action...",
            onChanged: (value) {
              nextAction = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save Changes",
                  size: bs.md,
                  onPressed: _saveChanges,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Convert to Customer",
                  size: bs.md,
                  onPressed: _convertToCustomer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivitiesTab() {
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
                  "Activities (${activities.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Add Activity",
                icon: Icons.add,
                size: bs.sm,
                onPressed: _addActivity,
              ),
            ],
          ),
          ...activities.map((activity) => _buildActivityCard(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    IconData activityIcon;
    Color activityColor;

    switch (activity["type"]) {
      case "Email":
        activityIcon = Icons.email;
        activityColor = infoColor;
        break;
      case "Call":
        activityIcon = Icons.phone;
        activityColor = successColor;
        break;
      case "Meeting":
        activityIcon = Icons.meeting_room;
        activityColor = warningColor;
        break;
      default:
        activityIcon = Icons.note;
        activityColor = primaryColor;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: activityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              activityIcon,
              size: 20,
              color: activityColor,
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
                      "${activity["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: activityColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${activity["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${activity["subject"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${activity["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                if (activity["outcome"] != null) ...[
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Outcome: ${activity["outcome"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: spXs),
                Text(
                  "By ${activity["user"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.more_vert,
            color: disabledBoldColor,
            size: 20,
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
                  "Documents (${documents.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Upload",
                icon: Icons.upload,
                size: bs.sm,
                onPressed: _uploadDocument,
              ),
            ],
          ),
          ...documents.map((document) => _buildDocumentCard(document)),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> document) {
    IconData fileIcon;
    Color fileColor;

    switch (document["type"]) {
      case "PDF":
        fileIcon = Icons.picture_as_pdf;
        fileColor = dangerColor;
        break;
      case "DOCX":
        fileIcon = Icons.description;
        fileColor = infoColor;
        break;
      case "XLSX":
        fileIcon = Icons.table_chart;
        fileColor = successColor;
        break;
      default:
        fileIcon = Icons.insert_drive_file;
        fileColor = disabledBoldColor;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: fileColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              fileIcon,
              size: 20,
              color: fileColor,
            ),
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
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${document["size"]} • ${document["type"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Uploaded by ${document["uploaded_by"]} on ${document["uploaded_date"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => _downloadDocument(document),
                child: Icon(
                  Icons.download,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () => _deleteDocument(document),
                child: Icon(
                  Icons.delete,
                  color: dangerColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOpportunitiesTab() {
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
                  "Opportunities (${opportunities.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Create",
                icon: Icons.add,
                size: bs.sm,
                onPressed: _createOpportunity,
              ),
            ],
          ),
          ...opportunities.map((opportunity) => _buildOpportunityCard(opportunity)),
        ],
      ),
    );
  }

  Widget _buildOpportunityCard(Map<String, dynamic> opportunity) {
    Color stageColor;
    switch (opportunity["stage"]) {
      case "Discovery":
        stageColor = infoColor;
        break;
      case "Proposal":
        stageColor = warningColor;
        break;
      case "Negotiation":
        stageColor = successColor;
        break;
      case "Closed Won":
        stageColor = successColor;
        break;
      default:
        stageColor = disabledBoldColor;
    }

    return Container(
      width: double.infinity,
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
              Expanded(
                child: Text(
                  "${opportunity["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: stageColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${opportunity["stage"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: stageColor,
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
                      "Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((opportunity["value"] as double) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                      "Probability",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${opportunity["probability"]}%",
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
                      "Close Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${opportunity["close_date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "Products",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (opportunity["products"] as List).map((product) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$product",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewOpportunity(opportunity),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Update Stage",
                  size: bs.sm,
                  onPressed: () => _updateOpportunityStage(opportunity),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _editLead() {
    ss("Edit lead functionality");
    // Navigate to edit lead view
  }

  void _showMoreOptions() {
    // Show more options menu
  }

  void _addActivity() {
    ss("Add activity functionality");
    // Navigate to add activity view
  }

  void _saveChanges() async {
    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    loading = false;
    setState(() {});

    ss("Lead updated successfully");
  }

  void _convertToCustomer() async {
    bool isConfirmed = await confirm("Convert this lead to a customer?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Lead converted to customer successfully");
  }

  void _uploadDocument() {
    ss("Upload document functionality");
    // Navigate to document upload
  }

  void _downloadDocument(Map<String, dynamic> document) {
    ss("Downloading ${document["name"]}");
    // Download document
  }

  void _deleteDocument(Map<String, dynamic> document) async {
    bool isConfirmed = await confirm("Delete ${document["name"]}?");
    if (!isConfirmed) return;

    documents.removeWhere((d) => d["id"] == document["id"]);
    setState(() {});

    ss("Document deleted successfully");
  }

  void _createOpportunity() {
    ss("Create opportunity functionality");
    // Navigate to create opportunity view
  }

  void _viewOpportunity(Map<String, dynamic> opportunity) {
    ss("Viewing opportunity: ${opportunity["name"]}");
    // Navigate to opportunity detail view
  }

  void _updateOpportunityStage(Map<String, dynamic> opportunity) {
    ss("Update stage for: ${opportunity["name"]}");
    // Show stage update dialog
  }
}
