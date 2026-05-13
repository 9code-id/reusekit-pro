import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmSessionFeedbackView extends StatefulWidget {
  const EcmSessionFeedbackView({super.key});

  @override
  State<EcmSessionFeedbackView> createState() => _EcmSessionFeedbackViewState();
}

class _EcmSessionFeedbackViewState extends State<EcmSessionFeedbackView> {
  int selectedSessionIndex = 0;
  
  List<Map<String, dynamic>> sessions = [
    {
      "id": 1,
      "title": "Digital Transformation in 2024",
      "speaker": "John Smith",
      "time": "09:00 - 10:30",
      "room": "Main Hall",
      "type": "Keynote",
      "averageRating": 4.5,
      "totalFeedbacks": 127,
      "status": "completed"
    },
    {
      "id": 2,
      "title": "AI Marketing Strategies",
      "speaker": "Sarah Johnson",
      "time": "11:00 - 12:00",
      "room": "Room A",
      "type": "Workshop",
      "averageRating": 4.2,
      "totalFeedbacks": 89,
      "status": "completed"
    },
    {
      "id": 3,
      "title": "Social Media Analytics",
      "speaker": "Mike Wilson",
      "time": "13:30 - 14:30",
      "room": "Room B",
      "type": "Presentation",
      "averageRating": 4.7,
      "totalFeedbacks": 156,
      "status": "completed"
    },
    {
      "id": 4,
      "title": "Future of E-commerce",
      "speaker": "Lisa Chen",
      "time": "15:00 - 16:00",
      "room": "Main Hall",
      "type": "Panel",
      "averageRating": 4.3,
      "totalFeedbacks": 203,
      "status": "live"
    },
    {
      "id": 5,
      "title": "Brand Building Workshop",
      "speaker": "David Brown",
      "time": "16:30 - 17:30",
      "room": "Room A",
      "type": "Workshop",
      "averageRating": 0.0,
      "totalFeedbacks": 0,
      "status": "upcoming"
    }
  ];
  
  List<Map<String, dynamic>> feedbacks = [
    {
      "id": 1,
      "sessionId": 1,
      "attendeeName": "Anonymous",
      "rating": 5,
      "contentRating": 5,
      "speakerRating": 4,
      "deliveryRating": 5,
      "comments": "Excellent session! Very informative and well-structured.",
      "wouldRecommend": true,
      "timestamp": "2024-12-15 10:45:00",
      "tags": ["informative", "well-structured", "engaging"]
    },
    {
      "id": 2,
      "sessionId": 1,
      "attendeeName": "Anonymous",
      "rating": 4,
      "contentRating": 4,
      "speakerRating": 5,
      "deliveryRating": 4,
      "comments": "Great insights on digital transformation. Speaker was very knowledgeable.",
      "wouldRecommend": true,
      "timestamp": "2024-12-15 10:50:00",
      "tags": ["insightful", "knowledgeable", "practical"]
    },
    {
      "id": 3,
      "sessionId": 1,
      "attendeeName": "Anonymous",
      "rating": 3,
      "contentRating": 3,
      "speakerRating": 4,
      "deliveryRating": 3,
      "comments": "Good content but could have been more interactive.",
      "wouldRecommend": false,
      "timestamp": "2024-12-15 11:00:00",
      "tags": ["good-content", "needs-interaction"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    final currentSession = sessions[selectedSessionIndex];
    final sessionFeedbacks = feedbacks.where((f) => (f["sessionId"] as int) == (currentSession["id"] as int)).toList();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Session Feedback"),
        actions: [
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () {
              // Navigate to analytics
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
            // Session selector
            Text(
              "Select Session",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QHorizontalScroll(
              children: List.generate(sessions.length, (index) {
                final session = sessions[index];
                final isSelected = index == selectedSessionIndex;
                
                return GestureDetector(
                  onTap: () {
                    selectedSessionIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    width: 280,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(10) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getSessionTypeColor("${session["type"]}"),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${session["type"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor("${session["status"]}"),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${session["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Text(
                          "${session["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        Text(
                          "${session["speaker"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 12, color: disabledBoldColor),
                            SizedBox(width: 4),
                            Text(
                              "${session["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        
                        if ((session["totalFeedbacks"] as int) > 0) ...[
                          Row(
                            children: [
                              Row(
                                children: List.generate(5, (starIndex) {
                                  return Icon(
                                    starIndex < (session["averageRating"] as double).floor() ? Icons.star : Icons.star_border,
                                    size: 12,
                                    color: warningColor,
                                  );
                                }),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(session["averageRating"] as double).toStringAsFixed(1)} (${session["totalFeedbacks"]})",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ),
            
            // Session details
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${currentSession["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${currentSession["status"]}"),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${currentSession["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${currentSession["speaker"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${currentSession["time"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(Icons.room, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${currentSession["room"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  if ((currentSession["totalFeedbacks"] as int) > 0) ...[
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              starIndex < (currentSession["averageRating"] as double).floor() ? Icons.star : Icons.star_border,
                              size: 16,
                              color: warningColor,
                            );
                          }),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(currentSession["averageRating"] as double).toStringAsFixed(1)} average rating",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${currentSession["totalFeedbacks"]} feedbacks",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            // Feedback list
            Row(
              children: [
                Text(
                  "Attendee Feedback",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Add Feedback",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: _showFeedbackForm,
                ),
              ],
            ),
            
            if (sessionFeedbacks.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.feedback_outlined,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    Text(
                      "No Feedback Yet",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Be the first to share your feedback about this session",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              ...sessionFeedbacks.map((feedback) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: List.generate(5, (starIndex) {
                              return Icon(
                                starIndex < (feedback["rating"] as int) ? Icons.star : Icons.star_border,
                                size: 16,
                                color: warningColor,
                              );
                            }),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${feedback["rating"]}/5",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${feedback["timestamp"]}".substring(0, 16),
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      
                      if ("${feedback["comments"]}".isNotEmpty) ...[
                        Text(
                          "${feedback["comments"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                      
                      Row(
                        children: [
                          Text(
                            "Content: ${feedback["contentRating"]}/5",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Speaker: ${feedback["speakerRating"]}/5",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Delivery: ${feedback["deliveryRating"]}/5",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          if (feedback["wouldRecommend"] as bool) ...[
                            Icon(
                              Icons.thumb_up,
                              size: 16,
                              color: successColor,
                            ),
                          ],
                        ],
                      ),
                      
                      if ((feedback["tags"] as List).isNotEmpty) ...[
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (feedback["tags"] as List).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "$tag",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: infoColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ],
          ],
        ),
      ),
    );
  }
  
  Color _getSessionTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'keynote':
        return primaryColor;
      case 'workshop':
        return successColor;
      case 'panel':
        return warningColor;
      case 'presentation':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
  
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'live':
        return dangerColor;
      case 'upcoming':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
  
  void _showFeedbackForm() {
    // Navigate to feedback form
    si("Feedback form will open here");
  }
}
