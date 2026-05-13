import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaArticleReaderView extends StatefulWidget {
  const NmaArticleReaderView({super.key});

  @override
  State<NmaArticleReaderView> createState() => _NmaArticleReaderViewState();
}

class _NmaArticleReaderViewState extends State<NmaArticleReaderView> {
  bool isReading = true;
  bool isBookmarked = false;
  double fontSize = 16.0;
  int readingProgress = 45;
  bool isDarkMode = false;
  bool isFullscreen = false;
  
  String selectedFont = "Default";
  List<String> fontOptions = ["Default", "Serif", "Sans Serif", "Dyslexic"];
  
  String selectedTheme = "Light";
  List<String> themeOptions = ["Light", "Dark", "Sepia", "High Contrast"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: isFullscreen ? null : AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : primaryColor,
        title: Text("Reader Mode"),
        actions: [
          IconButton(
            icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              isBookmarked = !isBookmarked;
              setState(() {});
              if (isBookmarked) {
                ss("Article bookmarked");
              } else {
                si("Bookmark removed");
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.text_format),
            onPressed: () {
              _showReaderSettings();
            },
          ),
          IconButton(
            icon: Icon(isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen),
            onPressed: () {
              isFullscreen = !isFullscreen;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showReaderMenu();
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          if (isFullscreen) {
            isFullscreen = false;
            setState(() {});
          }
        },
        child: Column(
          children: [
            // Reading Progress Bar
            if (!isFullscreen)
              Container(
                height: 4,
                width: double.infinity,
                color: disabledColor,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 4,
                    width: MediaQuery.of(context).size.width * (readingProgress / 100),
                    color: primaryColor,
                  ),
                ),
              ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Article Header
                    if (!isFullscreen) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "WORLD NEWS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                    ],

                    // Article Title
                    Text(
                      "Revolutionary AI Technology Transforms Healthcare Diagnostics Worldwide",
                      style: TextStyle(
                        fontSize: fontSize + 8,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : primaryColor,
                        height: 1.3,
                        fontFamily: _getFontFamily(),
                      ),
                    ),

                    if (!isFullscreen) ...[
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage("https://picsum.photos/100/100?random=1&keyword=doctor"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dr. Alex Thompson",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode ? Colors.white : primaryColor,
                                    fontFamily: _getFontFamily(),
                                  ),
                                ),
                                Text(
                                  "Medical Technology Correspondent • 2 hours ago",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDarkMode ? Colors.grey[400] : disabledBoldColor,
                                    fontFamily: _getFontFamily(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],

                    SizedBox(height: spMd),

                    // Article Content
                    Text(
                      "In a groundbreaking development that promises to revolutionize healthcare worldwide, researchers at the International Medical Technology Institute have unveiled an artificial intelligence system capable of diagnosing complex medical conditions with unprecedented accuracy.\n\n",
                      style: TextStyle(
                        fontSize: fontSize,
                        height: 1.8,
                        color: isDarkMode ? Colors.white : primaryColor,
                        fontFamily: _getFontFamily(),
                      ),
                    ),

                    Text(
                      "The AI system, dubbed MediScan Pro, has demonstrated the ability to detect early-stage diseases that human doctors often miss during initial examinations. In clinical trials involving over 50,000 patients across 15 countries, the system achieved a 97.3% accuracy rate in diagnosing various conditions ranging from cardiovascular diseases to rare genetic disorders.\n\n",
                      style: TextStyle(
                        fontSize: fontSize,
                        height: 1.8,
                        color: isDarkMode ? Colors.white : primaryColor,
                        fontFamily: _getFontFamily(),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(spMd),
                      margin: EdgeInsets.symmetric(vertical: spMd),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[800] : disabledColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: primaryColor,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Key Breakthrough Features:",
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : primaryColor,
                              fontFamily: _getFontFamily(),
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "• Real-time analysis of medical imaging\n• Multi-language diagnostic reports\n• Integration with existing hospital systems\n• Continuous learning from global medical data\n• Privacy-protected patient information processing",
                            style: TextStyle(
                              fontSize: fontSize - 1,
                              height: 1.6,
                              color: isDarkMode ? Colors.white : primaryColor,
                              fontFamily: _getFontFamily(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      "Dr. Maria Rodriguez, lead researcher on the project, explained the significance of this advancement: \"This technology represents a paradigm shift in how we approach medical diagnosis. By combining machine learning with decades of medical expertise, we're enabling healthcare providers to catch diseases earlier and save more lives.\"\n\n",
                      style: TextStyle(
                        fontSize: fontSize,
                        height: 1.8,
                        color: isDarkMode ? Colors.white : primaryColor,
                        fontFamily: _getFontFamily(),
                      ),
                    ),

                    Text(
                      "The implementation of MediScan Pro is already underway in major hospitals across North America and Europe, with plans for global deployment by the end of next year. Healthcare professionals report that the system has significantly reduced diagnostic errors and improved patient outcomes in pilot programs.\n\n",
                      style: TextStyle(
                        fontSize: fontSize,
                        height: 1.8,
                        color: isDarkMode ? Colors.white : primaryColor,
                        fontFamily: _getFontFamily(),
                      ),
                    ),

                    Text(
                      "Critics, however, raise concerns about the potential for over-reliance on AI in critical medical decisions. The Medical Ethics Council has called for comprehensive guidelines to ensure that human oversight remains central to patient care while leveraging AI capabilities.\n\n",
                      style: TextStyle(
                        fontSize: fontSize,
                        height: 1.8,
                        color: isDarkMode ? Colors.white : primaryColor,
                        fontFamily: _getFontFamily(),
                      ),
                    ),

                    Text(
                      "As this technology continues to evolve, it promises to democratize access to high-quality medical diagnostics worldwide, particularly benefiting underserved communities where specialist doctors are scarce. The future of healthcare appears to be one where artificial intelligence and human expertise work hand in hand to deliver better patient outcomes.",
                      style: TextStyle(
                        fontSize: fontSize,
                        height: 1.8,
                        color: isDarkMode ? Colors.white : primaryColor,
                        fontFamily: _getFontFamily(),
                      ),
                    ),

                    SizedBox(height: spMd * 2),

                    // Reading Stats
                    if (!isFullscreen)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[800] : disabledColor,
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Reading Time",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDarkMode ? Colors.grey[400] : disabledBoldColor,
                                    fontFamily: _getFontFamily(),
                                  ),
                                ),
                                Text(
                                  "7 min",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode ? Colors.white : primaryColor,
                                    fontFamily: _getFontFamily(),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Progress",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDarkMode ? Colors.grey[400] : disabledBoldColor,
                                    fontFamily: _getFontFamily(),
                                  ),
                                ),
                                Text(
                                  "${readingProgress}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode ? Colors.white : primaryColor,
                                    fontFamily: _getFontFamily(),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Words",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDarkMode ? Colors.grey[400] : disabledBoldColor,
                                    fontFamily: _getFontFamily(),
                                  ),
                                ),
                                Text(
                                  "1,847",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode ? Colors.white : primaryColor,
                                    fontFamily: _getFontFamily(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Bottom Reading Controls
            if (!isFullscreen)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[900] : Colors.white,
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.volume_up),
                      color: isDarkMode ? Colors.white : primaryColor,
                      onPressed: () {
                        ss("Text-to-speech started");
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.text_decrease),
                      color: isDarkMode ? Colors.white : primaryColor,
                      onPressed: () {
                        if (fontSize > 12) {
                          fontSize -= 2;
                          setState(() {});
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.text_increase),
                      color: isDarkMode ? Colors.white : primaryColor,
                      onPressed: () {
                        if (fontSize < 24) {
                          fontSize += 2;
                          setState(() {});
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                      color: isDarkMode ? Colors.white : primaryColor,
                      onPressed: () {
                        isDarkMode = !isDarkMode;
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      color: isDarkMode ? Colors.white : primaryColor,
                      onPressed: () {
                        ss("Article shared");
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getFontFamily() {
    switch (selectedFont) {
      case "Serif":
        return "serif";
      case "Sans Serif":
        return "sans-serif";
      case "Dyslexic":
        return "OpenDyslexic";
      default:
        return "default";
    }
  }

  void _showReaderSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reader Settings",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            // Font Size
            Text(
              "Font Size",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : primaryColor,
              ),
            ),
            Slider(
              value: fontSize,
              min: 12,
              max: 24,
              divisions: 6,
              label: fontSize.round().toString(),
              onChanged: (value) {
                fontSize = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            // Font Family
            Text(
              "Font Family",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Wrap(
              spacing: spXs,
              children: fontOptions.map((font) => GestureDetector(
                onTap: () {
                  selectedFont = font;
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: selectedFont == font ? primaryColor : disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    font,
                    style: TextStyle(
                      color: selectedFont == font ? Colors.white : (isDarkMode ? Colors.white : primaryColor),
                      fontWeight: selectedFont == font ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              )).toList(),
            ),
            SizedBox(height: spMd),

            // Theme
            Text(
              "Reading Theme",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Wrap(
              spacing: spXs,
              children: themeOptions.map((theme) => GestureDetector(
                onTap: () {
                  selectedTheme = theme;
                  isDarkMode = theme == "Dark";
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: selectedTheme == theme ? primaryColor : disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    theme,
                    style: TextStyle(
                      color: selectedTheme == theme ? Colors.white : (isDarkMode ? Colors.white : primaryColor),
                      fontWeight: selectedTheme == theme ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showReaderMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.copy, color: isDarkMode ? Colors.white : primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Copy Text",
                  style: TextStyle(color: isDarkMode ? Colors.white : primaryColor),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.translate, color: isDarkMode ? Colors.white : primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Translate",
                  style: TextStyle(color: isDarkMode ? Colors.white : primaryColor),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.highlight, color: isDarkMode ? Colors.white : primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Highlight",
                  style: TextStyle(color: isDarkMode ? Colors.white : primaryColor),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.note_add, color: isDarkMode ? Colors.white : primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Add Note",
                  style: TextStyle(color: isDarkMode ? Colors.white : primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
