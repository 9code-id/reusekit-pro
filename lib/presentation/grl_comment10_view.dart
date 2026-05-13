import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlComment10View extends StatefulWidget {
  @override
  State<GrlComment10View> createState() => _GrlComment10ViewState();
}

class _GrlComment10ViewState extends State<GrlComment10View> {
  String comment = "";
  String selectedView = "Timeline";
  List<String> viewOptions = ["Timeline", "Activity", "Popular", "Recent"];
  bool isAnonymous = false;
  
  List<Map<String, dynamic>> activities = [
    {
      "id": "1",
      "type": "comment",
      "user": {
        "name": "Rachel Green",
        "avatar": "https://picsum.photos/40/40?random=61",
        "role": "Senior Designer",
        "level": "Expert",
        "points": 2850,
        "badges": ["Top Contributor", "Design Master"],
      },
      "action": "commented on",
      "target": "Mobile App Redesign Project",
      "content": "The new color palette perfectly captures our brand identity! The accessibility improvements are fantastic too. I especially love how the contrast ratios meet WCAG standards while maintaining visual appeal.\n\nSuggestions for next iteration:\n• Consider adding more white space in dense sections\n• The CTA buttons could be slightly larger on mobile\n• Maybe explore a darker theme option?\n\nOverall, this is exceptional work! 🎨",
      "likes": 67,
      "replies": 12,
      "shares": 8,
      "bookmarks": 23,
      "isLiked": true,
      "isBookmarked": false,
      "timestamp": "15m ago",
      "location": "Design Review",
      "visibility": "Team",
      "reactions": {
        "love": 15,
        "thumbsUp": 28,
        "celebrate": 12,
        "insightful": 8,
        "helpful": 4
      },
      "attachments": [
        {
          "type": "image",
          "url": "https://picsum.photos/300/200?random=21",
          "caption": "Updated color scheme preview"
        }
      ],
      "mentions": ["@design_team", "@john_developer"],
    },
    {
      "id": "2",
      "type": "milestone",
      "user": {
        "name": "Project System",
        "avatar": "https://picsum.photos/40/40?random=110",
        "role": "System",
        "level": "System",
        "points": 0,
        "badges": [],
      },
      "action": "achieved milestone",
      "target": "Q4 Development Goals",
      "content": "🎉 Congratulations! The development team has successfully completed 95% of Q4 objectives ahead of schedule.\n\nCompleted milestones:\n✅ Mobile app beta release\n✅ API performance optimization (40% improvement)\n✅ User authentication overhaul\n✅ Database migration\n✅ Security audit completion\n\nRemaining:\n🔄 Final testing phase\n🔄 Documentation updates\n\nNext milestone: Production deployment scheduled for next week!",
      "likes": 156,
      "replies": 28,
      "shares": 45,
      "bookmarks": 67,
      "isLiked": true,
      "isBookmarked": true,
      "timestamp": "2h ago",
      "location": "Project Dashboard",
      "visibility": "Company",
      "reactions": {
        "celebrate": 45,
        "thumbsUp": 67,
        "love": 23,
        "fire": 15,
        "clap": 6
      },
      "attachments": [],
      "mentions": ["@dev_team", "@qa_team", "@management"],
    },
    {
      "id": "3",
      "type": "announcement",
      "user": {
        "name": "Sarah Mitchell",
        "avatar": "https://picsum.photos/40/40?random=62",
        "role": "Product Manager",
        "level": "Senior",
        "points": 3240,
        "badges": ["Product Visionary", "Team Leader"],
      },
      "action": "announced",
      "target": "New Feature Release: Advanced Analytics",
      "content": "🚀 Exciting news! We're launching Advanced Analytics next Monday!\n\nWhat's new:\n📊 Real-time dashboard with customizable widgets\n📈 Predictive analytics powered by machine learning\n📋 Automated report generation\n🔍 Deep-dive analysis tools\n📱 Mobile-first responsive design\n\nBeta testers have reported:\n• 60% faster insights discovery\n• 40% improvement in decision-making speed\n• 90% user satisfaction rate\n\nReady to revolutionize how we understand our data? Early access starts tomorrow for Pro users!",
      "likes": 234,
      "replies": 45,
      "shares": 78,
      "bookmarks": 123,
      "isLiked": false,
      "isBookmarked": true,
      "timestamp": "4h ago",
      "location": "Product Updates",
      "visibility": "Public",
      "reactions": {
        "celebrate": 67,
        "love": 45,
        "fire": 34,
        "thumbsUp": 88,
        "wow": 0
      },
      "attachments": [
        {
          "type": "video",
          "url": "https://picsum.photos/400/250?random=22",
          "caption": "Advanced Analytics Demo Video"
        },
        {
          "type": "document",
          "url": "feature_guide.pdf",
          "caption": "Feature Guide PDF"
        }
      ],
      "mentions": ["@all_users"],
    },
    {
      "id": "4",
      "type": "collaboration",
      "user": {
        "name": "Marcus Johnson",
        "avatar": "https://picsum.photos/40/40?random=63",
        "role": "Lead Developer",
        "level": "Expert",
        "points": 4120,
        "badges": ["Code Master", "Mentor", "Innovation Leader"],
      },
      "action": "shared knowledge in",
      "target": "Weekly Tech Talk: Microservices Best Practices",
      "content": "Just wrapped up an amazing tech talk on microservices architecture! 🛠️\n\nKey takeaways discussed:\n🏗️ Service decomposition strategies\n🔄 Event-driven communication patterns\n🛡️ Security in distributed systems\n📊 Monitoring and observability\n🚀 Deployment and scaling techniques\n\nDemo repository with examples:\n• Docker containerization setup\n• Kubernetes orchestration configs\n• API gateway implementation\n• Service mesh integration\n• Monitoring stack configuration\n\nThanks to everyone who attended! The Q&A session was incredibly insightful. Looking forward to seeing these patterns implemented in our upcoming projects.\n\nSlides and code samples are now available in our knowledge base! 📚",
      "likes": 189,
      "replies": 67,
      "shares": 34,
      "bookmarks": 156,
      "isLiked": true,
      "isBookmarked": false,
      "timestamp": "1d ago",
      "location": "Engineering",
      "visibility": "Team",
      "reactions": {
        "insightful": 45,
        "helpful": 67,
        "thumbsUp": 56,
        "celebrate": 12,
        "love": 9
      },
      "attachments": [
        {
          "type": "document",
          "url": "microservices_slides.pdf",
          "caption": "Presentation Slides"
        },
        {
          "type": "code",
          "url": "github.com/example/microservices-demo",
          "caption": "Demo Repository"
        }
      ],
      "mentions": ["@engineering_team", "@devops_team"],
    },
    {
      "id": "5",
      "type": "achievement",
      "user": {
        "name": "Emily Chen",
        "avatar": "https://picsum.photos/40/40?random=64",
        "role": "UX Researcher",
        "level": "Senior",
        "points": 2890,
        "badges": ["Research Expert", "User Advocate"],
      },
      "action": "completed research study",
      "target": "User Behavior Analysis Q4 2024",
      "content": "📊 Just completed our most comprehensive user research study yet!\n\nStudy highlights:\n👥 2,847 participants across 15 countries\n⏱️ 6-week observation period\n📱 Multi-platform usage analysis\n🎯 5 key user personas identified\n📈 87% data accuracy rate\n\nKey findings:\n🔍 Users spend 40% more time on mobile than expected\n💡 Feature discovery needs improvement (only 60% find advanced features)\n🎨 Visual hierarchy impacts task completion by 25%\n⚡ Load time tolerance: maximum 3 seconds\n🔄 Users prefer progressive disclosure over feature-heavy interfaces\n\nRecommendations:\n• Redesign onboarding to highlight key features\n• Implement smart feature suggestions\n• Optimize mobile experience for longer sessions\n• Simplify navigation architecture\n\nFull report available in research portal. This data will drive our 2025 product roadmap! 🚀",
      "likes": 145,
      "replies": 23,
      "shares": 19,
      "bookmarks": 89,
      "isLiked": false,
      "isBookmarked": true,
      "timestamp": "2d ago",
      "location": "Research",
      "visibility": "Company",
      "reactions": {
        "insightful": 56,
        "thumbsUp": 45,
        "celebrate": 23,
        "helpful": 12,
        "love": 9
      },
      "attachments": [
        {
          "type": "chart",
          "url": "https://picsum.photos/400/300?random=23",
          "caption": "User Behavior Insights Chart"
        }
      ],
      "mentions": ["@product_team", "@design_team", "@management"],
    }
  ];

