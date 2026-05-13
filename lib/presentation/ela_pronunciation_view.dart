import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaPronunciationView extends StatefulWidget {
  const ElaPronunciationView({super.key});

  @override
  State<ElaPronunciationView> createState() => _ElaPronunciationViewState();
}

class _ElaPronunciationViewState extends State<ElaPronunciationView> {
  String selectedCategory = "All";
  String selectedLevel = "All";
  String searchQuery = "";
  bool isRecording = false;
  bool isPlaying = false;
  String selectedSound = "";

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Vowel Sounds", "value": "Vowel Sounds"},
    {"label": "Consonant Sounds", "value": "Consonant Sounds"},
    {"label": "Diphthongs", "value": "Diphthongs"},
    {"label": "Silent Letters", "value": "Silent Letters"},
    {"label": "Word Stress", "value": "Word Stress"},
    {"label": "Common Mistakes", "value": "Common Mistakes"},
  ];

  final List<Map<String, dynamic>> levels = [
    {"label": "All", "value": "All"},
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
  ];

  final List<Map<String, dynamic>> sounds = [
    {
      "id": 1,
      "sound": "/iː/",
      "symbol": "ee",
      "category": "Vowel Sounds",
      "level": "Beginner",
      "description": "Long 'e' sound as in 'see'",
      "examples": ["see", "tree", "key", "field", "receive"],
      "commonMistakes": [
        "Confusing with short /ɪ/ sound",
        "Not holding the sound long enough"
      ],
      "tips": [
        "Make the sound longer than you think",
        "Keep your tongue high and forward",
        "Smile slightly while pronouncing"
      ],
      "practiceWords": [
        {"word": "peace", "phonetic": "/piːs/", "difficulty": "Easy"},
        {"word": "believe", "phonetic": "/bɪˈliːv/", "difficulty": "Medium"},
        {"word": "achieve", "phonetic": "/əˈtʃiːv/", "difficulty": "Medium"},
      ],
      "accuracy": 78,
      "practiced": 12,
      "mastered": false,
    },
    {
      "id": 2,
      "sound": "/θ/",
      "symbol": "th",
      "category": "Consonant Sounds",
      "level": "Intermediate",
      "description": "Voiceless 'th' sound as in 'think'",
      "examples": ["think", "three", "bath", "nothing", "birthday"],
      "commonMistakes": [
        "Pronouncing as /s/ or /f/",
        "Not placing tongue between teeth"
      ],
      "tips": [
        "Put your tongue between your teeth",
        "Blow air gently over your tongue",
        "Practice with a mirror to see tongue position"
      ],
      "practiceWords": [
        {"word": "math", "phonetic": "/mæθ/", "difficulty": "Easy"},
        {"word": "author", "phonetic": "/ˈɔːθər/", "difficulty": "Medium"},
        {"word": "sympathy", "phonetic": "/ˈsɪmpəθi/", "difficulty": "Hard"},
      ],
      "accuracy": 65,
      "practiced": 8,
      "mastered": false,
    },
    {
      "id": 3,
      "sound": "/aɪ/",
      "symbol": "ai",
      "category": "Diphthongs",
      "level": "Intermediate",
      "description": "Diphthong sound as in 'time'",
      "examples": ["time", "fly", "night", "buy", "eye"],
      "commonMistakes": [
        "Making it too short",
        "Not gliding smoothly between sounds"
      ],
      "tips": [
        "Start with /a/ and glide to /ɪ/",
        "Make it a smooth transition",
        "Practice slowly first"
      ],
      "practiceWords": [
        {"word": "right", "phonetic": "/raɪt/", "difficulty": "Easy"},
        {"word": "society", "phonetic": "/səˈsaɪəti/", "difficulty": "Hard"},
        {"word": "bicycle", "phonetic": "/ˈbaɪsɪkəl/", "difficulty": "Medium"},
      ],
      "accuracy": 82,
      "practiced": 15,
      "mastered": true,
    },
    {
      "id": 4,
      "sound": "/ə/",
      "symbol": "schwa",
      "category": "Vowel Sounds",
      "level": "Advanced",
      "description": "Neutral vowel sound in unstressed syllables",
      "examples": ["about", "problem", "circus", "camera", "banana"],
      "commonMistakes": [
        "Pronouncing unstressed vowels too clearly",
        "Not reducing vowels in fast speech"
      ],
      "tips": [
        "Relax your mouth completely",
        "Make the sound very short",
        "Use in unstressed syllables only"
      ],
      "practiceWords": [
        {"word": "above", "phonetic": "/əˈbʌv/", "difficulty": "Easy"},
        {"word": "photograph", "phonetic": "/ˈfoʊtəɡræf/", "difficulty": "Medium"},
        {"word": "comfortable", "phonetic": "/ˈkʌmftərbəl/", "difficulty": "Hard"},
      ],
      "accuracy": 71,
      "practiced": 6,
      "mastered": false,
    },
    {
      "id": 5,
      "sound": "Silent B",
      "symbol": "mb",
      "category": "Silent Letters",
      "level": "Beginner",
      "description": "Silent 'b' at the end of words after 'm'",
      "examples": ["lamb", "thumb", "bomb", "climb", "comb"],
      "commonMistakes": [
        "Pronouncing the 'b' sound",
        "Over-articulating the ending"
      ],
      "tips": [
        "Stop at the 'm' sound",
        "Don't close your lips for 'b'",
        "Practice with minimal pairs"
      ],
      "practiceWords": [
        {"word": "dumb", "phonetic": "/dʌm/", "difficulty": "Easy"},
        {"word": "plumber", "phonetic": "/ˈplʌmər/", "difficulty": "Medium"},
        {"word": "succumb", "phonetic": "/səˈkʌm/", "difficulty": "Hard"},
      ],
      "accuracy": 89,
      "practiced": 20,
      "mastered": true,
    },
    {
      "id": 6,
      "sound": "Primary Stress",
      "symbol": "ˈ",
      "category": "Word Stress",
      "level": "Advanced",
      "description": "Main emphasis in multi-syllable words",
      "examples": ["ˈteacher", "comˈputer", "ˈhospital", "reˈcord", "ˈphotograph"],
      "commonMistakes": [
        "Placing stress on wrong syllable",
        "Not making stressed syllable prominent enough"
      ],
      "tips": [
        "Make stressed syllable louder and longer",
        "Reduce unstressed syllables",
        "Practice with rhythm patterns"
      ],
      "practiceWords": [
        {"word": "banana", "phonetic": "/bəˈnænə/", "difficulty": "Easy"},
        {"word": "photography", "phonetic": "/fəˈtɑːɡrəfi/", "difficulty": "Hard"},
        {"word": "university", "phonetic": "/ˌjuːnɪˈvɜːrsəti/", "difficulty": "Hard"},
      ],
      "accuracy": 56,
      "practiced": 4,
      "mastered": false,
    },
  ];

  List<Map<String, dynamic>> get filteredSounds {
    return sounds.where((sound) {
      bool matchesCategory = selectedCategory == "All" || 
                           "${sound["category"]}" == selectedCategory;
      bool matchesLevel = selectedLevel == "All" || 
                         "${sound["level"]}" == selectedLevel;
      bool matchesSearch = searchQuery.isEmpty ||
                          "${sound["sound"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${sound["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesLevel && matchesSearch;
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

  Color _getLevelColor(String level) {
    switch (level) {
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

  Color _getAccuracyColor(int accuracy) {
    if (accuracy >= 80) return successColor;
    if (accuracy >= 60) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pronunciation Guide"),
        actions: [
          IconButton(
            icon: Icon(Icons.mic),
            onPressed: () {
              // Navigate to pronunciation test
            },
          ),
          IconButton(
            icon: Icon(Icons.assessment),
            onPressed: () {
              // Navigate to progress report
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
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
                  QTextField(
                    label: "Search sounds...",
                    value: searchQuery,
                    hint: "Enter sound symbol or description",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
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
                          label: "Level",
                          items: levels,
                          value: selectedLevel,
                          onChanged: (value, label) {
                            selectedLevel = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Progress Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "Pronunciation Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${sounds.where((s) => s["mastered"] as bool).length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Mastered",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${((sounds.fold(0.0, (sum, sound) => sum + (sound["accuracy"] as int)) / sounds.length)).toInt()}%",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Avg Accuracy",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${sounds.fold(0, (sum, sound) => sum + (sound["practiced"] as int))}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Practice",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sounds List
            ...filteredSounds.map((sound) {
              bool isMastered = sound["mastered"] as bool;
              int accuracy = sound["accuracy"] as int;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: isMastered 
                      ? Border.all(color: successColor.withAlpha(100), width: 2)
                      : null,
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
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: _getLevelColor("${sound["level"]}"),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${sound["sound"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                if (isMastered)
                                  Icon(
                                    Icons.verified,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${sound["description"]}",
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
                                        color: _getLevelColor("${sound["level"]}"),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${sound["level"]}",
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
                                        "${sound["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "Accuracy: ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "$accuracy%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: _getAccuracyColor(accuracy),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "Practiced: ${sound["practiced"]}x",
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
                            icon: isPlaying ? Icons.stop : Icons.play_arrow,
                            size: bs.sm,
                            onPressed: () {
                              isPlaying = !isPlaying;
                              setState(() {});
                              // Play pronunciation
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
                          // Examples
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Example Words:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Wrap(
                                  spacing: spXs,
                                  children: (sound["examples"] as List).take(5).map((example) {
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
                                        "${example}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: infoColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),

                          // Tips
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pronunciation Tips:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                ...(sound["tips"] as List).map((tip) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.lightbulb_outline,
                                          size: 12,
                                          color: successColor,
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            "${tip}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: successColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),

                          // Common Mistakes
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Common Mistakes:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                ...(sound["commonMistakes"] as List).map((mistake) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.warning_amber,
                                          size: 12,
                                          color: warningColor,
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            "${mistake}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: warningColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),

                          // Practice Words
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Practice Words:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                ...(sound["practiceWords"] as List).map((wordData) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: spXs),
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(
                                        color: _getDifficultyColor("${wordData["difficulty"]}").withAlpha(100),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${wordData["word"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                              Text(
                                                "${wordData["phonetic"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getDifficultyColor("${wordData["difficulty"]}"),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${wordData["difficulty"]}",
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        GestureDetector(
                                          onTap: () {
                                            // Play word pronunciation
                                          },
                                          child: Icon(
                                            Icons.volume_up,
                                            size: 18,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Practice",
                                  icon: Icons.mic,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Start pronunciation practice
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Record & Compare",
                                  icon: isRecording ? Icons.stop : Icons.fiber_manual_record,
                                  size: bs.sm,
                                  onPressed: () {
                                    isRecording = !isRecording;
                                    setState(() {});
                                    // Start/stop recording
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

            if (filteredSounds.isEmpty)
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
                      "No sounds found",
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
