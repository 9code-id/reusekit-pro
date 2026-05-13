import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaBuyingGuidesView extends StatefulWidget {
  const CmaBuyingGuidesView({super.key});

  @override
  State<CmaBuyingGuidesView> createState() => _CmaBuyingGuidesViewState();
}

class _CmaBuyingGuidesViewState extends State<CmaBuyingGuidesView> {
  int currentTab = 0;

  // Search and Filter
  String searchQuery = "";
  String selectedCategory = "";
  String selectedBudgetRange = "";
  String selectedExperience = "";

  List<Map<String, dynamic>> guideCategories = [
    {"label": "All Guides", "value": ""},
    {"label": "First-Time Buyers", "value": "first_time"},
    {"label": "Used Cars", "value": "used_cars"},
    {"label": "New Cars", "value": "new_cars"},
    {"label": "Electric Vehicles", "value": "electric"},
    {"label": "Luxury Cars", "value": "luxury"},
    {"label": "Trucks & SUVs", "value": "trucks_suvs"},
    {"label": "Financing", "value": "financing"},
    {"label": "Insurance", "value": "insurance"},
  ];

  List<Map<String, dynamic>> budgetRanges = [
    {"label": "All Budgets", "value": ""},
    {"label": "Under \$10K", "value": "under_10k"},
    {"label": "\$10K - \$20K", "value": "10k_20k"},
    {"label": "\$20K - \$35K", "value": "20k_35k"},
    {"label": "\$35K - \$50K", "value": "35k_50k"},
    {"label": "Over \$50K", "value": "over_50k"},
  ];

