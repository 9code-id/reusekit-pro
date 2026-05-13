import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmContactDetailView extends StatefulWidget {
  const CrmContactDetailView({super.key});

  @override
  State<CrmContactDetailView> createState() => _CrmContactDetailViewState();
}

class _CrmContactDetailViewState extends State<CrmContactDetailView> {
  int currentTab = 0;
  
  Map<String, dynamic> contact = {
    "id": "1",
    "name": "John Smith",
    "email": "john@acme.com",
    "phone": "+1 234 567 8900",
    "mobile": "+1 234 567 8901",
    "company": "Acme Corp",
    "position": "Chief Executive Officer",
    "department": "Executive",
    "status": "Active",
    "segment": "Enterprise",
    "last_contact": "2024-01-15",
    "created": "2024-01-01",
    "lead_score": 85,
    "tags": ["VIP", "Decision Maker", "Hot Lead"],
    "notes": "Very interested in our enterprise solution. Has budget approved for Q1 2024. Key decision maker for the entire organization.",
    "avatar": "https://picsum.photos/150/150?random=1",
    "value": 25000.0,
    "activities": 12,
    "location": "New York, NY",
    "timezone": "EST",
    "website": "https://acme.com",
    "linkedin": "https://linkedin.com/in/johnsmith",
    "twitter": "@johnsmith",
    "address": "123 Business Ave, Suite 500",
    "city": "New York",
    "state": "NY",
    "zip": "10001",
    "country": "United States",
    "industry": "Technology",
    "employees": "500-1000",
    "revenue": "50M-100M",
    "source": "Website",
    "assigned_to": "Sarah Johnson",
    "created_by": "Mike Thompson",
  };

