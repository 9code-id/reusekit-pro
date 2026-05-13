import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaHolidayPlanningView extends StatefulWidget {
  const FmaHolidayPlanningView({super.key});

  @override
  State<FmaHolidayPlanningView> createState() => _FmaHolidayPlanningViewState();
}

class _FmaHolidayPlanningViewState extends State<FmaHolidayPlanningView> {
  int selectedTab = 0;
  String selectedYear = "2024";
  String selectedHoliday = "all";
  String selectedRegion = "all";

  List<Map<String, dynamic>> holidayPlans = [
    {
      "id": "holiday001",
      "name": "Easter Celebration",
      "type": "Religious Holiday",
      "date": "2024-03-31",
      "duration": "March 25 - April 7, 2024",
      "status": "Completed",
      "locations": 12,
      "budget": 45000,
      "spent": 43200,
      "revenue": 128000,
      "target": 115000,
      "customerIncrease": 18.5,
      "campaigns": [
        {
          "name": "Easter Egg Hunt Event",
          "type": "Family Event",
          "budget": 15000,
          "reach": 25000,
          "engagement": 12.5
        },
        {
          "name": "Spring Menu Launch",
          "type": "Product Launch",
          "budget": 20000,
          "reach": 45000,
          "engagement": 8.7
        }
      ],
      "specialOffers": [
        "Buy 2 Get 1 Free Family Meals",
        "Easter Dessert Combo Special",
        "Kids Eat Free on Sundays"
      ],
      "staffingAdjustments": {
        "additionalStaff": 25,
        "extendedHours": "8am - 11pm",
        "overtimeBudget": 8500
      }
    },
    {
      "id": "holiday002",
      "name": "Independence Day",
      "type": "National Holiday",
      "date": "2024-07-04",
      "duration": "July 1 - July 7, 2024",
      "status": "Planning",
      "locations": 18,
      "budget": 75000,
      "spent": 12000,
      "revenue": 0,
      "target": 185000,
      "customerIncrease": 0,
      "campaigns": [
        {
          "name": "Red, White & Blue BBQ",
          "type": "Patriotic Campaign",
          "budget": 35000,
          "reach": 0,
          "engagement": 0
        },
        {
          "name": "Fireworks Viewing Party",
          "type": "Event Campaign",
          "budget": 25000,
          "reach": 0,
          "engagement": 0
        }
      ],
      "specialOffers": [
        "Patriotic Combo Meals",
        "Military Families 20% Discount",
        "Fireworks Special Desserts"
      ],
      "staffingAdjustments": {
        "additionalStaff": 40,
        "extendedHours": "10am - 12am",
        "overtimeBudget": 15000
      }
    },
    {
      "id": "holiday003",
      "name": "Christmas Season",
      "type": "Major Holiday",
      "date": "2024-12-25",
      "duration": "December 1 - January 2, 2025",
      "status": "Early Planning",
      "locations": 25,
      "budget": 150000,
      "spent": 0,
      "revenue": 0,
      "target": 420000,
      "customerIncrease": 0,
      "campaigns": [
        {
          "name": "12 Days of Christmas Deals",
          "type": "Progressive Campaign",
          "budget": 60000,
          "reach": 0,
          "engagement": 0
        },
        {
          "name": "Holiday Catering Services",
          "type": "Service Expansion",
          "budget": 40000,
          "reach": 0,
          "engagement": 0
        }
      ],
      "specialOffers": [
        "Christmas Family Feast Packages",
        "Holiday Gift Cards with Bonus",
        "New Year's Party Catering"
      ],
      "staffingAdjustments": {
        "additionalStaff": 60,
        "extendedHours": "7am - 1am",
        "overtimeBudget": 25000
      }
    },
    {
      "id": "holiday004",
      "name": "Valentine's Day",
      "type": "Romantic Holiday",
      "date": "2024-02-14",
      "duration": "February 12 - February 16, 2024",
      "status": "Completed",
      "locations": 8,
      "budget": 28000,
      "spent": 26500,
      "revenue": 85000,
      "target": 75000,
      "customerIncrease": 22.3,
      "campaigns": [
        {
          "name": "Date Night Special Menu",
          "type": "Romantic Campaign",
          "budget": 18000,
          "reach": 32000,
          "engagement": 15.2
        }
      ],
      "specialOffers": [
        "Couples Dinner for Two",
        "Heart-Shaped Desserts",
        "Romantic Ambiance Upgrade"
      ],
      "staffingAdjustments": {
        "additionalStaff": 15,
        "extendedHours": "5pm - 11pm",
        "overtimeBudget": 4500
      }
    }
  ];

