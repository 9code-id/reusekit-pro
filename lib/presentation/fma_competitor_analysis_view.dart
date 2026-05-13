import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaCompetitorAnalysisView extends StatefulWidget {
  const FmaCompetitorAnalysisView({super.key});

  @override
  State<FmaCompetitorAnalysisView> createState() => _FmaCompetitorAnalysisViewState();
}

class _FmaCompetitorAnalysisViewState extends State<FmaCompetitorAnalysisView> {
  int currentTab = 0;
  String selectedCompetitor = "";
  String selectedMetric = "";
  String selectedRegion = "";
  
  List<Map<String, dynamic>> competitors = [
    {
      "id": "COMP001",
      "name": "QuickBite Express",
      "logo": "https://picsum.photos/100/100?random=1&keyword=logo",
      "marketShare": 28.5,
      "revenue": 2850000.0,
      "locations": 45,
      "founded": "2015",
      "employees": 1200,
      "customerRating": 4.2,
      "priceRange": "Medium",
      "specialties": ["Fast Service", "Digital Ordering", "Delivery"],
      "strengths": ["Technology", "Speed", "Convenience"],
      "weaknesses": ["Food Quality", "Customer Service"],
      "recentNews": "Expanded to 5 new locations this quarter",
      "socialMedia": {"instagram": 125000, "facebook": 89000, "twitter": 34000},
      "avgTicket": 18.50,
      "growth": 15.2
    },
    {
      "id": "COMP002",
      "name": "Premium Plates",
      "logo": "https://picsum.photos/100/100?random=2&keyword=restaurant",
      "marketShare": 22.1,
      "revenue": 1980000.0,
      "locations": 28,
      "founded": "2018",
      "employees": 850,
      "customerRating": 4.7,
      "priceRange": "High",
      "specialties": ["Gourmet Food", "Fine Dining", "Local Ingredients"],
      "strengths": ["Quality", "Experience", "Brand Image"],
      "weaknesses": ["Price Point", "Accessibility"],
      "recentNews": "Won Best Restaurant Award 2024",
      "socialMedia": {"instagram": 78000, "facebook": 56000, "twitter": 12000},
      "avgTicket": 45.80,
      "growth": 8.7
    },
    {
      "id": "COMP003",
      "name": "Family Feast",
      "logo": "https://picsum.photos/100/100?random=3&keyword=family",
      "marketShare": 19.8,
      "revenue": 1750000.0,
      "locations": 38,
      "founded": "2012",
      "employees": 980,
      "customerRating": 4.4,
      "priceRange": "Low",
      "specialties": ["Family Portions", "Kids Menu", "Casual Dining"],
      "strengths": ["Value", "Family Appeal", "Portion Size"],
      "weaknesses": ["Innovation", "Digital Presence"],
      "recentNews": "Launched new kids meal program",
      "socialMedia": {"instagram": 45000, "facebook": 120000, "twitter": 8000},
      "avgTicket": 24.30,
      "growth": 3.1
    },
    {
      "id": "COMP004",
      "name": "Urban Eats",
      "logo": "https://picsum.photos/100/100?random=4&keyword=urban",
      "marketShare": 15.2,
      "revenue": 1340000.0,
      "locations": 22,
      "founded": "2020",
      "employees": 650,
      "customerRating": 4.6,
      "priceRange": "Medium-High",
      "specialties": ["Trendy Food", "Social Media", "Young Demographic"],
      "strengths": ["Marketing", "Innovation", "Social Presence"],
      "weaknesses": ["Experience", "Consistency"],
      "recentNews": "Viral TikTok campaign reached 2M views",
      "socialMedia": {"instagram": 195000, "facebook": 32000, "twitter": 45000},
      "avgTicket": 32.75,
      "growth": 24.8
    },
    {
      "id": "COMP005",
      "name": "Local Legends",
      "logo": "https://picsum.photos/100/100?random=5&keyword=local",
      "marketShare": 9.4,
      "revenue": 890000.0,
      "locations": 15,
      "founded": "2008",
      "employees": 420,
      "customerRating": 4.8,
      "priceRange": "Medium",
      "specialties": ["Local Sourcing", "Seasonal Menu", "Community Focus"],
      "strengths": ["Community", "Quality", "Authenticity"],
      "weaknesses": ["Scale", "Technology"],
      "recentNews": "Partnered with local farms for sourcing",
      "socialMedia": {"instagram": 28000, "facebook": 67000, "twitter": 5000},
      "avgTicket": 38.20,
      "growth": 6.5
    }
  ];