  List<Map<String, dynamic>> activities = [
    {
      "id": "1",
      "type": "email",
      "title": "Sent proposal for enterprise package",
      "description": "Sent detailed proposal including pricing and implementation timeline",
      "date": "2024-01-15",
      "time": "10:30 AM",
      "user": "Sarah Johnson",
      "status": "completed",
      "icon": Icons.email,
      "color": primaryColor,
    },
    {
      "id": "2",
      "type": "call",
      "title": "Discovery call scheduled",
      "description": "30-minute discovery call to understand requirements",
      "date": "2024-01-16",
      "time": "2:00 PM",
      "user": "Sarah Johnson",
      "status": "scheduled",
      "icon": Icons.phone,
      "color": successColor,
    },
    {
      "id": "3",
      "type": "meeting",
      "title": "Product demo meeting",
      "description": "Live demo of enterprise features and Q&A session",
      "date": "2024-01-14",
      "time": "11:00 AM",
      "user": "Mike Thompson",
      "status": "completed",
      "icon": Icons.video_call,
      "color": infoColor,
    },
    {
      "id": "4",
      "type": "note",
      "title": "Budget discussion",
      "description": "Discussed budget requirements and approval process",
      "date": "2024-01-13",
      "time": "3:15 PM",
      "user": "Sarah Johnson",
      "status": "completed",
      "icon": Icons.note,
      "color": warningColor,
    },
    {
      "id": "5",
      "type": "task",
      "title": "Follow up on pricing questions",
      "description": "Answer questions about volume discounts and payment terms",
      "date": "2024-01-17",
      "time": "9:00 AM",
      "user": "Sarah Johnson",
      "status": "pending",
      "icon": Icons.task,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> deals = [
    {
      "id": "1",
      "title": "Enterprise Software License",
      "value": 25000.0,
      "stage": "Proposal",
      "probability": 75,
      "close_date": "2024-02-15",
      "created": "2024-01-01",
      "status": "active",
      "products": ["Enterprise License", "Support Package", "Training"],
    },
    {
      "id": "2",
      "title": "Additional User Licenses",
      "value": 8000.0,
      "stage": "Qualified",
      "probability": 60,
      "close_date": "2024-03-30",
      "created": "2024-01-10",
      "status": "active",
      "products": ["User Licenses"],
    },
  ];

  List<Map<String, dynamic>> communications = [
    {
      "id": "1",
      "type": "email",
      "subject": "Re: Enterprise Package Proposal",
      "content": "Thank you for the detailed proposal. We have some questions about the implementation timeline and training requirements.",
      "date": "2024-01-15",
      "time": "2:45 PM",
      "direction": "inbound",
      "status": "read",
    },
    {
      "id": "2",
      "type": "email",
      "subject": "Enterprise Package Proposal",
      "content": "Please find attached our comprehensive proposal for your enterprise software needs. The package includes...",
      "date": "2024-01-15",
      "time": "10:30 AM",
      "direction": "outbound",
      "status": "sent",
    },
    {
      "id": "3",
      "type": "phone",
      "subject": "Discovery Call",
      "content": "Discussed current pain points and requirements. John mentioned they need to implement by Q2 2024.",
      "date": "2024-01-12",
      "time": "11:00 AM",
      "direction": "outbound",
      "status": "completed",
    },
  ];

  Widget _buildContactHeader() {
    Color statusColor = _getStatusColor(contact["status"]);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("${contact["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${contact["name"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${contact["position"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${contact["company"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${contact["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${contact["segment"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: spXs,
                children: [
                  Text(
                    "Lead Score",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${contact["lead_score"]}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _getScoreColor(contact["lead_score"]),
                    ),
                  ),
                  Text(
                    "Total Value",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${((contact["value"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Tags
          if ((contact["tags"] as List).isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: (contact["tags"] as List).map<Widget>((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          
          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  icon: Icons.email,
                  label: "Email",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: QButton(
                  icon: Icons.phone,
                  label: "Call",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: QButton(
                  icon: Icons.video_call,
                  label: "Meeting",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: QButton(
                  icon: Icons.edit,
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      spacing: spMd,
      children: [
        // Contact Information
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spSm),
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
              _buildInfoRow(Icons.email, "Email", "${contact["email"]}"),
              _buildInfoRow(Icons.phone, "Phone", "${contact["phone"]}"),
              _buildInfoRow(Icons.phone_android, "Mobile", "${contact["mobile"]}"),
              _buildInfoRow(Icons.location_on, "Location", "${contact["location"]}"),
              _buildInfoRow(Icons.access_time, "Timezone", "${contact["timezone"]}"),
              _buildInfoRow(Icons.web, "Website", "${contact["website"]}"),
              _buildInfoRow(Icons.link, "LinkedIn", "${contact["linkedin"]}"),
            ],
          ),
        ),

        // Company Information
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spSm),
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
              _buildInfoRow(Icons.business, "Company", "${contact["company"]}"),
              _buildInfoRow(Icons.work, "Department", "${contact["department"]}"),
              _buildInfoRow(Icons.category, "Industry", "${contact["industry"]}"),
              _buildInfoRow(Icons.people, "Employees", "${contact["employees"]}"),
              _buildInfoRow(Icons.attach_money, "Revenue", "${contact["revenue"]}"),
            ],
          ),
        ),

        // Lead Information
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spSm),
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
                "Lead Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              _buildInfoRow(Icons.source, "Source", "${contact["source"]}"),
              _buildInfoRow(Icons.person, "Assigned To", "${contact["assigned_to"]}"),
              _buildInfoRow(Icons.person_add, "Created By", "${contact["created_by"]}"),
              _buildInfoRow(Icons.calendar_today, "Created", "${contact["created"]}"),
              _buildInfoRow(Icons.schedule, "Last Contact", "${contact["last_contact"]}"),
            ],
          ),
        ),

        // Notes
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spSm),
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
                "Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${contact["notes"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(width: spSm),
        Text(
          "$label:",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(width: spSm),
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

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: activity["color"].withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              activity["icon"],
              color: activity["color"],
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${activity["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 12,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${activity["date"]} at ${activity["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.person,
                      size: 12,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${activity["user"]}",
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: _getActivityStatusColor(activity["status"]),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${activity["status"]}",
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealItem(Map<String, dynamic> deal) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
                  "${deal["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "\$${((deal["value"] as num).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${deal["stage"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${deal["probability"]}% probability",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Close: ${deal["close_date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if ((deal["products"] as List).isNotEmpty)
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (deal["products"] as List).map<Widget>((product) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    product,
                    style: TextStyle(
                      fontSize: 10,
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

  Widget _buildCommunicationItem(Map<String, dynamic> comm) {
    IconData icon = comm["type"] == "email" ? Icons.email : Icons.phone;
    Color directionColor = comm["direction"] == "inbound" ? successColor : primaryColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
                icon,
                color: directionColor,
                size: 16,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${comm["subject"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: directionColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${comm["direction"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: directionColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${comm["content"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${comm["date"]} at ${comm["time"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'hot':
        return dangerColor;
      case 'warm':
        return warningColor;
      case 'active':
        return successColor;
      case 'cold':
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return successColor;
    if (score >= 60) return warningColor;
    return dangerColor;
  }

  Color _getActivityStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'scheduled':
        return warningColor;
      case 'pending':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Details"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spSm),
            child: QButton(
              icon: Icons.edit,
              size: bs.sm,
              onPressed: () {
                // Navigate to edit contact
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Fixed Contact Header
          Container(
            padding: EdgeInsets.all(spMd),
            child: _buildContactHeader(),
          ),
          
          // Tabbed Content
          Expanded(
            child: QTabBar(
              withoutAppBar: true,
              selectedIndex: currentTab,
              tabs: [
                Tab(text: "Info", icon: Icon(Icons.info)),
                Tab(text: "Activity", icon: Icon(Icons.sports)),
                Tab(text: "Deals", icon: Icon(Icons.handshake)),
                Tab(text: "Communications", icon: Icon(Icons.chat)),
              ],
              tabChildren: [
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: _buildContactInfo(),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    children: activities.map((activity) => _buildActivityItem(activity)).toList(),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    children: deals.map((deal) => _buildDealItem(deal)).toList(),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    children: communications.map((comm) => _buildCommunicationItem(comm)).toList(),
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
