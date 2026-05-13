import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaTextPostView extends StatefulWidget {
  const SmaTextPostView({super.key});

  @override
  State<SmaTextPostView> createState() => _SmaTextPostViewState();
}

class _SmaTextPostViewState extends State<SmaTextPostView> {
  String postText = "";
  String backgroundColor = "white";
  String textColor = "black";
  String fontStyle = "normal";
  bool isLoading = false;

  List<Map<String, dynamic>> backgroundOptions = [
    {"label": "White", "value": "white", "color": Colors.white},
    {"label": "Gradient Blue", "value": "gradient_blue", "color": Colors.blue},
    {"label": "Gradient Purple", "value": "gradient_purple", "color": Colors.purple},
    {"label": "Gradient Pink", "value": "gradient_pink", "color": Colors.pink},
    {"label": "Gradient Orange", "value": "gradient_orange", "color": Colors.orange},
    {"label": "Black", "value": "black", "color": Colors.black},
  ];

  List<Map<String, dynamic>> fontStyleOptions = [
    {"label": "Normal", "value": "normal"},
    {"label": "Bold", "value": "bold"},
    {"label": "Italic", "value": "italic"},
    {"label": "Cursive", "value": "cursive"},
  ];

  List<Map<String, dynamic>> textColorOptions = [
    {"label": "Black", "value": "black", "color": Colors.black},
    {"label": "White", "value": "white", "color": Colors.white},
    {"label": "Blue", "value": "blue", "color": Colors.blue},
    {"label": "Purple", "value": "purple", "color": Colors.purple},
    {"label": "Pink", "value": "pink", "color": Colors.pink},
    {"label": "Orange", "value": "orange", "color": Colors.orange},
  ];

  Color _getBackgroundColor(String bgValue) {
    switch (bgValue) {
      case "white":
        return Colors.white;
      case "gradient_blue":
        return Colors.blue.shade300;
      case "gradient_purple":
        return Colors.purple.shade300;
      case "gradient_pink":
        return Colors.pink.shade300;
      case "gradient_orange":
        return Colors.orange.shade300;
      case "black":
        return Colors.black;
      default:
        return Colors.white;
    }
  }

  Color _getTextColor(String colorValue) {
    switch (colorValue) {
      case "black":
        return Colors.black;
      case "white":
        return Colors.white;
      case "blue":
        return Colors.blue;
      case "purple":
        return Colors.purple;
      case "pink":
        return Colors.pink;
      case "orange":
        return Colors.orange;
      default:
        return Colors.black;
    }
  }

  FontWeight _getFontWeight(String style) {
    return style == "bold" ? FontWeight.bold : FontWeight.normal;
  }

  FontStyle _getFontStyle(String style) {
    return style == "italic" ? FontStyle.italic : FontStyle.normal;
  }

  void _sharePost() async {
    if (postText.trim().isEmpty) {
      se("Please write some text for your post");
      return;
    }

    isLoading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    isLoading = false;
    setState(() {});

    ss("Text post shared successfully!");
    // navigateTo(SmaHomeFeedView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Text Post"),
        actions: [
          QButton(
            label: isLoading ? "Sharing..." : "Share",
            size: bs.sm,
            onPressed: isLoading ? null : _sharePost,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Preview
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: _getBackgroundColor(backgroundColor),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Text(
                    postText.isEmpty ? "Your text will appear here..." : postText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: postText.isEmpty 
                          ? Colors.grey 
                          : _getTextColor(textColor),
                      fontWeight: _getFontWeight(fontStyle),
                      fontStyle: _getFontStyle(fontStyle),
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ),

            // Text Input
            QMemoField(
              label: "What's on your mind?",
              value: postText,
              hint: "Share your thoughts, feelings, or what you're up to...",
              validator: Validator.required,
              onChanged: (value) {
                postText = value;
                setState(() {});
              },
            ),

            // Background Options
            Text(
              "Background",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              height: 60,
              child: QHorizontalScroll(
                children: backgroundOptions.map((option) {
                  bool isSelected = backgroundColor == option["value"];
                  return GestureDetector(
                    onTap: () {
                      backgroundColor = option["value"];
                      setState(() {});
                    },
                    child: Container(
                      width: 80,
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        color: option["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : Colors.grey.withValues(alpha: 0.3),
                          width: isSelected ? 3 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: option["value"] == "white" || option["value"] == "gradient_orange"
                                  ? primaryColor
                                  : Colors.white,
                              size: 20,
                            ),
                          SizedBox(height: 4),
                          Text(
                            "${option["label"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: option["value"] == "white" 
                                  ? Colors.black 
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Text Color Options
            Text(
              "Text Color",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              height: 50,
              child: QHorizontalScroll(
                children: textColorOptions.map((option) {
                  bool isSelected = textColor == option["value"];
                  return GestureDetector(
                    onTap: () {
                      textColor = option["value"];
                      setState(() {});
                    },
                    child: Container(
                      width: 60,
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        color: option["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : Colors.grey.withValues(alpha: 0.3),
                          width: isSelected ? 3 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: option["value"] == "white" 
                                  ? Colors.black 
                                  : Colors.white,
                              size: 16,
                            ),
                          Text(
                            "${option["label"]}",
                            style: TextStyle(
                              fontSize: 9,
                              color: option["value"] == "white" 
                                  ? Colors.black 
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Font Style
            QDropdownField(
              label: "Font Style",
              items: fontStyleOptions,
              value: fontStyle,
              onChanged: (value, label) {
                fontStyle = value;
                setState(() {});
              },
            ),

            // Character Count
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.text_fields,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Characters: ${postText.length}/500",
                    style: TextStyle(
                      fontSize: 12,
                      color: postText.length > 450 
                          ? dangerColor 
                          : disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  if (postText.length > 450)
                    Icon(
                      Icons.warning,
                      size: 16,
                      color: dangerColor,
                    ),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Add Emoji",
                          icon: Icons.emoji_emotions,
                          size: bs.sm,
                          onPressed: () {
                            postText += " 😊";
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Add Hashtag",
                          icon: Icons.tag,
                          size: bs.sm,
                          onPressed: () {
                            postText += " #";
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (isLoading)
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(strokeWidth: 2),
                    SizedBox(width: spSm),
                    Text(
                      "Sharing your post...",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
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
