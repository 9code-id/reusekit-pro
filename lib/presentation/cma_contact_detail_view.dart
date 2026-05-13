import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaContactDetailView extends StatefulWidget {
  const CmaContactDetailView({super.key});

  @override
  State<CmaContactDetailView> createState() => _CmaContactDetailViewState();
}

class _CmaContactDetailViewState extends State<CmaContactDetailView> {
  Map<String, dynamic> contact = {
    "id": "C001",
    "firstName": "John",
    "lastName": "Doe",
    "email": "john.doe@email.com",
    "phone": "+1 (555) 123-4567",
    "company": "Acme Corporation",
    "position": "Software Engineer",
    "address": "123 Main Street, New York, NY 10001",
    "status": "Active",
    "leadScore": 85,
    "tags": ["VIP", "Premium", "Developer"],
    "createdAt": "2024-12-15",
    "lastContact": "2024-12-18",
    "source": "Website",
    "notes": "Interested in enterprise solutions. Follow up on Q1 roadmap.",
    "socialMedia": {
      "linkedin": "linkedin.com/in/johndoe",
      "twitter": "@johndoe"
    },
    "customFields": {
      "Budget": "\$50,000",
      "Decision Timeline": "Q1 2025",
      "Pain Points": "Scalability issues"
    }
  };

  List<Map<String, dynamic>> activities = [
    {
      "type": "email",
      "title": "Email Sent",
      "description": "Sent product demo invitation",
      "date": "2024-12-18 14:30",
      "icon": Icons.email,
      "color": Colors.blue
    },
    {
      "type": "call",
      "title": "Phone Call",
      "description": "Discovery call - 45 minutes",
      "date": "2024-12-17 10:00",
      "icon": Icons.phone,
      "color": Colors.green
    },
    {
      "type": "meeting",
      "title": "Meeting Scheduled",
      "description": "Product demo meeting",
      "date": "2024-12-16 16:00",
      "icon": Icons.event,
      "color": Colors.orange
    },
    {
      "type": "note",
      "title": "Note Added",
      "description": "Updated requirements and budget info",
      "date": "2024-12-15 09:15",
      "icon": Icons.note,
      "color": Colors.purple
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              //navigateTo('CmaAddContactView')
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showMoreOptions();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactHeader(),
            SizedBox(height: spMd),
            _buildContactInfo(),
            SizedBox(height: spMd),
            _buildCustomFields(),
            SizedBox(height: spMd),
            _buildTags(),
            SizedBox(height: spMd),
            _buildRecentActivity(),
            SizedBox(height: spMd),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: primaryColor.withAlpha(20),
            child: Text(
              "${contact["firstName"][0]}${contact["lastName"][0]}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${contact["firstName"]} ${contact["lastName"]}",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${contact["position"]} at ${contact["company"]}",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildHeaderStat("Lead Score", "${contact["leadScore"]}", Colors.green),
              _buildHeaderStat("Status", "${contact["status"]}", primaryColor),
              _buildHeaderStat("Source", "${contact["source"]}", Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Container(
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
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          _buildInfoRow(Icons.email, "Email", "${contact["email"]}"),
          _buildInfoRow(Icons.phone, "Phone", "${contact["phone"]}"),
          _buildInfoRow(Icons.location_on, "Address", "${contact["address"]}"),
          _buildInfoRow(Icons.event, "Created", "${DateTime.parse(contact["createdAt"]).dMMMy}"),
          _buildInfoRow(Icons.access_time, "Last Contact", "${DateTime.parse(contact["lastContact"]).dMMMy}"),
          if (contact["socialMedia"]["linkedin"] != null)
            _buildInfoRow(Icons.link, "LinkedIn", "${contact["socialMedia"]["linkedin"]}"),
          if (contact["socialMedia"]["twitter"] != null)
            _buildInfoRow(Icons.link, "Twitter", "${contact["socialMedia"]["twitter"]}"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomFields() {
    return Container(
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
            "Custom Fields",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...contact["customFields"].entries.map((entry) {
            return _buildInfoRow(Icons.info, entry.key, entry.value);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTags() {
    return Container(
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
            "Tags",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: (contact["tags"] as List).map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$tag",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  //navigateTo('ActivityHistoryView')
                },
                child: Text("View All"),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...activities.take(4).map((activity) {
            return _buildActivityItem(activity);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 3,
            color: activity["color"],
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: (activity["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              activity["icon"],
              size: 16,
              color: activity["color"],
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${activity["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${DateTime.parse(activity["date"]).dMMMykkss}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: QButton(
            label: "Send Email",
            icon: Icons.email,
            size: bs.sm,
            onPressed: () {
              _sendEmail();
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QButton(
            label: "Make Call",
            icon: Icons.phone,
            size: bs.sm,
            onPressed: () {
              _makeCall();
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QButton(
            label: "Schedule",
            icon: Icons.event,
            size: bs.sm,
            onPressed: () {
              _scheduleMeeting();
            },
          ),
        ),
      ],
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit, color: primaryColor),
                title: Text("Edit Contact"),
                onTap: () {
                  back();
                  //navigateTo('CmaAddContactView')
                },
              ),
              ListTile(
                leading: Icon(Icons.copy, color: primaryColor),
                title: Text("Duplicate Contact"),
                onTap: () {
                  back();
                  _duplicateContact();
                },
              ),
              ListTile(
                leading: Icon(Icons.merge, color: primaryColor),
                title: Text("Merge Contact"),
                onTap: () {
                  back();
                  //navigateTo('CmaContactMergeView')
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: dangerColor),
                title: Text("Delete Contact"),
                onTap: () {
                  back();
                  _deleteContact();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendEmail() {
    si("Email composer opened");
  }

  void _makeCall() {
    si("Dialing ${contact["phone"]}");
  }

  void _scheduleMeeting() {
    si("Meeting scheduler opened");
  }

  void _duplicateContact() {
    si("Contact duplicated successfully");
  }

  void _deleteContact() async {
    bool isConfirmed = await confirm("Are you sure you want to delete this contact?");
    if (isConfirmed) {
      ss("Contact deleted successfully");
      back();
    }
  }
}
