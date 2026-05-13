import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaFormulaReferenceView extends StatefulWidget {
  const ElaFormulaReferenceView({super.key});

  @override
  State<ElaFormulaReferenceView> createState() => _ElaFormulaReferenceViewState();
}

class _ElaFormulaReferenceViewState extends State<ElaFormulaReferenceView> {
  String selectedCategory = "All";
  String searchQuery = "";
  bool showFavorites = false;

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Grammar", "value": "Grammar"},
    {"label": "Writing", "value": "Writing"},
    {"label": "Literature", "value": "Literature"},
    {"label": "Poetry", "value": "Poetry"},
    {"label": "Analysis", "value": "Analysis"},
  ];

  final List<Map<String, dynamic>> formulas = [
    {
      "id": 1,
      "title": "Five Paragraph Essay Structure",
      "category": "Writing",
      "description": "Standard essay format with introduction, three body paragraphs, and conclusion",
      "formula": "Introduction → Body 1 → Body 2 → Body 3 → Conclusion",
      "example": "Topic: Climate Change\n1. Hook + Thesis\n2. Causes\n3. Effects\n4. Solutions\n5. Restatement + Call to action",
      "difficulty": "Beginner",
      "isFavorite": true,
      "tags": ["essay", "structure", "academic"],
      "usageCount": 245,
    },
    {
      "id": 2,
      "title": "PEEL Paragraph Method",
      "category": "Writing",
      "description": "Point, Evidence, Explain, Link - effective paragraph structure",
      "formula": "P (Point) → E (Evidence) → E (Explain) → L (Link)",
      "example": "Point: Social media affects mental health\nEvidence: Studies show 40% increase in anxiety\nExplain: Constant comparison creates pressure\nLink: This connects to broader digital wellness",
      "difficulty": "Intermediate",
      "isFavorite": false,
      "tags": ["paragraph", "analysis", "structure"],
      "usageCount": 189,
    },
    {
      "id": 3,
      "title": "Subject-Verb Agreement Rules",
      "category": "Grammar",
      "description": "Essential rules for matching subjects with verbs",
      "formula": "Singular Subject + Singular Verb | Plural Subject + Plural Verb",
      "example": "The cat runs (singular)\nThe cats run (plural)\nNeither the teacher nor the students were ready",
      "difficulty": "Beginner",
      "isFavorite": true,
      "tags": ["grammar", "verb", "agreement"],
      "usageCount": 312,
    },
    {
      "id": 4,
      "title": "Thesis Statement Formula",
      "category": "Writing",
      "description": "Creating strong thesis statements for academic essays",
      "formula": "Topic + Position + Three Supporting Points",
      "example": "Topic: Online learning\nPosition: More effective than traditional\nPoints: Flexibility, personalization, technology integration",
      "difficulty": "Intermediate",
      "isFavorite": false,
      "tags": ["thesis", "essay", "argument"],
      "usageCount": 156,
    },
    {
      "id": 5,
      "title": "Literary Analysis Framework",
      "category": "Literature",
      "description": "Systematic approach to analyzing literary works",
      "formula": "Context + Theme + Technique + Impact",
      "example": "Context: Historical setting\nTheme: Coming of age\nTechnique: Symbolism, metaphor\nImpact: Reader's emotional response",
      "difficulty": "Advanced",
      "isFavorite": true,
      "tags": ["literature", "analysis", "framework"],
      "usageCount": 98,
    },
    {
      "id": 6,
      "title": "Poem Analysis Structure",
      "category": "Poetry",
      "description": "Step-by-step poetry analysis method",
      "formula": "Form → Sound → Imagery → Meaning → Effect",
      "example": "Form: Sonnet, 14 lines\nSound: Rhyme scheme ABAB\nImagery: Nature metaphors\nMeaning: Love's permanence\nEffect: Emotional resonance",
      "difficulty": "Advanced",
      "isFavorite": false,
      "tags": ["poetry", "analysis", "structure"],
      "usageCount": 87,
    },
  ];

  List<Map<String, dynamic>> get filteredFormulas {
    return formulas.where((formula) {
      bool matchesCategory = selectedCategory == "All" || 
                           "${formula["category"]}" == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty ||
                          "${formula["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${formula["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesFavorites = !showFavorites || (formula["isFavorite"] as bool);
      
      return matchesCategory && matchesSearch && matchesFavorites;
    }).toList();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formula Reference"),
        actions: [
          IconButton(
            icon: Icon(
              showFavorites ? Icons.favorite : Icons.favorite_border,
              color: showFavorites ? dangerColor : disabledBoldColor,
            ),
            onPressed: () {
              showFavorites = !showFavorites;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              // Navigate to saved formulas
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search formulas...",
                          value: searchQuery,
                          hint: "Enter formula name or description",
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
                          // Perform search
                        },
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${formulas.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Formulas",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${formulas.where((f) => f["isFavorite"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Favorites",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredFormulas.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Results",
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

            // Formulas List
            ...filteredFormulas.map((formula) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${formula["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getDifficultyColor("${formula["difficulty"]}"),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${formula["difficulty"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: secondaryColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${formula["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              (formula["isFavorite"] as bool) 
                                  ? Icons.favorite 
                                  : Icons.favorite_border,
                              color: (formula["isFavorite"] as bool) 
                                  ? dangerColor 
                                  : disabledBoldColor,
                            ),
                            onPressed: () {
                              formula["isFavorite"] = !(formula["isFavorite"] as bool);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "${formula["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),

                          // Formula
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: primaryColor.withAlpha(50),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Formula:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${formula["formula"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Example
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: successColor.withAlpha(50),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Example:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${formula["example"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Tags and Stats
                          Row(
                            children: [
                              Expanded(
                                child: Wrap(
                                  spacing: spXs,
                                  children: (formula["tags"] as List).map((tag) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "#${tag}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: infoColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Row(
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${formula["usageCount"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Copy Formula",
                                  icon: Icons.copy,
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Formula copied to clipboard");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Practice",
                                  icon: Icons.quiz,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to practice
                                  },
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

            if (filteredFormulas.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No formulas found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
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
}
