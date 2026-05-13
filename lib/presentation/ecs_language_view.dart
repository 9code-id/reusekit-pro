import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsLanguageView extends StatefulWidget {
  const EcsLanguageView({super.key});

  @override
  State<EcsLanguageView> createState() => _EcsLanguageViewState();
}

class _EcsLanguageViewState extends State<EcsLanguageView> {
  String selectedLanguage = "en";
  bool loading = false;

  List<Map<String, dynamic>> languages = [
    {
      "code": "en",
      "name": "English",
      "native_name": "English",
      "flag": "🇺🇸",
      "is_rtl": false,
    },
    {
      "code": "es",
      "name": "Spanish",
      "native_name": "Español",
      "flag": "🇪🇸",
      "is_rtl": false,
    },
    {
      "code": "fr",
      "name": "French",
      "native_name": "Français",
      "flag": "🇫🇷",
      "is_rtl": false,
    },
    {
      "code": "de",
      "name": "German",
      "native_name": "Deutsch",
      "flag": "🇩🇪",
      "is_rtl": false,
    },
    {
      "code": "it",
      "name": "Italian",
      "native_name": "Italiano",
      "flag": "🇮🇹",
      "is_rtl": false,
    },
    {
      "code": "pt",
      "name": "Portuguese",
      "native_name": "Português",
      "flag": "🇵🇹",
      "is_rtl": false,
    },
    {
      "code": "ru",
      "name": "Russian",
      "native_name": "Русский",
      "flag": "🇷🇺",
      "is_rtl": false,
    },
    {
      "code": "zh",
      "name": "Chinese",
      "native_name": "中文",
      "flag": "🇨🇳",
      "is_rtl": false,
    },
    {
      "code": "ja",
      "name": "Japanese",
      "native_name": "日本語",
      "flag": "🇯🇵",
      "is_rtl": false,
    },
    {
      "code": "ko",
      "name": "Korean",
      "native_name": "한국어",
      "flag": "🇰🇷",
      "is_rtl": false,
    },
    {
      "code": "ar",
      "name": "Arabic",
      "native_name": "العربية",
      "flag": "🇸🇦",
      "is_rtl": true,
    },
    {
      "code": "hi",
      "name": "Hindi",
      "native_name": "हिन्दी",
      "flag": "🇮🇳",
      "is_rtl": false,
    },
    {
      "code": "id",
      "name": "Indonesian",
      "native_name": "Bahasa Indonesia",
      "flag": "🇮🇩",
      "is_rtl": false,
    },
    {
      "code": "th",
      "name": "Thai",
      "native_name": "ไทย",
      "flag": "🇹🇭",
      "is_rtl": false,
    },
    {
      "code": "vi",
      "name": "Vietnamese",
      "native_name": "Tiếng Việt",
      "flag": "🇻🇳",
      "is_rtl": false,
    },
  ];

  void _changeLanguage(String languageCode) async {
    if (selectedLanguage == languageCode) return;

    loading = true;
    selectedLanguage = languageCode;
    setState(() {});

    // Simulate language change process
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    var language = languages.firstWhere((lang) => lang["code"] == languageCode);
    ss("Language changed to ${language["name"]}");
  }

  Widget _buildLanguageItem(Map<String, dynamic> language) {
    bool isSelected = selectedLanguage == language["code"];
    bool isRtl = language["is_rtl"] as bool;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor.withAlpha(25) : Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isSelected ? primaryColor : disabledOutlineBorderColor,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [shadowSm],
      ),
      child: GestureDetector(
        onTap: () => _changeLanguage(language["code"] as String),
        child: Container(
          padding: EdgeInsets.all(spSm),
          child: Row(
            children: [
              // Flag
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Center(
                  child: Text(
                    "${language["flag"]}",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),

              SizedBox(width: spSm),

              // Language Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${language["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? primaryColor : primaryColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${language["native_name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      
                    ),
                  ],
                ),
              ),

              // Selection Indicator
              if (isSelected)
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              else
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    shape: BoxShape.circle,
                  ),
                ),

              // RTL Indicator
              if (isRtl) ...[
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "RTL",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Language"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: spMd),
              Text(
                "Changing language...",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Language"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Language Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.language,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Current language: ${languages.firstWhere((lang) => lang["code"] == selectedLanguage)["name"]}",
                      style: TextStyle(
                        color: successColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Language Selection Header
            Text(
              "Choose Your Language",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spSm),

            Text(
              "Select your preferred language for the app interface",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),

            SizedBox(height: spMd),

            // Languages Grid
            Column(
              children: languages.map((language) => _buildLanguageItem(language)).toList(),
            ),

            SizedBox(height: spMd),

            // Additional Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Language Information",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• The app will restart to apply the language changes\n• Some content may still appear in English if not translated\n• RTL languages will change the app's text direction",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Restart Notice
            if (selectedLanguage != "en")
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(100)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.restart_alt,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "App restart may be required to fully apply language changes",
                        style: TextStyle(
                          color: warningColor,
                          fontSize: 14,
                        ),
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
