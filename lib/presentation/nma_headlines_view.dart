import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaHeadlinesView extends StatefulWidget {
  const NmaHeadlinesView({super.key});

  @override
  State<NmaHeadlinesView> createState() => _NmaHeadlinesViewState();
}

class _NmaHeadlinesViewState extends State<NmaHeadlinesView> {
  String selectedCategory = "All";
  List categories = ["All", "World", "National", "Politics", "Business"];
  
  List headlines = [
    {
      "id": 1,
      "title": "Global Economic Summit Concludes with Historic Trade Agreement",
      "summary": "Leaders from 20 nations sign comprehensive trade deal expected to boost global economy by 3%",
      "author": "Alexandra Smith",
      "timestamp": "15 minutes ago",
      "category": "World",
      "image": "https://picsum.photos/400/250?random=11&keyword=summit",
      "readTime": "4 min read",
      "priority": "high",
      "views": 15420,
      "shares": 892,
    },
    {
      "id": 2,
      "title": "Revolutionary Green Energy Initiative Launched Nationwide",
      "summary": "Government announces \$50 billion investment in renewable energy infrastructure",
      "author": "Michael Rodriguez",
      "timestamp": "32 minutes ago",
      "category": "National",
      "image": "https://picsum.photos/400/250?random=12&keyword=energy",
      "readTime": "5 min read",
      "priority": "high",
      "views": 12800,
      "shares": 634,
    },
    {
      "id": 3,
      "title": "Tech Giant Reports Record-Breaking Quarterly Earnings",
      "summary": "Company exceeds analyst expectations with 25% revenue growth and strong market expansion",
      "author": "Sarah Chen",
      "timestamp": "1 hour ago",
      "category": "Business",
      "image": "https://picsum.photos/400/250?random=13&keyword=tech",
      "readTime": "3 min read",
      "priority": "medium",
      "views": 9650,
      "shares": 445,
    },
    {
      "id": 4,
      "title": "Senate Passes Bipartisan Infrastructure Reform Bill",
      "summary": "Landmark legislation addresses transportation, broadband, and public works projects",
      "author": "David Thompson",
      "timestamp": "2 hours ago",
      "category": "Politics",
      "image": "https://picsum.photos/400/250?random=14&keyword=infrastructure",
      "readTime": "6 min read",
      "priority": "high",
      "views": 8970,
      "shares": 523,
    },
    {
      "id": 5,
      "title": "International Climate Conference Sets New Carbon Targets",
      "summary": "195 countries commit to ambitious emissions reduction goals for 2030",
      "author": "Emma Johnson",
      "timestamp": "3 hours ago",
      "category": "World",
      "image": "https://picsum.photos/400/250?random=15&keyword=climate",
      "readTime": "7 min read",
      "priority": "high",
      "views": 7340,
      "shares": 678,
    },
    {
      "id": 6,
      "title": "Major Healthcare Reform Proposal Unveiled",
      "summary": "New plan aims to expand coverage and reduce costs for millions of Americans",
      "author": "Dr. Lisa Park",
      "timestamp": "4 hours ago",
      "category": "National",
      "image": "https://picsum.photos/400/250?random=16&keyword=healthcare",
      "readTime": "5 min read",
      "priority": "medium",
      "views": 6780,
      "shares": 389,
    },
    {
      "id": 7,
      "title": "Stock Markets Surge Following Fed Interest Rate Decision",
      "summary": "Markets rally as central bank maintains accommodative monetary policy stance",
      "author": "Robert Kim",
      "timestamp": "5 hours ago",
      "category": "Business",
      "image": "https://picsum.photos/400/250?random=17&keyword=stocks",
      "readTime": "4 min read",
      "priority": "medium",
      "views": 5920,
      "shares": 267,
    },
    {
      "id": 8,
      "title": "Education Secretary Announces Digital Learning Initiative",
      "summary": "Comprehensive program to modernize classrooms and improve student outcomes",
      "author": "Jennifer Wilson",
      "timestamp": "6 hours ago",
      "category": "National",
      "image": "https://picsum.photos/400/250?random=18&keyword=education",
      "readTime": "4 min read",
      "priority": "medium",
      "views": 4560,
      "shares": 234,
    },
  ];

  List get filteredHeadlines {
    if (selectedCategory == "All") {
      return headlines;
    }
    return headlines.where((headline) => headline["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Headlines"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // navigateTo(NmaSearchView());
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: _buildHeadlinesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: QCategoryPicker(
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
    );
  }

  Widget _buildHeadlinesList() {
    if (filteredHeadlines.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.article,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No headlines found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Try selecting a different category",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFeaturedHeadline(),
          _buildRegularHeadlines(),
        ],
      ),
    );
  }

  Widget _buildFeaturedHeadline() {
    if (filteredHeadlines.isEmpty) return Container();
    
    final featured = filteredHeadlines.first;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(radiusMd),
                ),
                child: Image.network(
                  "${featured["image"]}",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spMd,
                left: spMd,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "FEATURED",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spMd,
                right: spMd,
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
                    "${featured["readTime"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
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
                    "${featured["category"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "${featured["title"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${featured["summary"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${featured["author"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      " • ",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${featured["timestamp"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.visibility,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${(featured["views"] as int).toStringAsFixed(0)} views",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.share,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${(featured["shares"] as int).toStringAsFixed(0)} shares",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Read Full Article",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(NmaArticleDetailView(articleId: featured["id"]));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegularHeadlines() {
    final remainingHeadlines = filteredHeadlines.skip(1).toList();
    
    if (remainingHeadlines.isEmpty) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "More Headlines",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...remainingHeadlines.map((headline) {
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${headline["image"]}",
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(headline["category"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${headline["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: _getCategoryColor(headline["category"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(headline["priority"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              _getPriorityIcon(headline["priority"]),
                              size: 12,
                              color: _getPriorityColor(headline["priority"]),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${headline["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${headline["summary"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  "${headline["author"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  " • ",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${headline["timestamp"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${headline["readTime"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${((headline["views"] as int) / 1000).toStringAsFixed(1)}K",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            Icons.share,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${(headline["shares"] as int).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "World":
        return primaryColor;
      case "National":
        return successColor;
      case "Politics":
        return warningColor;
      case "Business":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      default:
        return successColor;
    }
  }

  IconData _getPriorityIcon(String priority) {
    switch (priority) {
      case "high":
        return Icons.priority_high;
      case "medium":
        return Icons.remove;
      default:
        return Icons.keyboard_arrow_down;
    }
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Filter Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Sort by Priority",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Row(
                spacing: spSm,
                children: [
                  QButton(
                    label: "High Priority",
                    size: bs.sm,
                    onPressed: () {
                      back();
                    },
                  ),
                  QButton(
                    label: "Most Recent",
                    size: bs.sm,
                    onPressed: () {
                      back();
                    },
                  ),
                ],
              ),
              Row(
                spacing: spSm,
                children: [
                  QButton(
                    label: "Most Viewed",
                    size: bs.sm,
                    onPressed: () {
                      back();
                    },
                  ),
                  QButton(
                    label: "Most Shared",
                    size: bs.sm,
                    onPressed: () {
                      back();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