  List<Map<String, dynamic>> competitorOptions = [
    {"label": "All Competitors", "value": ""},
    {"label": "QuickBite Express", "value": "COMP001"},
    {"label": "Premium Plates", "value": "COMP002"},
    {"label": "Family Feast", "value": "COMP003"},
    {"label": "Urban Eats", "value": "COMP004"},
    {"label": "Local Legends", "value": "COMP005"},
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "All Metrics", "value": ""},
    {"label": "Market Share", "value": "marketShare"},
    {"label": "Revenue", "value": "revenue"},
    {"label": "Customer Rating", "value": "customerRating"},
    {"label": "Growth Rate", "value": "growth"},
  ];

  List<Map<String, dynamic>> regionOptions = [
    {"label": "All Regions", "value": ""},
    {"label": "Downtown", "value": "downtown"},
    {"label": "Suburbs", "value": "suburbs"},
    {"label": "Mall Areas", "value": "mall"},
    {"label": "Business District", "value": "business"},
  ];

  List<Map<String, dynamic>> get filteredCompetitors {
    return competitors.where((competitor) {
      bool matchesCompetitor = selectedCompetitor.isEmpty || competitor["id"] == selectedCompetitor;
      return matchesCompetitor;
    }).toList();
  }

  Color _getPriceRangeColor(String priceRange) {
    switch (priceRange) {
      case "Low":
        return successColor;
      case "Medium":
        return warningColor;
      case "Medium-High":
        return infoColor;
      case "High":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getGrowthColor(double growth) {
    if (growth >= 20) return successColor;
    if (growth >= 10) return warningColor;
    if (growth >= 0) return infoColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Competitor Analysis",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Competitors", icon: Icon(Icons.business)),
        Tab(text: "Market Share", icon: Icon(Icons.pie_chart)),
        Tab(text: "Intelligence", icon: Icon(Icons.insights)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCompetitorsTab(),
        _buildMarketShareTab(),
        _buildIntelligenceTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    double totalMarketShare = competitors.fold(0.0, (sum, comp) => sum + (comp["marketShare"] as double));
    double totalRevenue = competitors.fold(0.0, (sum, comp) => sum + (comp["revenue"] as double));
    int totalLocations = competitors.fold(0, (sum, comp) => sum + (comp["locations"] as int));
    double avgRating = competitors.fold(0.0, (sum, comp) => sum + (comp["customerRating"] as double)) / competitors.length;
    double avgGrowth = competitors.fold(0.0, (sum, comp) => sum + (comp["growth"] as double)) / competitors.length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildOverviewCard(
                "Total Competitors",
                "${competitors.length}",
                Icons.business,
                primaryColor,
              ),
              _buildOverviewCard(
                "Market Coverage",
                "${totalMarketShare.toStringAsFixed(1)}%",
                Icons.pie_chart,
                infoColor,
              ),
              _buildOverviewCard(
                "Total Locations",
                "$totalLocations",
                Icons.location_on,
                successColor,
              ),
              _buildOverviewCard(
                "Avg Growth Rate",
                "${avgGrowth.toStringAsFixed(1)}%",
                Icons.trending_up,
                warningColor,
              ),
            ],
          ),
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
              spacing: spMd,
              children: [
                Text(
                  "Market Share Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: competitors.map((competitor) {
                    Color shareColor = (competitor["marketShare"] as double) >= 25 
                        ? successColor 
                        : (competitor["marketShare"] as double) >= 15 
                            ? warningColor 
                            : infoColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: shareColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: shareColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${competitor["logo"]}",
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${competitor["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${competitor["locations"]} locations • Est. ${competitor["founded"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: disabledColor,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: (competitor["marketShare"] as double) / 35,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: shareColor,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${(competitor["marketShare"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: shareColor,
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
                  }).toList(),
                ),
              ],
            ),
          ),
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
              spacing: spMd,
              children: [
                Text(
                  "Performance Comparison",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: competitors.take(4).map((competitor) {
                      double maxRevenue = competitors.map((c) => c["revenue"] as double).reduce((a, b) => a > b ? a : b);
                      double revenueHeight = ((competitor["revenue"] as double) / maxRevenue) * 120;
                      
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "\$${((competitor["revenue"] as double) / 1000000).toStringAsFixed(1)}M",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            width: 30,
                            height: revenueHeight,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${competitor["name"].toString().split(' ')[0]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
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
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetitorsTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Select Competitor",
                  items: competitorOptions,
                  value: selectedCompetitor,
                  onChanged: (value, label) {
                    selectedCompetitor = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Metric Focus",
                  items: metricOptions,
                  value: selectedMetric,
                  onChanged: (value, label) {
                    selectedMetric = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Region",
                  items: regionOptions,
                  value: selectedRegion,
                  onChanged: (value, label) {
                    selectedRegion = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: filteredCompetitors.length,
            itemBuilder: (context, index) {
              final competitor = filteredCompetitors[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${competitor["logo"]}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${competitor["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Founded ${competitor["founded"]} • ${competitor["employees"]} employees",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getPriceRangeColor(competitor["priceRange"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${competitor["priceRange"]} Price",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _getPriceRangeColor(competitor["priceRange"]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getGrowthColor(competitor["growth"] as double).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${(competitor["growth"] as double).toStringAsFixed(1)}% Growth",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _getGrowthColor(competitor["growth"] as double),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        _buildCompetitorMetric(
                          "Market Share",
                          "${(competitor["marketShare"] as double).toStringAsFixed(1)}%",
                          Icons.pie_chart,
                          primaryColor,
                        ),
                        _buildCompetitorMetric(
                          "Revenue",
                          "\$${((competitor["revenue"] as double) / 1000000).toStringAsFixed(1)}M",
                          Icons.attach_money,
                          successColor,
                        ),
                        _buildCompetitorMetric(
                          "Rating",
                          "${competitor["customerRating"]}★",
                          Icons.star,
                          warningColor,
                        ),
                        _buildCompetitorMetric(
                          "Avg Ticket",
                          "\$${(competitor["avgTicket"] as double).toStringAsFixed(2)}",
                          Icons.receipt,
                          infoColor,
                        ),
                      ],
                    ),
                    Divider(color: disabledColor),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Specialties",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Wrap(
                                    spacing: spXs,
                                    runSpacing: spXs,
                                    children: (competitor["specialties"] as List).map((specialty) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "$specialty",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: infoColor,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spMd),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {},
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
                                    "Strengths",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${(competitor["strengths"] as List).join(", ")}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
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
                                  Text(
                                    "Weaknesses",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: dangerColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${(competitor["weaknesses"] as List).join(", ")}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (competitor["recentNews"] != null) ...[
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.campaign,
                                  color: warningColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${competitor["recentNews"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCompetitorMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketShareTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
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
              spacing: spMd,
              children: [
                Text(
                  "Market Share Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: competitors.map((competitor) {
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: primaryColor.withAlpha(20),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusXs),
                                child: Image.network(
                                  "${competitor["logo"]}",
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${competitor["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${(competitor["marketShare"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (competitor["marketShare"] as double) / 35,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "${competitor["locations"]} locations",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
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
              spacing: spMd,
              children: [
                Text(
                  "Growth Rate Comparison",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: competitors.map((competitor) {
                    Color growthColor = _getGrowthColor(competitor["growth"] as double);
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: growthColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: growthColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  child: Image.network(
                                    "${competitor["logo"]}",
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${competitor["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${competitor["locations"]} locations",
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
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${(competitor["growth"] as double) >= 0 ? '+' : ''}${(competitor["growth"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: growthColor,
                                  ),
                                ),
                                Text(
                                  "Growth Rate",
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
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntelligenceTab() {
    List<Map<String, dynamic>> intelligence = [
      {
        "title": "QuickBite Express Expansion",
        "type": "Market Move",
        "priority": "High",
        "date": "2024-06-15",
        "description": "Competitor announced plans to open 8 new locations in Q3 2024, targeting suburban markets.",
        "impact": "Potential 5% market share increase",
        "source": "Press Release",
        "action": "Monitor pricing and promotional strategies"
      },
      {
        "title": "Premium Plates Award Win",
        "type": "Brand Recognition",
        "priority": "Medium",
        "date": "2024-06-10",
        "description": "Won 'Best Restaurant Experience 2024' award, strengthening brand position in premium segment.",
        "impact": "Enhanced brand perception",
        "source": "Industry News",
        "action": "Review our premium service offerings"
      },
      {
        "title": "Urban Eats Social Campaign",
        "type": "Marketing",
        "priority": "Medium",
        "date": "2024-06-08",
        "description": "Viral TikTok campaign featuring trending food challenges reached over 2M views.",
        "impact": "Increased brand awareness among Gen Z",
        "source": "Social Media Monitoring",
        "action": "Evaluate social media strategy"
      },
      {
        "title": "Family Feast Menu Launch",
        "type": "Product Innovation",
        "priority": "Low",
        "date": "2024-06-05",
        "description": "Launched new kids meal program with educational activities and healthier options.",
        "impact": "Stronger family positioning",
        "source": "Customer Feedback",
        "action": "Consider family-oriented offerings"
      }
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
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
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Competitive Intelligence",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Add Intel",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                Column(
                  spacing: spMd,
                  children: intelligence.map((intel) {
                    Color priorityColor = intel["priority"] == "High" 
                        ? dangerColor 
                        : intel["priority"] == "Medium" 
                            ? warningColor 
                            : successColor;
                    
                    Color typeColor;
                    IconData typeIcon;
                    
                    switch (intel["type"]) {
                      case "Market Move":
                        typeColor = dangerColor;
                        typeIcon = Icons.trending_up;
                        break;
                      case "Brand Recognition":
                        typeColor = successColor;
                        typeIcon = Icons.emoji_events;
                        break;
                      case "Marketing":
                        typeColor = warningColor;
                        typeIcon = Icons.campaign;
                        break;
                      case "Product Innovation":
                        typeColor = infoColor;
                        typeIcon = Icons.lightbulb;
                        break;
                      default:
                        typeColor = primaryColor;
                        typeIcon = Icons.info;
                    }
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: typeColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spMd,
                        children: [
                          Row(
                            children: [
                              Icon(
                                typeIcon,
                                color: typeColor,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${intel["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: priorityColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${intel["priority"]} Priority",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: priorityColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${intel["description"]}",
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.flash_on,
                                      color: primaryColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Impact: ${intel["impact"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lightbulb_outline,
                                      color: primaryColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Action: ${intel["action"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: typeColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${intel["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: typeColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${intel["date"]} • ${intel["source"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
