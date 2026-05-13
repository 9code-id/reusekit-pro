import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaPartnershipView extends StatefulWidget {
  const EmaPartnershipView({super.key});

  @override
  State<EmaPartnershipView> createState() => _EmaPartnershipViewState();
}

class _EmaPartnershipViewState extends State<EmaPartnershipView> {
  String searchQuery = "";
  String selectedStatus = "All";

  List<Map<String, dynamic>> partnerships = [
    {
      "id": 1,
      "organizationName": "Global Tech Alliance",
      "logo": "https://picsum.photos/80/80?random=201",
      "partnershipType": "Strategic",
      "status": "Active",
      "startDate": "2024-01-15",
      "endDate": "2025-01-15",
      "contactPerson": "Jennifer Martinez",
      "email": "jennifer@globaltechalliance.com",
      "phone": "+1 555 0123",
      "benefits": [
        "Co-marketing opportunities",
        "Resource sharing",
        "Joint event hosting",
        "Technology collaboration"
      ],
      "eventsCollaborated": 8,
      "revenue": 125000,
      "description": "Strategic partnership for technology innovation and market expansion."
    },
    {
      "id": 2,
      "organizationName": "Education Connect",
      "logo": "https://picsum.photos/80/80?random=202",
      "partnershipType": "Content",
      "status": "Active",
      "startDate": "2024-02-01",
      "endDate": "2024-11-30",
      "contactPerson": "Dr. Michael Chen",
      "email": "michael@educationconnect.org",
      "phone": "+1 555 0124",
      "benefits": [
        "Educational content creation",
        "Speaker bureau access",
        "Certification programs",
        "Workshop facilitation"
      ],
      "eventsCollaborated": 12,
      "revenue": 85000,
      "description": "Partnership focused on educational content and professional development."
    },
    {
      "id": 3,
      "organizationName": "Media Fusion Network",
      "logo": "https://picsum.photos/80/80?random=203",
      "partnershipType": "Media",
      "status": "Pending",
      "startDate": "2024-03-15",
      "endDate": "2025-03-15",
      "contactPerson": "Sarah Thompson",
      "email": "sarah@mediafusion.net",
      "phone": "+1 555 0125",
      "benefits": [
        "Media coverage",
        "Live streaming services",
        "Content distribution",
        "Social media promotion"
      ],
      "eventsCollaborated": 0,
      "revenue": 0,
      "description": "Media partnership for enhanced event coverage and content distribution."
    },
    {
      "id": 4,
      "organizationName": "Venue Solutions Group",
      "logo": "https://picsum.photos/80/80?random=204",
      "partnershipType": "Venue",
      "status": "Active",
      "startDate": "2023-06-01",
      "endDate": "2024-12-31",
      "contactPerson": "Robert Wilson",
      "email": "robert@venuesolutions.com",
      "phone": "+1 555 0126",
      "benefits": [
        "Preferred venue rates",
        "Priority booking",
        "Setup assistance",
        "Equipment rental discounts"
      ],
      "eventsCollaborated": 15,
      "revenue": 200000,
      "description": "Venue partnership providing premium locations at discounted rates."
    },
    {
      "id": 5,
      "organizationName": "Catering Excellence",
      "logo": "https://picsum.photos/80/80?random=205",
      "partnershipType": "Service",
      "status": "Expired",
      "startDate": "2023-01-01",
      "endDate": "2023-12-31",
      "contactPerson": "Lisa Rodriguez",
      "email": "lisa@cateringexcellence.com",
      "phone": "+1 555 0127",
      "benefits": [
        "Catering services",
        "Menu customization",
        "Special dietary options",
        "Event setup support"
      ],
      "eventsCollaborated": 22,
      "revenue": 180000,
      "description": "Full-service catering partnership for all event types."
    },
    {
      "id": 6,
      "organizationName": "Innovation Hub",
      "logo": "https://picsum.photos/80/80?random=206",
      "partnershipType": "Strategic",
      "status": "Under Review",
      "startDate": "2024-04-01",
      "endDate": "2025-04-01",
      "contactPerson": "David Park",
      "email": "david@innovationhub.tech",
      "phone": "+1 555 0128",
      "benefits": [
        "Startup ecosystem access",
        "Innovation showcases",
        "Mentorship programs",
        "Investment opportunities"
      ],
      "eventsCollaborated": 0,
      "revenue": 0,
      "description": "Strategic partnership to connect with innovative startups and entrepreneurs."
    }
  ];

