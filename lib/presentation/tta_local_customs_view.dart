import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaLocalCustomsView extends StatefulWidget {
  const TtaLocalCustomsView({super.key});

  @override
  State<TtaLocalCustomsView> createState() => _TtaLocalCustomsViewState();
}

class _TtaLocalCustomsViewState extends State<TtaLocalCustomsView> {
  String selectedCountry = "japan";
  String selectedCategory = "greetings";

  final List<Map<String, dynamic>> countries = [
    {"label": "Japan", "value": "japan", "flag": "🇯🇵"},
    {"label": "India", "value": "india", "flag": "🇮🇳"},
    {"label": "France", "value": "france", "flag": "🇫🇷"},
    {"label": "Germany", "value": "germany", "flag": "🇩🇪"},
    {"label": "Thailand", "value": "thailand", "flag": "🇹🇭"},
    {"label": "Brazil", "value": "brazil", "flag": "🇧🇷"},
    {"label": "United Kingdom", "value": "uk", "flag": "🇬🇧"},
    {"label": "Italy", "value": "italy", "flag": "🇮🇹"},
  ];

  final List<Map<String, dynamic>> categories = [
    {"label": "Greetings", "value": "greetings", "icon": Icons.waving_hand},
    {"label": "Dining", "value": "dining", "icon": Icons.restaurant},
    {"label": "Gift Giving", "value": "gifts", "icon": Icons.card_giftcard},
    {"label": "Business", "value": "business", "icon": Icons.business},
    {"label": "Religious", "value": "religious", "icon": Icons.temple_buddhist},
    {"label": "Social", "value": "social", "icon": Icons.people},
    {"label": "Communication", "value": "communication", "icon": Icons.chat},
    {"label": "Taboos", "value": "taboos", "icon": Icons.block},
  ];

  final Map<String, Map<String, List<Map<String, dynamic>>>> customsData = {
    "japan": {
      "greetings": [
        {
          "title": "Bowing (Ojigi)",
          "description": "Bowing is the traditional Japanese greeting and shows respect",
          "doTip": "Bow slightly when meeting someone, deeper for elders or superiors",
          "dontTip": "Don't bow and shake hands simultaneously - it's awkward",
          "level": "Essential",
          "icon": Icons.person,
        },
        {
          "title": "Business Card Exchange",
          "description": "Meishi koukan is a formal ritual in Japanese business culture",
          "doTip": "Receive cards with both hands and study them carefully",
          "dontTip": "Never write on someone's business card or put it in your back pocket",
          "level": "Important",
          "icon": Icons.badge,
        },
      ],
      "dining": [
        {
          "title": "Chopstick Etiquette",
          "description": "Proper chopstick use is important in Japanese dining",
          "doTip": "Rest chopsticks on the holder or bowl rim when not eating",
          "dontTip": "Never stick chopsticks upright in rice - this resembles funeral rituals",
          "level": "Essential",
          "icon": Icons.restaurant,
        },
        {
          "title": "Saying Itadakimasu",
          "description": "Express gratitude before and after meals",
          "doTip": "Say 'Itadakimasu' before eating and 'Gochisousama' after",
          "dontTip": "Don't start eating before saying the proper greeting",
          "level": "Important",
          "icon": Icons.emoji_emotions,
        },
      ],
      "gifts": [
        {
          "title": "Omiyage Culture",
          "description": "Gift-giving is deeply embedded in Japanese culture",
          "doTip": "Bring small gifts (omiyage) when visiting someone's home",
          "dontTip": "Don't give gifts in sets of four (shi) - it sounds like death",
          "level": "Important",
          "icon": Icons.card_giftcard,
        },
      ],
      "business": [
        {
          "title": "Punctuality",
          "description": "Being on time is crucial in Japanese business culture",
          "doTip": "Arrive 5-10 minutes early for appointments",
          "dontTip": "Never be late - it's considered very disrespectful",
          "level": "Essential",
          "icon": Icons.schedule,
        },
      ],
      "taboos": [
        {
          "title": "Shoe Etiquette",
          "description": "Removing shoes is required in many places",
          "doTip": "Remove shoes when entering homes, temples, and some restaurants",
          "dontTip": "Don't wear shoes on tatami mats or in sacred spaces",
          "level": "Essential",
          "icon": Icons.no_cell,
        },
      ],
    },
    "india": {
      "greetings": [
        {
          "title": "Namaste Gesture",
          "description": "Traditional greeting with palms pressed together",
          "doTip": "Join palms at chest level and bow slightly while saying 'Namaste'",
          "dontTip": "Don't use your left hand alone for greetings",
          "level": "Essential",
          "icon": Icons.emoji_people,
        },
      ],
      "dining": [
        {
          "title": "Eating with Hands",
          "description": "Many Indian meals are traditionally eaten with hands",
          "doTip": "Use only your right hand for eating",
          "dontTip": "Never use your left hand for eating - it's considered unclean",
          "level": "Essential",
          "icon": Icons.restaurant,
        },
      ],
      "religious": [
        {
          "title": "Temple Visits",
          "description": "Respect religious customs when visiting temples",
          "doTip": "Remove shoes and cover your head in religious places",
          "dontTip": "Don't point feet toward altars or religious images",
          "level": "Essential",
          "icon": Icons.temple_hindu,
        },
      ],
    },
    "france": {
      "greetings": [
        {
          "title": "La Bise (Air Kisses)",
          "description": "Traditional French greeting between friends and family",
          "doTip": "Lightly kiss on both cheeks (start with right) among friends",
          "dontTip": "Don't do la bise in formal business settings",
          "level": "Important",
          "icon": Icons.favorite,
        },
      ],
      "dining": [
        {
          "title": "Bread Etiquette",
          "description": "Bread has special significance in French dining",
          "doTip": "Place bread directly on the table, not on your plate",
          "dontTip": "Don't cut bread with a knife - tear it with your hands",
          "level": "Important",
          "icon": Icons.bakery_dining,
        },
      ],
    },
  };

