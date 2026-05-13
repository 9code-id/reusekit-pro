import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaLanguageSettingsView extends StatefulWidget {
  const SpaLanguageSettingsView({super.key});

  @override
  State<SpaLanguageSettingsView> createState() => _SpaLanguageSettingsViewState();
}

class _SpaLanguageSettingsViewState extends State<SpaLanguageSettingsView> {
  String selectedLanguage = "English";
  String selectedRegion = "United States";
  bool autoDetectLanguage = true;
  bool translateProductDescriptions = true;
  bool translateReviews = false;
  bool translateUserContent = true;
  String translationQuality = "high";
  
  List<Map<String, dynamic>> languages = [
    {"label": "🇺🇸 English", "value": "English", "code": "en", "flag": "🇺🇸"},
    {"label": "🇪🇸 Español", "value": "Spanish", "code": "es", "flag": "🇪🇸"},
    {"label": "🇫🇷 Français", "value": "French", "code": "fr", "flag": "🇫🇷"},
    {"label": "🇩🇪 Deutsch", "value": "German", "code": "de", "flag": "🇩🇪"},
    {"label": "🇮🇹 Italiano", "value": "Italian", "code": "it", "flag": "🇮🇹"},
    {"label": "🇵🇹 Português", "value": "Portuguese", "code": "pt", "flag": "🇵🇹"},
    {"label": "🇷🇺 Русский", "value": "Russian", "code": "ru", "flag": "🇷🇺"},
    {"label": "🇨🇳 中文", "value": "Chinese", "code": "zh", "flag": "🇨🇳"},
    {"label": "🇯🇵 日本語", "value": "Japanese", "code": "ja", "flag": "🇯🇵"},
    {"label": "🇰🇷 한국어", "value": "Korean", "code": "ko", "flag": "🇰🇷"},
    {"label": "🇮🇳 हिन्दी", "value": "Hindi", "code": "hi", "flag": "🇮🇳"},
    {"label": "🇸🇦 العربية", "value": "Arabic", "code": "ar", "flag": "🇸🇦"},
    {"label": "🇹🇷 Türkçe", "value": "Turkish", "code": "tr", "flag": "🇹🇷"},
    {"label": "🇳🇱 Nederlands", "value": "Dutch", "code": "nl", "flag": "🇳🇱"},
    {"label": "🇸🇪 Svenska", "value": "Swedish", "code": "sv", "flag": "🇸🇪"},
  ];

  List<Map<String, dynamic>> regions = [
    {"label": "United States", "value": "United States", "flag": "🇺🇸"},
    {"label": "United Kingdom", "value": "United Kingdom", "flag": "🇬🇧"},
    {"label": "Canada", "value": "Canada", "flag": "🇨🇦"},
    {"label": "Australia", "value": "Australia", "flag": "🇦🇺"},
    {"label": "Germany", "value": "Germany", "flag": "🇩🇪"},
    {"label": "France", "value": "France", "flag": "🇫🇷"},
    {"label": "Spain", "value": "Spain", "flag": "🇪🇸"},
    {"label": "Italy", "value": "Italy", "flag": "🇮🇹"},
    {"label": "Japan", "value": "Japan", "flag": "🇯🇵"},
    {"label": "South Korea", "value": "South Korea", "flag": "🇰🇷"},
    {"label": "China", "value": "China", "flag": "🇨🇳"},
    {"label": "India", "value": "India", "flag": "🇮🇳"},
    {"label": "Brazil", "value": "Brazil", "flag": "🇧🇷"},
    {"label": "Mexico", "value": "Mexico", "flag": "🇲🇽"},
    {"label": "Singapore", "value": "Singapore", "flag": "🇸🇬"},
  ];

  List<Map<String, dynamic>> translationQualityOptions = [
    {"label": "High Quality (Slower)", "value": "high"},
    {"label": "Standard Quality", "value": "standard"},
    {"label": "Fast Translation", "value": "fast"},
  ];

