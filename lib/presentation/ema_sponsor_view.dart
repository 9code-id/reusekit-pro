import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSponsorView extends StatefulWidget {
  const EmaSponsorView({super.key});

  @override
  State<EmaSponsorView> createState() => _EmaSponsorViewState();
}

class _EmaSponsorViewState extends State<EmaSponsorView> {
  String searchQuery = "";
  String selectedCategory = "All";

  List<Map<String, dynamic>> sponsors = [
    {
      "id": 1,
      "name": "TechCorp Solutions",
      "logo": "https://picsum.photos/80/80?random=101",
      "category": "Technology",
      "tier": "Platinum",
      "amount": 50000,
      "status": "Active",
      "contact": "John Smith",
      "email": "john@techcorp.com",
      "phone": "+1 234 567 8900",
      "events": 12,
      "startDate": "2024-01-15",
      "endDate": "2024-12-31"
    },
    {
      "id": 2,
      "name": "Global Finance Inc",
      "logo": "https://picsum.photos/80/80?random=102",
      "category": "Finance",
      "tier": "Gold",
      "amount": 30000,
      "status": "Active",
      "contact": "Sarah Wilson",
      "email": "sarah@globalfinance.com",
      "phone": "+1 234 567 8901",
      "events": 8,
      "startDate": "2024-02-01",
      "endDate": "2024-11-30"
    },
    {
      "id": 3,
      "name": "Healthcare Plus",
      "logo": "https://picsum.photos/80/80?random=103",
      "category": "Healthcare",
      "tier": "Silver",
      "amount": 15000,
      "status": "Pending",
      "contact": "Dr. Michael Brown",
      "email": "michael@healthcareplus.com",
      "phone": "+1 234 567 8902",
      "events": 5,
      "startDate": "2024-03-01",
      "endDate": "2024-10-31"
    },
    {
      "id": 4,
      "name": "EduTech Academy",
      "logo": "https://picsum.photos/80/80?random=104",
      "category": "Education",
      "tier": "Bronze",
      "amount": 8000,
      "status": "Active",
      "contact": "Lisa Johnson",
      "email": "lisa@edutech.com",
      "phone": "+1 234 567 8903",
      "events": 3,
      "startDate": "2024-01-20",
      "endDate": "2024-08-30"
    },
    {
      "id": 5,
      "name": "Green Energy Co",
      "logo": "https://picsum.photos/80/80?random=105",
      "category": "Energy",
      "tier": "Gold",
      "amount": 35000,
      "status": "Expired",
      "contact": "Robert Green",
      "email": "robert@greenenergy.com",
      "phone": "+1 234 567 8904",
      "events": 10,
      "startDate": "2023-06-01",
      "endDate": "2024-05-31"
    },
    {
      "id": 6,
      "name": "Fashion Forward",
      "logo": "https://picsum.photos/80/80?random=106",
      "category": "Fashion",
      "tier": "Silver",
      "amount": 20000,
      "status": "Active",
      "contact": "Emma Davis",
      "email": "emma@fashionforward.com",
      "phone": "+1 234 567 8905",
      "events": 6,
      "startDate": "2024-02-15",
      "endDate": "2024-12-15"
    }
  ];

  List<String> categories = ["All", "Technology", "Finance", "Healthcare", "Education", "Energy", "Fashion"];

  List<Map<String, dynamic>> get filteredSponsors {
    return sponsors.where((sponsor) {
      bool matchesSearch = "${sponsor["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${sponsor["contact"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || sponsor["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Color _getTierColor(String tier) {
    switch (tier) {
      case "Platinum":
        return Colors.purple;
      case "Gold":
        return Colors.orange;
      case "Silver":
        return Colors.grey;
      case "Bronze":
        return Colors.brown;
      default:
        return primaryColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending":
        return warningColor;
      case "Expired":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Sponsors"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add sponsor
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
                    label: "Search sponsors...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  QCategoryPicker(
                    label: "Category",
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Stats Overview
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${sponsors.where((s) => s["status"] == "Active").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active Sponsors",
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
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${((sponsors.where((s) => s["status"] == "Active").map((s) => s["amount"] as int).fold(0, (sum, amount) => sum + amount)) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Funding",
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
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${sponsors.map((s) => s["events"] as int).fold(0, (sum, events) => sum + events)}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Total Events",
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

            // Sponsors List
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
                        "Sponsors (${filteredSponsors.length})",
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
                          // Show filter options
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredSponsors.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final sponsor = filteredSponsors[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
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
                                  "${sponsor["logo"]}",
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
                                          "${sponsor["name"]}",
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
                                          color: _getTierColor("${sponsor["tier"]}").withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${sponsor["tier"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: _getTierColor("${sponsor["tier"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(Icons.business, size: 12, color: disabledBoldColor),
                                      SizedBox(width: 4),
                                      Text(
                                        "${sponsor["category"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(" • ", style: TextStyle(color: disabledBoldColor)),
                                      Icon(Icons.person, size: 12, color: disabledBoldColor),
                                      SizedBox(width: 4),
                                      Text(
                                        "${sponsor["contact"]}",
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
                                      Text(
                                        "\$${((sponsor["amount"] as int).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                      Text(" • ", style: TextStyle(color: disabledBoldColor)),
                                      Text(
                                        "${sponsor["events"]} events",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor("${sponsor["status"]}").withAlpha(30),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${sponsor["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: _getStatusColor("${sponsor["status"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Column(
                              children: [
                                QButton(
                                  icon: Icons.visibility,
                                  size: bs.sm,
                                  onPressed: () {
                                    // View sponsor details
                                  },
                                ),
                                SizedBox(height: spXs),
                                QButton(
                                  icon: Icons.edit,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Edit sponsor
                                  },
                                ),
                              ],
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
