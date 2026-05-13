import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsMaintenanceTipsView extends StatefulWidget {
  const BrsMaintenanceTipsView({super.key});

  @override
  State<BrsMaintenanceTipsView> createState() => _BrsMaintenanceTipsViewState();
}

class _BrsMaintenanceTipsViewState extends State<BrsMaintenanceTipsView> {
  String selectedCategory = "Hair Care";
  
  List<String> categories = [
    "Hair Care",
    "Beard Care",
    "Styling",
    "General Tips",
  ];

  Map<String, List<Map<String, dynamic>>> tipsByCategory = {
    "Hair Care": [
      {
        "title": "Daily Hair Washing",
        "description": "Wash your hair every 2-3 days to maintain natural oils",
        "difficulty": "Easy",
        "time": "5 minutes",
        "icon": Icons.local_florist,
        "steps": [
          "Use lukewarm water to wet your hair",
          "Apply small amount of shampoo to scalp",
          "Massage gently with fingertips, not nails",
          "Rinse thoroughly with cool water",
          "Apply conditioner to mid-lengths and ends only",
          "Leave for 2-3 minutes before rinsing",
        ],
      },
      {
        "title": "Weekly Deep Conditioning",
        "description": "Intensive treatment for healthy, strong hair",
        "difficulty": "Medium",
        "time": "20 minutes",
        "icon": Icons.spa,
        "steps": [
          "Shampoo hair as usual",
          "Apply deep conditioning mask generously",
          "Comb through with wide-tooth comb",
          "Cover with shower cap",
          "Leave for 15-20 minutes",
          "Rinse with cool water",
        ],
      },
      {
        "title": "Heat Protection",
        "description": "Protect your hair from styling tool damage",
        "difficulty": "Easy",
        "time": "2 minutes",
        "icon": Icons.shield,
        "steps": [
          "Apply heat protectant to damp hair",
          "Use lowest effective temperature setting",
          "Keep tools moving to avoid hot spots",
          "Allow hair to cool before styling",
          "Use tools sparingly (2-3 times per week max)",
        ],
      },
    ],
    "Beard Care": [
      {
        "title": "Daily Beard Oil Application",
        "description": "Keep your beard moisturized and healthy",
        "difficulty": "Easy",
        "time": "3 minutes",
        "icon": Icons.face,
        "steps": [
          "Clean hands thoroughly",
          "Dispense 3-5 drops of beard oil",
          "Rub between palms to warm the oil",
          "Apply to beard starting from roots",
          "Work through to tips with fingers",
          "Comb through for even distribution",
        ],
      },
      {
        "title": "Weekly Beard Trimming",
        "description": "Maintain shape and remove split ends",
        "difficulty": "Medium",
        "time": "10 minutes",
        "icon": Icons.content_cut,
        "steps": [
          "Clean and dry your beard first",
          "Comb beard in growth direction",
          "Use sharp beard scissors or trimmer",
          "Trim gradually, less is more",
          "Check both sides for symmetry",
          "Clean up neckline and cheek edges",
        ],
      },
      {
        "title": "Beard Washing Technique",
        "description": "Proper cleaning without stripping natural oils",
        "difficulty": "Easy",
        "time": "5 minutes",
        "icon": Icons.cleaning_services,
        "steps": [
          "Rinse beard with warm water",
          "Apply specialized beard shampoo",
          "Massage gently into skin beneath",
          "Rinse thoroughly with lukewarm water",
          "Pat dry with clean towel",
          "Apply beard oil while slightly damp",
        ],
      },
    ],
    "Styling": [
      {
        "title": "Morning Hair Routine",
        "description": "Quick styling for a polished look",
        "difficulty": "Easy",
        "time": "5 minutes",
        "icon": Icons.style,
        "steps": [
          "Lightly dampen hair with water or spray",
          "Apply small amount of styling product",
          "Work through hair with fingers",
          "Style in desired direction",
          "Use comb for final shaping",
          "Set with light hairspray if needed",
        ],
      },
      {
        "title": "Pompadour Styling",
        "description": "Classic men's hairstyle technique",
        "difficulty": "Hard",
        "time": "15 minutes",
        "icon": Icons.auto_awesome,
        "steps": [
          "Start with damp, clean hair",
          "Apply volumizing mousse to roots",
          "Blow dry hair backwards and upwards",
          "Apply pomade to slightly damp hair",
          "Use round brush to create volume",
          "Comb back and shape the front",
          "Secure with strong hold hairspray",
        ],
      },
      {
        "title": "Textured Finish",
        "description": "Create natural, lived-in texture",
        "difficulty": "Medium",
        "time": "8 minutes",
        "icon": Icons.texture,
        "steps": [
          "Apply texturizing cream to damp hair",
          "Scrunch hair while blow drying",
          "Use diffuser attachment for curly hair",
          "Work small amount of clay through hair",
          "Tousle with fingers for texture",
          "Avoid over-combing for natural look",
        ],
      },
    ],
    "General Tips": [
      {
        "title": "Choosing the Right Products",
        "description": "Select products based on your hair type",
        "difficulty": "Easy",
        "time": "Research",
        "icon": Icons.shopping_cart,
        "steps": [
          "Identify your hair type (oily, dry, normal)",
          "Consider your styling goals",
          "Read ingredient lists carefully",
          "Test products on small sections first",
          "Invest in quality over quantity",
          "Consult your barber for recommendations",
        ],
      },
      {
        "title": "Healthy Hair Diet",
        "description": "Nutrition for strong, healthy hair growth",
        "difficulty": "Easy",
        "time": "Daily",
        "icon": Icons.restaurant,
        "steps": [
          "Eat protein-rich foods (eggs, fish, lean meat)",
          "Include omega-3 fatty acids",
          "Consume vitamins A, C, D, and E",
          "Stay hydrated (8+ glasses of water daily)",
          "Take biotin supplements if recommended",
          "Limit processed foods and sugar",
        ],
      },
      {
        "title": "Sleep Care for Hair",
        "description": "Protect your hair while you sleep",
        "difficulty": "Easy",
        "time": "Before bed",
        "icon": Icons.bedtime,
        "steps": [
          "Use silk or satin pillowcase",
          "Avoid sleeping with wet hair",
          "Loosely tie long hair if necessary",
          "Apply leave-in treatment before bed",
          "Consider a silk hair wrap",
          "Change pillowcases regularly",
        ],
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final currentTips = tipsByCategory[selectedCategory] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Maintenance Tips"),
      ),
      body: Column(
        children: [
          // Category Tabs
          Container(
            padding: EdgeInsets.all(spSm),
            child: QCategoryPicker(
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),

          // Tips List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: currentTips.map((tip) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: EdgeInsets.only(top: spSm),
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          tip["icon"] as IconData,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      title: Text(
                        "${tip["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${tip["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: spXs/2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getDifficultyColor(tip["difficulty"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${tip["difficulty"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getDifficultyColor(tip["difficulty"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: spXs/2,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${tip["time"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Step-by-Step Instructions:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            ...(tip["steps"] as List<String>).asMap().entries.map((entry) {
                              int index = entry.key;
                              String step = entry.value;
                              
                              return Padding(
                                padding: EdgeInsets.only(bottom: spSm),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        step,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "easy":
        return successColor;
      case "medium":
        return warningColor;
      case "hard":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