  List<Map<String, dynamic>> buyingGuides = [
    {
      "id": "1",
      "title": "Complete First-Time Car Buyer's Guide",
      "description": "Everything you need to know before buying your first car",
      "category": "first_time",
      "budget_range": "under_10k",
      "difficulty": "beginner",
      "reading_time": 15,
      "rating": 4.9,
      "reviews": 1234,
      "author": "Sarah Johnson",
      "author_avatar": "https://picsum.photos/40/40?random=1&keyword=woman",
      "updated": "2024-06-15",
      "image": "https://picsum.photos/300/180?random=1&keyword=car",
      "sections": [
        "Setting Your Budget",
        "Understanding Car Types",
        "Financing Options",
        "Where to Shop",
        "Inspection Checklist",
        "Negotiation Tips",
        "Paperwork Process",
      ],
      "highlights": [
        "Determine true cost of ownership",
        "Avoid common first-time buyer mistakes",
        "Get the best financing deals",
      ],
    },
    {
      "id": "2",
      "title": "Used Car Inspection Checklist",
      "description": "Comprehensive guide to inspecting used cars before purchase",
      "category": "used_cars",
      "budget_range": "10k_20k",
      "difficulty": "intermediate",
      "reading_time": 12,
      "rating": 4.8,
      "reviews": 896,
      "author": "Mike Rodriguez",
      "author_avatar": "https://picsum.photos/40/40?random=2&keyword=man",
      "updated": "2024-06-12",
      "image": "https://picsum.photos/300/180?random=2&keyword=inspection",
      "sections": [
        "Exterior Inspection",
        "Interior Inspection",
        "Engine & Mechanical",
        "Test Drive Checklist",
        "Vehicle History Check",
        "Red Flags to Avoid",
      ],
      "highlights": [
        "Professional inspection techniques",
        "Hidden problem detection",
        "Negotiation leverage points",
      ],
    },
    {
      "id": "3",
      "title": "Electric Vehicle Buying Guide 2024",
      "description": "Navigate the EV market with confidence",
      "category": "electric",
      "budget_range": "35k_50k",
      "difficulty": "intermediate",
      "reading_time": 18,
      "rating": 4.7,
      "reviews": 567,
      "author": "Emily Chen",
      "author_avatar": "https://picsum.photos/40/40?random=3&keyword=woman",
      "updated": "2024-06-18",
      "image": "https://picsum.photos/300/180?random=3&keyword=electric",
      "sections": [
        "EV Basics",
        "Range & Charging",
        "Federal & State Incentives",
        "Home Charging Setup",
        "Best EV Models 2024",
        "Total Cost Analysis",
      ],
      "highlights": [
        "Maximize tax incentives",
        "Choose the right range",
        "Future-proof your purchase",
      ],
    },
    {
      "id": "4",
      "title": "Car Financing & Loan Guide",
      "description": "Get the best auto loan rates and terms",
      "category": "financing",
      "budget_range": "20k_35k",
      "difficulty": "beginner",
      "reading_time": 10,
      "rating": 4.6,
      "reviews": 1123,
      "author": "David Park",
      "author_avatar": "https://picsum.photos/40/40?random=4&keyword=man",
      "updated": "2024-06-10",
      "image": "https://picsum.photos/300/180?random=4&keyword=finance",
      "sections": [
        "Credit Score Impact",
        "Loan Types",
        "Interest Rates",
        "Down Payment Strategy",
        "Dealer vs Bank Financing",
        "Refinancing Options",
      ],
      "highlights": [
        "Improve your credit score",
        "Compare financing options",
        "Save thousands on interest",
      ],
    },
    {
      "id": "5",
      "title": "Luxury Car Buying Strategy",
      "description": "Smart approach to buying luxury vehicles",
      "category": "luxury",
      "budget_range": "over_50k",
      "difficulty": "advanced",
      "reading_time": 20,
      "rating": 4.8,
      "reviews": 345,
      "author": "Alexandra Smith",
      "author_avatar": "https://picsum.photos/40/40?random=5&keyword=woman",
      "updated": "2024-06-14",
      "image": "https://picsum.photos/300/180?random=5&keyword=luxury",
      "sections": [
        "New vs Certified Pre-Owned",
        "Depreciation Strategies",
        "Warranty Considerations",
        "Maintenance Costs",
        "Resale Value Protection",
        "Premium Features Worth Paying For",
      ],
      "highlights": [
        "Minimize depreciation impact",
        "Certified pre-owned benefits",
        "Long-term value retention",
      ],
    },
    {
      "id": "6",
      "title": "Truck & SUV Buyer's Guide",
      "description": "Find the perfect truck or SUV for your needs",
      "category": "trucks_suvs",
      "budget_range": "35k_50k",
      "difficulty": "intermediate",
      "reading_time": 16,
      "rating": 4.7,
      "reviews": 789,
      "author": "Robert Johnson",
      "author_avatar": "https://picsum.photos/40/40?random=6&keyword=man",
      "updated": "2024-06-11",
      "image": "https://picsum.photos/300/180?random=6&keyword=truck",
      "sections": [
        "Size & Capacity Needs",
        "Towing Requirements",
        "Fuel Economy Considerations",
        "4WD vs AWD",
        "Best Models by Category",
        "Total Cost of Ownership",
      ],
      "highlights": [
        "Match size to actual needs",
        "Understand towing capacity",
        "Balance capability with efficiency",
      ],
    },
  ];

