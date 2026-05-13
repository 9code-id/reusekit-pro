import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsContentIdeasView extends StatefulWidget {
  const DmsContentIdeasView({super.key});

  @override
  State<DmsContentIdeasView> createState() => _DmsContentIdeasViewState();
}

class _DmsContentIdeasViewState extends State<DmsContentIdeasView> {
  int currentTab = 0;
  String selectedCategory = "All Categories";
  String selectedPlatform = "All Platforms";
  String searchQuery = "";
  String ideaTitle = "";
  String ideaDescription = "";
  String ideaCategory = "Marketing";
  String targetPlatform = "Facebook";
  bool isLoading = false;

  // Mock data for content ideas
  List<Map<String, dynamic>> contentIdeas = [
    {
      "id": "CI001",
      "title": "Behind-the-Scenes Office Tour",
      "description": "Show your workspace, team members, and daily operations to build trust and transparency with your audience.",
      "category": "Brand Building",
      "platform": "Instagram",
      "difficulty": "Easy",
      "estimatedTime": "30 mins",
      "engagement": "High",
      "tags": ["BehindScenes", "Team", "Transparency", "Trust"],
      "image": "https://picsum.photos/400/300?random=1&keyword=office",
      "likes": 245,
      "saves": 67,
      "trending": true,
      "tips": [
        "Show authentic moments, not staged scenes",
        "Include team introductions",
        "Highlight company culture",
        "Use good lighting and stable shots"
      ],
      "contentFormat": ["Video", "Story", "Reel"],
      "bestTimes": ["10:00 AM", "2:00 PM", "5:00 PM"]
    },
    {
      "id": "CI002",
      "title": "Customer Success Story Spotlight",
      "description": "Feature a customer's journey and how your product/service helped them achieve their goals.",
      "category": "Social Proof",
      "platform": "LinkedIn",
      "difficulty": "Medium",
      "estimatedTime": "2 hours",
      "engagement": "Very High",
      "tags": ["CustomerSuccess", "Testimonial", "Results", "ROI"],
      "image": "https://picsum.photos/400/300?random=2&keyword=success",
      "likes": 342,
      "saves": 89,
      "trending": true,
      "tips": [
        "Use real customer quotes and data",
        "Include before/after scenarios",
        "Add visual proof (screenshots, charts)",
        "Keep it authentic and honest"
      ],
      "contentFormat": ["Post", "Article", "Video"],
      "bestTimes": ["9:00 AM", "1:00 PM", "4:00 PM"]
    },
    {
      "id": "CI003",
      "title": "Quick Tips Tuesday Series",
      "description": "Weekly series sharing bite-sized tips and tricks related to your industry or niche.",
      "category": "Educational",
      "platform": "Twitter",
      "difficulty": "Easy",
      "estimatedTime": "15 mins",
      "engagement": "Medium",
      "tags": ["Tips", "Education", "Weekly", "Series"],
      "image": "https://picsum.photos/400/300?random=3&keyword=tips",
      "likes": 156,
      "saves": 34,
      "trending": false,
      "tips": [
        "Keep tips actionable and specific",
        "Use consistent visual branding",
        "Create a recognizable hashtag",
        "Engage with responses and questions"
      ],
      "contentFormat": ["Post", "Carousel", "Thread"],
      "bestTimes": ["8:00 AM", "12:00 PM", "6:00 PM"]
    },
    {
      "id": "CI004",
      "title": "Industry Trend Analysis",
      "description": "Deep dive into current industry trends, what they mean, and how they impact your audience.",
      "category": "Thought Leadership",
      "platform": "LinkedIn",
      "difficulty": "Hard",
      "estimatedTime": "4 hours",
      "engagement": "High",
      "tags": ["Trends", "Analysis", "Industry", "Insights"],
      "image": "https://picsum.photos/400/300?random=4&keyword=analysis",
      "likes": 198,
      "saves": 145,
      "trending": true,
      "tips": [
        "Back up claims with data and research",
        "Provide unique perspective or insights",
        "Include actionable takeaways",
        "Use visuals to support your points"
      ],
      "contentFormat": ["Article", "Video", "Infographic"],
      "bestTimes": ["10:00 AM", "2:00 PM", "4:00 PM"]
    },
    {
      "id": "CI005",
      "title": "User-Generated Content Campaign",
      "description": "Encourage customers to share their experiences using a branded hashtag and feature the best submissions.",
      "category": "Community",
      "platform": "Instagram",
      "difficulty": "Medium",
      "estimatedTime": "1 hour setup",
      "engagement": "Very High",
      "tags": ["UGC", "Community", "Hashtag", "Campaign"],
      "image": "https://picsum.photos/400/300?random=5&keyword=community",
      "likes": 287,
      "saves": 76,
      "trending": true,
      "tips": [
        "Create a memorable, brandable hashtag",
        "Offer incentives for participation",
        "Always credit original creators",
        "Repost the best content regularly"
      ],
      "contentFormat": ["Story", "Post", "Reel"],
      "bestTimes": ["11:00 AM", "3:00 PM", "7:00 PM"]
    },
    {
      "id": "CI006",
      "title": "Q&A Session with Experts",
      "description": "Host live Q&A sessions with industry experts or team members to provide value and build authority.",
      "category": "Live Content",
      "platform": "Facebook",
      "difficulty": "Medium",
      "estimatedTime": "1-2 hours",
      "engagement": "High",
      "tags": ["QA", "Live", "Expert", "Authority"],
      "image": "https://picsum.photos/400/300?random=6&keyword=expert",
      "likes": 134,
      "saves": 45,
      "trending": false,
      "tips": [
        "Promote the session well in advance",
        "Prepare common questions beforehand",
        "Encourage audience participation",
        "Save and repurpose key insights"
      ],
      "contentFormat": ["Live Video", "Story", "Post"],
      "bestTimes": ["12:00 PM", "5:00 PM", "7:00 PM"]
    }
  ];

