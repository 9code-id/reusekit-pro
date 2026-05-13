import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaCompetitionsView extends StatefulWidget {
  const GeaCompetitionsView({super.key});

  @override
  State<GeaCompetitionsView> createState() => _GeaCompetitionsViewState();
}

class _GeaCompetitionsViewState extends State<GeaCompetitionsView> {
  String selectedTab = "Live";
  String searchQuery = "";

  List<Map<String, dynamic>> competitions = [
    {
      "id": 1,
      "name": "World Championship",
      "game": "Battle Arena",
      "status": "Live",
      "startDate": "2024-06-15",
      "endDate": "2024-06-30",
      "prizePool": 100000,
      "participants": 2456,
      "maxParticipants": 5000,
      "entryFee": 25.0,
      "image": "https://picsum.photos/300/200?random=1&keyword=gaming",
      "category": "Tournament",
      "difficulty": "Professional",
    },
    {
      "id": 2,
      "name": "Summer League",
      "game": "Racing Masters",
      "status": "Live",
      "startDate": "2024-06-10",
      "endDate": "2024-07-10",
      "prizePool": 50000,
      "participants": 1234,
      "maxParticipants": 2000,
      "entryFee": 15.0,
      "image": "https://picsum.photos/300/200?random=2&keyword=racing",
      "category": "League",
      "difficulty": "Amateur",
    },
    {
      "id": 3,
      "name": "Rookie Challenge",
      "game": "Strategy Quest",
      "status": "Upcoming",
      "startDate": "2024-07-01",
      "endDate": "2024-07-15",
      "prizePool": 25000,
      "participants": 0,
      "maxParticipants": 1000,
      "entryFee": 10.0,
      "image": "https://picsum.photos/300/200?random=3&keyword=strategy",
      "category": "Challenge",
      "difficulty": "Beginner",
    },
    {
      "id": 4,
      "name": "Championship Series",
      "game": "Action Heroes",
      "status": "Ended",
      "startDate": "2024-05-01",
      "endDate": "2024-05-31",
      "prizePool": 75000,
      "participants": 3456,
      "maxParticipants": 4000,
      "entryFee": 20.0,
      "image": "https://picsum.photos/300/200?random=4&keyword=action",
      "category": "Series",
      "difficulty": "Professional",
    },
  ];

  List<Map<String, dynamic>> get filteredCompetitions {
    return competitions.where((competition) {
      final matchesTab = selectedTab == "All" || competition["status"] == selectedTab;
      final matchesSearch = searchQuery.isEmpty ||
          (competition["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (competition["game"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesTab && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Live":
        return successColor;
      case "Upcoming":
        return warningColor;
      case "Ended":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gaming Competitions"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('CreateCompetitionView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Live Competitions",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${competitions.where((c) => c["status"] == "Live").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Prize Pool",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${((competitions.fold(0.0, (sum, c) => sum + (c["prizePool"] as int))) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Players",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${((competitions.fold(0, (sum, c) => sum + (c["participants"] as int))) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search and Filter
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search competitions...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Live", "value": "Live"},
                      {"label": "Upcoming", "value": "Upcoming"},
                      {"label": "Ended", "value": "Ended"},
                    ],
                    value: selectedTab,
                    onChanged: (value, label) {
                      selectedTab = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Competitions List
            ...filteredCompetitions.map((competition) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Header
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            "${competition["image"]}",
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(competition["status"]),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${competition["status"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "\$${((competition["prizePool"] as int) / 1000).toStringAsFixed(0)}K",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${competition["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,  
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${competition["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "${competition["game"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          // Date Range
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${competition["startDate"]} - ${competition["endDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          // Stats Row  
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Participants",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${competition["participants"]}/${competition["maxParticipants"]}",
                                      style: TextStyle(
                                        fontSize: 16,
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
                                      "Entry Fee",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(competition["entryFee"] as double).toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                label: competition["status"] == "Live" ? "Join" : "View",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('CompetitionDetailView', arguments: competition)
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