  List<Map<String, dynamic>> get currentCustoms {
    return customsData[selectedCountry]?[selectedCategory] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Customs & Etiquette"),
        actions: [
          IconButton(
            icon: Icon(Icons.translate),
            onPressed: () {
              // Open translator
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), secondaryColor.withAlpha(20)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.public,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cultural Etiquette Guide",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Learn local customs to show respect and avoid cultural misunderstandings",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Country Selection
            Text(
              "Select Country",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: countries.map((country) {
                final isSelected = selectedCountry == country["value"];
                return GestureDetector(
                  onTap: () {
                    selectedCountry = country["value"] as String;
                    selectedCategory = "greetings"; // Reset to first category
                    setState(() {});
                  },
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${country["flag"]}",
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${country["label"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Category Selection
            Text(
              "Custom Categories",
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
              children: categories.map((category) {
                final isSelected = selectedCategory == category["value"];
                final hasContent = customsData[selectedCountry]?.containsKey(category["value"]) ?? false;
                
                return GestureDetector(
                  onTap: hasContent ? () {
                    selectedCategory = category["value"] as String;
                    setState(() {});
                  } : null,
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : hasContent ? Colors.white : disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : hasContent ? disabledOutlineBorderColor : disabledColor,
                      ),
                      boxShadow: hasContent ? [shadowSm] : [],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          category["icon"] as IconData,
                          color: isSelected ? Colors.white : hasContent ? primaryColor : disabledColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${category["label"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : hasContent ? primaryColor : disabledColor,
                          ),
                        ),
                        if (!hasContent) ...[
                          SizedBox(height: spXs),
                          Text(
                            "Coming Soon",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Customs Content
            if (currentCustoms.isNotEmpty) ...[
              Row(
                children: [
                  Text(
                    "${categories.firstWhere((c) => c["value"] == selectedCategory)["label"]} Customs",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: secondaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${countries.firstWhere((c) => c["value"] == selectedCountry)["flag"]} ${countries.firstWhere((c) => c["value"] == selectedCountry)["label"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spSm),
              
              Column(
                children: currentCustoms.map((custom) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: _buildCustomCard(custom),
                  );
                }).toList(),
              ),
            ] else ...[
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.info,
                      color: infoColor,
                      size: 48,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No customs information available",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Customs information for this category is being prepared",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            SizedBox(height: spMd),
            
            // Additional Resources
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Cultural Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Observe locals and follow their lead when unsure\n• Ask questions politely if you need clarification\n• Show respect even if customs seem different\n• Learn basic phrases in the local language",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Learn Phrases",
                          size: bs.sm,
                          onPressed: () {
                            // Open phrase guide
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Cultural Guide",
                          size: bs.sm,
                          onPressed: () {
                            // Open detailed cultural guide
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
      ),
    );
  }

  Widget _buildCustomCard(Map<String, dynamic> custom) {
    final level = custom["level"] as String;
    Color levelColor = level == "Essential" 
        ? dangerColor 
        : level == "Important" 
        ? warningColor 
        : infoColor;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: levelColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    custom["icon"] as IconData,
                    color: levelColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${custom["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${custom["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: levelColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    level.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Do's and Don'ts
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "DO",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: successColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${custom["doTip"]}",
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
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: dangerColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.cancel,
                              color: dangerColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "DON'T",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${custom["dontTip"]}",
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
            
            SizedBox(height: spSm),
            
            // Action Buttons
            Row(
              children: [
                QButton(
                  icon: Icons.bookmark_border,
                  size: bs.sm,
                  onPressed: () {
                    // Save custom
                  },
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.share,
                  size: bs.sm,
                  onPressed: () {
                    // Share custom
                  },
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.translate,
                  size: bs.sm,
                  onPressed: () {
                    // Translate to local language
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
