import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaPartyPlanningView extends StatefulWidget {
  const FmaPartyPlanningView({super.key});

  @override
  State<FmaPartyPlanningView> createState() => _FmaPartyPlanningViewState();
}

class _FmaPartyPlanningViewState extends State<FmaPartyPlanningView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedPartyType = "all";
  String selectedStatus = "all";

  List<Map<String, dynamic>> partyPlans = [
    {
      "id": "PP001",
      "party_name": "Emma's Sweet 16",
      "client_name": "Jennifer Martinez",
      "party_type": "Birthday",
      "status": "Planning",
      "event_date": "2024-07-20",
      "event_time": "4:00 PM",
      "guests_count": 25,
      "age_group": "Teen",
      "theme": "Hollywood Glam",
      "venue": "Community Center Hall",
      "budget": 1800.00,
      "services": ["Catering", "Decorations", "DJ", "Photography"],
      "menu_style": "Buffet & Dessert Bar",
      "special_requirements": ["Nut-free options", "Vegetarian choices"],
      "entertainment": ["DJ with teen music", "Photo booth", "Dance floor"],
      "decorations": ["Gold & black balloons", "Red carpet entrance", "Hollywood backdrop"],
      "contact_phone": "+1 (555) 123-4567",
      "contact_email": "jennifer.martinez@email.com",
      "planning_progress": 65,
      "next_milestone": "Final menu confirmation",
      "assigned_planner": "Sarah Johnson"
    },
    {
      "id": "PP002",
      "party_name": "Johnson 25th Anniversary",
      "client_name": "Robert Johnson",
      "party_type": "Anniversary",
      "status": "Confirmed",
      "event_date": "2024-06-30",
      "event_time": "6:00 PM",
      "guests_count": 40,
      "age_group": "Adult",
      "theme": "Silver Elegance",
      "venue": "Garden Terrace Restaurant",
      "budget": 3200.00,
      "services": ["Catering", "Decorations", "Live Music", "Flowers"],
      "menu_style": "Plated Dinner",
      "special_requirements": ["Diabetic-friendly desserts"],
      "entertainment": ["Acoustic duo", "Anniversary slideshow", "Dancing"],
      "decorations": ["Silver tablecloths", "White roses", "Candle centerpieces"],
      "contact_phone": "+1 (555) 987-6543",
      "contact_email": "robert.johnson@email.com",
      "planning_progress": 90,
      "next_milestone": "Final headcount",
      "assigned_planner": "Michael Chen"
    },
    {
      "id": "PP003",
      "party_name": "Alex's Graduation Celebration",
      "client_name": "Maria Rodriguez",
      "party_type": "Graduation",
      "status": "Initial Planning",
      "event_date": "2024-08-15",
      "event_time": "2:00 PM",
      "guests_count": 35,
      "age_group": "Young Adult",
      "theme": "University Colors",
      "venue": "Backyard Garden",
      "budget": 2100.00,
      "services": ["Catering", "Tent Rental", "Sound System"],
      "menu_style": "BBQ & Picnic Style",
      "special_requirements": ["Outdoor setup", "Weather backup plan"],
      "entertainment": ["Playlist music", "Graduation speech setup", "Games"],
      "decorations": ["School banners", "Graduation caps", "Photo timeline"],
      "contact_phone": "+1 (555) 456-7890",
      "contact_email": "maria.rodriguez@email.com",
      "planning_progress": 25,
      "next_milestone": "Venue confirmation",
      "assigned_planner": "Lisa Wilson"
    },
    {
      "id": "PP004",
      "party_name": "Thompson Baby Shower",
      "client_name": "Ashley Thompson",
      "party_type": "Baby Shower",
      "status": "Completed",
      "event_date": "2024-06-10",
      "event_time": "1:00 PM",
      "guests_count": 20,
      "age_group": "Adult",
      "theme": "Little Prince",
      "venue": "Private Home",
      "budget": 950.00,
      "services": ["Catering", "Decorations", "Games"],
      "menu_style": "Light Lunch & Finger Foods",
      "special_requirements": ["Pregnancy-safe foods only"],
      "entertainment": ["Baby shower games", "Gift opening", "Photo session"],
      "decorations": ["Blue & gold theme", "Crown centerpieces", "Baby photos"],
      "contact_phone": "+1 (555) 234-5678",
      "contact_email": "ashley.thompson@email.com",
      "planning_progress": 100,
      "next_milestone": "Event completed",
      "assigned_planner": "Emma Davis"
    },
  ];

  List<Map<String, dynamic>> partyTypeItems = [
    {"label": "All Types", "value": "all"},
    {"label": "Birthday", "value": "Birthday"},
    {"label": "Anniversary", "value": "Anniversary"},
    {"label": "Graduation", "value": "Graduation"},
    {"label": "Baby Shower", "value": "Baby Shower"},
    {"label": "Retirement", "value": "Retirement"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Initial Planning", "value": "Initial Planning"},
    {"label": "Planning", "value": "Planning"},
    {"label": "Confirmed", "value": "Confirmed"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Party Planning",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Active Plans", icon: Icon(Icons.celebration)),
        Tab(text: "Templates", icon: Icon(Icons.library_books)),
        Tab(text: "Resources", icon: Icon(Icons.inventory_2)),
      ],
      tabChildren: [
        _buildPlansTab(),
        _buildTemplatesTab(),
        _buildResourcesTab(),
      ],
    );
  }

  Widget _buildPlansTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildPlansList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search party plans...",
                value: searchQuery,
                hint: "Search by party name, client, or plan ID",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.search,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QDropdownField(
                label: "Party Type",
                items: partyTypeItems,
                value: selectedPartyType,
                onChanged: (value, label) {
                  selectedPartyType = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QDropdownField(
                label: "Status",
                items: statusItems,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlansList() {
    return Column(
      spacing: spSm,
      children: partyPlans.map((plan) => _buildPlanCard(plan)).toList(),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    Color statusColor = _getStatusColor("${plan["status"]}");
    Color typeColor = _getPartyTypeColor("${plan["party_type"]}");
    double budget = plan["budget"] as double;
    int guestsCount = plan["guests_count"] as int;
    int progress = plan["planning_progress"] as int;
    List<String> services = (plan["services"] as List).cast<String>();
    List<String> entertainment = (plan["entertainment"] as List).cast<String>();
    List<String> decorations = (plan["decorations"] as List).cast<String>();
    List<String> specialRequirements = (plan["special_requirements"] as List).cast<String>();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: typeColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${plan["party_name"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${plan["id"]} • ${plan["theme"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: typeColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${plan["party_type"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: typeColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${plan["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${plan["client_name"]}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Icon(Icons.group, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "$guestsCount guests",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.calendar_today, size: 20, color: primaryColor),
                      SizedBox(height: spXs),
                      Text(
                        "${plan["event_date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${plan["event_time"]}",
                        style: TextStyle(
                          fontSize: 10,
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
                      Icon(Icons.location_on, size: 20, color: infoColor),
                      SizedBox(height: spXs),
                      Text(
                        "${plan["venue"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
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
                      Icon(Icons.attach_money, size: 20, color: successColor),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(budget / 1000).toStringAsFixed(1)}K",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Planning Progress",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "$progress%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: infoColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Next: ${plan["next_milestone"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: infoColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${plan["contact_phone"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.person_outline, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${plan["assigned_planner"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Services Included:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  children: services.map((service) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        service,
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Entertainment:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: entertainment.map((item) {
                    return Text(
                      "• $item",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Decorations:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: decorations.map((item) {
                    return Text(
                      "• $item",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          if (specialRequirements.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, size: 16, color: dangerColor),
                      SizedBox(width: spXs),
                      Text(
                        "Special Requirements:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: specialRequirements.map((req) {
                      return Text(
                        "• $req",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Full Plan",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Update Progress",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {},
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Birthday Party Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildTemplateItem(
                  "Kids Birthday (Ages 5-12)",
                  "Fun themes with entertainment and activities",
                  "\$800 - \$1,500",
                  ["Themed decorations", "Entertainment/Games", "Kid-friendly menu", "Birthday cake", "Party favors"],
                  primaryColor,
                ),
                _buildTemplateItem(
                  "Teen Birthday (Ages 13-17)",
                  "Modern themes with music and social activities",
                  "\$1,200 - \$2,500",
                  ["DJ/Music", "Photo booth", "Teen-appropriate menu", "Custom cake", "Social activities"],
                  infoColor,
                ),
                _buildTemplateItem(
                  "Adult Birthday (18+)",
                  "Elegant celebration with dining and entertainment",
                  "\$1,500 - \$3,500",
                  ["Cocktail hour", "Dinner service", "Live music/DJ", "Custom dessert", "Professional photography"],
                  successColor,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Anniversary Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildTemplateItem(
                  "Silver Anniversary (25 years)",
                  "Elegant silver-themed celebration",
                  "\$2,000 - \$4,000",
                  ["Silver decorations", "Memory slideshow", "Formal dinner", "Anniversary cake", "Live music"],
                  warningColor,
                ),
                _buildTemplateItem(
                  "Golden Anniversary (50 years)",
                  "Grand celebration with family focus",
                  "\$3,000 - \$6,000",
                  ["Gold theme decor", "Multi-generation seating", "Traditional menu", "Photo displays", "Special tributes"],
                  infoColor,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Special Occasion Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildTemplateItem(
                  "Graduation Party",
                  "Celebrate academic achievements",
                  "\$1,000 - \$2,500",
                  ["School colors theme", "Achievement displays", "Buffet dinner", "Graduate recognition", "Memory book"],
                  successColor,
                ),
                _buildTemplateItem(
                  "Retirement Party",
                  "Honor years of dedicated service",
                  "\$1,500 - \$3,000",
                  ["Career timeline", "Colleague speeches", "Dinner service", "Retirement gifts", "Photo memories"],
                  primaryColor,
                ),
                _buildTemplateItem(
                  "Baby Shower",
                  "Welcome the new arrival",
                  "\$600 - \$1,200",
                  ["Baby theme decor", "Shower games", "Light refreshments", "Gift opening area", "Keepsake activities"],
                  warningColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateItem(String title, String description, String priceRange, List<String> includes, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: color.withAlpha(50)),
        borderRadius: BorderRadius.circular(radiusSm),
        color: color.withAlpha(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                priceRange,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Includes:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: includes.map((item) {
              return Padding(
                padding: EdgeInsets.only(left: spSm, top: 2),
                child: Row(
                  children: [
                    Icon(Icons.check, size: 16, color: color),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spXs),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Use Template",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Vendor Partners",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildVendorItem("Elite Photography", "Professional event photography", "4.9", "+1 (555) 111-2222", primaryColor),
                _buildVendorItem("Sound & Lights Co.", "Audio/visual equipment rental", "4.8", "+1 (555) 333-4444", infoColor),
                _buildVendorItem("Flower Power", "Fresh floral arrangements", "4.7", "+1 (555) 555-6666", successColor),
                _buildVendorItem("Party Rentals Plus", "Tables, chairs, linens rental", "4.8", "+1 (555) 777-8888", warningColor),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Planning Checklist Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildChecklistItem("8 Weeks Before", ["Set date and budget", "Choose venue", "Create guest list", "Book major vendors"]),
                _buildChecklistItem("6 Weeks Before", ["Send invitations", "Plan menu", "Order decorations", "Confirm entertainment"]),
                _buildChecklistItem("4 Weeks Before", ["Finalize headcount", "Order cake", "Arrange seating", "Confirm all vendors"]),
                _buildChecklistItem("2 Weeks Before", ["Final details", "Prepare timeline", "Delegate tasks", "Confirm pickup/delivery"]),
                _buildChecklistItem("1 Week Before", ["Final confirmations", "Prepare day-of kit", "Brief all helpers", "Relax and enjoy!"]),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Budget Planning Tools",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildBudgetItem("Venue & Space", "30-40%", "Location rental, setup fees"),
                _buildBudgetItem("Food & Beverage", "25-35%", "Catering, drinks, cake"),
                _buildBudgetItem("Entertainment", "10-15%", "DJ, band, activities"),
                _buildBudgetItem("Decorations", "8-12%", "Flowers, balloons, linens"),
                _buildBudgetItem("Photography", "5-10%", "Professional photos/video"),
                _buildBudgetItem("Miscellaneous", "5-10%", "Invitations, favors, extras"),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Emergency Contact List",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildEmergencyContact("Event Manager", "Sarah Johnson", "+1 (555) 123-0001", Icons.person),
                _buildEmergencyContact("Kitchen Manager", "Marco Rodriguez", "+1 (555) 123-0002", Icons.restaurant),
                _buildEmergencyContact("Setup Crew Lead", "Mike Wilson", "+1 (555) 123-0003", Icons.construction),
                _buildEmergencyContact("Security", "Emergency Services", "+1 (555) 911-0000", Icons.security),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorItem(String name, String service, String rating, String phone, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(Icons.business, color: color, size: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  service,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  phone,
                  style: TextStyle(
                    fontSize: 11,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.star, size: 16, color: warningColor),
              SizedBox(width: 2),
              Text(
                rating,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String timeframe, List<String> tasks) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Text(
            timeframe,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tasks.map((task) {
              return Padding(
                padding: EdgeInsets.only(left: spSm, top: 2),
                child: Row(
                  children: [
                    Icon(Icons.check_box_outline_blank, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        task,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetItem(String category, String percentage, String description) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              percentage,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
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
    );
  }

  Widget _buildEmergencyContact(String role, String name, String phone, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Icon(icon, color: dangerColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.phone,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Initial Planning":
        return warningColor;
      case "Planning":
        return infoColor;
      case "Confirmed":
        return successColor;
      case "Completed":
        return primaryColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPartyTypeColor(String type) {
    switch (type) {
      case "Birthday":
        return primaryColor;
      case "Anniversary":
        return warningColor;
      case "Graduation":
        return successColor;
      case "Baby Shower":
        return infoColor;
      case "Retirement":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
