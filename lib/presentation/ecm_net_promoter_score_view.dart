import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmNetPromoterScoreView extends StatefulWidget {
  const EcmNetPromoterScoreView({super.key});

  @override
  State<EcmNetPromoterScoreView> createState() => _EcmNetPromoterScoreViewState();
}

class _EcmNetPromoterScoreViewState extends State<EcmNetPromoterScoreView> {
  String selectedTimeframe = "event";
  String selectedSegment = "all";
  
  Map<String, dynamic> npsData = {
    "overall": {
      "score": 67,
      "totalResponses": 432,
      "promoters": 298,
      "passives": 89,
      "detractors": 45,
      "responseRate": 78.5
    },
    "trend": [
      {"period": "Day 1", "score": 62, "responses": 156},
      {"period": "Day 2", "score": 68, "responses": 184},
      {"period": "Day 3", "score": 71, "responses": 92},
    ],
    "segments": [
      {"name": "First-time Attendees", "score": 72, "responses": 189, "percentage": 43.8},
      {"name": "Returning Attendees", "score": 61, "responses": 156, "percentage": 36.1},
      {"name": "VIP Attendees", "score": 78, "responses": 87, "percentage": 20.1},
    ],
    "reasons": {
      "promoters": [
        {"reason": "Excellent speakers", "count": 89, "percentage": 29.9},
        {"reason": "Great content quality", "count": 76, "percentage": 25.5},
        {"reason": "Well organized", "count": 67, "percentage": 22.5},
        {"reason": "Valuable networking", "count": 45, "percentage": 15.1},
        {"reason": "Perfect venue", "count": 21, "percentage": 7.0},
      ],
      "detractors": [
        {"reason": "Poor audio/visual", "count": 18, "percentage": 40.0},
        {"reason": "Overcrowded sessions", "count": 12, "percentage": 26.7},
        {"reason": "Limited networking time", "count": 8, "percentage": 17.8},
        {"reason": "Food quality", "count": 4, "percentage": 8.9},
        {"reason": "Registration issues", "count": 3, "percentage": 6.7},
      ]
    }
  };
  
  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Entire Event", "value": "event"},
    {"label": "Daily Trend", "value": "daily"},
    {"label": "By Session", "value": "session"},
    {"label": "Real-time", "value": "realtime"},
  ];
  
  List<Map<String, dynamic>> segmentOptions = [
    {"label": "All Attendees", "value": "all"},
    {"label": "First-time", "value": "firsttime"},
    {"label": "Returning", "value": "returning"},
    {"label": "VIP", "value": "vip"},
  ];

  @override
  Widget build(BuildContext context) {
    final overall = npsData["overall"] as Map<String, dynamic>;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Net Promoter Score"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: _exportData,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframeOptions,
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
                    label: "Segment",
                    items: segmentOptions,
                    value: selectedSegment,
                    onChanged: (value, label) {
                      selectedSegment = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            // Overall NPS Score
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowLg],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Overall NPS Score",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  
                  Text(
                    "${overall["score"]}",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      _getNPSCategory(overall["score"] as int),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  
                  Text(
                    "Based on ${overall["totalResponses"]} responses",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  
                  Text(
                    "${(overall["responseRate"] as double).toStringAsFixed(1)}% response rate",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
            
            // NPS Breakdown
            Container(
              width: double.infinity,
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
                  Text(
                    "Score Breakdown",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  // Promoters
                  _buildScoreSegment(
                    "Promoters (9-10)",
                    overall["promoters"] as int,
                    overall["totalResponses"] as int,
                    successColor,
                    "Love the event and will recommend it",
                  ),
                  
                  // Passives
                  _buildScoreSegment(
                    "Passives (7-8)",
                    overall["passives"] as int,
                    overall["totalResponses"] as int,
                    warningColor,
                    "Satisfied but not enthusiastic",
                  ),
                  
                  // Detractors
                  _buildScoreSegment(
                    "Detractors (0-6)",
                    overall["detractors"] as int,
                    overall["totalResponses"] as int,
                    dangerColor,
                    "Dissatisfied and unlikely to recommend",
                  ),
                ],
              ),
            ),
            
            // NPS Trend
            if (selectedTimeframe == "daily") ...[
              Container(
                width: double.infinity,
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
                    Text(
                      "NPS Trend",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    ...(npsData["trend"] as List).map((trendItem) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spXs),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${trendItem["period"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getNPSColor(trendItem["score"] as int),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${trendItem["score"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${trendItem["responses"]} responses",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
            
            // Segment Analysis
            Container(
              width: double.infinity,
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
                  Text(
                    "Segment Analysis",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...(npsData["segments"] as List).map((segment) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${segment["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getNPSColor(segment["score"] as int),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${segment["score"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          Row(
                            children: [
                              Text(
                                "${segment["responses"]} responses",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${(segment["percentage"] as double).toStringAsFixed(1)}% of total",
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
            ),
            
            // Feedback Reasons
            Row(
              children: [
                Expanded(
                  child: _buildReasonsCard(
                    "Why Promoters Love It",
                    (npsData["reasons"] as Map)["promoters"] as List,
                    successColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildReasonsCard(
                    "Why Detractors Don't",
                    (npsData["reasons"] as Map)["detractors"] as List,
                    dangerColor,
                  ),
                ),
              ],
            ),
            
            // Action Items
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: infoColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Recommended Actions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  
                  _buildActionItem("Address audio/visual issues mentioned by detractors"),
                  _buildActionItem("Improve session capacity management"),
                  _buildActionItem("Extend networking time slots"),
                  _buildActionItem("Follow up with passive attendees"),
                  _buildActionItem("Leverage promoter testimonials for marketing"),
                ],
              ),
            ),
            
            // Export and Share
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.download,
                    size: bs.md,
                    onPressed: _exportData,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Share Insights",
                    icon: Icons.share,
                    size: bs.md,
                    onPressed: _shareInsights,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildScoreSegment(String title, int count, int total, Color color, String description) {
    final percentage = ((count / total) * 100);
    
    return Column(
      spacing: spXs,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            Text(
              "$count (${percentage.toStringAsFixed(1)}%)",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(50),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage / 100,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
          ),
        ),
        
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
  
  Widget _buildReasonsCard(String title, List reasons, Color color) {
    return Container(
      width: double.infinity,
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
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          
          ...reasons.take(3).map((reason) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${reason["reason"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "${reason["count"]} mentions (${(reason["percentage"] as double).toStringAsFixed(1)}%)",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
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
  
  Widget _buildActionItem(String action) {
    return Row(
      children: [
        Icon(Icons.check_circle_outline, size: 16, color: infoColor),
        SizedBox(width: spXs),
        Expanded(
          child: Text(
            action,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
  
  String _getNPSCategory(int score) {
    if (score >= 70) return "Excellent";
    if (score >= 50) return "Great";
    if (score >= 30) return "Good";
    if (score >= 0) return "Needs Improvement";
    return "Critical";
  }
  
  Color _getNPSColor(int score) {
    if (score >= 70) return successColor;
    if (score >= 50) return primaryColor;
    if (score >= 30) return warningColor;
    if (score >= 0) return Colors.orange;
    return dangerColor;
  }
  
  void _exportData() {
    ss("NPS report exported successfully");
  }
  
  void _shareInsights() {
    ss("NPS insights shared with team");
  }
}