  List<Map<String, dynamic>> holidayCalendar = [
    {
      "month": "January",
      "holidays": [
        {"name": "New Year's Day", "date": "2024-01-01", "impact": "High", "type": "National"},
        {"name": "Martin Luther King Jr. Day", "date": "2024-01-15", "impact": "Low", "type": "Federal"}
      ]
    },
    {
      "month": "February",
      "holidays": [
        {"name": "Valentine's Day", "date": "2024-02-14", "impact": "High", "type": "Cultural"},
        {"name": "Presidents Day", "date": "2024-02-19", "impact": "Medium", "type": "Federal"}
      ]
    },
    {
      "month": "March",
      "holidays": [
        {"name": "St. Patrick's Day", "date": "2024-03-17", "impact": "Medium", "type": "Cultural"},
        {"name": "Easter", "date": "2024-03-31", "impact": "High", "type": "Religious"}
      ]
    },
    {
      "month": "April",
      "holidays": [
        {"name": "Easter Monday", "date": "2024-04-01", "impact": "Medium", "type": "Religious"}
      ]
    },
    {
      "month": "May",
      "holidays": [
        {"name": "Mother's Day", "date": "2024-05-12", "impact": "High", "type": "Cultural"},
        {"name": "Memorial Day", "date": "2024-05-27", "impact": "High", "type": "Federal"}
      ]
    },
    {
      "month": "June",
      "holidays": [
        {"name": "Father's Day", "date": "2024-06-16", "impact": "High", "type": "Cultural"}
      ]
    },
    {
      "month": "July",
      "holidays": [
        {"name": "Independence Day", "date": "2024-07-04", "impact": "High", "type": "National"}
      ]
    },
    {
      "month": "September",
      "holidays": [
        {"name": "Labor Day", "date": "2024-09-02", "impact": "High", "type": "Federal"}
      ]
    },
    {
      "month": "October",
      "holidays": [
        {"name": "Halloween", "date": "2024-10-31", "impact": "Medium", "type": "Cultural"}
      ]
    },
    {
      "month": "November",
      "holidays": [
        {"name": "Thanksgiving", "date": "2024-11-28", "impact": "High", "type": "National"},
        {"name": "Black Friday", "date": "2024-11-29", "impact": "Medium", "type": "Commercial"}
      ]
    },
    {
      "month": "December",
      "holidays": [
        {"name": "Christmas Eve", "date": "2024-12-24", "impact": "High", "type": "Religious"},
        {"name": "Christmas Day", "date": "2024-12-25", "impact": "High", "type": "Religious"},
        {"name": "New Year's Eve", "date": "2024-12-31", "impact": "High", "type": "Cultural"}
      ]
    }
  ];

  List<Map<String, dynamic>> operationalAdjustments = [
    {
      "holiday": "Christmas Season",
      "period": "December 1 - January 2",
      "adjustments": [
        {
          "category": "Staffing",
          "details": [
            "60 additional seasonal staff",
            "Extended hours: 7am - 1am",
            "Overtime budget: \$25,000",
            "Holiday pay premium: 1.5x"
          ]
        },
        {
          "category": "Inventory",
          "details": [
            "200% increase in holiday menu items",
            "Special packaging for gift orders",
            "Extended storage for catering supplies",
            "Backup supplier agreements"
          ]
        },
        {
          "category": "Operations",
          "details": [
            "Dedicated catering preparation area",
            "Extended delivery radius",
            "Priority reservation system",
            "Enhanced cleaning protocols"
          ]
        }
      ]
    },
    {
      "holiday": "Independence Day",
      "period": "July 1 - July 7",
      "adjustments": [
        {
          "category": "Staffing",
          "details": [
            "40 additional event staff",
            "Extended hours: 10am - 12am",
            "Event coordination team",
            "Security personnel for events"
          ]
        },
        {
          "category": "Inventory",
          "details": [
            "BBQ and grilling supplies stock-up",
            "Patriotic decorations and supplies",
            "Cold beverage inventory increase",
            "Ice and cooling equipment rental"
          ]
        },
        {
          "category": "Operations",
          "details": [
            "Outdoor event setup capabilities",
            "Sound system and entertainment",
            "Traffic management for events",
            "Waste management enhancement"
          ]
        }
      ]
    }
  ];

