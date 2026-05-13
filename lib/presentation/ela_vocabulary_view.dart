import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaVocabularyView extends StatefulWidget {
  const ElaVocabularyView({super.key});

  @override
  State<ElaVocabularyView> createState() => _ElaVocabularyViewState();
}

class _ElaVocabularyViewState extends State<ElaVocabularyView> {
  String selectedCategory = "All";
  String selectedDifficulty = "All";
  String searchQuery = "";
  bool showFavorites = false;
  bool studyMode = false;
  int currentCardIndex = 0;
  bool showDefinition = false;

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Academic", "value": "Academic"},
    {"label": "Literature", "value": "Literature"},
    {"label": "Science", "value": "Science"},
    {"label": "History", "value": "History"},
    {"label": "Arts", "value": "Arts"},
    {"label": "Technology", "value": "Technology"},
  ];

  final List<Map<String, dynamic>> difficulties = [
    {"label": "All", "value": "All"},
    {"label": "Easy", "value": "Easy"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Hard", "value": "Hard"},
  ];

  final List<Map<String, dynamic>> vocabulary = [
    {
      "id": 1,
      "word": "Eloquent",
      "definition": "Fluent or persuasive in speaking or writing",
      "pronunciation": "/ˈeləkwənt/",
      "partOfSpeech": "Adjective",
      "difficulty": "Medium",
      "category": "Academic",
      "synonyms": ["articulate", "fluent", "persuasive"],
      "antonyms": ["inarticulate", "stammering"],
      "example": "The eloquent speaker captivated the entire audience with her passionate speech.",
      "etymology": "From Latin eloquens, meaning 'speaking out'",
      "isFavorite": true,
      "mastered": false,
      "studyCount": 5,
      "correctAnswers": 3,
    },
    {
      "id": 2,
      "word": "Ubiquitous",
      "definition": "Present, appearing, or found everywhere",
      "pronunciation": "/yo͞oˈbikwədəs/",
      "partOfSpeech": "Adjective",
      "difficulty": "Hard",
      "category": "Academic",
      "synonyms": ["omnipresent", "pervasive", "universal"],
      "antonyms": ["rare", "scarce", "limited"],
      "example": "Smartphones have become ubiquitous in modern society.",
      "etymology": "From Latin ubique, meaning 'everywhere'",
      "isFavorite": false,
      "mastered": true,
      "studyCount": 12,
      "correctAnswers": 10,
    },
    {
      "id": 3,
      "word": "Metaphor",
      "definition": "A figure of speech comparing two unlike things without using 'like' or 'as'",
      "pronunciation": "/ˈmedəˌfôr/",
      "partOfSpeech": "Noun",
      "difficulty": "Easy",
      "category": "Literature",
      "synonyms": ["analogy", "comparison", "symbol"],
      "antonyms": ["literal statement"],
      "example": "Her voice is music to my ears is a metaphor comparing voice to music.",
      "etymology": "From Greek metaphora, meaning 'transfer'",
      "isFavorite": true,
      "mastered": true,
      "studyCount": 8,
      "correctAnswers": 8,
    },
    {
      "id": 4,
      "word": "Catalyst",
      "definition": "A substance that increases the rate of a chemical reaction or an agent that causes change",
      "pronunciation": "/ˈkadlˌist/",
      "partOfSpeech": "Noun",
      "difficulty": "Medium",
      "category": "Science",
      "synonyms": ["accelerator", "trigger", "stimulant"],
      "antonyms": ["inhibitor", "suppressant"],
      "example": "The new policy served as a catalyst for educational reform.",
      "etymology": "From Greek katalysis, meaning 'dissolution'",
      "isFavorite": false,
      "mastered": false,
      "studyCount": 3,
      "correctAnswers": 1,
    },
    {
      "id": 5,
      "word": "Renaissance",
      "definition": "A period of renewed interest in art, literature, and learning; rebirth",
      "pronunciation": "/ˌrenəˈsäns/",
      "partOfSpeech": "Noun",
      "difficulty": "Medium",
      "category": "History",
      "synonyms": ["revival", "rebirth", "resurgence"],
      "antonyms": ["decline", "deterioration"],
      "example": "The Renaissance period brought significant advances in art and science.",
      "etymology": "From French renaissance, meaning 'rebirth'",
      "isFavorite": true,
      "mastered": false,
      "studyCount": 6,
      "correctAnswers": 4,
    },
    {
      "id": 6,
      "word": "Algorithm",
      "definition": "A set of rules or instructions for solving a problem",
      "pronunciation": "/ˈalɡəˌriT͟Həm/",
      "partOfSpeech": "Noun",
      "difficulty": "Hard",
      "category": "Technology",
      "synonyms": ["procedure", "formula", "method"],
      "antonyms": ["randomness", "chaos"],
      "example": "The search algorithm efficiently finds relevant results in milliseconds.",
      "etymology": "From the name of Persian mathematician Al-Khwarizmi",
      "isFavorite": false,
      "mastered": false,
      "studyCount": 2,
      "correctAnswers": 1,
    },
  ];

  List<Map<String, dynamic>> get filteredVocabulary {
    return vocabulary.where((word) {
      bool matchesCategory = selectedCategory == "All" || 
                           "${word["category"]}" == selectedCategory;
      bool matchesDifficulty = selectedDifficulty == "All" || 
                             "${word["difficulty"]}" == selectedDifficulty;
      bool matchesSearch = searchQuery.isEmpty ||
                          "${word["word"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${word["definition"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesFavorites = !showFavorites || (word["isFavorite"] as bool);
      
      return matchesCategory && matchesDifficulty && matchesSearch && matchesFavorites;
    }).toList();
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

  Widget _buildStudyCard() {
    if (filteredVocabulary.isEmpty) return Container();
    
    final word = filteredVocabulary[currentCardIndex % filteredVocabulary.length];
    
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: GestureDetector(
        onTap: () {
          showDefinition = !showDefinition;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.all(spLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!showDefinition) ...[
                // Front of card - Word
                Icon(
                  Icons.quiz,
                  size: 48,
                  color: primaryColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "${word["word"]}",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: spSm),
                Text(
                  "${word["pronunciation"]}",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor("${word["difficulty"]}"),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${word["partOfSpeech"]} • ${word["difficulty"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "Tap to reveal definition",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledColor,
                  ),
                ),
              ] else ...[
                // Back of card - Definition
                Icon(
                  Icons.lightbulb_outline,
                  size: 48,
                  color: successColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "${word["definition"]}",
                  style: TextStyle(
                    fontSize: 18,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: spMd),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${word["example"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Text(
                  "Tap to see word again",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVocabularyList() {
    return Column(
      spacing: spMd,
      children: [
        // Search and Filters
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
                      label: "Search vocabulary...",
                      value: searchQuery,
                      hint: "Enter word or definition",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: showFavorites ? Icons.favorite : Icons.favorite_border,
                    size: bs.sm,
                    onPressed: () {
                      showFavorites = !showFavorites;
                      setState(() {});
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Category",
                      items: categories,
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
                      label: "Difficulty",
                      items: difficulties,
                      value: selectedDifficulty,
                      onChanged: (value, label) {
                        selectedDifficulty = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Statistics
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
                      "${vocabulary.where((w) => w["mastered"] as bool).length}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Mastered",
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
                      "${vocabulary.where((w) => !(w["mastered"] as bool)).length}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Learning",
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
                      "${filteredVocabulary.length}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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

        // Vocabulary Cards
        ...filteredVocabulary.map((word) {
          double accuracyRate = (word["studyCount"] as int) > 0 
              ? ((word["correctAnswers"] as int) / (word["studyCount"] as int) * 100)
              : 0;

          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: (word["mastered"] as bool) 
                  ? Border.all(color: successColor.withAlpha(100), width: 2)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(spSm),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${word["word"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                if (word["mastered"] as bool)
                                  Icon(
                                    Icons.verified,
                                    color: successColor,
                                    size: 18,
                                  ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${word["pronunciation"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
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
                                    color: _getDifficultyColor("${word["difficulty"]}"),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${word["difficulty"]}",
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
                                    "${word["category"]}",
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
                          (word["isFavorite"] as bool) 
                              ? Icons.favorite 
                              : Icons.favorite_border,
                          color: (word["isFavorite"] as bool) 
                              ? dangerColor 
                              : disabledBoldColor,
                        ),
                        onPressed: () {
                          word["isFavorite"] = !(word["isFavorite"] as bool);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),

                // Definition
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "${word["partOfSpeech"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${word["definition"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      // Example
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${word["example"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: infoColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),

                      // Synonyms & Antonyms
                      if ((word["synonyms"] as List).isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Synonyms:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Wrap(
                              spacing: spXs,
                              children: (word["synonyms"] as List).map((synonym) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${synonym}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),

                      // Progress Stats
                      if ((word["studyCount"] as int) > 0)
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Study Progress",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${word["studyCount"]} attempts • ${accuracyRate.toInt()}% accuracy",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CircularProgressIndicator(
                                value: accuracyRate / 100,
                                backgroundColor: disabledColor,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  accuracyRate >= 80 ? successColor : 
                                  accuracyRate >= 60 ? warningColor : dangerColor,
                                ),
                                strokeWidth: 3,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                // Action Buttons
                Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Study",
                          icon: Icons.school,
                          size: bs.sm,
                          onPressed: () {
                            // Start studying this word
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Quiz",
                          icon: Icons.quiz,
                          size: bs.sm,
                          onPressed: () {
                            // Quiz on this word
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),

        if (filteredVocabulary.isEmpty)
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
                  "No vocabulary found",
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vocabulary Builder"),
        actions: [
          QButton(
            label: studyMode ? "List View" : "Study Mode",
            icon: studyMode ? Icons.list : Icons.school,
            size: bs.sm,
            onPressed: () {
              studyMode = !studyMode;
              showDefinition = false;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: studyMode ? Column(
          spacing: spMd,
          children: [
            // Study Mode Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Study Mode",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Card ${currentCardIndex + 1} of ${filteredVocabulary.length}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${(((currentCardIndex + 1) / filteredVocabulary.length) * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Study Card
            _buildStudyCard(),

            // Navigation Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Previous",
                    icon: Icons.arrow_back,
                    size: bs.sm,
                    onPressed: currentCardIndex > 0 ? () {
                      currentCardIndex--;
                      showDefinition = false;
                      setState(() {});
                    } : null,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Know It",
                    icon: Icons.check,
                    size: bs.sm,
                    onPressed: () {
                      // Mark as known and move to next
                      if (currentCardIndex < filteredVocabulary.length - 1) {
                        currentCardIndex++;
                        showDefinition = false;
                        setState(() {});
                      }
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Next",
                    icon: Icons.arrow_forward,
                    size: bs.sm,
                    onPressed: currentCardIndex < filteredVocabulary.length - 1 ? () {
                      currentCardIndex++;
                      showDefinition = false;
                      setState(() {});
                    } : null,
                  ),
                ),
              ],
            ),
          ],
        ) : _buildVocabularyList(),
      ),
    );
  }
}
