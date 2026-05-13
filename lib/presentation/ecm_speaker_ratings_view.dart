import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmSpeakerRatingsView extends StatefulWidget {
  const EcmSpeakerRatingsView({super.key});

  @override
  State<EcmSpeakerRatingsView> createState() => _EcmSpeakerRatingsViewState();
}

class _EcmSpeakerRatingsViewState extends State<EcmSpeakerRatingsView> {
  String searchQuery = "";
  String sortBy = "rating";
  String filterBy = "all";
  
  List<Map<String, dynamic>> speakers = [
    {
      "id": 1,
      "name": "Dr. Sarah Johnson",
      "title": "Chief Marketing Officer",
      "company": "TechCorp Inc.",
      "bio": "20+ years experience in digital marketing and AI technologies",
      "image": "https://picsum.photos/150/150?random=1&keyword=woman",
      "averageRating": 4.8,
      "totalRatings": 156,
      "sessions": [
        {
          "title": "AI Marketing Strategies",
          "rating": 4.7,
          "feedback": 89
        },
        {
          "title": "Future of Digital Marketing",
          "rating": 4.9,
          "feedback": 67
        }
      ],
      "ratings": {
        "knowledge": 4.9,
        "presentation": 4.7,
        "engagement": 4.8,
        "clarity": 4.6,
        "relevance": 4.9
      },
      "topFeedback": [
        "Excellent insights on AI implementation",
        "Very engaging presentation style",
        "Practical examples were valuable"
      ]
    },
    {
      "id": 2,
      "name": "John Smith",
      "title": "Digital Transformation Expert",
      "company": "Innovation Labs",
      "bio": "Leading digital transformation initiatives across Fortune 500 companies",
      "image": "https://picsum.photos/150/150?random=2&keyword=man",
      "averageRating": 4.5,
      "totalRatings": 203,
      "sessions": [
        {
          "title": "Digital Transformation in 2024",
          "rating": 4.5,
          "feedback": 127
        },
        {
          "title": "Change Management Strategies",
          "rating": 4.4,
          "feedback": 76
        }
      ],
      "ratings": {
        "knowledge": 4.7,
        "presentation": 4.3,
        "engagement": 4.4,
        "clarity": 4.6,
        "relevance": 4.5
      },
      "topFeedback": [
        "Deep knowledge of digital transformation",
        "Could improve audience interaction",
        "Great real-world examples"
      ]
    },
    {
      "id": 3,
      "name": "Lisa Chen",
      "title": "E-commerce Strategist",
      "company": "RetailMax Solutions",
      "bio": "Helping brands scale their online presence with innovative strategies",
      "image": "https://picsum.photos/150/150?random=3&keyword=businesswoman",
      "averageRating": 4.7,
      "totalRatings": 134,
      "sessions": [
        {
          "title": "Future of E-commerce",
          "rating": 4.6,
          "feedback": 98
        },
        {
          "title": "Customer Experience Optimization",
          "rating": 4.8,
          "feedback": 36
        }
      ],
      "ratings": {
        "knowledge": 4.8,
        "presentation": 4.6,
        "engagement": 4.7,
        "clarity": 4.8,
        "relevance": 4.6
      },
      "topFeedback": [
        "Outstanding e-commerce insights",
        "Clear and actionable advice",
        "Engaging storytelling approach"
      ]
    },
    {
      "id": 4,
      "name": "Mike Wilson",
      "title": "Social Media Analytics Expert",
      "company": "DataDriven Marketing",
      "bio": "Specialist in social media analytics and performance optimization",
      "image": "https://picsum.photos/150/150?random=4&keyword=professional",
      "averageRating": 4.2,
      "totalRatings": 87,
      "sessions": [
        {
          "title": "Social Media Analytics Deep Dive",
          "rating": 4.2,
          "feedback": 67
        },
        {
          "title": "ROI Measurement in Social Media",
          "rating": 4.1,
          "feedback": 20
        }
      ],
      "ratings": {
        "knowledge": 4.4,
        "presentation": 4.0,
        "engagement": 4.1,
        "clarity": 4.2,
        "relevance": 4.5
      },
      "topFeedback": [
        "Technical content was valuable",
        "Presentation could be more dynamic",
        "Good analytical frameworks"
      ]
    },
    {
      "id": 5,
      "name": "Emma Rodriguez",
      "title": "Brand Strategy Consultant",
      "company": "BrandGenius Agency",
      "bio": "Award-winning brand strategist with expertise in global campaigns",
      "image": "https://picsum.photos/150/150?random=5&keyword=consultant",
      "averageRating": 4.9,
      "totalRatings": 98,
      "sessions": [
        {
          "title": "Brand Building Workshop",
          "rating": 4.9,
          "feedback": 78
        },
        {
          "title": "Brand Storytelling Masterclass",
          "rating": 4.8,
          "feedback": 20
        }
      ],
      "ratings": {
        "knowledge": 4.9,
        "presentation": 4.8,
        "engagement": 5.0,
        "clarity": 4.9,
        "relevance": 4.8
      },
      "topFeedback": [
        "Absolutely brilliant workshop!",
        "Most engaging speaker of the event",
        "Practical brand building strategies"
      ]
    }
  ];
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Highest Rating", "value": "rating"},
    {"label": "Most Reviews", "value": "reviews"},
    {"label": "Name A-Z", "value": "name"},
    {"label": "Company", "value": "company"},
  ];
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Speakers", "value": "all"},
    {"label": "4.5+ Rating", "value": "high"},
    {"label": "4.0-4.4 Rating", "value": "medium"},
    {"label": "Below 4.0", "value": "low"},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredSpeakers = _getFilteredSpeakers();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Speaker Ratings"),
        actions: [
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () {
              // Navigate to speaker analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search speakers...",
                    value: searchQuery,
                    hint: "Search by name, company, or expertise",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Filter by rating",
                    items: filterOptions,
                    value: filterBy,
                    onChanged: (value, label) {
                      filterBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            // Statistics summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${speakers.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Speakers",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 40, color: disabledOutlineBorderColor),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${(speakers.map((s) => s["averageRating"] as double).reduce((a, b) => a + b) / speakers.length).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Avg Rating",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 40, color: disabledOutlineBorderColor),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${speakers.map((s) => s["totalRatings"] as int).reduce((a, b) => a + b)}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Total Reviews",
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
            ),
            
            // Speakers list
            Text(
              "Speaker Rankings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ...filteredSpeakers.asMap().entries.map((entry) {
              final index = entry.key;
              final speaker = entry.value;
              
              return Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: _getRankColor(index + 1),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${speaker["image"]}",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${speaker["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${speaker["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${speaker["company"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star, size: 16, color: warningColor),
                                SizedBox(width: 4),
                                Text(
                                  "${(speaker["averageRating"] as double).toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${speaker["totalRatings"]} reviews",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    // Rating breakdown
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Text(
                            "Rating Breakdown",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _buildRatingBar("Knowledge", (speaker["ratings"] as Map)["knowledge"] as double),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: _buildRatingBar("Presentation", (speaker["ratings"] as Map)["presentation"] as double),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _buildRatingBar("Engagement", (speaker["ratings"] as Map)["engagement"] as double),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: _buildRatingBar("Clarity", (speaker["ratings"] as Map)["clarity"] as double),
                              ),
                            ],
                          ),
                          _buildRatingBar("Relevance", (speaker["ratings"] as Map)["relevance"] as double),
                        ],
                      ),
                    ),
                    
                    // Sessions
                    Text(
                      "Sessions (${(speaker["sessions"] as List).length})",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    
                    ...(speaker["sessions"] as List).map((session) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spXs),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${session["title"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star, size: 12, color: warningColor),
                                SizedBox(width: 2),
                                Text(
                                  "${(session["rating"] as double).toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  " (${session["feedback"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    
                    // Top feedback
                    if ((speaker["topFeedback"] as List).isNotEmpty) ...[
                      Text(
                        "Top Feedback",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      
                      ...(speaker["topFeedback"] as List).take(2).map((feedback) {
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spXs),
                          margin: EdgeInsets.only(bottom: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: successColor.withAlpha(50)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.format_quote, size: 12, color: successColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "$feedback",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                    
                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () => _viewSpeakerDetails(speaker),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "All Feedback",
                            size: bs.sm,
                            onPressed: () => _viewAllFeedback(speaker),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildRatingBar(String label, double rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
            Spacer(),
            Text(
              "${rating.toStringAsFixed(1)}",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 2),
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(50),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: rating / 5.0,
            child: Container(
              decoration: BoxDecoration(
                color: _getRatingColor(rating),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return warningColor; // Gold
      case 2:
        return disabledBoldColor; // Silver
      case 3:
        return Colors.brown; // Bronze
      default:
        return primaryColor;
    }
  }
  
  Color _getRatingColor(double rating) {
    if (rating >= 4.5) return successColor;
    if (rating >= 4.0) return warningColor;
    if (rating >= 3.0) return infoColor;
    return dangerColor;
  }
  
  List<Map<String, dynamic>> _getFilteredSpeakers() {
    var filtered = speakers.where((speaker) {
      // Search filter
      if (searchQuery.isNotEmpty) {
        final searchLower = searchQuery.toLowerCase();
        if (!("${speaker["name"]}".toLowerCase().contains(searchLower) ||
            "${speaker["company"]}".toLowerCase().contains(searchLower) ||
            "${speaker["title"]}".toLowerCase().contains(searchLower))) {
          return false;
        }
      }
      
      // Rating filter
      final rating = speaker["averageRating"] as double;
      switch (filterBy) {
        case "high":
          return rating >= 4.5;
        case "medium":
          return rating >= 4.0 && rating < 4.5;
        case "low":
          return rating < 4.0;
        default:
          return true;
      }
    }).toList();
    
    // Sort
    switch (sortBy) {
      case "rating":
        filtered.sort((a, b) => (b["averageRating"] as double).compareTo(a["averageRating"] as double));
        break;
      case "reviews":
        filtered.sort((a, b) => (b["totalRatings"] as int).compareTo(a["totalRatings"] as int));
        break;
      case "name":
        filtered.sort((a, b) => "${a["name"]}".compareTo("${b["name"]}"));
        break;
      case "company":
        filtered.sort((a, b) => "${a["company"]}".compareTo("${b["company"]}"));
        break;
    }
    
    return filtered;
  }
  
  void _viewSpeakerDetails(Map<String, dynamic> speaker) {
    // Navigate to speaker details
    si("Speaker details for ${speaker["name"]}");
  }
  
  void _viewAllFeedback(Map<String, dynamic> speaker) {
    // Navigate to all feedback for speaker
    si("All feedback for ${speaker["name"]}");
  }
}