  List<Map<String, dynamic>> trendingTopics = [
    {
      "topic": "AI and Automation",
      "growth": "+185%",
      "engagement": "Very High",
      "platforms": ["LinkedIn", "Twitter", "YouTube"],
      "keywords": ["AI", "Automation", "Machine Learning", "Future of Work"],
      "color": primaryColor
    },
    {
      "topic": "Sustainability",
      "growth": "+127%",
      "engagement": "High",
      "platforms": ["Instagram", "Facebook", "LinkedIn"],
      "keywords": ["Sustainability", "Eco-friendly", "Green Business", "Climate"],
      "color": successColor
    },
    {
      "topic": "Remote Work",
      "growth": "+95%",
      "engagement": "Medium",
      "platforms": ["LinkedIn", "Twitter"],
      "keywords": ["Remote Work", "Work from Home", "Digital Nomad", "Productivity"],
      "color": infoColor
    },
    {
      "topic": "Personal Branding",
      "growth": "+78%",
      "engagement": "High",
      "platforms": ["Instagram", "TikTok", "LinkedIn"],
      "keywords": ["Personal Brand", "Influence", "Thought Leadership", "Authority"],
      "color": warningColor
    }
  ];

  List<Map<String, dynamic>> contentTemplates = [
    {
      "id": "CT001",
      "name": "How-To Guide",
      "description": "Step-by-step tutorial format",
      "structure": [
        "Hook: Start with the end result",
        "Problem: What challenge does this solve?",
        "Steps: Break down the process",
        "Tips: Add pro tips and warnings",
        "CTA: What should they do next?"
      ],
      "bestFor": ["Educational", "Tutorial", "Tips"],
      "platforms": ["All"]
    },
    {
      "id": "CT002",
      "name": "Before & After",
      "description": "Transformation showcase format",
      "structure": [
        "Before: Show the starting point",
        "Journey: Explain the process",
        "After: Reveal the results",
        "Lessons: Key takeaways",
        "CTA: How they can achieve similar results"
      ],
      "bestFor": ["Case Study", "Success Story", "Transformation"],
      "platforms": ["Instagram", "LinkedIn", "Facebook"]
    },
    {
      "id": "CT003",
      "name": "List Post",
      "description": "Numbered list format",
      "structure": [
        "Hook: Why this list matters",
        "Introduction: Set the context",
        "Items: Number each point clearly",
        "Explanation: Brief detail for each",
        "Summary: Wrap up the key message"
      ],
      "bestFor": ["Tips", "Resources", "Tools", "Trends"],
      "platforms": ["LinkedIn", "Twitter", "Facebook"]
    }
  ];

  List<String> categories = [
    "All Categories", "Marketing", "Brand Building", "Social Proof", 
    "Educational", "Thought Leadership", "Community", "Live Content",
    "Promotional", "Seasonal", "Behind the Scenes"
  ];

  List<String> platforms = [
    "All Platforms", "Facebook", "Instagram", "Twitter", 
    "LinkedIn", "YouTube", "TikTok", "Pinterest"
  ];