  List<Map<String, dynamic>> recentTranslations = [
    {
      "original": "Product description",
      "translated": "Descripción del producto",
      "from": "English",
      "to": "Spanish",
      "timestamp": DateTime.now().subtract(Duration(minutes: 5)),
    },
    {
      "original": "Customer review",
      "translated": "Avis client",
      "from": "English",
      "to": "French",
      "timestamp": DateTime.now().subtract(Duration(hours: 1)),
    },
    {
      "original": "Shipping information",
      "translated": "Informações de envio",
      "from": "English",
      "to": "Portuguese",
      "timestamp": DateTime.now().subtract(Duration(hours: 2)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Language Settings
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Display Language",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  QDropdownField(
                    label: "Select Language",
                    items: languages,
                    value: selectedLanguage,
                    onChanged: (value, label) {
                      selectedLanguage = value;
                      setState(() {});
                      ss("Language changed to $value");
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QDropdownField(
                    label: "Select Region",
                    items: regions,
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
                      setState(() {});
                      ss("Region changed to $value");
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Auto-detect language from device settings",
                        "value": true,
                        "checked": autoDetectLanguage,
                      }
                    ],
                    value: [
                      if (autoDetectLanguage)
                        {
                          "label": "Auto-detect language from device settings",
                          "value": true,
                          "checked": true,
                        }
                    ],
                    onChanged: (values, ids) {
                      autoDetectLanguage = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Translation Settings
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Translation Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  QDropdownField(
                    label: "Translation Quality",
                    items: translationQualityOptions,
                    value: translationQuality,
                    onChanged: (value, label) {
                      translationQuality = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "Auto-translate Content",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Product descriptions",
                        "value": "descriptions",
                        "checked": translateProductDescriptions,
                      }
                    ],
                    value: [
                      if (translateProductDescriptions)
                        {
                          "label": "Product descriptions",
                          "value": "descriptions",
                          "checked": true,
                        }
                    ],
                    onChanged: (values, ids) {
                      translateProductDescriptions = values.contains("descriptions");
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spXs),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Customer reviews",
                        "value": "reviews",
                        "checked": translateReviews,
                      }
                    ],
                    value: [
                      if (translateReviews)
                        {
                          "label": "Customer reviews",
                          "value": "reviews",
                          "checked": true,
                        }
                    ],
                    onChanged: (values, ids) {
                      translateReviews = values.contains("reviews");
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spXs),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "User-generated content",
                        "value": "user_content",
                        "checked": translateUserContent,
                      }
                    ],
                    value: [
                      if (translateUserContent)
                        {
                          "label": "User-generated content",
                          "value": "user_content",
                          "checked": true,
                        }
                    ],
                    onChanged: (values, ids) {
                      translateUserContent = values.contains("user_content");
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Language Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Usage Statistics",
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
                    children: [
                      _buildStatCard(
                        "Translations Today",
                        "47",
                        primaryColor,
                        Icons.translate,
                      ),
                      _buildStatCard(
                        "Languages Detected",
                        "8",
                        infoColor,
                        Icons.language,
                      ),
                      _buildStatCard(
                        "Auto-translations",
                        "32",
                        successColor,
                        Icons.auto_mode,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Popular Languages
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Most Popular Languages",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  _buildLanguagePopularityItem("English", "🇺🇸", 85, primaryColor),
                  _buildLanguagePopularityItem("Spanish", "🇪🇸", 72, successColor),
                  _buildLanguagePopularityItem("French", "🇫🇷", 68, infoColor),
                  _buildLanguagePopularityItem("German", "🇩🇪", 61, warningColor),
                  _buildLanguagePopularityItem("Chinese", "🇨🇳", 58, dangerColor),
                ],
              ),
            ),

            // Recent Translations
            if (recentTranslations.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Translations",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            recentTranslations.clear();
                            setState(() {});
                            ss("Translation history cleared");
                          },
                          child: Text(
                            "Clear All",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recentTranslations.length,
                      itemBuilder: (context, index) {
                        final translation = recentTranslations[index];
                        return _buildTranslationHistoryItem(translation);
                      },
                    ),
                  ],
                ),
              ),

            // Language Download
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Offline Language Packs",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Text(
                    "Download language packs for offline translation",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  _buildLanguagePackItem("Spanish", "🇪🇸", "Downloaded", true),
                  _buildLanguagePackItem("French", "🇫🇷", "25.2 MB", false),
                  _buildLanguagePackItem("German", "🇩🇪", "28.7 MB", false),
                  _buildLanguagePackItem("Chinese", "🇨🇳", "32.1 MB", false),
                ],
              ),
            ),

            // Translation Tips
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: infoColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Translation Tips",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Enable auto-detect for seamless language switching\n"
                    "• Download offline packs for faster translations\n"
                    "• High quality mode provides better accuracy\n"
                    "• Translation may vary for technical terms\n"
                    "• Report incorrect translations to help improve quality",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Container(
              width: double.infinity,
              child: QButton(
                label: "Save Language Settings",
                size: bs.md,
                onPressed: () async {
                  showLoading();
                  await Future.delayed(Duration(seconds: 2));
                  hideLoading();
                  ss("Language settings saved successfully!");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguagePopularityItem(String language, String flag, int percentage, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Text(
            flag,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      language,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "$percentage%",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: percentage / 100,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationHistoryItem(Map<String, dynamic> translation) {
    final timestamp = translation["timestamp"] as DateTime;
    
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${translation["from"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: spXs),
              Icon(
                Icons.arrow_forward,
                size: 10,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${translation["to"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                "${timestamp.dMMMy}",
                style: TextStyle(
                  fontSize: 8,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "\"${translation["original"]}\"",
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 2),
          Text(
            "\"${translation["translated"]}\"",
            style: TextStyle(
              fontSize: 11,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguagePackItem(String language, String flag, String size, bool isDownloaded) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Text(
            flag,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  language,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  size,
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isDownloaded) {
                ss("Language pack removed");
              } else {
                ss("Downloading $language language pack...");
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
              decoration: BoxDecoration(
                color: isDownloaded ? dangerColor : primaryColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                isDownloaded ? "Remove" : "Download",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