  List<Map<String, dynamic>> get filteredActivities {
    switch (selectedView) {
      case "Activity":
        return activities.where((a) => a["type"] != "milestone").toList();
      case "Popular":
        return activities..sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
      case "Recent":
        return activities..sort((a, b) => _parseTimestamp(a["timestamp"]).compareTo(_parseTimestamp(b["timestamp"])));
      default:
        return activities;
    }
  }

  int _parseTimestamp(String timestamp) {
    if (timestamp.contains("m ago")) {
      return int.parse(timestamp.split("m")[0]);
    } else if (timestamp.contains("h ago")) {
      return int.parse(timestamp.split("h")[0]) * 60;
    } else if (timestamp.contains("d ago")) {
      return int.parse(timestamp.split("d")[0]) * 1440;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Feed"),
        actions: [
          QButton(
            icon: Icons.notifications,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Activity Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(15), primaryColor.withAlpha(5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.timeline,
                      color: primaryColor,
                      size: 28,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Team Activity Timeline",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Stay updated with team progress and achievements",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: successColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Live",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildActivityMetric("Total Activities", "${activities.length}", Icons.timeline, primaryColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildActivityMetric("Today", "12", Icons.today, successColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildActivityMetric("Engagement", "94%", Icons.favorite, dangerColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // View Selector
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Icon(
                  Icons.view_list,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QCategoryPicker(
                    items: viewOptions.map((view) => {
                      "label": view,
                      "value": view,
                    }).toList(),
                    value: selectedView,
                    onChanged: (index, label, value, item) {
                      selectedView = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: filteredActivities.map((activity) => _buildActivityCard(activity)).toList(),
              ),
            ),
          ),

          // Enhanced Comment Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowLg],
              border: Border(
                top: BorderSide(color: disabledColor, width: 1),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Share an update or announcement...",
                        value: comment,
                        hint: "What's happening with your work today?",
                        onChanged: (value) {
                          comment = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isAnonymous,
                          onChanged: (value) {
                            isAnonymous = value ?? false;
                            setState(() {});
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        Text(
                          "Post anonymously",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spMd),
                    QButton(
                      icon: Icons.attach_file,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.poll,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.location_on,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    Spacer(),
                    QButton(
                      label: "Share Update",
                      size: bs.sm,
                      onPressed: comment.isNotEmpty ? () {
                        _shareUpdate();
                      } : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowXs],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    final user = activity["user"];
    final reactions = activity["reactions"] as Map<String, dynamic>;
    final attachments = activity["attachments"] as List;
    final mentions = activity["mentions"] as List;
    
    return Container(
      margin: EdgeInsets.only(bottom: spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Activity Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: _getActivityTypeColor(activity["type"]).withAlpha(10),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: user["role"] != "System" ? DecorationImage(
                          image: NetworkImage("${user["avatar"]}"),
                          fit: BoxFit.cover,
                        ) : null,
                        color: user["role"] == "System" ? primaryColor : null,
                      ),
                      child: user["role"] == "System" ? Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 24,
                      ) : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: _getActivityTypeColor(activity["type"]),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          _getActivityTypeIcon(activity["type"]),
                          size: 8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${user["name"]}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          if (user["level"] != "System") ...[
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getLevelColor(user["level"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${user["level"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getLevelColor(user["level"]),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        "${user["role"]}${user["points"] > 0 ? ' • ${user["points"]} points' : ''}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if ((user["badges"] as List).isNotEmpty) ...[
                        SizedBox(height: 2),
                        Wrap(
                          spacing: spXs,
                          children: (user["badges"] as List).take(2).map((badge) => Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$badge",
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          )).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: disabledColor),
                      ),
                      child: Text(
                        "${activity["visibility"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${activity["timestamp"]}",
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

          // Activity Body
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Action Summary
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                    children: [
                      TextSpan(
                        text: "${activity["action"]} ",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      TextSpan(
                        text: "${activity["target"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _getActivityTypeColor(activity["type"]),
                        ),
                      ),
                      if (activity["location"] != "") ...[
                        TextSpan(text: " in "),
                        TextSpan(
                          text: "${activity["location"]}",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ],
                  ),
                ),

                SizedBox(height: spSm),

                // Content
                Text(
                  "${activity["content"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    height: 1.5,
                  ),
                ),

                // Mentions
                if (mentions.isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: mentions.map((mention) => Text(
                      "$mention",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    )).toList(),
                  ),
                ],

                // Attachments
                if (attachments.isNotEmpty) ...[
                  SizedBox(height: spMd),
                  ...attachments.map((attachment) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledColor),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _getAttachmentIcon(attachment["type"]),
                          size: 20,
                          color: primaryColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${attachment["caption"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              if (attachment["type"] == "image") ...[
                                SizedBox(height: spXs),
                                Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    image: DecorationImage(
                                      image: NetworkImage("${attachment["url"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Icon(
                          Icons.open_in_new,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                      ],
                    ),
                  )),
                ],

                SizedBox(height: spMd),

                // Reactions
                Container(
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  child: QHorizontalScroll(
                    children: reactions.entries.map((entry) => GestureDetector(
                      onTap: () {
                        // Handle reaction toggle
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: primaryColor.withAlpha(30)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _getReactionEmoji(entry.key),
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${entry.value}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Actions Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: disabledColor, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: activity["isLiked"] ? Icons.favorite : Icons.favorite_border,
                    label: "${activity["likes"]}",
                    color: activity["isLiked"] ? dangerColor : disabledBoldColor,
                    onTap: () {
                      activity["isLiked"] = !activity["isLiked"];
                      if (activity["isLiked"]) {
                        activity["likes"] = (activity["likes"] as int) + 1;
                      } else {
                        activity["likes"] = (activity["likes"] as int) - 1;
                      }
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.chat_bubble_outline,
                    label: "${activity["replies"]}",
                    color: disabledBoldColor,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.share,
                    label: "${activity["shares"]}",
                    color: disabledBoldColor,
                    onTap: () {},
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    activity["isBookmarked"] = !activity["isBookmarked"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    child: Icon(
                      activity["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                      size: 20,
                      color: activity["isBookmarked"] ? warningColor : disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: color,
            ),
            SizedBox(width: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getActivityTypeColor(String type) {
    switch (type) {
      case "comment": return primaryColor;
      case "milestone": return successColor;
      case "announcement": return warningColor;
      case "collaboration": return infoColor;
      case "achievement": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getActivityTypeIcon(String type) {
    switch (type) {
      case "comment": return Icons.comment;
      case "milestone": return Icons.flag;
      case "announcement": return Icons.campaign;
      case "collaboration": return Icons.people;
      case "achievement": return Icons.emoji_events;
      default: return Icons.timeline;
    }
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case "Expert": return dangerColor;
      case "Senior": return warningColor;
      case "Intermediate": return infoColor;
      default: return successColor;
    }
  }

  IconData _getAttachmentIcon(String type) {
    switch (type) {
      case "image": return Icons.image;
      case "video": return Icons.video_library;
      case "document": return Icons.description;
      case "code": return Icons.code;
      case "chart": return Icons.bar_chart;
      default: return Icons.attach_file;
    }
  }

  String _getReactionEmoji(String reaction) {
    switch (reaction) {
      case "love": return "❤️";
      case "thumbsUp": return "👍";
      case "celebrate": return "🎉";
      case "insightful": return "💡";
      case "helpful": return "🙏";
      case "fire": return "🔥";
      case "clap": return "👏";
      case "wow": return "😮";
      default: return "👍";
    }
  }

  void _shareUpdate() {
    if (comment.trim().isEmpty) return;
    
    final newActivity = {
      "id": "${activities.length + 1}",
      "type": "comment",
      "user": {
        "name": isAnonymous ? "Anonymous User" : "You",
        "avatar": "https://picsum.photos/40/40?random=100",
        "role": "Team Member",
        "level": "Intermediate",
        "points": 450,
        "badges": ["Active Contributor"],
      },
      "action": "shared update",
      "target": "Team Discussion",
      "content": comment,
      "likes": 0,
      "replies": 0,
      "shares": 0,
      "bookmarks": 0,
      "isLiked": false,
      "isBookmarked": false,
      "timestamp": "now",
      "location": "Activity Feed",
      "visibility": "Team",
      "reactions": {
        "love": 0,
        "thumbsUp": 0,
        "celebrate": 0,
        "insightful": 0,
        "helpful": 0
      },
      "attachments": [],
      "mentions": [],
    };
    
    activities.insert(0, newActivity);
    comment = "";
    isAnonymous = false;
    setState(() {});
    
    ss("Update shared successfully!");
  }
}
