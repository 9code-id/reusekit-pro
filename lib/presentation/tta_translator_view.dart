import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaTranslatorView extends StatefulWidget {
  const TtaTranslatorView({super.key});

  @override
  State<TtaTranslatorView> createState() => _TtaTranslatorViewState();
}

class _TtaTranslatorViewState extends State<TtaTranslatorView> {
  String fromLanguage = "English";
  String toLanguage = "Spanish";
  String inputText = "";
  String translatedText = "";
  bool isLoading = false;
  bool isListening = false;

  List<Map<String, dynamic>> languageItems = [
    {"label": "English", "value": "English"},
    {"label": "Spanish", "value": "Spanish"},
    {"label": "French", "value": "French"},
    {"label": "German", "value": "German"},
    {"label": "Italian", "value": "Italian"},
    {"label": "Portuguese", "value": "Portuguese"},
    {"label": "Mandarin", "value": "Mandarin"},
    {"label": "Japanese", "value": "Japanese"},
    {"label": "Korean", "value": "Korean"},
    {"label": "Russian", "value": "Russian"},
    {"label": "Arabic", "value": "Arabic"},
    {"label": "Hindi", "value": "Hindi"},
  ];

  List<Map<String, dynamic>> translationHistory = [
    {
      "from": "English",
      "to": "Spanish", 
      "original": "Hello, how are you?",
      "translation": "Hola, ¿cómo estás?",
      "timestamp": "2 minutes ago"
    },
    {
      "from": "English",
      "to": "French",
      "original": "Where is the restaurant?",
      "translation": "Où est le restaurant?",
      "timestamp": "5 minutes ago"
    },
    {
      "from": "Spanish",
      "to": "English",
      "original": "Gracias por su ayuda",
      "translation": "Thank you for your help",
      "timestamp": "10 minutes ago"
    },
  ];

  List<Map<String, dynamic>> quickPhrases = [
    {"text": "Hello", "category": "Greetings"},
    {"text": "Thank you", "category": "Basic"},
    {"text": "How much?", "category": "Shopping"},
    {"text": "Where is...?", "category": "Directions"},
    {"text": "I need help", "category": "Emergency"},
    {"text": "Excuse me", "category": "Basic"},
  ];

  void _translateText() {
    if (inputText.trim().isEmpty) return;
    
    setState(() {
      isLoading = true;
    });

    // Simulate translation API call
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        translatedText = "Translated: $inputText"; // Mock translation
        isLoading = false;
      });
    });
  }

  void _swapLanguages() {
    setState(() {
      String temp = fromLanguage;
      fromLanguage = toLanguage;
      toLanguage = temp;
      
      // Swap texts too if both have content
      if (inputText.isNotEmpty && translatedText.isNotEmpty) {
        String tempText = inputText;
        inputText = translatedText;
        translatedText = tempText;
      }
    });
  }

  void _startVoiceInput() {
    setState(() {
      isListening = true;
    });
    
    // Simulate voice recognition
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isListening = false;
        inputText = "Voice input recognized text";
      });
      _translateText();
    });
  }

  void _playAudio(String text) {
    ss("Playing audio: $text");
  }

  void _copyToClipboard(String text) {
    ss("Copied to clipboard: $text");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Translator"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Translation Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  // Language Selection Row
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "From",
                          items: languageItems,
                          value: fromLanguage,
                          onChanged: (value, label) {
                            fromLanguage = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: _swapLanguages,
                          icon: Icon(
                            Icons.swap_horiz,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "To",
                          items: languageItems,
                          value: toLanguage,
                          onChanged: (value, label) {
                            toLanguage = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // Input Text Area
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledColor),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                fromLanguage,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              if (inputText.isNotEmpty) ...[
                                GestureDetector(
                                  onTap: () => _playAudio(inputText),
                                  child: Icon(
                                    Icons.volume_up,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: spSm),
                              ],
                              GestureDetector(
                                onTap: _startVoiceInput,
                                child: Icon(
                                  isListening ? Icons.mic : Icons.mic_none,
                                  color: isListening ? dangerColor : primaryColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QMemoField(
                          label: "Enter text to translate...",
                          value: inputText,
                          onChanged: (value) {
                            inputText = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),

                  // Translate Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: isLoading ? "Translating..." : "Translate",
                      size: bs.md,
                      onPressed: isLoading ? null : _translateText,
                    ),
                  ),

                  // Translation Result
                  if (translatedText.isNotEmpty) ...[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: successColor.withAlpha(100)),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(10),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  toLanguage,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () => _playAudio(translatedText),
                                  child: Icon(
                                    Icons.volume_up,
                                    color: successColor,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () => _copyToClipboard(translatedText),
                                  child: Icon(
                                    Icons.copy,
                                    color: successColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spMd),
                            child: Text(
                              translatedText,
                              style: TextStyle(
                                fontSize: 16,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Quick Phrases
            Text(
              "Quick Phrases",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: List.generate(quickPhrases.length, (index) {
                final phrase = quickPhrases[index];
                
                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      inputText = "${phrase["text"]}";
                      setState(() {});
                      _translateText();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(color: primaryColor.withAlpha(100)),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: spXs,
                        children: [
                          Text(
                            "${phrase["text"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${phrase["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),

            // Translation History
            Text(
              "Recent Translations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: List.generate(translationHistory.length, (index) {
                final history = translationHistory[index];
                
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${history["from"]} → ${history["to"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${history["timestamp"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${history["original"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${history["translation"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: () => _playAudio("${history["translation"]}"),
                            child: Icon(
                              Icons.volume_up,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () => _copyToClipboard("${history["translation"]}"),
                            child: Icon(
                              Icons.copy,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {
                              inputText = "${history["original"]}";
                              fromLanguage = "${history["from"]}";
                              toLanguage = "${history["to"]}";
                              setState(() {});
                            },
                            child: Icon(
                              Icons.refresh,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
