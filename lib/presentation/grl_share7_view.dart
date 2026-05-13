import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShare7View extends StatefulWidget {
  @override
  State<GrlShare7View> createState() => _GrlShare7ViewState();
}

class _GrlShare7ViewState extends State<GrlShare7View> {
  String shareText = "";
  String selectedTheme = "default";
  String selectedFont = "roboto";
  String selectedSize = "medium";
  String backgroundColor = "#FFFFFF";
  String textColor = "#000000";
  bool addBorder = false;
  bool addShadow = false;
  String watermark = "";
  bool includeAuthor = true;
  String authorName = "";
  String selectedFormat = "image";

  final List<Map<String, dynamic>> themes = [
    {"name": "Default", "value": "default", "bg": "#FFFFFF", "text": "#000000"},
    {"name": "Dark", "value": "dark", "bg": "#1A1A1A", "text": "#FFFFFF"},
    {"name": "Gradient Blue", "value": "blue", "bg": "#4285F4", "text": "#FFFFFF"},
    {"name": "Gradient Purple", "value": "purple", "bg": "#9C27B0", "text": "#FFFFFF"},
    {"name": "Nature", "value": "nature", "bg": "#4CAF50", "text": "#FFFFFF"},
    {"name": "Sunset", "value": "sunset", "bg": "#FF9800", "text": "#000000"},
    {"name": "Ocean", "value": "ocean", "bg": "#2196F3", "text": "#FFFFFF"},
    {"name": "Minimal", "value": "minimal", "bg": "#F5F5F5", "text": "#333333"},
  ];

  final List<Map<String, dynamic>> fonts = [
    {"name": "Roboto", "value": "roboto"},
    {"name": "Arial", "value": "arial"},
    {"name": "Times New Roman", "value": "times"},
    {"name": "Helvetica", "value": "helvetica"},
    {"name": "Open Sans", "value": "opensans"},
    {"name": "Lato", "value": "lato"},
    {"name": "Montserrat", "value": "montserrat"},
    {"name": "Playfair Display", "value": "playfair"},
  ];

  final List<Map<String, dynamic>> sizes = [
    {"name": "Small", "value": "small"},
    {"name": "Medium", "value": "medium"},
    {"name": "Large", "value": "large"},
    {"name": "Extra Large", "value": "xlarge"},
  ];

  final List<Map<String, dynamic>> formats = [
    {"name": "Image (PNG)", "value": "image", "icon": Icons.image},
    {"name": "Text Post", "value": "text", "icon": Icons.text_fields},
    {"name": "Story Format", "value": "story", "icon": Icons.auto_stories},
    {"name": "Card Format", "value": "card", "icon": Icons.credit_card},
  ];

