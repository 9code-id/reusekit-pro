import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsContentCalendarView extends StatefulWidget {
  const DmsContentCalendarView({super.key});

  @override
  State<DmsContentCalendarView> createState() => _DmsContentCalendarViewState();
}

class _DmsContentCalendarViewState extends State<DmsContentCalendarView> {
  int currentTab = 0;
  String selectedDate = DateTime.now().toIso8601String();
  String selectedPlatform = "All Platforms";
  String selectedStatus = "All Status";
  String calendarView = "month";
  bool isCreatingContent = false;
  String contentType = "Post";
  String contentTitle = "";
  String contentDescription = "";
  String contentPlatform = "Facebook";
  String scheduledTime = "12:00";
  String contentStatus = "Scheduled";

  // Mock data for content calendar
  List<Map<String, dynamic>> scheduledContent = [
    {
      "id": "SC001",
      "title": "Black Friday Marketing Campaign",
      "type": "Post",
      "platform": "Facebook",
      "date": "2024-01-15",
      "time": "10:00 AM",
      "status": "Published",
      "engagement": {"likes": 245, "shares": 32, "comments": 18},
      "content": "Exclusive Black Friday deals are here! Get up to 70% off on selected items.",
      "image": "https://picsum.photos/400/300?random=1&keyword=marketing",
      "tags": ["BlackFriday", "Sale", "Marketing"]
    },
    {
      "id": "SC002",
      "title": "Product Launch Announcement",
      "type": "Video",
      "platform": "Instagram",
      "date": "2024-01-15",
      "time": "2:30 PM",
      "status": "Scheduled",
      "engagement": {"views": 0, "likes": 0, "comments": 0},
      "content": "Introducing our latest innovation - coming soon!",
      "image": "https://picsum.photos/400/300?random=2&keyword=product",
      "tags": ["ProductLaunch", "Innovation", "ComingSoon"]
    },
    {
      "id": "SC003",
      "title": "Customer Success Story",
      "type": "Story",
      "platform": "LinkedIn",
      "date": "2024-01-16",
      "time": "9:00 AM",
      "status": "Draft",
      "engagement": {"views": 0, "likes": 0, "comments": 0},
      "content": "How our client increased their revenue by 300% in 6 months.",
      "image": "https://picsum.photos/400/300?random=3&keyword=success",
      "tags": ["Success", "CustomerStory", "ROI"]
    },
    {
      "id": "SC004",
      "title": "Industry Insights Blog",
      "type": "Article",
      "platform": "Twitter",
      "date": "2024-01-16",
      "time": "4:00 PM",
      "status": "In Review",
      "engagement": {"retweets": 0, "likes": 0, "replies": 0},
      "content": "Top 10 trends shaping the future of digital marketing in 2024.",
      "image": "https://picsum.photos/400/300?random=4&keyword=trends",
      "tags": ["Trends", "2024", "DigitalMarketing"]
    },
    {
      "id": "SC005",
      "title": "Behind the Scenes",
      "type": "Reel",
      "platform": "Instagram",
      "date": "2024-01-17",
      "time": "11:30 AM",
      "status": "Scheduled",
      "engagement": {"views": 0, "likes": 0, "comments": 0},
      "content": "A day in the life of our creative team - see how magic happens!",
      "image": "https://picsum.photos/400/300?random=5&keyword=team",
      "tags": ["BehindScenes", "Team", "Creative"]
    }
  ];

  List<Map<String, dynamic>> contentTemplates = [
    {
      "id": "CT001",
      "name": "Product Announcement",
      "type": "Post",
      "description": "Template for announcing new products",
      "platforms": ["Facebook", "Instagram", "Twitter"],
      "template": "🎉 Exciting News! We're thrilled to announce our latest [PRODUCT NAME]! \n\n✨ Key Features:\n• [FEATURE 1]\n• [FEATURE 2]\n• [FEATURE 3]\n\n🛒 Available now: [LINK]\n\n#ProductLaunch #Innovation #NewProduct"
    },
    {
      "id": "CT002",
      "name": "Customer Testimonial",
      "type": "Story",
      "description": "Template for sharing customer success stories",
      "platforms": ["LinkedIn", "Facebook"],
      "template": "💬 Customer Spotlight: [CUSTOMER NAME]\n\n\"[TESTIMONIAL TEXT]\"\n\n🎯 Results:\n• [RESULT 1]\n• [RESULT 2]\n• [RESULT 3]\n\n#CustomerSuccess #Testimonial #Results"
    },
    {
      "id": "CT003",
      "name": "Educational Content",
      "type": "Carousel",
      "description": "Template for educational posts",
      "platforms": ["Instagram", "LinkedIn"],
      "template": "📚 Did you know?\n\n[EDUCATIONAL FACT/TIP]\n\n💡 Quick Tips:\n1. [TIP 1]\n2. [TIP 2]\n3. [TIP 3]\n\n💬 What's your experience with this? Share below!\n\n#Education #Tips #Learning"
    }
  ];