  List<Map<String, dynamic>> performanceMetrics = [
    {
      "holiday": "Valentine's Day 2024",
      "performance": {
        "revenueIncrease": 22.3,
        "customerTrafficIncrease": 18.7,
        "averageOrderValue": 45.20,
        "customerSatisfaction": 4.6,
        "repeatCustomers": 68.5
      },
      "topPerformingItems": [
        {"item": "Romantic Dinner for Two", "sales": 234, "revenue": 11700},
        {"item": "Heart-Shaped Desserts", "sales": 156, "revenue": 3120},
        {"item": "Premium Wine Selection", "sales": 89, "revenue": 2670}
      ],
      "campaignEffectiveness": {
        "socialMedia": 15.2,
        "emailMarketing": 12.8,
        "inStore": 9.5
      }
    },
    {
      "holiday": "Easter 2024",
      "performance": {
        "revenueIncrease": 18.5,
        "customerTrafficIncrease": 25.3,
        "averageOrderValue": 38.90,
        "customerSatisfaction": 4.3,
        "repeatCustomers": 72.1
      },
      "topPerformingItems": [
        {"item": "Easter Family Feast", "sales": 312, "revenue": 18720},
        {"item": "Egg Hunt Special Menu", "sales": 189, "revenue": 5670},
        {"item": "Spring Dessert Collection", "sales": 267, "revenue": 8010}
      ],
      "campaignEffectiveness": {
        "familyEvents": 18.7,
        "socialMedia": 11.2,
        "communityPartnerships": 8.9
      }
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Holiday Planning",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.celebration)),
        Tab(text: "Holiday Plans", icon: Icon(Icons.event)),
        Tab(text: "Calendar", icon: Icon(Icons.calendar_month)),
        Tab(text: "Operations", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildHolidayPlansTab(),
        _buildCalendarTab(),
        _buildOperationsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Holiday Planning Summary
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
                Row(
                  children: [
                    Icon(Icons.celebration, color: Colors.white, size: 24),
                    SizedBox(width: spXs),
                    Text(
                      "Holiday Planning Dashboard",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Strategic planning and execution for major holidays and seasonal events",
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
                            "Active Holiday Plans",
                            style: TextStyle(
                              color: Colors.white.withAlpha(230),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "8 Events Planned",
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
                            "Total Holiday Budget",
                            style: TextStyle(
                              color: Colors.white.withAlpha(230),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "\$298K Allocated",
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

          // Key Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Completed Events", "2", Icons.check_circle, successColor),
              _buildMetricCard("Revenue Generated", "\$213K", Icons.attach_money, primaryColor),
              _buildMetricCard("Avg. Sales Increase", "+20.4%", Icons.trending_up, warningColor),
              _buildMetricCard("Customer Satisfaction", "4.5/5", Icons.star, infoColor),
            ],
          ),

          // Recent Holiday Performance
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
                  "Recent Holiday Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...performanceMetrics.map((metric) => _buildPerformanceSummaryCard(metric)),
              ],
            ),
          ),

          // Upcoming Holidays
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
                    Icon(Icons.upcoming, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Upcoming Holiday Priorities",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                _buildUpcomingHolidayItem("Independence Day", "July 4, 2024", "45 days", dangerColor),
                _buildUpcomingHolidayItem("Labor Day", "September 2, 2024", "105 days", warningColor),
                _buildUpcomingHolidayItem("Halloween", "October 31, 2024", "164 days", infoColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHolidayPlansTab() {
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
                  label: "Holiday Type",
                  items: [
                    {"label": "All Holidays", "value": "all"},
                    {"label": "Major Holidays", "value": "major"},
                    {"label": "Religious", "value": "religious"},
                    {"label": "Cultural", "value": "cultural"},
                    {"label": "National", "value": "national"},
                  ],
                  value: selectedHoliday,
                  onChanged: (value, label) {
                    selectedHoliday = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Holiday Plans List
          ...holidayPlans.map((plan) => _buildHolidayPlanCard(plan)),
        ],
      ),
    );
  }

  Widget _buildCalendarTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Calendar Overview
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
                  "2024 Holiday Calendar",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Strategic holidays and events that impact franchise operations",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Monthly Holiday Breakdown
          ...holidayCalendar.map((month) => _buildMonthlyHolidayCard(month)),
        ],
      ),
    );
  }

  Widget _buildOperationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Operational Planning Overview
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
                    Icon(Icons.settings, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Holiday Operations Management",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Operational adjustments and resource planning for holiday periods",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Operational Adjustments
          ...operationalAdjustments.map((adjustment) => _buildOperationalAdjustmentCard(adjustment)),
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

  Widget _buildPerformanceSummaryCard(Map<String, dynamic> metric) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${metric["holiday"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Completed",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Revenue Growth",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "+${(metric["performance"]["revenueIncrease"] as num).toStringAsFixed(1)}%",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Customer Traffic",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "+${(metric["performance"]["customerTrafficIncrease"] as num).toStringAsFixed(1)}%",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Satisfaction",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(metric["performance"]["customerSatisfaction"] as num).toStringAsFixed(1)}/5",
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
        ],
      ),
    );
  }

  Widget _buildUpcomingHolidayItem(String holiday, String date, String countdown, Color color) {
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
                  holiday,
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

  Widget _buildHolidayPlanCard(Map<String, dynamic> plan) {
    Color statusColor = plan["status"] == "Completed" ? successColor :
                       plan["status"] == "Planning" ? warningColor :
                       plan["status"] == "Early Planning" ? infoColor : primaryColor;

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
                  color: _getHolidayColor(plan["type"]).withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getHolidayIcon(plan["type"]),
                  color: _getHolidayColor(plan["type"]),
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${plan["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${plan["type"]} • ${plan["duration"]}",
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

          // Key Metrics Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Locations",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${plan["locations"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                      "Budget",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((plan["budget"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                      "Target Revenue",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((plan["target"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Progress Bars (only for active/completed plans)
          if (plan["status"] != "Early Planning")
            Column(
              spacing: spSm,
              children: [
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
                      valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                    ),
                  ],
                ),

                // Revenue Progress (only for completed)
                if (plan["status"] == "Completed")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Revenue Achievement",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${(revenueProgress * 100).toInt()}%",
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
                    ],
                  ),
              ],
            ),

          // Customer Increase (if available)
          if ((plan["customerIncrease"] as num) > 0)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.trending_up, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Customer Increase: +${(plan["customerIncrease"] as num).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: successColor,
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
                "Marketing Campaigns (${(plan["campaigns"] as List).length})",
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
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${campaign["name"]} (${campaign["type"]})",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${((campaign["budget"] as num).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Special Offers
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Special Offers",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              ...(plan["specialOffers"] as List).take(3).map((offer) =>
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1),
                  child: Row(
                    children: [
                      Icon(Icons.local_offer, color: warningColor, size: 12),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "$offer",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
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

  Widget _buildMonthlyHolidayCard(Map<String, dynamic> month) {
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
                child: Icon(Icons.calendar_month, color: primaryColor, size: 20),
              ),
              SizedBox(width: spSm),
              Text(
                "${month["month"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${(month["holidays"] as List).length} Holidays",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          // Holidays List
          ...(month["holidays"] as List).map((holiday) {
            Color impactColor = holiday["impact"] == "High" ? dangerColor :
                              holiday["impact"] == "Medium" ? warningColor : successColor;

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
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _getHolidayTypeColor(holiday["type"]),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${holiday["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${holiday["date"]} • ${holiday["type"]}",
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
                      color: impactColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${holiday["impact"]} Impact",
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
          }),
        ],
      ),
    );
  }

  Widget _buildOperationalAdjustmentCard(Map<String, dynamic> adjustment) {
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
                child: Icon(Icons.settings, color: primaryColor, size: 20),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${adjustment["holiday"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Period: ${adjustment["period"]}",
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

          // Adjustment Categories
          ...(adjustment["adjustments"] as List).map((category) =>
            Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getCategoryIcon(category["category"]),
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${category["category"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...(category["details"] as List).map((detail) =>
                    Padding(
                      padding: EdgeInsets.only(left: spMd, bottom: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            margin: EdgeInsets.only(top: 6, right: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getHolidayColor(String type) {
    switch (type) {
      case "Major Holiday":
        return dangerColor;
      case "Religious Holiday":
        return primaryColor;
      case "National Holiday":
        return warningColor;
      case "Cultural":
        return successColor;
      case "Romantic Holiday":
        return Colors.pink;
      default:
        return infoColor;
    }
  }

  IconData _getHolidayIcon(String type) {
    switch (type) {
      case "Major Holiday":
        return Icons.celebration;
      case "Religious Holiday":
        return Icons.church;
      case "National Holiday":
        return Icons.flag;
      case "Cultural":
        return Icons.people;
      case "Romantic Holiday":
        return Icons.favorite;
      default:
        return Icons.event;
    }
  }

  Color _getHolidayTypeColor(String type) {
    switch (type) {
      case "National":
        return dangerColor;
      case "Religious":
        return primaryColor;
      case "Cultural":
        return warningColor;
      case "Federal":
        return infoColor;
      case "Commercial":
        return successColor;
      default:
        return primaryColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Staffing":
        return Icons.people;
      case "Inventory":
        return Icons.inventory;
      case "Operations":
        return Icons.build;
      default:
        return Icons.settings;
    }
  }
}