  List<String> statusOptions = ["All", "Active", "Pending", "Under Review", "Expired"];
  List<String> partnershipTypes = ["All", "Strategic", "Content", "Media", "Venue", "Service"];

  List<Map<String, dynamic>> get filteredPartnerships {
    return partnerships.where((partnership) {
      bool matchesSearch = "${partnership["organizationName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${partnership["contactPerson"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || partnership["status"] == selectedStatus;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending":
        return warningColor;
      case "Under Review":
        return infoColor;
      case "Expired":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPartnershipTypeColor(String type) {
    switch (type) {
      case "Strategic":
        return Colors.purple;
      case "Content":
        return Colors.blue;
      case "Media":
        return Colors.pink;
      case "Venue":
        return Colors.green;
      case "Service":
        return Colors.orange;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Partnership Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add partnership
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search partnerships...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  QCategoryPicker(
                    label: "Status Filter",
                    items: statusOptions.map((status) => {
                      "label": status,
                      "value": status,
                    }).toList(),
                    value: selectedStatus,
                    onChanged: (index, label, value, item) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Partnership Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Partnership Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${partnerships.where((p) => p["status"] == "Active").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Active",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${partnerships.where((p) => p["status"] == "Pending" || p["status"] == "Under Review").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Pending",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${((partnerships.where((p) => p["status"] == "Active").map((p) => p["revenue"] as int).fold(0, (sum, revenue) => sum + revenue)) / 1000).toInt()}K",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Revenue",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${partnerships.map((p) => p["eventsCollaborated"] as int).fold(0, (sum, events) => sum + events)}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Events",
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
                ],
              ),
            ),

            // Partnership Types Distribution
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Partnership Types",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spXs,
                    children: partnershipTypes.skip(1).map((type) {
                      final count = partnerships.where((p) => p["partnershipType"] == type).length;
                      final color = _getPartnershipTypeColor(type);
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: color.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: color.withAlpha(100)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "$type ($count)",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Partnerships List
            Container(
              padding: EdgeInsets.all(spSm),
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
                        "Partnerships (${filteredPartnerships.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.filter_list, size: 20),
                        onPressed: () {
                          // Show advanced filters
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredPartnerships.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final partnership = filteredPartnerships[index];
                      final typeColor = _getPartnershipTypeColor("${partnership["partnershipType"]}");
                      final statusColor = _getStatusColor("${partnership["status"]}");
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(color: disabledOutlineBorderColor),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    child: Image.network(
                                      "${partnership["logo"]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${partnership["organizationName"]}",
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
                                              color: statusColor.withAlpha(30),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${partnership["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: statusColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: typeColor.withAlpha(30),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${partnership["partnershipType"]} Partnership",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: typeColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Icon(Icons.person, size: 12, color: disabledBoldColor),
                                          SizedBox(width: 4),
                                          Text(
                                            "${partnership["contactPerson"]}",
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
                                          Icon(Icons.event, size: 12, color: disabledBoldColor),
                                          SizedBox(width: 4),
                                          Text(
                                            "${partnership["eventsCollaborated"]} events",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          if ((partnership["revenue"] as int) > 0) ...[
                                            Text(" • ", style: TextStyle(color: disabledBoldColor)),
                                            Text(
                                              "\$${((partnership["revenue"] as int).toDouble()).currency}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: successColor,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    QButton(
                                      icon: Icons.visibility,
                                      size: bs.sm,
                                      onPressed: () {
                                        // View partnership details
                                      },
                                    ),
                                    SizedBox(height: spXs),
                                    QButton(
                                      icon: Icons.edit,
                                      size: bs.sm,
                                      onPressed: () {
                                        // Edit partnership
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${partnership["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            
                            SizedBox(height: spXs),
                            Wrap(
                              spacing: spXs,
                              runSpacing: 4,
                              children: (partnership["benefits"] as List).take(3).map((benefit) => 
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$benefit",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ).toList(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