  List<Map<String, dynamic>> contentAnalytics = [
    {
      "metric": "Total Posts",
      "value": "127",
      "change": "+12%",
      "trend": "up",
      "period": "This Month"
    },
    {
      "metric": "Engagement Rate",
      "value": "4.8%",
      "change": "+0.7%",
      "trend": "up",
      "period": "This Month"
    },
    {
      "metric": "Reach",
      "value": "52.3K",
      "change": "+18%",
      "trend": "up",
      "period": "This Month"
    },
    {
      "metric": "Best Time to Post",
      "value": "2:00 PM",
      "change": "Tue, Thu",
      "trend": "neutral",
      "period": "Based on Analytics"
    }
  ];

  List<String> platforms = ["All Platforms", "Facebook", "Instagram", "Twitter", "LinkedIn", "YouTube", "TikTok"];
  List<String> statusOptions = ["All Status", "Published", "Scheduled", "Draft", "In Review"];
  List<String> contentTypes = ["Post", "Story", "Video", "Article", "Reel", "Carousel"];
  List<String> platformOptions = ["Facebook", "Instagram", "Twitter", "LinkedIn", "YouTube", "TikTok"];

  Widget _buildCalendarView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Calendar Controls
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Platform",
                  items: platforms.map((platform) => {
                    "label": platform,
                    "value": platform,
                  }).toList(),
                  value: selectedPlatform,
                  onChanged: (value, label) {
                    selectedPlatform = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions.map((status) => {
                    "label": status,
                    "value": status,
                  }).toList(),
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // View Toggle
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Month View",
                  size: bs.sm,
                  color: calendarView == "month" ? primaryColor : disabledBoldColor,
                  onPressed: () {
                    calendarView = "month";
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Week View",
                  size: bs.sm,
                  color: calendarView == "week" ? primaryColor : disabledBoldColor,
                  onPressed: () {
                    calendarView = "week";
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Day View",
                  size: bs.sm,
                  color: calendarView == "day" ? primaryColor : disabledBoldColor,
                  onPressed: () {
                    calendarView = "day";
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Calendar Grid
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                // Calendar Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "January 2024",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.chevron_left, color: primaryColor),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right, color: primaryColor),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spMd),

                // Calendar Content
                Column(
                  children: List.generate(5, (weekIndex) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        children: List.generate(7, (dayIndex) {
                          int dayNumber = (weekIndex * 7) + dayIndex + 1;
                          if (dayNumber > 31) return Expanded(child: Container());
                          
                          List<Map<String, dynamic>> dayContent = scheduledContent.where((content) {
                            return content["date"] == "2024-01-${dayNumber.toString().padLeft(2, '0')}";
                          }).toList();

                          return Expanded(
                            child: Container(
                              height: 80,
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: dayNumber == 15 ? primaryColor.withAlpha(20) : Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: dayNumber == 15 ? primaryColor : Colors.grey.shade200,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    child: Text(
                                      "$dayNumber",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: dayNumber == 15 ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: dayContent.take(2).map((content) {
                                        return Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: _getStatusColor(content["status"]).withAlpha(20),
                                            borderRadius: BorderRadius.circular(2),
                                          ),
                                          child: Text(
                                            "${content["title"]}",
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: _getStatusColor(content["status"]),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          // Upcoming Content
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upcoming Content",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Column(
                  children: scheduledContent.where((content) => content["status"] == "Scheduled").take(3).map((content) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${content["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${content["title"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "${content["date"]} at ${content["time"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getPlatformColor(content["platform"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        "${content["platform"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getPlatformColor(content["platform"]),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right, color: disabledBoldColor),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateContentView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Content Type Selection
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Content Type",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  minItemWidth: 120,
                  children: contentTypes.map((type) {
                    bool isSelected = contentType == type;
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : Colors.grey.shade200,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          contentType = type;
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            Icon(
                              _getContentTypeIcon(type),
                              color: isSelected ? primaryColor : disabledBoldColor,
                              size: 32,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              type,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isSelected ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Content Details Form
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                QTextField(
                  label: "Content Title",
                  value: contentTitle,
                  hint: "Enter a catchy title for your content",
                  onChanged: (value) {
                    contentTitle = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spMd),
                QMemoField(
                  label: "Content Description",
                  value: contentDescription,
                  hint: "Write your content description here...",
                  onChanged: (value) {
                    contentDescription = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Platform",
                        items: platformOptions.map((platform) => {
                          "label": platform,
                          "value": platform,
                        }).toList(),
                        value: contentPlatform,
                        onChanged: (value, label) {
                          contentPlatform = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: ["Draft", "Scheduled", "In Review"].map((status) => {
                          "label": status,
                          "value": status,
                        }).toList(),
                        value: contentStatus,
                        onChanged: (value, label) {
                          contentStatus = value;
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
                      child: QDatePicker(
                        label: "Scheduled Date",
                        value: DateTime.parse(selectedDate),
                        onChanged: (value) {
                          selectedDate = value.toIso8601String();
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTimePicker(
                        label: "Scheduled Time",
                        value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $scheduledTime:00")),
                        onChanged: (value) {
                          scheduledTime = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save as Draft",
                  size: bs.md,
                  color: disabledBoldColor,
                  onPressed: () {
                    ss("Content saved as draft");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Schedule Content",
                  size: bs.md,
                  onPressed: () {
                    ss("Content scheduled successfully");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Templates Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Content Templates",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "Create Template",
                size: bs.sm,
                icon: Icons.add,
                onPressed: () {
                  ss("Creating new template");
                },
              ),
            ],
          ),

          // Templates List
          Column(
            children: contentTemplates.map((template) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${template["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${template["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            QButton(
                              label: "Use Template",
                              size: bs.sm,
                              onPressed: () {
                                ss("Template applied");
                              },
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(Icons.more_vert, color: disabledBoldColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    // Template Content Preview
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${template["template"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontFamily: 'monospace',
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Supported Platforms
                    Row(
                      children: [
                        Text(
                          "Platforms: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        Expanded(
                          child: Wrap(
                            spacing: spXs,
                            children: (template["platforms"] as List).map((platform) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getPlatformColor(platform).withAlpha(20),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "$platform",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getPlatformColor(platform),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Analytics Cards
          ResponsiveGridView(
            minItemWidth: 200,
            children: contentAnalytics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${metric["metric"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          metric["trend"] == "up" ? Icons.trending_up : 
                          metric["trend"] == "down" ? Icons.trending_down : Icons.trending_flat,
                          color: metric["trend"] == "up" ? successColor : 
                                 metric["trend"] == "down" ? dangerColor : disabledBoldColor,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${metric["value"]}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: metric["trend"] == "up" ? successColor.withAlpha(20) : 
                                   metric["trend"] == "down" ? dangerColor.withAlpha(20) : 
                                   disabledBoldColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "${metric["change"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: metric["trend"] == "up" ? successColor : 
                                     metric["trend"] == "down" ? dangerColor : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${metric["period"]}",
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
          ),

          // Content Performance Chart
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Content Performance",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Period",
                      items: [
                        {"label": "Last 7 Days", "value": "7d"},
                        {"label": "Last 30 Days", "value": "30d"},
                        {"label": "Last 3 Months", "value": "3m"},
                      ],
                      value: "30d",
                      onChanged: (value, label) {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bar_chart, size: 48, color: disabledBoldColor),
                        SizedBox(height: spSm),
                        Text(
                          "Performance Chart",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Engagement trends over time",
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
          ),

          // Top Performing Content
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Performing Content",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Column(
                  children: scheduledContent.where((content) => content["status"] == "Published").map((content) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${content["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${content["title"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(Icons.thumb_up, size: 14, color: successColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "${content["engagement"]["likes"]}",
                                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(Icons.share, size: 14, color: infoColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "${content["engagement"]["shares"]}",
                                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(Icons.comment, size: 14, color: warningColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "${content["engagement"]["comments"]}",
                                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getPlatformColor(content["platform"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "${content["platform"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: _getPlatformColor(content["platform"]),
                                fontWeight: FontWeight.w600,
                              ),
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
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Published":
        return successColor;
      case "Scheduled":
        return infoColor;
      case "Draft":
        return warningColor;
      case "In Review":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPlatformColor(String platform) {
    switch (platform) {
      case "Facebook":
        return Color(0xFF1877F2);
      case "Instagram":
        return Color(0xFFE4405F);
      case "Twitter":
        return Color(0xFF1DA1F2);
      case "LinkedIn":
        return Color(0xFF0A66C2);
      case "YouTube":
        return Color(0xFFFF0000);
      case "TikTok":
        return Color(0xFF000000);
      default:
        return primaryColor;
    }
  }

  IconData _getContentTypeIcon(String type) {
    switch (type) {
      case "Post":
        return Icons.post_add;
      case "Story":
        return Icons.auto_stories;
      case "Video":
        return Icons.videocam;
      case "Article":
        return Icons.article;
      case "Reel":
        return Icons.movie;
      case "Carousel":
        return Icons.view_carousel;
      default:
        return Icons.content_copy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Content Calendar",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Calendar", icon: Icon(Icons.calendar_today)),
        Tab(text: "Create", icon: Icon(Icons.add_circle)),
        Tab(text: "Templates", icon: Icon(Icons.library_books)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildCalendarView(),
        _buildCreateContentView(),
        _buildTemplatesView(),
        _buildAnalyticsView(),
      ],
    );
  }
}