  Widget _buildIdeasView() {
    List<Map<String, dynamic>> filteredIdeas = contentIdeas.where((idea) {
      bool matchesCategory = selectedCategory == "All Categories" || idea["category"] == selectedCategory;
      bool matchesPlatform = selectedPlatform == "All Platforms" || idea["platform"] == selectedPlatform;
      bool matchesSearch = searchQuery.isEmpty || 
                          idea["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          idea["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesPlatform && matchesSearch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
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
                  label: "Search Ideas",
                  value: searchQuery,
                  hint: "Search by title, description, or tags...",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories.map((category) => {
                          "label": category,
                          "value": category,
                        }).toList(),
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
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
                  ],
                ),
              ],
            ),
          ),

          // Trending Topics
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
                      "🔥 Trending Topics",
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
                QHorizontalScroll(
                  children: trendingTopics.map((topic) {
                    return Container(
                      width: 200,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: topic["color"].withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: topic["color"].withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${topic["topic"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: topic["color"],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "${topic["growth"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Engagement: ${topic["engagement"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: (topic["keywords"] as List).take(3).map((keyword) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "$keyword",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Content Ideas List
          Column(
            children: filteredIdeas.map((idea) {
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
                    // Header with trending indicator
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              if (idea["trending"])
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.trending_up, size: 12, color: dangerColor),
                                      SizedBox(width: 2),
                                      Text(
                                        "Trending",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: dangerColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(idea["category"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "${idea["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getCategoryColor(idea["category"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.favorite, size: 16, color: disabledBoldColor),
                            SizedBox(width: 4),
                            Text(
                              "${idea["likes"]}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                            SizedBox(width: spSm),
                            Icon(Icons.bookmark, size: 16, color: disabledBoldColor),
                            SizedBox(width: 4),
                            Text(
                              "${idea["saves"]}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),

                    // Main content
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("${idea["image"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${idea["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${idea["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),

                    // Details
                    Row(
                      children: [
                        _buildDetailChip("Platform", idea["platform"], _getPlatformColor(idea["platform"])),
                        SizedBox(width: spSm),
                        _buildDetailChip("Difficulty", idea["difficulty"], _getDifficultyColor(idea["difficulty"])),
                        SizedBox(width: spSm),
                        _buildDetailChip("Time", idea["estimatedTime"], infoColor),
                      ],
                    ),
                    SizedBox(height: spMd),

                    // Tags
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (idea["tags"] as List).take(4).map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "#$tag",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: spMd),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            color: disabledBoldColor,
                            onPressed: () {
                              _showIdeaDetails(idea);
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Use This Idea",
                            size: bs.sm,
                            onPressed: () {
                              ss("Idea saved to your content calendar");
                            },
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

  Widget _buildSubmitIdeaView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb, color: primaryColor, size: 32),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Share Your Content Idea",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Help the community by sharing your creative content ideas",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Form
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
                  label: "Idea Title",
                  value: ideaTitle,
                  hint: "Enter a catchy title for your idea",
                  onChanged: (value) {
                    ideaTitle = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spMd),
                QMemoField(
                  label: "Idea Description",
                  value: ideaDescription,
                  hint: "Describe your content idea in detail...",
                  onChanged: (value) {
                    ideaDescription = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories.where((c) => c != "All Categories").map((category) => {
                          "label": category,
                          "value": category,
                        }).toList(),
                        value: ideaCategory,
                        onChanged: (value, label) {
                          ideaCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Best Platform",
                        items: platforms.where((p) => p != "All Platforms").map((platform) => {
                          "label": platform,
                          "value": platform,
                        }).toList(),
                        value: targetPlatform,
                        onChanged: (value, label) {
                          targetPlatform = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                QButton(
                  label: isLoading ? "Submitting..." : "Submit Idea",
                  size: bs.md,
                  onPressed: isLoading ? null : () async {
                    if (ideaTitle.isEmpty || ideaDescription.isEmpty) {
                      se("Please fill in all required fields");
                      return;
                    }

                    isLoading = true;
                    setState(() {});

                    // Simulate API call
                    await Future.delayed(Duration(seconds: 2));

                    isLoading = false;
                    setState(() {});
                    
                    ss("Your idea has been submitted for review!");
                    
                    // Reset form
                    ideaTitle = "";
                    ideaDescription = "";
                    ideaCategory = "Marketing";
                    targetPlatform = "Facebook";
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Benefits of sharing
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
                  "Why Share Your Ideas?",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildBenefitItem(
                  icon: Icons.people,
                  title: "Help the Community",
                  description: "Your creative ideas can inspire and help other marketers succeed.",
                ),
                _buildBenefitItem(
                  icon: Icons.star,
                  title: "Get Recognition",
                  description: "Popular ideas get featured and credited to their creators.",
                ),
                _buildBenefitItem(
                  icon: Icons.trending_up,
                  title: "Build Your Profile",
                  description: "Sharing valuable content helps establish your expertise.",
                ),
                _buildBenefitItem(
                  icon: Icons.feedback,
                  title: "Get Feedback",
                  description: "Receive comments and suggestions from fellow marketers.",
                ),
              ],
            ),
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
          // Header
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

          // Templates
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
                        QButton(
                          label: "Use Template",
                          size: bs.sm,
                          onPressed: () {
                            ss("Template applied to your content");
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),

                    // Structure
                    Text(
                      "Structure:",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Column(
                      children: (template["structure"] as List).asMap().entries.map((entry) {
                        int index = entry.key;
                        String step = entry.value;
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  step,
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: spMd),

                    // Best for and platforms
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Best for:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Wrap(
                                spacing: spXs,
                                children: (template["bestFor"] as List).map((type) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "$type",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Platforms:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                (template["platforms"] as List).join(", "),
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
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedIdeasView() {
    List<Map<String, dynamic>> savedIdeas = contentIdeas.where((idea) => idea["saves"] > 50).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Saved Ideas",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${savedIdeas.length} ideas",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          // Quick stats
          ResponsiveGridView(
            minItemWidth: 150,
            children: [
              _buildStatCard("Total Saved", "${savedIdeas.length}", Icons.bookmark, primaryColor),
              _buildStatCard("Most Popular", "Customer Stories", Icons.trending_up, successColor),
              _buildStatCard("Avg. Engagement", "High", Icons.favorite, dangerColor),
              _buildStatCard("Used This Month", "12", Icons.check_circle, infoColor),
            ],
          ),

          // Saved ideas list
          if (savedIdeas.isEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Icon(Icons.bookmark_border, size: 64, color: disabledBoldColor),
                  SizedBox(height: spMd),
                  Text(
                    "No Saved Ideas Yet",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Start saving content ideas you like to build your personal collection",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              children: savedIdeas.map((idea) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${idea["image"]}"),
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
                              "${idea["title"]}",
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
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(idea["category"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "${idea["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getCategoryColor(idea["category"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "• ${idea["engagement"]} engagement",
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
                      QButton(
                        label: "Use Now",
                        size: bs.sm,
                        onPressed: () {
                          ss("Idea added to content calendar");
                        },
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

  Widget _buildDetailChip(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "$label: $value",
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBenefitItem({required IconData icon, required String title, required String description}) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: primaryColor, size: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showIdeaDetails(Map<String, dynamic> idea) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${idea["title"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Image
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        image: DecorationImage(
                          image: NetworkImage("${idea["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Description
                    Text(
                      "${idea["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),

                    // Tips
                    Text(
                      "💡 Pro Tips:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      children: (idea["tips"] as List).map((tip) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("• ", style: TextStyle(color: primaryColor)),
                              Expanded(
                                child: Text(
                                  "$tip",
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    // Content formats
                    Text(
                      "📱 Content Formats:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      children: (idea["contentFormat"] as List).map((format) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "$format",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Best times
                    Text(
                      "⏰ Best Times to Post:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      children: (idea["bestTimes"] as List).map((time) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "$time",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Save Idea",
                            size: bs.md,
                            color: disabledBoldColor,
                            onPressed: () {
                              Navigator.pop(context);
                              ss("Idea saved to your collection");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Use in Calendar",
                            size: bs.md,
                            onPressed: () {
                              Navigator.pop(context);
                              ss("Idea added to content calendar");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Marketing":
        return primaryColor;
      case "Brand Building":
        return successColor;
      case "Social Proof":
        return infoColor;
      case "Educational":
        return warningColor;
      case "Thought Leadership":
        return secondaryColor;
      case "Community":
        return dangerColor;
      case "Live Content":
        return Color(0xFF9C27B0);
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
      case "Pinterest":
        return Color(0xFFBD081C);
      default:
        return primaryColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Medium":
        return warningColor;
      case "Hard":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Content Ideas",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Explore", icon: Icon(Icons.explore)),
        Tab(text: "Submit", icon: Icon(Icons.add_circle)),
        Tab(text: "Templates", icon: Icon(Icons.library_books)),
        Tab(text: "Saved", icon: Icon(Icons.bookmark)),
      ],
      tabChildren: [
        _buildIdeasView(),
        _buildSubmitIdeaView(),
        _buildTemplatesView(),
        _buildSavedIdeasView(),
      ],
    );
  }
}
