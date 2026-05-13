import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsVoiceSearchView extends StatefulWidget {
  const EcsVoiceSearchView({super.key});

  @override
  State<EcsVoiceSearchView> createState() => _EcsVoiceSearchViewState();
}

class _EcsVoiceSearchViewState extends State<EcsVoiceSearchView> {
  bool isListening = false;
  String recognizedText = "";
  String searchQuery = "";
  List<Map<String, dynamic>> voiceSearchHistory = [
    {
      "query": "wireless headphones",
      "timestamp": "2 hours ago",
      "results": 45,
    },
    {
      "query": "running shoes for men",
      "timestamp": "Yesterday",
      "results": 128,
    },
    {
      "query": "laptop bag",
      "timestamp": "2 days ago",
      "results": 67,
    },
  ];

  List<Map<String, dynamic>> searchSuggestions = [
    {"text": "Show me smartphones under \$500", "icon": Icons.phone_android},
    {"text": "Find black leather jackets", "icon": Icons.checkroom},
    {"text": "Search for wireless earbuds", "icon": Icons.headphones},
    {"text": "Look for gaming keyboards", "icon": Icons.keyboard},
    {"text": "Find women's running shoes", "icon": Icons.directions_run},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voice Search"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_voice),
            onPressed: () {
              _showVoiceSettings();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Voice Input Area
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withAlpha(20),
                    primaryColor.withAlpha(10),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: isListening ? primaryColor : disabledBoldColor.withAlpha(50),
                  width: isListening ? 2 : 1,
                ),
              ),
              child: Column(
                children: [
                  // Microphone Button
                  GestureDetector(
                    onTap: () {
                      _toggleListening();
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isListening ? primaryColor : Colors.white,
                        boxShadow: [
                          if (isListening) 
                            BoxShadow(
                              color: primaryColor.withAlpha(50),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                        ],
                      ),
                      child: Icon(
                        isListening ? Icons.mic : Icons.mic_none,
                        size: 50,
                        color: isListening ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Status Text
                  Text(
                    isListening 
                        ? "Listening..." 
                        : recognizedText.isNotEmpty 
                            ? "Tap to search again"
                            : "Tap microphone to start",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  if (recognizedText.isNotEmpty) ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledBoldColor.withAlpha(50)),
                      ),
                      child: Text(
                        "\"$recognizedText\"",
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Search Controls
            if (recognizedText.isNotEmpty) ...[
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Search Products",
                      size: bs.md,
                      onPressed: () {
                        _searchProducts(recognizedText);
                      },
                    ),
                  ),
                  QButton(
                    icon: Icons.edit,
                    size: bs.md,
                    onPressed: () {
                      _editQuery();
                    },
                  ),
                ],
              ),
            ],

            // Language Settings
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Voice Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Language: English (US)",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search Suggestions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Try saying...",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...searchSuggestions.map((suggestion) => _buildSuggestionItem(suggestion)),
                ],
              ),
            ),

            // Voice Search History
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Text(
                        "Recent Voice Searches",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => _clearHistory(),
                        child: Text(
                          "Clear",
                          style: TextStyle(
                            color: dangerColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...voiceSearchHistory.map((search) => _buildHistoryItem(search)),
                ],
              ),
            ),

            // Voice Search Tips
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Voice Search Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  _buildTip("Speak clearly and at normal pace"),
                  _buildTip("Include brand names for better results"),
                  _buildTip("Use specific terms like 'wireless' or 'waterproof'"),
                  _buildTip("Say 'show me' or 'find' to start your search"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionItem(Map<String, dynamic> suggestion) {
    return GestureDetector(
      onTap: () {
        recognizedText = "${suggestion["text"]}";
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        margin: EdgeInsets.only(bottom: spXs),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: disabledBoldColor.withAlpha(30)),
        ),
        child: Row(
          children: [
            Icon(
              suggestion["icon"] as IconData,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Text(
                "${suggestion["text"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ),
            Icon(
              Icons.mic,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> search) {
    return GestureDetector(
      onTap: () {
        recognizedText = "${search["query"]}";
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        margin: EdgeInsets.only(bottom: spXs),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              Icons.history,
              color: disabledBoldColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${search["query"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${search["results"]} results • ${search["timestamp"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 4,
          margin: EdgeInsets.only(top: 8, right: spSm),
          decoration: BoxDecoration(
            color: infoColor,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: infoColor,
            ),
          ),
        ),
      ],
    );
  }

  void _toggleListening() {
    isListening = !isListening;
    setState(() {});
    
    if (isListening) {
      _simulateVoiceRecognition();
    }
  }

  void _simulateVoiceRecognition() {
    Future.delayed(Duration(seconds: 3), () {
      if (isListening) {
        recognizedText = "wireless bluetooth headphones";
        isListening = false;
        setState(() {});
      }
    });
  }

  void _searchProducts(String query) {
    ss("Searching for: $query");
    // Navigate to search results
  }

  void _editQuery() {
    showDialog(
      context: context,
      builder: (context) {
        String editedQuery = recognizedText;
        return AlertDialog(
          title: Text("Edit Search Query"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Search Query",
                value: editedQuery,
                onChanged: (value) {
                  editedQuery = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => back(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                recognizedText = editedQuery;
                setState(() {});
                back();
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void _showVoiceSettings() {
    ss("Voice settings opened");
  }

  void _clearHistory() {
    voiceSearchHistory.clear();
    setState(() {});
    ss("Voice search history cleared");
  }
}
