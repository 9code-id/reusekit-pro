import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsCompetitorBacklinksView extends StatefulWidget {
  const DmsCompetitorBacklinksView({super.key});

  @override
  State<DmsCompetitorBacklinksView> createState() => _DmsCompetitorBacklinksViewState();
}

class _DmsCompetitorBacklinksViewState extends State<DmsCompetitorBacklinksView> {
  String mainDomain = "";
  List<String> competitorDomains = [];
  String newCompetitor = "";
  int currentTab = 0;
  bool loading = false;

  List<Map<String, dynamic>> competitorData = [
    {
      "domain": "competitor1.com",
      "total_backlinks": 15420,
      "referring_domains": 2340,
      "dr": 78,
      "organic_traffic": 145000,
      "top_pages": 1250,
      "new_backlinks": 234,
      "lost_backlinks": 89,
      "growth": 12.5
    },
    {
      "domain": "competitor2.com",
      "total_backlinks": 12890,
      "referring_domains": 1980,
      "dr": 72,
      "organic_traffic": 198000,
      "top_pages": 980,
      "new_backlinks": 189,
      "lost_backlinks": 145,
      "growth": -2.3
    },
    {
      "domain": "competitor3.com",
      "total_backlinks": 18750,
      "referring_domains": 2890,
      "dr": 82,
      "organic_traffic": 267000,
      "top_pages": 1560,
      "new_backlinks": 298,
      "lost_backlinks": 67,
      "growth": 18.7
    }
  ];

  List<Map<String, dynamic>> gapAnalysis = [
    {
      "domain": "authoritysite1.com",
      "dr": 85,
      "links_to_competitors": 3,
      "links_to_me": 0,
      "opportunity_score": 92,
      "content_type": "Industry News",
      "contact_info": "editor@authoritysite1.com"
    },
    {
      "domain": "techblog2.net",
      "dr": 67,
      "links_to_competitors": 2,
      "links_to_me": 0,
      "opportunity_score": 78,
      "content_type": "Tech Reviews",
      "contact_info": "contact@techblog2.net"
    },
    {
      "domain": "resourcehub3.org",
      "dr": 71,
      "links_to_competitors": 4,
      "links_to_me": 1,
      "opportunity_score": 65,
      "content_type": "Resource Lists",
      "contact_info": "outreach@resourcehub3.org"
    }
  ];

  List<Map<String, dynamic>> sharedBacklinks = [
    {
      "domain": "sharedsite1.com",
      "dr": 74,
      "links_to_me": true,
      "links_to_competitor1": true,
      "links_to_competitor2": false,
      "anchor_text": "digital marketing",
      "page_title": "Best Digital Marketing Tools 2024",
      "content_type": "List Post"
    },
    {
      "domain": "commonlink2.net",
      "dr": 68,
      "links_to_me": true,
      "links_to_competitor1": true,
      "links_to_competitor2": true,
      "anchor_text": "marketing automation",
      "page_title": "Marketing Automation Guide",
      "content_type": "Tutorial"
    }
  ];

  List<Map<String, dynamic>> topBacklinks = [
    {
      "url": "https://highdr-site.com/marketing-tools",
      "domain": "highdr-site.com",
      "dr": 89,
      "ur": 67,
      "traffic": 45000,
      "anchor_text": "best marketing platform",
      "first_seen": "2024-02-15",
      "competitors_linked": ["competitor1.com", "competitor3.com"]
    },
    {
      "url": "https://authority-blog.net/seo-guide",
      "domain": "authority-blog.net",
      "dr": 82,
      "ur": 72,
      "traffic": 38000,
      "anchor_text": "SEO optimization",
      "first_seen": "2024-01-28",
      "competitors_linked": ["competitor2.com"]
    },
    {
      "url": "https://industry-report.org/trends",
      "domain": "industry-report.org",
      "dr": 76,
      "ur": 64,
      "traffic": 29000,
      "anchor_text": "marketing trends",
      "first_seen": "2024-03-05",
      "competitors_linked": ["competitor1.com", "competitor2.com", "competitor3.com"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Competitor Backlinks",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.analytics)),
        Tab(text: "Gap Analysis", icon: Icon(Icons.search)),
        Tab(text: "Shared Links", icon: Icon(Icons.share)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildGapAnalysisTab(),
        _buildSharedLinksTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalysisForm(),
          if (mainDomain.isNotEmpty && competitorDomains.isNotEmpty) ...[
            _buildCompetitorComparison(),
            _buildTopBacklinks(),
          ]
        ],
      ),
    );
  }

