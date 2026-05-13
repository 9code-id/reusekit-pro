import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaMarketReportsView extends StatefulWidget {
  const RmaMarketReportsView({super.key});

  @override
  State<RmaMarketReportsView> createState() => _RmaMarketReportsViewState();
}

class _RmaMarketReportsViewState extends State<RmaMarketReportsView> {
  String selectedTimeframe = "Monthly";
  String selectedLocation = "Manhattan";
  String selectedReportType = "All Reports";
  
  List<Map<String, dynamic>> marketReports = [
    {
      "id": "1",
      "title": "Manhattan Luxury Market Report",
      "subtitle": "Q4 2023 Market Analysis",
      "publishDate": "2024-01-15",
      "reportType": "Market Analysis",
      "location": "Manhattan",
      "author": "NYC Real Estate Research",
      "readTime": "8 min read",
      "downloadCount": 1247,
      "image": "https://picsum.photos/400/250?random=1&keyword=manhattan",
      "insights": {
        "averagePrice": 1850000,
        "priceChange": 5.2,
        "inventory": 2450,
        "daysOnMarket": 68
      },
      "keyPoints": [
        "Luxury market showing strong recovery",
        "Inventory levels stable compared to Q3",
        "Price appreciation in prime locations",
        "International buyer interest increasing"
      ],
      "isPremium": true
    },
    {
      "id": "2",
      "title": "Brooklyn Housing Market Trends",
      "subtitle": "Year-End 2023 Summary",
      "publishDate": "2024-01-12",
      "reportType": "Trends Analysis",
      "location": "Brooklyn",
      "author": "Brooklyn Real Estate Board",
      "readTime": "6 min read",
      "downloadCount": 892,
      "image": "https://picsum.photos/400/250?random=2&keyword=brooklyn",
      "insights": {
        "averagePrice": 785000,
        "priceChange": 3.8,
        "inventory": 4320,
        "daysOnMarket": 45
      },
      "keyPoints": [
        "Steady price growth across all neighborhoods",
        "First-time buyer activity remains high",
        "New construction driving inventory growth",
        "Transit-oriented development impact"
      ],
      "isPremium": false
    },
    {
      "id": "3",
      "title": "NYC Rental Market Outlook",
      "subtitle": "2024 Forecast & Predictions",
      "publishDate": "2024-01-10",
      "reportType": "Forecast",
      "location": "All NYC",
      "author": "Metropolitan Housing Authority",
      "readTime": "12 min read",
      "downloadCount": 2156,
      "image": "https://picsum.photos/400/250?random=3&keyword=rental",
      "insights": {
        "averagePrice": 3200,
        "priceChange": 2.1,
        "inventory": 12500,
        "daysOnMarket": 25
      },
      "keyPoints": [
        "Rental prices stabilizing after 2023 surge",
        "Increased supply from new developments",
        "Remote work impact on neighborhood preferences",
        "Rental concessions becoming more common"
      ],
      "isPremium": true
    },
    {
      "id": "4",
      "title": "Queens Commercial Real Estate",
      "subtitle": "Investment Opportunities Report",
      "publishDate": "2024-01-08",
      "reportType": "Investment Guide",
      "location": "Queens",
      "author": "Commercial Realty Advisors",
      "readTime": "10 min read",
      "downloadCount": 634,
      "image": "https://picsum.photos/400/250?random=4&keyword=commercial",
      "insights": {
        "averagePrice": 450000,
        "priceChange": 7.3,
        "inventory": 890,
        "daysOnMarket": 89
      },
      "keyPoints": [
        "Strong demand for industrial properties",
        "E-commerce driving warehouse needs",
        "Transportation infrastructure improvements",
        "Opportunity zones offering tax incentives"
      ],
      "isPremium": false
    },
    {
      "id": "5",
      "title": "Luxury Penthouse Market Analysis",
      "subtitle": "Ultra-High Net Worth Buyer Trends",
      "publishDate": "2024-01-05",
      "reportType": "Luxury Focus",
      "location": "Manhattan",
      "author": "Luxury Real Estate Collective",
      "readTime": "15 min read",
      "downloadCount": 567,
      "image": "https://picsum.photos/400/250?random=5&keyword=penthouse",
      "insights": {
        "averagePrice": 8500000,
        "priceChange": -2.4,
        "inventory": 156,
        "daysOnMarket": 156
      },
      "keyPoints": [
        "Selective buyer market for ultra-luxury",
        "Focus on unique amenities and views",
        "International buyers showing caution",
        "New development completions affecting prices"
      ],
      "isPremium": true
    }
  ];

