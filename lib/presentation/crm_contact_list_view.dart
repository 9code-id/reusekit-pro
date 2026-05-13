import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmContactListView extends StatefulWidget {
  const CrmContactListView({super.key});

  @override
  State<CrmContactListView> createState() => _CrmContactListViewState();
}

class _CrmContactListViewState extends State<CrmContactListView> {
  String searchQuery = "";
  String selectedSegment = "";
  String selectedStatus = "";
  String sortBy = "name";
  bool isListView = true;

  List<Map<String, dynamic>> contacts = [
    {
      "id": "1",
      "name": "John Smith",
      "email": "john@acme.com",
      "phone": "+1 234 567 8900",
      "company": "Acme Corp",
      "position": "CEO",
      "status": "Active",
      "segment": "Enterprise",
      "last_contact": "2024-01-15",
      "lead_score": 85,
      "tags": ["VIP", "Decision Maker"],
      "notes": "Interested in enterprise solution",
      "avatar": "https://picsum.photos/150/150?random=1",
      "value": 25000.0,
      "created": "2024-01-01",
      "activities": 12,
      "location": "New York, NY",
    },
    {
      "id": "2",
      "name": "Sarah Johnson",
      "email": "sarah@techstart.com",
      "phone": "+1 234 567 8901",
      "company": "TechStart Inc",
      "position": "CTO",
      "status": "Active",
      "segment": "SMB",
      "last_contact": "2024-01-14",
      "lead_score": 72,
      "tags": ["Technical", "Evaluator"],
      "notes": "Technical evaluation stage",
      "avatar": "https://picsum.photos/150/150?random=2",
      "value": 15000.0,
      "created": "2024-01-03",
      "activities": 8,
      "location": "San Francisco, CA",
    },
    {
      "id": "3",
      "name": "Mike Davis",
      "email": "mike@global.com",
      "phone": "+1 234 567 8902",
      "company": "Global Solutions",
      "position": "VP Sales",
      "status": "Cold",
      "segment": "Mid-Market",
      "last_contact": "2024-01-10",
      "lead_score": 58,
      "tags": ["Sales", "Prospect"],
      "notes": "No response to recent outreach",
      "avatar": "https://picsum.photos/150/150?random=3",
      "value": 8000.0,
      "created": "2023-12-28",
      "activities": 3,
      "location": "Chicago, IL",
    },
    {
      "id": "4",
      "name": "Emily Brown",
      "email": "emily@startup.com",
      "phone": "+1 234 567 8903",
      "company": "StartupCo",
      "position": "Founder",
      "status": "Hot",
      "segment": "Startup",
      "last_contact": "2024-01-16",
      "lead_score": 91,
      "tags": ["Hot Lead", "Founder"],
      "notes": "Ready to sign this week",
      "avatar": "https://picsum.photos/150/150?random=4",
      "value": 12000.0,
      "created": "2024-01-05",
      "activities": 15,
      "location": "Austin, TX",
    },
    {
      "id": "5",
      "name": "David Wilson",
      "email": "david@enterprise.com",
      "phone": "+1 234 567 8904",
      "company": "Enterprise Ltd",
      "position": "Director IT",
      "status": "Warm",
      "segment": "Enterprise",
      "last_contact": "2024-01-12",
      "lead_score": 78,
      "tags": ["IT", "Budget Holder"],
      "notes": "Budget approved for next quarter",
      "avatar": "https://picsum.photos/150/150?random=5",
      "value": 35000.0,
      "created": "2024-01-02",
      "activities": 9,
      "location": "Seattle, WA",
    },
    {
      "id": "6",
      "name": "Lisa Anderson",
      "email": "lisa@solutions.com",
      "phone": "+1 234 567 8905",
      "company": "Solutions Inc",
      "position": "VP Marketing",
      "status": "Active",
      "segment": "Mid-Market",
      "last_contact": "2024-01-13",
      "lead_score": 83,
      "tags": ["Marketing", "Influencer"],
      "notes": "Interested in marketing automation",
      "avatar": "https://picsum.photos/150/150?random=6",
      "value": 22000.0,
      "created": "2024-01-04",
      "activities": 11,
      "location": "Boston, MA",
    },
  ];

