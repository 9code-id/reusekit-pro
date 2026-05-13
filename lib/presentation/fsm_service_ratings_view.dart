import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmServiceRatingsView extends StatefulWidget {
  const FsmServiceRatingsView({super.key});

  @override
  State<FsmServiceRatingsView> createState() => _FsmServiceRatingsViewState();
}

class _FsmServiceRatingsViewState extends State<FsmServiceRatingsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedTimeframe = "this_month";
  String selectedTechnician = "all";
  String selectedService = "all";
  bool enableRatingPrompts = true;
  bool autoFollowUp = true;
  double followUpDelay = 2.0;
  double targetRating = 4.5;

  List<Map<String, dynamic>> ratingsData = [
    {
      "id": "R001",
      "customer": "Sarah Johnson",
      "technician": "Mike Chen",
      "service": "HVAC Repair",
      "overall_rating": 5,
      "punctuality": 5,
      "professionalism": 5,
      "quality": 5,
      "communication": 4,
      "value": 5,
      "date": "2024-01-15",
      "duration": "2h 30m",
      "location": "Downtown Office",
      "feedback": "Excellent service. Very professional and efficient.",
      "would_recommend": true,
      "response_time": "1h",
      "follow_up_sent": true
    },
    {
      "id": "R002",
      "customer": "Robert Davis", 
      "technician": "John Smith",
      "service": "Plumbing Installation",
      "overall_rating": 2,
      "punctuality": 2,
      "professionalism": 3,
      "quality": 2,
      "communication": 2,
      "value": 2,
      "date": "2024-01-14",
      "duration": "4h 15m",
      "location": "Residential Complex",
      "feedback": "Service was delayed and parts were missing.",
      "would_recommend": false,
      "response_time": "3h",
      "follow_up_sent": true
    },
    {
      "id": "R003",
      "customer": "Emily Wilson",
      "technician": "Alex Rodriguez",
      "service": "Electrical Maintenance",
      "overall_rating": 4,
      "punctuality": 3,
      "professionalism": 4,
      "quality": 4,
      "communication": 4,
      "value": 4,
      "date": "2024-01-13",
      "duration": "1h 45m",
      "location": "Commercial Building",
      "feedback": "Good work, but arrived late.",
      "would_recommend": true,
      "response_time": "2h",
      "follow_up_sent": false
    },
    {
      "id": "R004",
      "customer": "Michael Brown",
      "technician": "Lisa Wang",
      "service": "Generator Service",
      "overall_rating": 5,
      "punctuality": 5,
      "professionalism": 5,
      "quality": 5,
      "communication": 5,
      "value": 4,
      "date": "2024-01-12",
      "duration": "3h 20m",
      "location": "Industrial Site",
      "feedback": "Outstanding service. Very knowledgeable technician.",
      "would_recommend": true,
      "response_time": "30m",
      "follow_up_sent": true
    }
  ];

  List<Map<String, dynamic>> technicianRatings = [
    {
      "name": "Mike Chen",
      "overall_rating": 4.8,
      "total_reviews": 127,
      "punctuality": 4.9,
      "professionalism": 4.8,
      "quality": 4.7,
      "communication": 4.6,
      "value": 4.8,
      "recommendation_rate": 96.5,
      "response_rate": 89.2,
      "specialties": ["HVAC", "Refrigeration", "Ventilation"],
      "trend": "increasing",
      "monthly_average": 4.7
    },
    {
      "name": "John Smith",
      "overall_rating": 3.2,
      "total_reviews": 89,
      "punctuality": 3.1,
      "professionalism": 3.4,
      "quality": 3.0,
      "communication": 3.2,
      "value": 3.3,
      "recommendation_rate": 67.4,
      "response_rate": 78.1,
      "specialties": ["Plumbing", "Pipe Installation", "Repairs"],
      "trend": "stable",
      "monthly_average": 3.2
    },
    {
      "name": "Alex Rodriguez",
      "overall_rating": 4.3,
      "total_reviews": 156,
      "punctuality": 4.0,
      "professionalism": 4.4,
      "quality": 4.5,
      "communication": 4.2,
      "value": 4.3,
      "recommendation_rate": 87.2,
      "response_rate": 92.3,
      "specialties": ["Electrical", "Lighting", "Maintenance"],
      "trend": "increasing",
      "monthly_average": 4.1
    },
    {
      "name": "Lisa Wang",
      "overall_rating": 4.9,
      "total_reviews": 203,
      "punctuality": 4.8,
      "professionalism": 5.0,
      "quality": 4.9,
      "communication": 4.9,
      "value": 4.7,
      "recommendation_rate": 98.5,
      "response_rate": 95.6,
      "specialties": ["Generator", "Power Systems", "Emergency"],
      "trend": "increasing",
      "monthly_average": 4.8
    }
  ];

  List<Map<String, dynamic>> serviceRatings = [
    {
      "service": "HVAC Repair",
      "average_rating": 4.2,
      "total_jobs": 234,
      "satisfaction_rate": 89.3,
      "completion_time": "2h 45m",
      "price_satisfaction": 4.1,
      "repeat_customer_rate": 76.8,
      "trend": "stable"
    },
    {
      "service": "Plumbing Installation",
      "average_rating": 3.8,
      "total_jobs": 156,
      "satisfaction_rate": 78.2,
      "completion_time": "3h 30m",
      "price_satisfaction": 3.6,
      "repeat_customer_rate": 62.4,
      "trend": "decreasing"
    },
    {
      "service": "Electrical Maintenance",
      "average_rating": 4.4,
      "total_jobs": 189,
      "satisfaction_rate": 91.5,
      "completion_time": "2h 15m",
      "price_satisfaction": 4.3,
      "repeat_customer_rate": 83.6,
      "trend": "increasing"
    },
    {
      "service": "Generator Service",
      "average_rating": 4.7,
      "total_jobs": 98,
      "satisfaction_rate": 95.9,
      "completion_time": "3h 10m",
      "price_satisfaction": 4.5,
      "repeat_customer_rate": 89.2,
      "trend": "increasing"
    }
  ];

  List<Map<String, dynamic>> get filteredRatings {
    return ratingsData.where((rating) {
      bool matchesSearch = searchQuery.isEmpty ||
          rating["customer"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          rating["technician"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          rating["service"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesTechnician = selectedTechnician == "all" || rating["technician"] == selectedTechnician;
      bool matchesService = selectedService == "all" || rating["service"] == selectedService;
      
      return matchesSearch && matchesTechnician && matchesService;
    }).toList();
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4.0) return successColor;
    if (rating >= 3.0) return warningColor;
    return dangerColor;
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "increasing": return successColor;
      case "decreasing": return dangerColor;
      default: return warningColor;
    }
  }

  Widget _buildRatingsOverview() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search ratings...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          // Filter Row
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Timeframe",
                  items: [
                    {"label": "This Month", "value": "this_month"},
                    {"label": "Last 3 Months", "value": "last_3_months"},
                    {"label": "Last 6 Months", "value": "last_6_months"},
                    {"label": "This Year", "value": "this_year"},
                  ],
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Technician",
                  items: [
                    {"label": "All Technicians", "value": "all"},
                    {"label": "Mike Chen", "value": "Mike Chen"},
                    {"label": "John Smith", "value": "John Smith"},
                    {"label": "Alex Rodriguez", "value": "Alex Rodriguez"},
                    {"label": "Lisa Wang", "value": "Lisa Wang"},
                  ],
                  value: selectedTechnician,
                  onChanged: (value, label) {
                    selectedTechnician = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Average Rating", "4.2", "stars", "+0.3", successColor),
              _buildStatCard("Response Rate", "88.7", "%", "+2.1%", successColor),
              _buildStatCard("Recommendation", "84.6", "%", "-1.2%", warningColor),
              _buildStatCard("Total Reviews", "575", "", "+45", infoColor),
            ],
          ),

          // Recent Ratings
          Container(
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
                  "Recent Ratings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                ...filteredRatings.take(5).map((rating) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getRatingColor((rating["overall_rating"] as int).toDouble()).withAlpha(15),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: _getRatingColor((rating["overall_rating"] as int).toDouble()).withAlpha(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${rating["customer"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${rating["service"]} • ${rating["technician"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getRatingColor((rating["overall_rating"] as int).toDouble()).withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: _getRatingColor((rating["overall_rating"] as int).toDouble()),
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${rating["overall_rating"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: _getRatingColor((rating["overall_rating"] as int).toDouble()),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        
                        // Rating Breakdown
                        Row(
                          children: [
                            _buildMiniRating("P", rating["punctuality"] as int),
                            SizedBox(width: spXs),
                            _buildMiniRating("Pr", rating["professionalism"] as int),
                            SizedBox(width: spXs),
                            _buildMiniRating("Q", rating["quality"] as int),
                            SizedBox(width: spXs),
                            _buildMiniRating("C", rating["communication"] as int),
                            SizedBox(width: spXs),
                            _buildMiniRating("V", rating["value"] as int),
                            Spacer(),
                            if (rating["would_recommend"] as bool)
                              Icon(
                                Icons.thumb_up,
                                color: successColor,
                                size: 16,
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
        ],
      ),
    );
  }

  Widget _buildTechnicianAnalytics() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Header
          Text(
            "Technician Performance",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Technician Cards
          ...technicianRatings.map((tech) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getRatingColor(tech["overall_rating"] as double),
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Header
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryColor.withAlpha(25),
                        child: Text(
                          "${tech["name"]}".split(" ").map((n) => n[0]).join(""),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${tech["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${tech["total_reviews"]} reviews • ${tech["recommendation_rate"]}% recommend",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getRatingColor(tech["overall_rating"] as double).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${(tech["overall_rating"] as double).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _getRatingColor(tech["overall_rating"] as double),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),

                  // Rating Breakdown
                  Row(
                    children: [
                      Expanded(child: _buildRatingBar("Punctuality", tech["punctuality"] as double)),
                      SizedBox(width: spSm),
                      Expanded(child: _buildRatingBar("Quality", tech["quality"] as double)),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(child: _buildRatingBar("Professional", tech["professionalism"] as double)),
                      SizedBox(width: spSm),
                      Expanded(child: _buildRatingBar("Communication", tech["communication"] as double)),
                    ],
                  ),
                  SizedBox(height: spMd),

                  // Specialties
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (tech["specialties"] as List).map((specialty) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$specialty",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spMd),

                  // Trend Indicator
                  Row(
                    children: [
                      Icon(
                        tech["trend"] == "increasing" ? Icons.trending_up : 
                        tech["trend"] == "decreasing" ? Icons.trending_down : Icons.trending_flat,
                        color: _getTrendColor("${tech["trend"]}"),
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Monthly avg: ${tech["monthly_average"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${tech["response_rate"]}% response rate",
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
        ],
      ),
    );
  }

  Widget _buildServiceAnalytics() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Service Performance Cards
          ...serviceRatings.map((service) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getRatingColor(service["average_rating"] as double),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${service["service"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${service["total_jobs"]} jobs completed",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getRatingColor(service["average_rating"] as double).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: _getRatingColor(service["average_rating"] as double),
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${(service["average_rating"] as double).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _getRatingColor(service["average_rating"] as double),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),

                  // Metrics Grid
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildServiceMetric("Satisfaction", "${service["satisfaction_rate"]}%", successColor),
                      _buildServiceMetric("Avg Duration", "${service["completion_time"]}", infoColor),
                      _buildServiceMetric("Price Rating", "${service["price_satisfaction"]}", warningColor),
                      _buildServiceMetric("Repeat Rate", "${service["repeat_customer_rate"]}%", primaryColor),
                    ],
                  ),
                  SizedBox(height: spSm),

                  // Trend
                  Row(
                    children: [
                      Icon(
                        service["trend"] == "increasing" ? Icons.trending_up :
                        service["trend"] == "decreasing" ? Icons.trending_down : Icons.trending_flat,
                        color: _getTrendColor("${service["trend"]}"),
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Trend: ${service["trend"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: _getTrendColor("${service["trend"]}"),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),

          // Rating Settings
          Container(
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
                  "Rating System Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Enable Rating Prompts",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Switch(
                      value: enableRatingPrompts,
                      onChanged: (value) {
                        enableRatingPrompts = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                SizedBox(height: spSm),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Auto Follow-up",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Switch(
                      value: autoFollowUp,
                      onChanged: (value) {
                        autoFollowUp = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),

                Text(
                  "Follow-up Delay (days)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Slider(
                  value: followUpDelay,
                  min: 1,
                  max: 7,
                  divisions: 6,
                  label: "${followUpDelay.round()} days",
                  onChanged: (value) {
                    followUpDelay = value;
                    setState(() {});
                  },
                ),
                Text(
                  "Send follow-up after ${followUpDelay.round()} days",
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
    );
  }

  Widget _buildStatCard(String title, String value, String unit, String change, Color color) {
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
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              if (unit.isNotEmpty)
                Text(
                  " $unit",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniRating(String label, int rating) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: _getRatingColor(rating.toDouble()).withAlpha(25),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: _getRatingColor(rating.toDouble()),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBar(String label, double rating) {
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
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: rating / 5,
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation(_getRatingColor(rating)),
              ),
            ),
            SizedBox(width: spXs),
            Text(
              "${rating.toStringAsFixed(1)}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _getRatingColor(rating),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceMetric(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Service Ratings",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.star)),
        Tab(text: "Technicians", icon: Icon(Icons.person)),
        Tab(text: "Services", icon: Icon(Icons.build)),
      ],
      tabChildren: [
        _buildRatingsOverview(),
        _buildTechnicianAnalytics(),
        _buildServiceAnalytics(),
      ],
    );
  }
}
