import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaSeasonalPlanningView extends StatefulWidget {
  const FmaSeasonalPlanningView({super.key});

  @override
  State<FmaSeasonalPlanningView> createState() => _FmaSeasonalPlanningViewState();
}

class _FmaSeasonalPlanningViewState extends State<FmaSeasonalPlanningView> {
  int selectedTab = 0;
  String selectedYear = "2024";
  String selectedSeason = "all";
  String selectedLocation = "all";

  List<Map<String, dynamic>> seasonalPlans = [
    {
      "id": "plan001",
      "season": "Spring",
      "year": 2024,
      "period": "March - May 2024",
      "status": "Active",
      "locations": 15,
      "budget": 125000,
      "spent": 78500,
      "revenue": 340000,
      "target": 320000,
      "campaigns": [
        {
          "name": "Spring Fresh Menu Launch",
          "type": "Product Launch",
          "budget": 45000,
          "status": "Running",
          "startDate": "2024-03-01",
          "endDate": "2024-05-31"
        },
        {
          "name": "Easter Special Promotion",
          "type": "Holiday Promotion",
          "budget": 25000,
          "status": "Completed",
          "startDate": "2024-03-25",
          "endDate": "2024-04-07"
        }
      ],
      "metrics": {
        "salesIncrease": 12.5,
        "footTraffic": 8.2,
        "customerSatisfaction": 4.3,
        "marketShare": 2.1
      },
      "challenges": [
        "Supply chain disruptions",
        "Weather-dependent sales",
        "Competition from seasonal rivals"
      ],
      "opportunities": [
        "Outdoor dining expansion",
        "Fresh ingredient sourcing",
        "Health-conscious menu items"
      ]
    },
    {
      "id": "plan002",
      "season": "Summer",
      "year": 2024,
      "period": "June - August 2024",
      "status": "Planning",
      "locations": 18,
      "budget": 180000,
      "spent": 0,
      "revenue": 0,
      "target": 450000,
      "campaigns": [
        {
          "name": "Summer BBQ Festival",
          "type": "Event Campaign",
          "budget": 65000,
          "status": "Planning",
          "startDate": "2024-06-15",
          "endDate": "2024-08-15"
        },
        {
          "name": "Ice Cream & Beverages Push",
          "type": "Product Focus",
          "budget": 35000,
          "status": "Scheduled",
          "startDate": "2024-07-01",
          "endDate": "2024-08-31"
        }
      ],
      "metrics": {
        "salesIncrease": 0,
        "footTraffic": 0,
        "customerSatisfaction": 0,
        "marketShare": 0
      },
      "challenges": [
        "Peak summer competition",
        "Staff scheduling for vacation season",
        "Temperature-sensitive products"
      ],
      "opportunities": [
        "Extended operating hours",
        "Catering for summer events",
        "Cold beverage specialization"
      ]
    },
    {
      "id": "plan003",
      "season": "Fall",
      "year": 2024,
      "period": "September - November 2024",
      "status": "Draft",
      "locations": 20,
      "budget": 140000,
      "spent": 0,
      "revenue": 0,
      "target": 380000,
      "campaigns": [
        {
          "name": "Back to School Campaign",
          "type": "Target Audience",
          "budget": 40000,
          "status": "Conceptual",
          "startDate": "2024-08-25",
          "endDate": "2024-10-15"
        },
        {
          "name": "Harvest Menu Introduction",
          "type": "Seasonal Menu",
          "budget": 55000,
          "status": "Development",
          "startDate": "2024-09-01",
          "endDate": "2024-11-30"
        }
      ],
      "metrics": {
        "salesIncrease": 0,
        "footTraffic": 0,
        "customerSatisfaction": 0,
        "marketShare": 0
      },
      "challenges": [
        "Seasonal ingredient availability",
        "Weather transition management",
        "Back-to-school competition"
      ],
      "opportunities": [
        "Comfort food positioning",
        "Educational institution partnerships",
        "Seasonal flavor innovations"
      ]
    }
  ];

