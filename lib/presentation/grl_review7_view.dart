import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReview7View extends StatefulWidget {
  @override
  State<GrlReview7View> createState() => _GrlReview7ViewState();
}

class _GrlReview7ViewState extends State<GrlReview7View> {
  String replyText = "";
  bool isPublicReply = true;
  
  Map<String, dynamic> reviewDetails = {
    "id": 1,
    "customer": "Sarah Johnson",
    "avatar": "https://picsum.photos/60/60?random=1&keyword=woman",
    "rating": 2,
    "title": "Disappointed with the service quality",
    "content": "I had high expectations based on the reviews, but the experience was quite disappointing. The food took over an hour to arrive, and when it did, it was cold. The staff seemed overwhelmed and not very attentive. The restaurant was also quite noisy, making it difficult to have a conversation. For the price we paid, I expected much better quality and service. I've been to many restaurants in this price range and this was below average. I hope they can improve because the location is great.",
    "date": DateTime.now().subtract(Duration(days: 2)),
    "verified": true,
    "helpful_votes": 12,
    "product": "Bella Vista Restaurant",
    "order_value": 89.50,
    "photos": [
      "https://picsum.photos/150/150?random=10&keyword=food",
      "https://picsum.photos/150/150?random=11&keyword=restaurant",
    ],
    "customer_tier": "gold",
    "visit_type": "dine_in",
    "party_size": 4,
  };
  
  List<Map<String, dynamic>> suggestedReplies = [
    {
      "type": "apology",
      "title": "Sincere Apology",
      "content": "We sincerely apologize for the disappointing experience you had at our restaurant. This is not the level of service we strive to provide our valued customers.",
    },
    {
      "type": "explanation",
      "title": "Acknowledge Issues",
      "content": "We understand your frustration with the delayed service and food temperature. We've identified issues with our kitchen workflow during peak hours and are actively working to resolve them.",
    },
    {
      "type": "resolution",
      "title": "Offering Resolution",
      "content": "We would love the opportunity to make this right. Please contact us directly so we can arrange a complimentary return visit and show you the experience we're known for.",
    },
  ];
  
  List<Map<String, dynamic>> replyHistory = [
    {
      "id": 1,
      "author": "Restaurant Manager",
      "content": "Thank you for taking the time to share your feedback. We take all reviews seriously and are committed to improving our service.",
      "date": DateTime.now().subtract(Duration(hours: 6)),
      "type": "business_reply",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reply to Review"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              _showReplyGuidelines();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Original Review
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getRatingColor(reviewDetails["rating"]),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Customer Info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("${reviewDetails["avatar"]}"),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${reviewDetails["customer"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                if (reviewDetails["verified"] as bool)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "VERIFIED",
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getTierColor(reviewDetails["customer_tier"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${reviewDetails["customer_tier"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: _getTierColor(reviewDetails["customer_tier"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (index) => Icon(
                                    index < (reviewDetails["rating"] as int) ? Icons.star : Icons.star_border,
                                    size: 16,
                                    color: index < (reviewDetails["rating"] as int) ? warningColor : disabledColor,
                                  )),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(reviewDetails["date"] as DateTime).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${((reviewDetails["order_value"] as double).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${reviewDetails["helpful_votes"]} helpful",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Review Content
                  Text(
                    "${reviewDetails["title"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${reviewDetails["content"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Visit Details
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Visit Details",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "Type: ${reviewDetails["visit_type"]}".replaceAll('_', ' ').toUpperCase(),
                              style: TextStyle(fontSize: 10, color: disabledBoldColor),
                            ),
                            SizedBox(width: spMd),
                            Text(
                              "Party Size: ${reviewDetails["party_size"]}",
                              style: TextStyle(fontSize: 10, color: disabledBoldColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Photos
                  if ((reviewDetails["photos"] as List).isNotEmpty) ...[
                    SizedBox(height: spMd),
                    QHorizontalScroll(
                      children: (reviewDetails["photos"] as List).map((photo) => Container(
                        margin: EdgeInsets.only(right: spSm),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "$photo",
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Reply History
            if (replyHistory.isNotEmpty) ...[
              Text(
                "Previous Replies",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              ...replyHistory.map((reply) => Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 3,
                      color: primaryColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.business,
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${reply["author"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${(reply["date"] as DateTime).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${reply["content"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )).toList(),
              SizedBox(height: spMd),
            ],
            
            // Suggested Replies
            Text(
              "Suggested Reply Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            
            ...suggestedReplies.map((suggestion) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _getSuggestionIcon(suggestion["type"]),
                              size: 16,
                              color: _getSuggestionColor(suggestion["type"]),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${suggestion["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _getSuggestionColor(suggestion["type"]),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                replyText = suggestion["content"];
                                setState(() {});
                              },
                              child: Text(
                                "Use Template",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${suggestion["content"]}",
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
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Reply Form
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Write Your Reply",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  QMemoField(
                    label: "Your Reply",
                    value: replyText,
                    hint: "Write a professional and helpful response to address the customer's concerns...",
                    onChanged: (value) {
                      replyText = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Public reply (visible to all)",
                              "value": true,
                              "checked": isPublicReply,
                            }
                          ],
                          value: [
                            if (isPublicReply)
                              {
                                "label": "Public reply (visible to all)",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            isPublicReply = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Send Reply",
                          size: bs.md,
                          onPressed: replyText.isNotEmpty
                              ? () {
                                  _sendReply();
                                }
                              : () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.save,
                        size: bs.md,
                        onPressed: () {
                          _saveDraft();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Reply Guidelines
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        size: 20,
                        color: infoColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Reply Best Practices",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Acknowledge the customer's concerns\n• Apologize for any shortcomings\n• Explain what went wrong (if appropriate)\n• Offer a solution or next steps\n• Keep it professional and empathetic\n• Thank them for their feedback",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRatingColor(int rating) {
    switch (rating) {
      case 1:
      case 2:
        return dangerColor;
      case 3:
        return warningColor;
      case 4:
      case 5:
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getTierColor(String tier) {
    switch (tier) {
      case 'platinum':
        return Color(0xFF9C27B0);
      case 'gold':
        return warningColor;
      case 'silver':
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  IconData _getSuggestionIcon(String type) {
    switch (type) {
      case 'apology':
        return Icons.favorite;
      case 'explanation':
        return Icons.info;
      case 'resolution':
        return Icons.handshake;
      default:
        return Icons.help;
    }
  }

  Color _getSuggestionColor(String type) {
    switch (type) {
      case 'apology':
        return dangerColor;
      case 'explanation':
        return infoColor;
      case 'resolution':
        return successColor;
      default:
        return primaryColor;
    }
  }

  void _sendReply() {
    ss("Reply sent successfully!");
    replyText = "";
    setState(() {});
  }

  void _saveDraft() {
    ss("Reply saved as draft");
  }

  void _showReplyGuidelines() {
    // Show reply guidelines modal
  }
}