  final List<Map<String, dynamic>> recentQuotes = [
    {
      "text": "The only way to do great work is to love what you do.",
      "author": "Steve Jobs",
      "category": "motivation",
      "shares": 145,
      "date": "2024-01-15"
    },
    {
      "text": "Innovation distinguishes between a leader and a follower.",
      "author": "Steve Jobs",
      "category": "innovation",
      "shares": 89,
      "date": "2024-01-14"
    },
    {
      "text": "Life is what happens to you while you're busy making other plans.",
      "author": "John Lennon",
      "category": "life",
      "shares": 234,
      "date": "2024-01-13"
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {"name": "Motivation", "value": "motivation", "color": "#FF9800"},
    {"name": "Love", "value": "love", "color": "#E91E63"},
    {"name": "Success", "value": "success", "color": "#4CAF50"},
    {"name": "Life", "value": "life", "color": "#2196F3"},
    {"name": "Wisdom", "value": "wisdom", "color": "#9C27B0"},
    {"name": "Inspiration", "value": "inspiration", "color": "#FF5722"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Quote"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              _downloadQuote();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuoteInput(),
            _buildQuotePreview(),
            _buildThemeSelection(),
            _buildCustomization(),
            _buildFormatSelection(),
            _buildAuthorSettings(),
            _buildCategorySelection(),
            _buildRecentQuotes(),
            _buildShareButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteInput() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter Quote",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Quote Text",
            value: shareText,
            hint: "Enter your inspiring quote here...",
            onChanged: (value) {
              shareText = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              QButton(
                icon: Icons.auto_awesome,
                size: bs.sm,
                onPressed: () {
                  _generateRandomQuote();
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.content_paste,
                size: bs.sm,
                onPressed: () {
                  _pasteFromClipboard();
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.mic,
                size: bs.sm,
                onPressed: () {
                  _voiceInput();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuotePreview() {
    if (shareText.isEmpty) return Container();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Preview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: _getThemeBackgroundColor(),
              borderRadius: BorderRadius.circular(radiusSm),
              border: addBorder ? Border.all(color: primaryColor, width: 2) : null,
              boxShadow: addShadow ? [shadowLg] : null,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.format_quote,
                  size: 32,
                  color: _getThemeTextColor().withAlpha(150),
                ),
                SizedBox(height: spSm),
                Text(
                  shareText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _getFontSize(),
                    fontWeight: FontWeight.w600,
                    color: _getThemeTextColor(),
                    height: 1.4,
                  ),
                ),
                if (includeAuthor && authorName.isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Text(
                    "- $authorName",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: _getFontSize() * 0.8,
                      fontStyle: FontStyle.italic,
                      color: _getThemeTextColor().withAlpha(180),
                    ),
                  ),
                ],
                if (watermark.isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Text(
                    watermark,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: _getThemeTextColor().withAlpha(100),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose Theme",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: themes.map((theme) {
              bool isSelected = selectedTheme == theme["value"];
              return GestureDetector(
                onTap: () {
                  selectedTheme = theme["value"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 3 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(int.parse("0xFF${theme["bg"].toString().substring(1)}")),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Center(
                          child: Text(
                            "Aa",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(int.parse("0xFF${theme["text"].toString().substring(1)}")),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${theme["name"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
    );
  }

  Widget _buildCustomization() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customization",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Font",
                  items: fonts,
                  value: selectedFont,
                  onChanged: (value, label) {
                    selectedFont = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Size",
                  items: sizes,
                  value: selectedSize,
                  onChanged: (value, label) {
                    selectedSize = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QSwitch(
            items: [
              {
                "label": "Add Border",
                "value": "border",
                "checked": addBorder,
              }
            ],
            value: addBorder ? [{"label": "Add Border", "value": "border", "checked": true}] : [],
            onChanged: (values, ids) {
              addBorder = values.isNotEmpty;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QSwitch(
            items: [
              {
                "label": "Add Shadow",
                "value": "shadow",
                "checked": addShadow,
              }
            ],
            value: addShadow ? [{"label": "Add Shadow", "value": "shadow", "checked": true}] : [],
            onChanged: (values, ids) {
              addShadow = values.isNotEmpty;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Watermark (Optional)",
            value: watermark,
            hint: "Add watermark text",
            onChanged: (value) {
              watermark = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFormatSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Output Format",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: formats.map((format) {
              bool isSelected = selectedFormat == format["value"];
              return GestureDetector(
                onTap: () {
                  selectedFormat = format["value"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        format["icon"],
                        color: isSelected ? primaryColor : disabledBoldColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${format["name"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
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
    );
  }

  Widget _buildAuthorSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Author Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QSwitch(
            items: [
              {
                "label": "Include Author",
                "value": "author",
                "checked": includeAuthor,
              }
            ],
            value: includeAuthor ? [{"label": "Include Author", "value": "author", "checked": true}] : [],
            onChanged: (values, ids) {
              includeAuthor = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (includeAuthor) ...[
            SizedBox(height: spSm),
            QTextField(
              label: "Author Name",
              value: authorName,
              hint: "Enter author name",
              onChanged: (value) {
                authorName = value;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCategorySelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quote Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: categories.map((category) {
              return GestureDetector(
                onTap: () {
                  _loadCategoryQuotes(category["value"]);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Color(int.parse("0xFF${category["color"].toString().substring(1)}")).withAlpha(40),
                    borderRadius: BorderRadius.circular(radiusXl),
                    border: Border.all(
                      color: Color(int.parse("0xFF${category["color"].toString().substring(1)}")),
                    ),
                  ),
                  child: Text(
                    "${category["name"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(int.parse("0xFF${category["color"].toString().substring(1)}")),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentQuotes() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Popular Quotes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...recentQuotes.map((quote) => _buildQuoteItem(quote)).toList(),
        ],
      ),
    );
  }

  Widget _buildQuoteItem(Map<String, dynamic> quote) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${quote["text"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "- ${quote["author"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${quote["category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Row(
                children: [
                  Icon(Icons.share, size: 12, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${quote["shares"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.content_copy,
                size: bs.sm,
                onPressed: () {
                  _useQuote(quote);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Create & Share Quote",
        size: bs.md,
        onPressed: shareText.isNotEmpty ? () {
          _createQuote();
        } : null,
      ),
    );
  }

  Color _getThemeBackgroundColor() {
    final theme = themes.firstWhere((t) => t["value"] == selectedTheme);
    return Color(int.parse("0xFF${theme["bg"].toString().substring(1)}"));
  }

  Color _getThemeTextColor() {
    final theme = themes.firstWhere((t) => t["value"] == selectedTheme);
    return Color(int.parse("0xFF${theme["text"].toString().substring(1)}"));
  }

  double _getFontSize() {
    switch (selectedSize) {
      case "small":
        return 16.0;
      case "medium":
        return 20.0;
      case "large":
        return 24.0;
      case "xlarge":
        return 28.0;
      default:
        return 20.0;
    }
  }

  void _generateRandomQuote() {
    final quotes = [
      "The only way to do great work is to love what you do.",
      "Innovation distinguishes between a leader and a follower.",
      "Life is what happens to you while you're busy making other plans.",
      "The future belongs to those who believe in the beauty of their dreams.",
      "It is during our darkest moments that we must focus to see the light.",
    ];
    shareText = quotes[(DateTime.now().millisecondsSinceEpoch % quotes.length)];
    setState(() {});
  }

  void _pasteFromClipboard() {
    // Simulate pasting from clipboard
    shareText = "Success is not final, failure is not fatal: it is the courage to continue that counts.";
    setState(() {});
  }

  void _voiceInput() {
    si("Voice input feature");
  }

  void _loadCategoryQuotes(String category) {
    si("Loading $category quotes");
  }

  void _useQuote(Map<String, dynamic> quote) {
    shareText = quote["text"];
    authorName = quote["author"];
    includeAuthor = true;
    setState(() {});
    ss("Quote loaded!");
  }

  void _downloadQuote() {
    if (shareText.isEmpty) {
      se("Please enter a quote first");
      return;
    }
    ss("Quote downloaded as ${selectedFormat.toUpperCase()}!");
  }

  void _createQuote() {
    if (shareText.isEmpty) {
      se("Please enter a quote to share");
      return;
    }

    ss("Quote created and shared successfully!");
  }
}