  List<Map<String, dynamic>> seasonalTrends = [
    {
      "season": "Spring",
      "peakMonths": ["April", "May"],
      "avgSalesIncrease": 15.2,
      "topCategories": ["Salads", "Light Meals", "Fresh Juices"],
      "customerBehavior": "Health-conscious choices, outdoor dining preference",
      "marketingFocus": "Fresh ingredients, renewal themes, Easter promotions",
      "historicalData": {
        "2023": {"sales": 280000, "traffic": 12500, "satisfaction": 4.1},
        "2022": {"sales": 245000, "traffic": 11800, "satisfaction": 4.0},
        "2021": {"sales": 220000, "traffic": 10900, "satisfaction": 3.9}
      }
    },
    {
      "season": "Summer",
      "peakMonths": ["July", "August"],
      "avgSalesIncrease": 22.8,
      "topCategories": ["Ice Cream", "Cold Beverages", "BBQ Items"],
      "customerBehavior": "Extended hours dining, family gatherings, impulse purchases",
      "marketingFocus": "Cooling products, outdoor events, vacation themes",
      "historicalData": {
        "2023": {"sales": 420000, "traffic": 18200, "satisfaction": 4.4},
        "2022": {"sales": 385000, "traffic": 16800, "satisfaction": 4.2},
        "2021": {"sales": 340000, "traffic": 15500, "satisfaction": 4.1}
      }
    },
    {
      "season": "Fall",
      "peakMonths": ["October", "November"],
      "avgSalesIncrease": 8.7,
      "topCategories": ["Warm Beverages", "Comfort Food", "Seasonal Specials"],
      "customerBehavior": "Comfort-seeking, indoor dining return, holiday preparation",
      "marketingFocus": "Warmth themes, harvest ingredients, back-to-school",
      "historicalData": {
        "2023": {"sales": 310000, "traffic": 13800, "satisfaction": 4.2},
        "2022": {"sales": 295000, "traffic": 13200, "satisfaction": 4.1},
        "2021": {"sales": 275000, "traffic": 12600, "satisfaction": 4.0}
      }
    },
    {
      "season": "Winter",
      "peakMonths": ["December", "January"],
      "avgSalesIncrease": 18.5,
      "topCategories": ["Hot Beverages", "Hearty Meals", "Holiday Items"],
      "customerBehavior": "Holiday celebrations, gift purchases, comfort focus",
      "marketingFocus": "Holiday themes, warmth messaging, family gatherings",
      "historicalData": {
        "2023": {"sales": 380000, "traffic": 15200, "satisfaction": 4.3},
        "2022": {"sales": 350000, "traffic": 14500, "satisfaction": 4.2},
        "2021": {"sales": 320000, "traffic": 13800, "satisfaction": 4.1}
      }
    }
  ];

  List<Map<String, dynamic>> campaigns = [
    {
      "id": "camp001",
      "name": "Spring Renewal Campaign",
      "season": "Spring",
      "type": "Seasonal Menu",
      "status": "Active",
      "budget": 45000,
      "spent": 32500,
      "startDate": "2024-03-01",
      "endDate": "2024-05-31",
      "locations": ["Downtown", "Mall Plaza", "University Area"],
      "targetAudience": "Health-conscious millennials",
      "channels": ["Social Media", "In-store", "Email"],
      "kpis": {
        "reach": 125000,
        "engagement": 8.5,
        "conversion": 3.2,
        "roi": 280
      },
      "assets": [
        "Fresh ingredient photography",
        "Spring color palette branding",
        "Outdoor dining visuals"
      ]
    },
    {
      "id": "camp002",
      "name": "Summer BBQ Extravaganza",
      "season": "Summer",
      "type": "Event Campaign",
      "status": "Scheduled",
      "budget": 65000,
      "spent": 0,
      "startDate": "2024-06-15",
      "endDate": "2024-08-15",
      "locations": ["All Locations"],
      "targetAudience": "Families and young adults",
      "channels": ["TV", "Radio", "Social Media", "Outdoor"],
      "kpis": {
        "reach": 200000,
        "engagement": 0,
        "conversion": 0,
        "roi": 0
      },
      "assets": [
        "BBQ product photography",
        "Summer lifestyle imagery",
        "Event promotional materials"
      ]
    },
    {
      "id": "camp003",
      "name": "Cozy Fall Comfort",
      "season": "Fall",
      "type": "Seasonal Menu",
      "status": "Development",
      "budget": 38000,
      "spent": 0,
      "startDate": "2024-09-01",
      "endDate": "2024-11-30",
      "locations": ["Downtown", "Suburban Centers"],
      "targetAudience": "Working professionals and families",
      "channels": ["Email", "In-store", "Social Media"],
      "kpis": {
        "reach": 0,
        "engagement": 0,
        "conversion": 0,
        "roi": 0
      },
      "assets": [
        "Autumn color schemes",
        "Comfort food photography",
        "Warm ambiance visuals"
      ]
    }
  ];

