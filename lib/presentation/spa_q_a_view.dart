import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaQAView extends StatefulWidget {
  const SpaQAView({super.key});

  @override
  State<SpaQAView> createState() => _SpaQAViewState();
}

class _SpaQAViewState extends State<SpaQAView> {
  String selectedCategory = "all";
  String searchQuery = "";
  String newQuestion = "";
  bool showAnswerForm = false;
  int? selectedQuestionId;

  List<Map<String, dynamic>> qaData = [
    {
      "id": 1,
      "question": "What should I wear to my spa appointment?",
      "answer": "We provide robes and slippers for all treatments. For massage treatments, you'll undress to your comfort level and be properly draped with towels. For facials, we recommend avoiding makeup and removing jewelry. Comfortable clothing is best for arrival and departure.",
      "category": "general",
      "askedBy": "Sarah M.",
      "answeredBy": "Spa Manager",
      "date": "2024-01-15",
      "helpful": 45,
      "tags": ["dress-code", "preparation", "comfort"],
      "featured": true,
    },
    {
      "id": 2,
      "question": "How early should I arrive for my appointment?",
      "answer": "Please arrive 15-20 minutes before your scheduled treatment time. This allows you to check in, change into spa attire, and relax before your service begins. Late arrivals may result in shortened treatment time.",
      "category": "booking",
      "askedBy": "Mike D.",
      "answeredBy": "Front Desk",
      "date": "2024-01-14",
      "helpful": 38,
      "tags": ["timing", "arrival", "preparation"],
      "featured": true,
    },
    {
      "id": 3,
      "question": "Can I bring my phone into the treatment rooms?",
      "answer": "We encourage guests to disconnect and leave phones in provided lockers for the full relaxation experience. However, if you must keep it for emergencies, please ensure it's on silent mode. Photography is not permitted in treatment areas.",
      "category": "policies",
      "askedBy": "Jennifer L.",
      "answeredBy": "Spa Manager",
      "date": "2024-01-13",
      "helpful": 29,
      "tags": ["phones", "electronics", "relaxation"],
      "featured": false,
    },
    {
      "id": 4,
      "question": "What's the difference between Swedish and deep tissue massage?",
      "answer": "Swedish massage uses lighter pressure with long, flowing strokes for relaxation and stress relief. Deep tissue massage targets deeper muscle layers with firmer pressure to address chronic tension and knots. We'll discuss your preferences during consultation.",
      "category": "treatments",
      "askedBy": "David K.",
      "answeredBy": "Licensed Therapist",
      "date": "2024-01-12",
      "helpful": 67,
      "tags": ["massage", "pressure", "techniques"],
      "featured": true,
    },
    {
      "id": 5,
      "question": "Are there any age restrictions for spa services?",
      "answer": "Guests must be 18+ for most services. We offer teen facials (ages 13-17) with parental consent. Children under 13 are not permitted in treatment areas for safety and tranquility reasons. Valid ID required for verification.",
      "category": "policies",
      "askedBy": "Lisa R.",
      "answeredBy": "Spa Manager",
      "date": "2024-01-11",
      "helpful": 34,
      "tags": ["age-limit", "teens", "policy"],
      "featured": false,
    },
    {
      "id": 6,
      "question": "Can I get a facial if I have sensitive skin?",
      "answer": "Absolutely! Our licensed aestheticians are trained to work with all skin types including sensitive skin. We'll perform a consultation and patch test if needed. We use gentle, hypoallergenic products and can customize treatments to your skin's needs.",
      "category": "treatments",
      "askedBy": "Emma T.",
      "answeredBy": "Senior Aesthetician",
      "date": "2024-01-10",
      "helpful": 52,
      "tags": ["sensitive-skin", "facial", "customization"],
      "featured": true,
    },
    {
      "id": 7,
      "question": "What's your cancellation policy?",
      "answer": "We require 24-hour notice for cancellations or changes. Same-day cancellations or no-shows may incur a 50% charge. For packages or multiple services, 48-hour notice is required. We understand emergencies happen and will work with you when possible.",
      "category": "booking",
      "askedBy": "Robert H.",
      "answeredBy": "Front Desk Manager",
      "date": "2024-01-09",
      "helpful": 41,
      "tags": ["cancellation", "policy", "charges"],
      "featured": false,
    },
    {
      "id": 8,
      "question": "Do you offer couples massage in the same room?",
      "answer": "Yes! Our couples suite accommodates two massage tables and provides a romantic atmosphere with dim lighting and soft music. Both partners receive simultaneous massages from two therapists. Advanced booking recommended as this is very popular.",
      "category": "treatments",
      "askedBy": "Amanda & John",
      "answeredBy": "Spa Coordinator",
      "date": "2024-01-08",
      "helpful": 78,
      "tags": ["couples", "massage", "romantic"],
      "featured": true,
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Questions", "value": "all", "icon": Icons.help},
    {"label": "General Info", "value": "general", "icon": Icons.info},
    {"label": "Booking", "value": "booking", "icon": Icons.calendar_today},
    {"label": "Treatments", "value": "treatments", "icon": Icons.spa},
    {"label": "Policies", "value": "policies", "icon": Icons.policy},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questions & Answers"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              _showAskQuestionForm();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Q&A Header
          _buildQAHeader(),

          // Search and Filter
          _buildSearchAndFilter(),

          // Q&A List
          Expanded(
            child: _buildQAList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQAHeader() {
    final filteredQA = _getFilteredQA();
    final featuredCount = filteredQA.where((qa) => qa["featured"]).length;
    final totalHelpful = filteredQA.map((qa) => qa["helpful"] as int).reduce((a, b) => a + b);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.quiz, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Frequently Asked Questions",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Get instant answers to common spa questions",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Stats Row
          Row(
            children: [
              _buildStatCard("${filteredQA.length}", "Questions", Icons.quiz),
              SizedBox(width: spSm),
              _buildStatCard("$featuredCount", "Featured", Icons.star),
              SizedBox(width: spSm),
              _buildStatCard("${(totalHelpful / 1000).toStringAsFixed(1)}K", "Helpful Votes", Icons.thumb_up),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(51),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: Colors.white.withAlpha(100),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withAlpha(180),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.grey[50],
      child: Column(
        spacing: spSm,
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search questions...",
                  value: searchQuery,
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
                onPressed: () {
                  _performSearch();
                },
              ),
            ],
          ),

          // Category Filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categoryOptions.map((category) {
                bool isSelected = selectedCategory == category["value"];
                final count = selectedCategory == "all" 
                    ? qaData.length 
                    : qaData.where((qa) => qa["category"] == category["value"]).length;
                
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category["value"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          category["icon"] as IconData,
                          color: isSelected ? Colors.white : disabledBoldColor,
                          size: 18,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${category["label"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : disabledBoldColor,
                          ),
                        ),
                        if (isSelected) ...[
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$count",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQAList() {
    final filteredQA = _getFilteredQA();
    
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredQA.length,
      itemBuilder: (context, index) {
        final qa = filteredQA[index];
        return _buildQACard(qa);
      },
    );
  }

  Widget _buildQACard(Map<String, dynamic> qa) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: qa["featured"] ? Border.all(color: warningColor, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Question Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "Q",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (qa["featured"])
                                Container(
                                  margin: EdgeInsets.only(right: spSm),
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.star, color: Colors.white, size: 12),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Featured",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(qa["category"]).withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${qa["category"].toString().toUpperCase()}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getCategoryColor(qa["category"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${qa["question"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Asked by ${qa["askedBy"]} • ${DateTime.parse(qa["date"]).dMMMy}",
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

                // Answer Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: successColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "A",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${qa["answer"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Answered by ${qa["answeredBy"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Tags
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (qa["tags"] as List<String>).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "#$tag",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Actions
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.thumb_up, size: 14, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${qa["helpful"]} helpful",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    QButton(
                      icon: Icons.thumb_up_outlined,
                      size: bs.sm,
                      onPressed: () {
                        _markHelpful(qa["id"]);
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {
                        _shareQA(qa);
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
  }

  List<Map<String, dynamic>> _getFilteredQA() {
    List<Map<String, dynamic>> filtered = qaData;
    
    // Filter by category
    if (selectedCategory != "all") {
      filtered = filtered.where((qa) => qa["category"] == selectedCategory).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((qa) {
        final question = qa["question"].toString().toLowerCase();
        final answer = qa["answer"].toString().toLowerCase();
        final query = searchQuery.toLowerCase();
        return question.contains(query) || answer.contains(query);
      }).toList();
    }
    
    // Sort featured first
    filtered.sort((a, b) {
      if (a["featured"] && !b["featured"]) return -1;
      if (!a["featured"] && b["featured"]) return 1;
      return (b["helpful"] as int).compareTo(a["helpful"] as int);
    });
    
    return filtered;
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "general":
        return primaryColor;
      case "booking":
        return infoColor;
      case "treatments":
        return successColor;
      case "policies":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _performSearch() {
    ss("Searching for: $searchQuery");
  }

  void _showAskQuestionForm() {
    ss("Ask Question form opened");
    //navigateTo ( AskQuestionView )
  }

  void _markHelpful(int qaId) {
    setState(() {
      final index = qaData.indexWhere((qa) => qa["id"] == qaId);
      if (index != -1) {
        qaData[index]["helpful"] = (qaData[index]["helpful"] as int) + 1;
      }
    });
    ss("Marked as helpful");
  }

  void _shareQA(Map<String, dynamic> qa) {
    ss("Sharing: ${qa["question"]}");
  }
}
