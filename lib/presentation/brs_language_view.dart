import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsLanguageView extends StatefulWidget {
  const BrsLanguageView({super.key});

  @override
  State<BrsLanguageView> createState() => _BrsLanguageViewState();
}

class _BrsLanguageViewState extends State<BrsLanguageView> {
  String selectedLanguage = "en";
  String selectedRegion = "US";
  bool autoDetectLanguage = true;
  bool showTranslations = true;
  
  final List<Map<String, dynamic>> languages = [
    {
      "code": "en",
      "name": "English",
      "nativeName": "English",
      "flag": "🇺🇸",
      "isDownloaded": true,
      "downloadSize": "2.1 MB",
      "regions": ["US", "UK", "AU", "CA"]
    },
    {
      "code": "es",
      "name": "Spanish",
      "nativeName": "Español",
      "flag": "🇪🇸",
      "isDownloaded": true,
      "downloadSize": "2.3 MB",
      "regions": ["ES", "MX", "AR", "CO"]
    },
    {
      "code": "fr",
      "name": "French",
      "nativeName": "Français",
      "flag": "🇫🇷",
      "isDownloaded": false,
      "downloadSize": "2.2 MB",
      "regions": ["FR", "CA", "BE", "CH"]
    },
    {
      "code": "de",
      "name": "German",
      "nativeName": "Deutsch",
      "flag": "🇩🇪",
      "isDownloaded": false,
      "downloadSize": "2.4 MB",
      "regions": ["DE", "AT", "CH"]
    },
    {
      "code": "it",
      "name": "Italian",
      "nativeName": "Italiano",
      "flag": "🇮🇹",
      "isDownloaded": false,
      "downloadSize": "2.1 MB",
      "regions": ["IT", "CH", "SM"]
    },
    {
      "code": "pt",
      "name": "Portuguese",
      "nativeName": "Português",
      "flag": "🇵🇹",
      "isDownloaded": false,
      "downloadSize": "2.2 MB",
      "regions": ["PT", "BR"]
    },
    {
      "code": "zh",
      "name": "Chinese",
      "nativeName": "中文",
      "flag": "🇨🇳",
      "isDownloaded": false,
      "downloadSize": "3.1 MB",
      "regions": ["CN", "TW", "HK", "SG"]
    },
    {
      "code": "ja",
      "name": "Japanese",
      "nativeName": "日本語",
      "flag": "🇯🇵",
      "isDownloaded": false,
      "downloadSize": "2.8 MB",
      "regions": ["JP"]
    },
    {
      "code": "ko",
      "name": "Korean",
      "nativeName": "한국어",
      "flag": "🇰🇷",
      "isDownloaded": false,
      "downloadSize": "2.6 MB",
      "regions": ["KR"]
    },
    {
      "code": "ar",
      "name": "Arabic",
      "nativeName": "العربية",
      "flag": "🇸🇦",
      "isDownloaded": false,
      "downloadSize": "2.7 MB",
      "regions": ["SA", "AE", "EG", "JO"]
    }
  ];
  
  final List<Map<String, dynamic>> downloadQueue = [];
  bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language & Region"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Show language help
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Language Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Language",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Text(
                        languages.firstWhere((lang) => lang["code"] == selectedLanguage)["flag"],
                        style: TextStyle(fontSize: 32),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${languages.firstWhere((lang) => lang["code"] == selectedLanguage)["name"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${languages.firstWhere((lang) => lang["code"] == selectedLanguage)["nativeName"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 12,
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
            
            SizedBox(height: spLg),
            
            // Language Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Language Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Auto Detect Language
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Auto-detect Language",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Automatically detect language from device settings",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: autoDetectLanguage,
                          onChanged: (value) {
                            autoDetectLanguage = value;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Show Translations
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.translate,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Show Translations",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Show original text alongside translations",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: showTranslations,
                          onChanged: (value) {
                            showTranslations = value;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Available Languages
            Text(
              "Available Languages",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Column(
              children: languages.map((language) {
                final isSelected = selectedLanguage == language["code"];
                final isDownloaded = language["isDownloaded"] as bool;
                final isInQueue = downloadQueue.any((item) => item["code"] == language["code"]);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: isSelected ? [shadowSm] : null,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${language["flag"]}",
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${language["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? primaryColor : Colors.black,
                                  ),
                                ),
                                if (isSelected) ...[
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.check_circle,
                                    color: successColor,
                                    size: 16,
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              "${language["nativeName"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            if (!isDownloaded) ...[
                              SizedBox(height: spXs),
                              Text(
                                "Download size: ${language["downloadSize"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (isDownloaded) ...[
                        if (isSelected) ...[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "Active",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ] else ...[
                          QButton(
                            label: "Select",
                            size: bs.sm,
                            onPressed: () {
                              selectedLanguage = language["code"];
                              setState(() {});
                              ss("Language changed to ${language["name"]}");
                            },
                          ),
                        ],
                      ] else ...[
                        if (isInQueue || isDownloading) ...[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: infoColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Downloading",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          QButton(
                            label: "Download",
                            icon: Icons.download,
                            size: bs.sm,
                            onPressed: () {
                              downloadQueue.add(language);
                              _startDownload(language);
                            },
                          ),
                        ],
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spLg),
            
            // Region Selection
            if (selectedLanguage == "en") ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Region Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "Select your region for localized content",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    QDropdownField(
                      label: "Region",
                      items: [
                        {"label": "United States (US)", "value": "US"},
                        {"label": "United Kingdom (UK)", "value": "UK"},
                        {"label": "Australia (AU)", "value": "AU"},
                        {"label": "Canada (CA)", "value": "CA"},
                      ],
                      value: selectedRegion,
                      onChanged: (value, label) {
                        selectedRegion = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
            ],
            
            // Reset to Default
            Container(
              width: double.infinity,
              child: QButton(
                label: "Reset to Device Language",
                icon: Icons.restore,
                size: bs.md,
                onPressed: () async {
                  bool isConfirmed = await confirm("Reset language settings to device default?");
                  if (isConfirmed) {
                    selectedLanguage = "en";
                    selectedRegion = "US";
                    autoDetectLanguage = true;
                    setState(() {});
                    ss("Language settings reset to default");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _startDownload(Map<String, dynamic> language) async {
    setState(() {
      isDownloading = true;
    });
    
    // Simulate download
    await Future.delayed(Duration(seconds: 3));
    
    // Update language as downloaded
    final index = languages.indexWhere((lang) => lang["code"] == language["code"]);
    if (index != -1) {
      languages[index]["isDownloaded"] = true;
    }
    
    // Remove from queue
    downloadQueue.removeWhere((item) => item["code"] == language["code"]);
    
    setState(() {
      isDownloading = false;
    });
    
    ss("${language["name"]} downloaded successfully");
  }
}
