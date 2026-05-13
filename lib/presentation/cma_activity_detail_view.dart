import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaActivityDetailView extends StatefulWidget {
  const CmaActivityDetailView({super.key});

  @override
  State<CmaActivityDetailView> createState() => _CmaActivityDetailViewState();
}

class _CmaActivityDetailViewState extends State<CmaActivityDetailView> {
  String notes = "";
  String outcome = "";
  String followUpDate = "";
  String followUpTime = "";
  bool isCompleted = false;
  String priority = "Medium";
  String assignedTo = "John Smith";

  final Map<String, dynamic> activity = {
    "id": "ACT-001",
    "title": "Follow-up Call with Acme Corp",
    "type": "Call",
    "status": "Completed",
    "priority": "High",
    "customer": {
      "name": "Acme Corporation",
      "contact": "Jane Smith",
      "email": "jane.smith@acme.com",
      "phone": "+1 (555) 123-4567",
      "company": "Acme Corp",
      "position": "VP Sales"
    },
    "opportunity": {
      "title": "Enterprise Software License",
      "value": 250000,
      "stage": "Proposal",
      "probability": 75
    },
    "assignedTo": "John Smith",
    "createdDate": "2024-01-15",
    "dueDate": "2024-01-20",
    "completedDate": "2024-01-19",
    "duration": 45,
    "description": "Follow-up call to discuss the enterprise software licensing proposal and address any technical questions from the client.",
    "notes": "Client expressed strong interest in the enterprise package. Technical team will need to schedule a demo next week. Pricing discussion went well, they're comfortable with the proposed budget.",
    "outcome": "Positive - Client ready to move forward with technical demo",
    "followUpRequired": true,
    "followUpDate": "2024-01-25",
    "followUpAction": "Schedule technical demo with their IT team",
    "attachments": [
      {
        "name": "Meeting_Notes_Jan19.pdf",
        "type": "PDF",
        "size": "245 KB",
        "uploadDate": "2024-01-19"
      },
      {
        "name": "Proposal_Acme_v2.docx",
        "type": "Word",
        "size": "1.2 MB",
        "uploadDate": "2024-01-18"
      }
    ],
    "history": [
      {
        "action": "Activity Completed",
        "user": "John Smith",
        "timestamp": "2024-01-19 14:30",
        "details": "Call completed successfully, positive outcome"
      },
      {
        "action": "Notes Updated",
        "user": "John Smith",
        "timestamp": "2024-01-19 14:15",
        "details": "Added detailed meeting notes"
      },
      {
        "action": "Activity Started",
        "user": "John Smith",
        "timestamp": "2024-01-19 13:45",
        "details": "Initiated follow-up call"
      },
      {
        "action": "Activity Created",
        "user": "Sarah Johnson",
        "timestamp": "2024-01-15 09:00",
        "details": "Created follow-up activity for Acme Corp opportunity"
      }
    ],
    "relatedActivities": [
      {
        "id": "ACT-002",
        "title": "Technical Demo Setup",
        "type": "Meeting",
        "status": "Scheduled",
        "dueDate": "2024-01-25"
      },
      {
        "id": "ACT-003",
        "title": "Proposal Review",
        "type": "Email",
        "status": "Pending",
        "dueDate": "2024-01-22"
      }
    ]
  };

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Urgent", "value": "Urgent"},
  ];

  List<Map<String, dynamic>> assigneeOptions = [
    {"label": "John Smith", "value": "John Smith"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Mike Davis", "value": "Mike Davis"},
    {"label": "Lisa Chen", "value": "Lisa Chen"},
  ];

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return infoColor;
      case 'medium':
        return warningColor;
      case 'high':
        return dangerColor;
      case 'urgent':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in progress':
        return warningColor;
      case 'scheduled':
        return infoColor;
      case 'pending':
        return warningColor;
      case 'cancelled':
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildInfoCard() {
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
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor("${activity["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${activity["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${activity["status"]}"),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${activity["priority"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${activity["priority"]} Priority",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor("${activity["priority"]}"),
                  ),
                ),
              ),
              Spacer(),
              Text(
                "ID: ${activity["id"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "${activity["title"]}",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${activity["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Type",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${activity["type"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                      "Duration",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${activity["duration"]} minutes",
                      style: TextStyle(
                        fontSize: 14,
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
                      "Assigned To",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${activity["assignedTo"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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

  Widget _buildCustomerCard() {
    final customer = activity["customer"] as Map<String, dynamic>;
    
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
        children: [
          Row(
            children: [
              Icon(
                Icons.business,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Customer Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  Icons.business,
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
                      "${customer["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${customer["contact"]} - ${customer["position"]}",
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
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${customer["email"]}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Phone",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${customer["phone"]}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
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

  Widget _buildOpportunityCard() {
    final opportunity = activity["opportunity"] as Map<String, dynamic>;
    
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
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Related Opportunity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "${opportunity["title"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
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
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((opportunity["value"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 16,
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
                      "Stage",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${opportunity["stage"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
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
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${opportunity["probability"]}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: opportunity["probability"] >= 70 ? successColor : 
                               opportunity["probability"] >= 40 ? warningColor : dangerColor,
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

  Widget _buildDatesCard() {
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
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Timeline",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
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
                      "Created",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${activity["createdDate"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                      "Due Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${activity["dueDate"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                      "Completed",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${activity["completedDate"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
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

  Widget _buildNotesCard() {
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
        children: [
          Row(
            children: [
              Icon(
                Icons.note,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Activity Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: disabledOutlineBorderColor,
                width: 1,
              ),
            ),
            child: Text(
              "${activity["notes"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Outcome",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: successColor.withAlpha(30),
                width: 1,
              ),
            ),
            child: Text(
              "${activity["outcome"]}",
              style: TextStyle(
                fontSize: 14,
                color: successColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowUpCard() {
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
        children: [
          Row(
            children: [
              Icon(
                Icons.next_plan,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Follow-up Required",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
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
                      "Follow-up Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${activity["followUpDate"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Action Required",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: warningColor.withAlpha(30),
                width: 1,
              ),
            ),
            child: Text(
              "${activity["followUpAction"]}",
              style: TextStyle(
                fontSize: 14,
                color: warningColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentsCard() {
    final attachments = activity["attachments"] as List<dynamic>;
    
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
        children: [
          Row(
            children: [
              Icon(
                Icons.attach_file,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Attachments (${attachments.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...attachments.map((attachment) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    attachment["type"] == "PDF" ? Icons.picture_as_pdf : Icons.description,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${attachment["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${attachment["type"]} • ${attachment["size"]} • ${attachment["uploadDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.download,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildHistoryCard() {
    final history = activity["history"] as List<dynamic>;
    
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
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Activity History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...history.map((item) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item["action"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${item["details"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${item["user"]} • ${item["timestamp"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
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
      ),
    );
  }

  Widget _buildRelatedActivitiesCard() {
    final relatedActivities = activity["relatedActivities"] as List<dynamic>;
    
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
        children: [
          Row(
            children: [
              Icon(
                Icons.link,
                color: secondaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Related Activities",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...relatedActivities.map((relatedActivity) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: secondaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor("${relatedActivity["status"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${relatedActivity["status"]}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor("${relatedActivity["status"]}"),
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${relatedActivity["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${relatedActivity["type"]} • Due: ${relatedActivity["dueDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: disabledBoldColor,
                    size: 14,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit activity
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Show action menu
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildInfoCard(),
            SizedBox(height: spMd),
            _buildCustomerCard(),
            SizedBox(height: spMd),
            _buildOpportunityCard(),
            SizedBox(height: spMd),
            _buildDatesCard(),
            SizedBox(height: spMd),
            _buildNotesCard(),
            SizedBox(height: spMd),
            if (activity["followUpRequired"] == true) ...[
              _buildFollowUpCard(),
              SizedBox(height: spMd),
            ],
            _buildAttachmentsCard(),
            SizedBox(height: spMd),
            _buildHistoryCard(),
            SizedBox(height: spMd),
            _buildRelatedActivitiesCard(),
            SizedBox(height: spLg),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Mark as Complete",
                    size: bs.md,
                    onPressed: () {
                      // Mark activity as complete
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Create Follow-up",
                    size: bs.md,
                    onPressed: () {
                      // Create follow-up activity
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