  List<String> timeframes = ["Weekly", "Monthly", "Quarterly", "Annual"];
  List<String> locations = ["All NYC", "Manhattan", "Brooklyn", "Queens", "Bronx", "Staten Island"];
  List<String> reportTypes = ["All Reports", "Market Analysis", "Trends Analysis", "Forecast", "Investment Guide", "Luxury Focus"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Market Reports"),
        actions: [
          Icon(Icons.download),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildHeaderSection(),
            _buildMarketOverview(),
            _buildFiltersSection(),
            _buildReportsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.assessment,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Text(
                "Market Reports",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "Stay informed with comprehensive real estate market analysis and insights",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(230),
            ),
          ),
          Row(
            children: [
              _buildHeaderStat("Reports", "150+"),
              SizedBox(width: spLg),
              _buildHeaderStat("Downloads", "15K+"),
              SizedBox(width: spLg),
              _buildHeaderStat("Updated", "Weekly"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketOverview() {
    return Container(
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
            "Market Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildOverviewCard(
                  "Average Price",
                  "\$1.2M",
                  "+3.2%",
                  Icons.attach_money,
                  successColor,
                  true,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard(
                  "Inventory",
                  "8,450",
                  "-1.8%",
                  Icons.home,
                  dangerColor,
                  false,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildOverviewCard(
                  "Days on Market",
                  "52",
                  "-5.4%",
                  Icons.schedule,
                  successColor,
                  false,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard(
                  "Sales Volume",
                  "2,340",
                  "+12.7%",
                  Icons.trending_up,
                  successColor,
                  true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, String change, IconData icon, Color changeColor, bool isPositive) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(15),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: primaryColor,
                size: 16,
              ),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
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
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: changeColor,
                size: 12,
              ),
              SizedBox(width: 2),
              Text(
                change,
                style: TextStyle(
                  fontSize: 10,
                  color: changeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
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
            "Filter Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Timeframe",
                  items: timeframes.map((timeframe) => {
                    "label": timeframe,
                    "value": timeframe,
                  }).toList(),
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Location",
                  items: locations.map((location) => {
                    "label": location,
                    "value": location,
                  }).toList(),
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Report Type",
            items: reportTypes.map((type) => {
              "label": type,
              "value": type,
            }).toList(),
            value: selectedReportType,
            onChanged: (value, label) {
              selectedReportType = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReportsList() {
    List<Map<String, dynamic>> filteredReports = marketReports.where((report) {
      bool locationMatch = selectedLocation == "All NYC" || report["location"] == selectedLocation;
      bool typeMatch = selectedReportType == "All Reports" || report["reportType"] == selectedReportType;
      return locationMatch && typeMatch;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Latest Reports (${filteredReports.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Column(
          spacing: spSm,
          children: filteredReports.map((report) {
            return _buildReportCard(report);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    bool isPremium = report["isPremium"] as bool;
    Map<String, dynamic> insights = report["insights"] as Map<String, dynamic>;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isPremium ? warningColor.withAlpha(80) : disabledOutlineBorderColor,
          width: isPremium ? 2 : 1,
        ),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Stack(
              children: [
                Image.network(
                  "${report["image"]}",
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                if (isPremium)
                  Positioned(
                    top: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "PREMIUM",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(180),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${report["reportType"]}",
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
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${report["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${report["publishDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${report["subtitle"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.person, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text("${report["author"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    SizedBox(width: spSm),
                    Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text("${report["readTime"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    SizedBox(width: spSm),
                    Icon(Icons.download, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text("${report["downloadCount"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(15),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Key Insights",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInsightItem(
                              "Avg Price",
                              report["reportType"] == "NYC Rental Market Outlook" 
                                ? "\$${insights["averagePrice"]}"
                                : "\$${((insights["averagePrice"] as int) / 1000).toInt()}K",
                              Icons.attach_money,
                            ),
                          ),
                          Expanded(
                            child: _buildInsightItem(
                              "Change",
                              "${(insights["priceChange"] as double) > 0 ? '+' : ''}${(insights["priceChange"] as double).toStringAsFixed(1)}%",
                              (insights["priceChange"] as double) > 0 ? Icons.trending_up : Icons.trending_down,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInsightItem(
                              "Inventory",
                              "${insights["inventory"]}",
                              Icons.home,
                            ),
                          ),
                          Expanded(
                            child: _buildInsightItem(
                              "Days on Market",
                              "${insights["daysOnMarket"]}",
                              Icons.schedule,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Key Points:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Column(
                      spacing: spXs,
                      children: (report["keyPoints"] as List<String>).map((point) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                point,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: isPremium ? "Get Premium" : "Read Report",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {
                        ss("Report downloaded successfully");
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {},
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

  Widget _buildInsightItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 12,
        ),
        SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