  List<Map<String, dynamic>> seasonalInventory = [
    {
      "category": "Spring Items",
      "items": [
        {"name": "Fresh Salad Mix", "demandIncrease": 45, "stockLevel": "High"},
        {"name": "Light Dressings", "demandIncrease": 32, "stockLevel": "Medium"},
        {"name": "Seasonal Fruits", "demandIncrease": 28, "stockLevel": "Medium"},
        {"name": "Herbal Teas", "demandIncrease": 18, "stockLevel": "Low"}
      ],
      "totalInvestment": 85000,
      "peakDemandPeriod": "April - May"
    },
    {
      "category": "Summer Items",
      "items": [
        {"name": "Ice Cream Products", "demandIncrease": 180, "stockLevel": "Planning"},
        {"name": "Cold Beverages", "demandIncrease": 95, "stockLevel": "Planning"},
        {"name": "BBQ Ingredients", "demandIncrease": 65, "stockLevel": "Planning"},
        {"name": "Fresh Produce", "demandIncrease": 40, "stockLevel": "Planning"}
      ],
      "totalInvestment": 145000,
      "peakDemandPeriod": "July - August"
    },
    {
      "category": "Fall Items",
      "items": [
        {"name": "Warm Beverages", "demandIncrease": 55, "stockLevel": "Planning"},
        {"name": "Comfort Foods", "demandIncrease": 42, "stockLevel": "Planning"},
        {"name": "Seasonal Spices", "demandIncrease": 38, "stockLevel": "Planning"},
        {"name": "Hearty Soups", "demandIncrease": 48, "stockLevel": "Planning"}
      ],
      "totalInvestment": 95000,
      "peakDemandPeriod": "October - November"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Seasonal Planning",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.calendar_today)),
        Tab(text: "Plans", icon: Icon(Icons.event_note)),
        Tab(text: "Campaigns", icon: Icon(Icons.campaign)),
        Tab(text: "Inventory", icon: Icon(Icons.inventory)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildPlansTab(),
        _buildCampaignsTab(),
        _buildInventoryTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Current Season Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(204)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Current Season: Spring 2024",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "March - May 2024 • 15 Locations Active",
                  style: TextStyle(
                    color: Colors.white.withAlpha(230),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Budget Progress",
                            style: TextStyle(
                              color: Colors.white.withAlpha(230),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "\$78.5K / \$125K",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Revenue vs Target",
                            style: TextStyle(
                              color: Colors.white.withAlpha(230),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "\$340K / \$320K",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Seasonal Performance Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Active Campaigns", "5", Icons.campaign, successColor),
              _buildMetricCard("Sales Growth", "+12.5%", Icons.trending_up, primaryColor),
              _buildMetricCard("Customer Satisfaction", "4.3/5", Icons.star, warningColor),
              _buildMetricCard("Market Share", "+2.1%", Icons.pie_chart, infoColor),
            ],
          ),

          // Seasonal Trends Overview
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
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
                  "Seasonal Performance Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...seasonalTrends.map((trend) => _buildTrendSummaryCard(trend)),
              ],
            ),
          ),

          // Upcoming Planning
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
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
                    Icon(Icons.schedule, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Upcoming Seasonal Milestones",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                _buildMilestoneItem("Summer Campaign Launch", "June 15, 2024", "15 days", warningColor),
                _buildMilestoneItem("Fall Menu Development", "July 1, 2024", "31 days", infoColor),
                _buildMilestoneItem("Holiday Planning Start", "August 15, 2024", "76 days", successColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlansTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Year",
                  items: [
                    {"label": "2024", "value": "2024"},
                    {"label": "2025", "value": "2025"},
                  ],
                  value: selectedYear,
                  onChanged: (value, label) {
                    selectedYear = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Season",
                  items: [
                    {"label": "All Seasons", "value": "all"},
                    {"label": "Spring", "value": "spring"},
                    {"label": "Summer", "value": "summer"},
                    {"label": "Fall", "value": "fall"},
                    {"label": "Winter", "value": "winter"},
                  ],
                  value: selectedSeason,
                  onChanged: (value, label) {
                    selectedSeason = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Seasonal Plans
          ...seasonalPlans.map((plan) => _buildSeasonalPlanCard(plan)),
        ],
      ),
    );
  }

  Widget _buildCampaignsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Campaign Performance Summary
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Active Campaigns", "3", Icons.play_circle, successColor),
              _buildMetricCard("Total Reach", "325K", Icons.visibility, primaryColor),
              _buildMetricCard("Avg. ROI", "280%", Icons.trending_up, warningColor),
              _buildMetricCard("Campaign Budget", "\$148K", Icons.attach_money, infoColor),
            ],
          ),

          // Campaigns List
          ...campaigns.map((campaign) => _buildCampaignCard(campaign)),
        ],
      ),
    );
  }

  Widget _buildInventoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Inventory Overview
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
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
                  "Seasonal Inventory Planning",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Strategic inventory management for seasonal demand fluctuations",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Inventory Categories
          ...seasonalInventory.map((category) => _buildInventoryCategoryCard(category)),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendSummaryCard(Map<String, dynamic> trend) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getSeasonColor(trend["season"]).withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getSeasonIcon(trend["season"]),
              color: _getSeasonColor(trend["season"]),
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${trend["season"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Avg. Sales: +${(trend["avgSalesIncrease"] as num).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Peak: ${(trend["peakMonths"] as List).join(", ")}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$${((trend["historicalData"]["2023"]["sales"] as num).toDouble() / 1000).toInt()}K",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneItem(String title, String date, String countdown, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              countdown,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonalPlanCard(Map<String, dynamic> plan) {
    Color statusColor = plan["status"] == "Active" ? successColor :
                       plan["status"] == "Planning" ? warningColor : infoColor;
    
    double budgetProgress = (plan["spent"] as num) / (plan["budget"] as num);
    double revenueProgress = plan["revenue"] > 0 ? (plan["revenue"] as num) / (plan["target"] as num) : 0;

    return Container(
      padding: EdgeInsets.all(spMd),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: _getSeasonColor(plan["season"]).withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getSeasonIcon(plan["season"]),
                  color: _getSeasonColor(plan["season"]),
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${plan["season"]} ${plan["year"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${plan["period"]} • ${plan["locations"]} Locations",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${plan["status"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Budget and Revenue Progress
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Budget Progress",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${(budgetProgress * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: budgetProgress,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((plan["spent"] as num).toDouble()).currency} / \$${((plan["budget"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Revenue Progress",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          revenueProgress > 0 ? "${(revenueProgress * 100).toInt()}%" : "0%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: revenueProgress,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(successColor),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((plan["revenue"] as num).toDouble()).currency} / \$${((plan["target"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Performance Metrics (if available)
          if (plan["status"] == "Active" && (plan["metrics"]["salesIncrease"] as num) > 0)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Sales Growth",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "+${(plan["metrics"]["salesIncrease"] as num).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Foot Traffic",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "+${(plan["metrics"]["footTraffic"] as num).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Satisfaction",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(plan["metrics"]["customerSatisfaction"] as num).toStringAsFixed(1)}/5",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Campaigns
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Active Campaigns (${(plan["campaigns"] as List).length})",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              ...(plan["campaigns"] as List).map((campaign) => 
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.only(right: spXs),
                        decoration: BoxDecoration(
                          color: campaign["status"] == "Running" ? successColor :
                                 campaign["status"] == "Completed" ? primaryColor : warningColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${campaign["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "${campaign["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: campaign["status"] == "Running" ? successColor :
                                 campaign["status"] == "Completed" ? primaryColor : warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "View Detailed Plan",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
    Color statusColor = campaign["status"] == "Active" ? successColor :
                       campaign["status"] == "Scheduled" ? warningColor :
                       campaign["status"] == "Development" ? infoColor : primaryColor;

    double budgetProgress = (campaign["spent"] as num) / (campaign["budget"] as num);

    return Container(
      padding: EdgeInsets.all(spMd),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(Icons.campaign, color: statusColor, size: 20),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${campaign["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${campaign["type"]} • ${campaign["season"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${campaign["status"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Campaign Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Duration",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${campaign["startDate"]} - ${campaign["endDate"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Target Audience",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${campaign["targetAudience"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Budget Progress
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Budget Utilization",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${(budgetProgress * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              LinearProgressIndicator(
                value: budgetProgress,
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              ),
              SizedBox(height: spXs),
              Text(
                "\$${((campaign["spent"] as num).toDouble()).currency} / \$${((campaign["budget"] as num).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          // KPIs (if available)
          if (campaign["status"] == "Active" && (campaign["kpis"]["reach"] as num) > 0)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Reach",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${((campaign["kpis"]["reach"] as num) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Engagement",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(campaign["kpis"]["engagement"] as num).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "ROI",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${campaign["kpis"]["roi"]}%",
                          style: TextStyle(
                            fontSize: 14,
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

          // Channels
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Marketing Channels",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (campaign["channels"] as List).map((channel) =>
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$channel",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ],
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Manage Campaign",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryCategoryCard(Map<String, dynamic> category) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(Icons.inventory, color: primaryColor, size: 20),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${category["category"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Peak: ${category["peakDemandPeriod"]} • Investment: \$${((category["totalInvestment"] as num).toDouble()).currency}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Inventory Items
          Column(
            children: (category["items"] as List).map((item) {
              Color stockColor = item["stockLevel"] == "High" ? successColor :
                               item["stockLevel"] == "Medium" ? warningColor :
                               item["stockLevel"] == "Low" ? dangerColor : infoColor;

              return Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spXs),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Demand Increase: +${item["demandIncrease"]}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: stockColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["stockLevel"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
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

  Color _getSeasonColor(String season) {
    switch (season) {
      case "Spring":
        return successColor;
      case "Summer":
        return warningColor;
      case "Fall":
        return dangerColor;
      case "Winter":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData _getSeasonIcon(String season) {
    switch (season) {
      case "Spring":
        return Icons.wb_sunny;
      case "Summer":
        return Icons.beach_access;
      case "Fall":
        return Icons.nature;
      case "Winter":
        return Icons.ac_unit;
      default:
        return Icons.calendar_today;
    }
  }
}
