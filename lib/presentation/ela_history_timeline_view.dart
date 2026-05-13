import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaHistoryTimelineView extends StatefulWidget {
  const ElaHistoryTimelineView({super.key});

  @override
  State<ElaHistoryTimelineView> createState() => _ElaHistoryTimelineViewState();
}

class _ElaHistoryTimelineViewState extends State<ElaHistoryTimelineView> {
  String selectedPeriod = "All";
  String selectedCategory = "All";
  bool loading = false;
  int selectedEventIndex = -1;

  List<Map<String, dynamic>> periods = [
    {"label": "All", "value": "All"},
    {"label": "Ancient", "value": "Ancient"},
    {"label": "Medieval", "value": "Medieval"},
    {"label": "Renaissance", "value": "Renaissance"},
    {"label": "Modern", "value": "Modern"},
    {"label": "Contemporary", "value": "Contemporary"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Political", "value": "Political"},
    {"label": "Cultural", "value": "Cultural"},
    {"label": "Scientific", "value": "Scientific"},
    {"label": "Military", "value": "Military"},
    {"label": "Economic", "value": "Economic"},
  ];

  List<Map<String, dynamic>> timelineEvents = [
    {
      "title": "Rise of Ancient Egypt",
      "year": -3100,
      "period": "Ancient",
      "category": "Political",
      "description": "Unification of Upper and Lower Egypt under the first pharaoh",
      "significance": "Marked the beginning of one of the world's longest-lasting civilizations",
      "image": "https://picsum.photos/400/300?random=1&keyword=egypt",
      "keyFigures": ["Narmer", "Menes"],
      "location": "Egypt, Africa",
      "details": [
        "Formation of the first unified Egyptian state",
        "Development of hieroglyphic writing system",
        "Construction of early pyramid structures",
        "Establishment of pharaonic rule"
      ]
    },
    {
      "title": "Great Wall of China Construction",
      "year": -220,
      "period": "Ancient",
      "category": "Military",
      "description": "Construction of the Great Wall to defend against northern invasions",
      "significance": "One of the most impressive architectural feats in human history",
      "image": "https://picsum.photos/400/300?random=2&keyword=wall",
      "keyFigures": ["Qin Shi Huang"],
      "location": "China, Asia",
      "details": [
        "Connected existing wall segments",
        "Employed millions of workers",
        "Used innovative construction techniques",
        "Became symbol of Chinese civilization"
      ]
    },
    {
      "title": "Fall of the Roman Empire",
      "year": 476,
      "period": "Medieval",
      "category": "Political",
      "description": "The Western Roman Empire collapses, ending ancient period",
      "significance": "Marked the transition from ancient to medieval Europe",
      "image": "https://picsum.photos/400/300?random=3&keyword=rome",
      "keyFigures": ["Romulus Augustulus", "Odoacer"],
      "location": "Europe",
      "details": [
        "Barbarian invasions weakened the empire",
        "Economic and political instability",
        "Rise of Germanic kingdoms",
        "Beginning of the Dark Ages"
      ]
    },
    {
      "title": "Renaissance Begins",
      "year": 1400,
      "period": "Renaissance",
      "category": "Cultural",
      "description": "Cultural and intellectual revival in Europe",
      "significance": "Transition from medieval to modern world",
      "image": "https://picsum.photos/400/300?random=4&keyword=renaissance",
      "keyFigures": ["Leonardo da Vinci", "Michelangelo", "Raphael"],
      "location": "Italy, Europe",
      "details": [
        "Revival of classical learning",
        "Artistic and scientific breakthroughs",
        "Humanism philosophy emerged",
        "Printing press revolutionized knowledge"
      ]
    },
    {
      "title": "Scientific Revolution",
      "year": 1543,
      "period": "Renaissance",
      "category": "Scientific",
      "description": "Period of major scientific discoveries and theories",
      "significance": "Laid foundation for modern scientific method",
      "image": "https://picsum.photos/400/300?random=5&keyword=science",
      "keyFigures": ["Copernicus", "Galileo", "Newton"],
      "location": "Europe",
      "details": [
        "Heliocentric model of solar system",
        "Laws of physics and motion",
        "Telescope observations",
        "Mathematical descriptions of nature"
      ]
    },
    {
      "title": "Industrial Revolution",
      "year": 1760,
      "period": "Modern",
      "category": "Economic",
      "description": "Transition to mechanized manufacturing",
      "significance": "Transformed society from agricultural to industrial",
      "image": "https://picsum.photos/400/300?random=6&keyword=industry",
      "keyFigures": ["James Watt", "Adam Smith"],
      "location": "Britain, Europe",
      "details": [
        "Steam engine invented",
        "Factory system developed",
        "Urbanization increased",
        "Transportation revolution"
      ]
    },
    {
      "title": "World War I",
      "year": 1914,
      "period": "Modern",
      "category": "Military",
      "description": "Global conflict involving major world powers",
      "significance": "Reshaped the political map of the world",
      "image": "https://picsum.photos/400/300?random=7&keyword=war",
      "keyFigures": ["Kaiser Wilhelm II", "Woodrow Wilson"],
      "location": "Global",
      "details": [
        "First global mechanized warfare",
        "End of several empires",
        "Rise of United States as world power",
        "League of Nations established"
      ]
    },
    {
      "title": "Moon Landing",
      "year": 1969,
      "period": "Contemporary",
      "category": "Scientific",
      "description": "First human landing on the Moon",
      "significance": "Greatest achievement in space exploration",
      "image": "https://picsum.photos/400/300?random=8&keyword=moon",
      "keyFigures": ["Neil Armstrong", "Buzz Aldrin"],
      "location": "Moon",
      "details": [
        "Apollo 11 mission success",
        "First human steps on lunar surface",
        "Technological advancement demonstration",
        "International scientific collaboration"
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    return timelineEvents.where((event) {
      bool periodMatch = selectedPeriod == "All" || event["period"] == selectedPeriod;
      bool categoryMatch = selectedCategory == "All" || event["category"] == selectedCategory;
      return periodMatch && categoryMatch;
    }).toList()
      ..sort((a, b) => (a["year"] as int).compareTo(b["year"] as int));
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("History Timeline"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigate to search
            },
          ),
          IconButton(
            icon: Icon(Icons.quiz),
            onPressed: () {
              // Navigate to history quiz
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.timeline,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Journey Through Time",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Explore major events that shaped human civilization",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Filter Section
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
                    "Filter Timeline",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: periods,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
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
                    ],
                  ),
                ],
              ),
            ),

            // Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredEvents.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Events",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${periods.length - 1}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Periods",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredEvents.isNotEmpty ? ((filteredEvents.last["year"] as int) - (filteredEvents.first["year"] as int)) : 0}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Years Span",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Timeline
            Text(
              "Historical Timeline",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            // Timeline Events
            ...filteredEvents.asMap().entries.map((entry) {
              final index = entry.key;
              final event = entry.value;
              final isSelected = selectedEventIndex == index;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline indicator
                    Column(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: _getEventColor(event["category"]),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            boxShadow: [shadowSm],
                          ),
                        ),
                        if (index < filteredEvents.length - 1)
                          Container(
                            width: 2,
                            height: 100,
                            color: disabledColor,
                          ),
                      ],
                    ),
                    SizedBox(width: spSm),
                    
                    // Event content
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedEventIndex = isSelected ? -1 : index;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                            border: isSelected
                                ? Border.all(color: primaryColor, width: 2)
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              // Year and category
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getEventColor(event["category"]),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${event["year"] < 0 ? "${(-event["year"] as int)} BC" : "${event["year"]} AD"}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${event["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    isSelected ? Icons.expand_less : Icons.expand_more,
                                    color: disabledBoldColor,
                                    size: 20,
                                  ),
                                ],
                              ),
                              
                              // Title and basic info
                              Text(
                                "${event["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${event["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              
                              // Expanded content
                              if (isSelected) ...[
                                // Image
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(vertical: spSm),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    child: Image.network(
                                      "${event["image"]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                
                                // Significance
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Text(
                                        "Historical Significance",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                      Text(
                                        "${event["significance"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Key figures and location
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Key Figures",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          ...((event["keyFigures"] as List).map((figure) {
                                            return Text(
                                              "• $figure",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            );
                                          }).toList()),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Location",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "${event["location"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                
                                // Details
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Key Details",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    ...((event["details"] as List).map((detail) {
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 4,
                                            height: 4,
                                            margin: EdgeInsets.only(top: 6),
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Expanded(
                                            child: Text(
                                              "$detail",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList()),
                                  ],
                                ),
                              ],
                            ],
                          ),
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
    );
  }

  Color _getEventColor(String category) {
    switch (category) {
      case "Political":
        return primaryColor;
      case "Cultural":
        return successColor;
      case "Scientific":
        return infoColor;
      case "Military":
        return dangerColor;
      case "Economic":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
}