  List<Map<String, dynamic>> segmentItems = [
    {"label": "All Segments", "value": ""},
    {"label": "Enterprise", "value": "enterprise"},
    {"label": "Mid-Market", "value": "mid-market"},
    {"label": "SMB", "value": "smb"},
    {"label": "Startup", "value": "startup"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": ""},
    {"label": "Hot", "value": "hot"},
    {"label": "Warm", "value": "warm"},
    {"label": "Active", "value": "active"},
    {"label": "Cold", "value": "cold"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Name", "value": "name"},
    {"label": "Company", "value": "company"},
    {"label": "Last Contact", "value": "last_contact"},
    {"label": "Lead Score", "value": "lead_score"},
    {"label": "Created Date", "value": "created"},
  ];

  List<Map<String, dynamic>> get filteredAndSortedContacts {
    List<Map<String, dynamic>> filtered = contacts.where((contact) {
      bool matchesSearch = searchQuery.isEmpty || 
          contact["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          contact["company"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          contact["email"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesSegment = selectedSegment.isEmpty || 
          contact["segment"].toLowerCase() == selectedSegment;
      
      bool matchesStatus = selectedStatus.isEmpty || 
          contact["status"].toLowerCase() == selectedStatus;
      
      return matchesSearch && matchesSegment && matchesStatus;
    }).toList();

    // Sort contacts
    filtered.sort((a, b) {
      switch (sortBy) {
        case "name":
          return a["name"].compareTo(b["name"]);
        case "company":
          return a["company"].compareTo(b["company"]);
        case "last_contact":
          return b["last_contact"].compareTo(a["last_contact"]);
        case "lead_score":
          return (b["lead_score"] as int).compareTo(a["lead_score"] as int);
        case "created":
          return b["created"].compareTo(a["created"]);
        default:
          return a["name"].compareTo(b["name"]);
      }
    });

    return filtered;
  }

  Widget _buildContactListItem(Map<String, dynamic> contact) {
    Color statusColor = _getStatusColor(contact["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to contact detail
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("${contact["avatar"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${contact["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${contact["position"]} at ${contact["company"]}",
                        style: TextStyle(
                          fontSize: 14,
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
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${contact["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Score: ${contact["lead_score"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getScoreColor(contact["lead_score"]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            Row(
              children: [
                Icon(Icons.email, size: 14, color: disabledBoldColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${contact["email"]}",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                ),
                Icon(Icons.phone, size: 14, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "${contact["phone"]}",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
              ],
            ),
            
            Row(
              children: [
                Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${contact["location"]}",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${contact["segment"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            if ((contact["tags"] as List).isNotEmpty)
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (contact["tags"] as List).map<Widget>((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 10,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
            
            Divider(),
            
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Last Contact",
                        style: TextStyle(fontSize: 10, color: disabledBoldColor),
                      ),
                      Text(
                        "${contact["last_contact"]}",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Activities",
                        style: TextStyle(fontSize: 10, color: disabledBoldColor),
                      ),
                      Text(
                        "${contact["activities"]}",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Value",
                      style: TextStyle(fontSize: 10, color: disabledBoldColor),
                    ),
                    Text(
                      "\$${((contact["value"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactGridItem(Map<String, dynamic> contact) {
    Color statusColor = _getStatusColor(contact["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to contact detail
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("${contact["avatar"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${contact["status"]}",
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            Text(
              "${contact["name"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            Text(
              "${contact["company"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            Text(
              "${contact["position"]}",
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${contact["segment"]}",
                style: TextStyle(
                  fontSize: 8,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            Spacer(),
            
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Score",
                        style: TextStyle(fontSize: 8, color: disabledBoldColor),
                      ),
                      Text(
                        "${contact["lead_score"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getScoreColor(contact["lead_score"]),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Value",
                      style: TextStyle(fontSize: 8, color: disabledBoldColor),
                    ),
                    Text(
                      "\$${((contact["value"] as num).toDouble() / 1000).round()}K",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact List"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spSm),
            child: QButton(
              icon: isListView ? Icons.grid_view : Icons.list,
              size: bs.sm,
              onPressed: () {
                isListView = !isListView;
                setState(() {});
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: spSm),
            child: QButton(
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                // Navigate to add contact
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
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
                    "Search & Filter",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QTextField(
                    label: "Search contacts...",
                    value: searchQuery,
                    hint: "Name, company, or email",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Segment",
                          items: segmentItems,
                          value: selectedSegment,
                          onChanged: (value, label) {
                            selectedSegment = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusItems,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Sort By",
                    items: sortItems,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Results Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.contacts,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Showing ${filteredAndSortedContacts.length} of ${contacts.length} contacts",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Total Value: \$${((filteredAndSortedContacts.map((c) => c["value"] as num).fold(0.0, (a, b) => a + b)) / 1000).round()}K",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),

            // Contacts Display
            if (isListView)
              // List View
              Column(
                children: filteredAndSortedContacts.map((contact) => 
                  _buildContactListItem(contact)).toList(),
              )
            else
              // Grid View
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredAndSortedContacts.map((contact) {
                  return _buildContactGridItem(contact);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