  Widget _buildAnalysisForm() {
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
            "Competitor Backlink Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Your Domain",
            value: mainDomain,
            hint: "yourdomain.com",
            onChanged: (value) {
              mainDomain = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Add Competitor",
                  value: newCompetitor,
                  hint: "competitor.com",
                  onChanged: (value) {
                    newCompetitor = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add",
                size: bs.md,
                onPressed: () => _addCompetitor(),
              ),
            ],
          ),
          if (competitorDomains.isNotEmpty) ...[
            Text(
              "Competitors:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: competitorDomains.map((domain) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        domain,
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      GestureDetector(
                        onTap: () => _removeCompetitor(domain),
                        child: Icon(
                          Icons.close,
                          size: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
          Container(
            width: double.infinity,
            child: QButton(
              label: "Analyze Backlinks",
              size: bs.md,
              onPressed: () => _analyzeBacklinks(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetitorComparison() {
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
            "Competitor Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: spSm,
              children: competitorData.map((competitor) {
                return Container(
                  width: 280,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor.withAlpha(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${competitor["domain"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getGrowthColor((competitor["growth"] as double)).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(competitor["growth"] as double) >= 0 ? '+' : ''}${(competitor["growth"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 11,
                                color: _getGrowthColor((competitor["growth"] as double)),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      _buildCompetitorMetric("Total Backlinks", "${((competitor["total_backlinks"] as int) / 1000).toStringAsFixed(1)}K", Icons.link),
                      _buildCompetitorMetric("Referring Domains", "${((competitor["referring_domains"] as int) / 1000).toStringAsFixed(1)}K", Icons.domain),
                      _buildCompetitorMetric("Domain Rating", "${competitor["dr"]}", Icons.star),
                      _buildCompetitorMetric("Organic Traffic", "${((competitor["organic_traffic"] as int) / 1000).toStringAsFixed(0)}K", Icons.trending_up),
                      Row(
                        children: [
                          Expanded(
                            child: _buildGrowthMetric("New", "${competitor["new_backlinks"]}", successColor),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: _buildGrowthMetric("Lost", "${competitor["lost_backlinks"]}", dangerColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetitorMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(width: spSm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGrowthMetric(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBacklinks() {
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
          Row(
            children: [
              Text(
                "Top Competitor Backlinks",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Export",
                size: bs.sm,
                icon: Icons.download,
                onPressed: () {},
              ),
            ],
          ),
          ...topBacklinks.map((backlink) {
            return Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(20)),
              ),
              child: Column(
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
                              "${backlink["domain"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${backlink["url"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Replicate",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildBacklinkMetric("DR", "${backlink["dr"]}", Icons.star),
                      ),
                      Expanded(
                        child: _buildBacklinkMetric("UR", "${backlink["ur"]}", Icons.link),
                      ),
                      Expanded(
                        child: _buildBacklinkMetric("Traffic", "${((backlink["traffic"] as int) / 1000).toStringAsFixed(0)}K", Icons.trending_up),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Anchor: \"${backlink["anchor_text"]}\"",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Competitors linked: ${(backlink["competitors_linked"] as List).join(", ")}",
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
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildBacklinkMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGapAnalysisTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildGapAnalysisHeader(),
          _buildGapOpportunities(),
        ],
      ),
    );
  }

  Widget _buildGapAnalysisHeader() {
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
            "Link Gap Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Discover websites that link to your competitors but not to you. These represent potential link building opportunities.",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildGapStat("Total Opportunities", "47", successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildGapStat("High DR Sites", "18", warningColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildGapStat("Easy Targets", "12", infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGapStat(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGapOpportunities() {
    return Column(
      spacing: spSm,
      children: gapAnalysis.map((opportunity) {
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${opportunity["domain"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${opportunity["content_type"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getOpportunityColor((opportunity["opportunity_score"] as int)).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Score ${opportunity["opportunity_score"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: _getOpportunityColor((opportunity["opportunity_score"] as int)),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildOpportunityMetric("DR", "${opportunity["dr"]}", Icons.star),
                  ),
                  Expanded(
                    child: _buildOpportunityMetric("Links to Competitors", "${opportunity["links_to_competitors"]}", Icons.link),
                  ),
                  Expanded(
                    child: _buildOpportunityMetric("Links to Me", "${opportunity["links_to_me"]}", Icons.check_circle),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: infoColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${opportunity["contact_info"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  QButton(
                    label: "Start Outreach",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildOpportunityMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSharedLinksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSharedLinksHeader(),
          _buildSharedLinksList(),
        ],
      ),
    );
  }

  Widget _buildSharedLinksHeader() {
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
            "Shared Backlinks",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Websites that link to both you and your competitors. Analyze these for relationship building opportunities.",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSharedLinksList() {
    return Column(
      spacing: spSm,
      children: sharedBacklinks.map((shared) {
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${shared["domain"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${shared["page_title"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "DR ${shared["dr"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Link Status:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        _buildLinkStatus("Me", (shared["links_to_me"] as bool)),
                        SizedBox(width: spMd),
                        _buildLinkStatus("Competitor 1", (shared["links_to_competitor1"] as bool)),
                        SizedBox(width: spMd),
                        _buildLinkStatus("Competitor 2", (shared["links_to_competitor2"] as bool)),
                      ],
                    ),
                    Text(
                      "Anchor: \"${shared["anchor_text"]}\"",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  QButton(
                    label: "Strengthen Relationship",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLinkStatus(String label, bool hasLink) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          hasLink ? Icons.check_circle : Icons.cancel,
          color: hasLink ? successColor : dangerColor,
          size: 16,
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: hasLink ? successColor : dangerColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _getGrowthColor(double growth) {
    if (growth > 10) return successColor;
    if (growth > 0) return infoColor;
    if (growth > -5) return warningColor;
    return dangerColor;
  }

  Color _getOpportunityColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 70) return infoColor;
    if (score >= 50) return warningColor;
    return dangerColor;
  }

  void _addCompetitor() {
    if (newCompetitor.isEmpty) {
      se("Please enter a competitor domain");
      return;
    }
    
    if (competitorDomains.contains(newCompetitor)) {
      se("Competitor already added");
      return;
    }
    
    competitorDomains.add(newCompetitor);
    newCompetitor = "";
    setState(() {});
    ss("Competitor added successfully");
  }

  void _removeCompetitor(String domain) {
    competitorDomains.remove(domain);
    setState(() {});
    ss("Competitor removed");
  }

  void _analyzeBacklinks() {
    if (mainDomain.isEmpty) {
      se("Please enter your domain");
      return;
    }
    
    if (competitorDomains.isEmpty) {
      se("Please add at least one competitor");
      return;
    }
    
    loading = true;
    setState(() {});
    
    // Simulate analysis
    Future.delayed(Duration(seconds: 3), () {
      loading = false;
      setState(() {});
      ss("Competitor backlink analysis completed successfully");
    });
  }
}