  List<Map<String, dynamic>> quickTips = [
    {
      "title": "Research Before You Shop",
      "description": "Know market prices, reviews, and reliability ratings",
      "icon": Icons.search,
      "color": primaryColor,
    },
    {
      "title": "Get Pre-Approved for Financing",
      "description": "Know your budget and leverage better rates",
      "icon": Icons.account_balance,
      "color": successColor,
    },
    {
      "title": "Always Get an Inspection",
      "description": "Professional inspection for used cars over \$5K",
      "icon": Icons.build,
      "color": warningColor,
    },
    {
      "title": "Don't Rush the Decision",
      "description": "Take time to compare options and think it over",
      "icon": Icons.schedule,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> buyingSteps = [
    {
      "step": 1,
      "title": "Determine Your Budget",
      "description": "Calculate total monthly costs including insurance, maintenance, and fuel",
      "icon": Icons.calculate,
      "completed": true,
    },
    {
      "step": 2,
      "title": "Research Vehicle Options",
      "description": "Compare models, read reviews, check reliability ratings",
      "icon": Icons.search,
      "completed": true,
    },
    {
      "step": 3,
      "title": "Secure Financing",
      "description": "Get pre-approved for loans to know your buying power",
      "icon": Icons.account_balance,
      "completed": false,
    },
    {
      "step": 4,
      "title": "Shop & Compare",
      "description": "Visit dealers, check online listings, compare prices",
      "icon": Icons.store,
      "completed": false,
    },
    {
      "step": 5,
      "title": "Inspect & Test Drive",
      "description": "Thoroughly inspect the vehicle and take an extended test drive",
      "icon": Icons.directions_car,
      "completed": false,
    },
    {
      "step": 6,
      "title": "Negotiate & Purchase",
      "description": "Negotiate price, review paperwork, complete the purchase",
      "icon": Icons.handshake,
      "completed": false,
    },
  ];

  List<Map<String, dynamic>> getFilteredGuides() {
    return buyingGuides.where((guide) {
      bool matchesCategory = selectedCategory.isEmpty || guide["category"] == selectedCategory;
      bool matchesBudget = selectedBudgetRange.isEmpty || guide["budget_range"] == selectedBudgetRange;
      bool matchesSearch = searchQuery.isEmpty || 
          guide["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          guide["description"].toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesBudget && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Car Buying Guides",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Guides", icon: Icon(Icons.menu_book)),
        Tab(text: "Quick Tips", icon: Icon(Icons.lightbulb)),
        Tab(text: "Process", icon: Icon(Icons.timeline)),
      ],
      tabChildren: [
        _buildGuidesTab(),
        _buildQuickTipsTab(),
        _buildProcessTab(),
      ],
    );
  }

  Widget _buildGuidesTab() {
    List<Map<String, dynamic>> filteredGuides = getFilteredGuides();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search Guides",
                  value: searchQuery,
                  hint: "Search by topic, keyword, or category",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: guideCategories,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Budget Range",
                        items: budgetRanges,
                        value: selectedBudgetRange,
                        onChanged: (value, label) {
                          selectedBudgetRange = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Results Count
          if (filteredGuides.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              child: Row(
                children: [
                  Text(
                    "Showing ${filteredGuides.length} guide${filteredGuides.length != 1 ? 's' : ''}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      searchQuery = "";
                      selectedCategory = "";
                      selectedBudgetRange = "";
                      setState(() {});
                    },
                    child: Text(
                      "Clear filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Guides List
          ...filteredGuides.map((guide) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Guide Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${guide["image"]}",
                        width: 80,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${guide["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${guide["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: guide["difficulty"] == "beginner" ? successColor :
                                         guide["difficulty"] == "intermediate" ? warningColor :
                                         dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${guide["difficulty"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Text(
                                "${guide["reading_time"]} min",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Rating and Author
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${guide["author_avatar"]}",
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${guide["author"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.star, color: warningColor, size: 16),
                    SizedBox(width: 2),
                    Text(
                      "${guide["rating"]}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${guide["reviews"]})",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Updated ${guide["updated"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Key Highlights
                Text(
                  "Key Highlights:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                ...(guide["highlights"] as List).map((highlight) => Padding(
                  padding: EdgeInsets.only(left: spSm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "$highlight",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),

                // Action Buttons
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Read Guide",
                        size: bs.sm,
                        onPressed: () {
                          si("Opening: ${guide["title"]}");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Save for Later",
                        size: bs.sm,
                        onPressed: () {
                          ss("Guide saved to your reading list");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),

          if (filteredGuides.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No guides found",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Try adjusting your search criteria or filters",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuickTipsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Essential Tips
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
                  "Essential Car Buying Tips",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...quickTips.map((tip) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: (tip["color"] as Color).withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: (tip["color"] as Color).withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: tip["color"],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          tip["icon"],
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${tip["title"]}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXxs),
                            Text(
                              "${tip["description"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),

          // Budget Calculator
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
                Row(
                  children: [
                    Icon(Icons.calculate, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Quick Budget Calculator",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "A good rule of thumb: your total monthly car expenses shouldn't exceed 20% of your take-home pay.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "\$3,500",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Monthly Income",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward, color: disabledBoldColor),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "\$700",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Car Budget (20%)",
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
                      Text(
                        "This includes loan payment, insurance, gas, and maintenance",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Open Full Calculator",
                    size: bs.sm,
                    onPressed: () {
                      si("Opening detailed budget calculator");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Common Mistakes to Avoid
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
                Row(
                  children: [
                    Icon(Icons.warning, color: dangerColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Common Mistakes to Avoid",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                ...List.generate(6, (index) {
                  List<String> mistakes = [
                    "Not getting pre-approved for financing",
                    "Focusing only on monthly payment",
                    "Skipping the vehicle inspection",
                    "Not researching market values",
                    "Buying more car than you need",
                    "Not factoring in insurance costs",
                  ];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: dangerColor.withAlpha(30)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.close,
                          color: dangerColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            mistakes[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // Negotiation Tips
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
                Row(
                  children: [
                    Icon(Icons.handshake, color: successColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Negotiation Tips",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                ...List.generate(5, (index) {
                  List<Map<String, String>> tips = [
                    {
                      "title": "Do Your Homework",
                      "desc": "Know the market value and have multiple quotes"
                    },
                    {
                      "title": "Negotiate Total Price",
                      "desc": "Focus on the total cost, not monthly payments"
                    },
                    {
                      "title": "Be Prepared to Walk Away",
                      "desc": "Your best negotiation tool is being willing to leave"
                    },
                    {
                      "title": "Time It Right",
                      "desc": "End of month/quarter often brings better deals"
                    },
                    {
                      "title": "Stay Professional",
                      "desc": "Be friendly but firm in your negotiations"
                    },
                  ];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(30)),
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
                              tips[index]["title"]!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: Text(
                            tips[index]["desc"]!,
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Process Overview
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
                  "Car Buying Process",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Follow this step-by-step process to make a smart car purchase. Track your progress as you go.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                LinearProgressIndicator(
                  value: 2 / buyingSteps.length,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
                SizedBox(height: spXs),
                Text(
                  "Progress: 2 of ${buyingSteps.length} steps completed",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Process Steps
          ...buyingSteps.map((step) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border.all(
                color: step["completed"] ? successColor : disabledOutlineBorderColor,
                width: step["completed"] ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: step["completed"] ? successColor : 
                           step["step"] == 3 ? primaryColor : disabledColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: step["completed"] 
                    ? Icon(Icons.check, color: Colors.white, size: 20)
                    : Center(
                        child: Text(
                          "${step["step"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${step["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: step["completed"] ? successColor : primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${step["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (!step["completed"] && step["step"] == 3)
                        Padding(
                          padding: EdgeInsets.only(top: spSm),
                          child: QButton(
                            label: "Start This Step",
                            size: bs.sm,
                            onPressed: () {
                              si("Starting step: ${step["title"]}");
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                if (step["completed"])
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 24,
                  ),
              ],
            ),
          )).toList(),

          // Resources & Tools
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
                Row(
                  children: [
                    Icon(Icons.build, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Helpful Tools & Resources",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                // Tools Grid
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.calculate, color: primaryColor, size: 28),
                            SizedBox(height: spXs),
                            Text(
                              "Payment Calculator",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
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
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.history, color: infoColor, size: 28),
                            SizedBox(height: spXs),
                            Text(
                              "Vehicle History",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.checklist, color: successColor, size: 28),
                            SizedBox(height: spXs),
                            Text(
                              "Inspection Checklist",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                              textAlign: TextAlign.center,
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
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.gavel, color: warningColor, size: 28),
                            SizedBox(height: spXs),
                            Text(
                              "Negotiation Guide",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View All Tools & Resources",
                    size: bs.md,
                    onPressed: () {
                      si("Opening tools and resources section");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Personal Progress Tracker
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
                Row(
                  children: [
                    Icon(Icons.bookmark, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Your Buying Journey",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Keep track of your car buying progress and save important information.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Save Progress",
                        size: bs.sm,
                        onPressed: () {
                          ss("Progress saved to your account");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "View Saved Cars",
                        size: bs.sm,
                        onPressed: () {
                          si("Opening your saved vehicles");
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
    );
  }
}
