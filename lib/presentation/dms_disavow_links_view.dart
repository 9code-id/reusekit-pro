import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsDisavowLinksView extends StatefulWidget {
  const DmsDisavowLinksView({super.key});

  @override
  State<DmsDisavowLinksView> createState() => _DmsDisavowLinksViewState();
}

class _DmsDisavowLinksViewState extends State<DmsDisavowLinksView> {
  String domain = "";
  String disavowContent = "";
  int currentTab = 0;
  bool loading = false;

  List<Map<String, dynamic>> toxicLinks = [
    {
      "url": "https://spamsite1.com/page1",
      "domain": "spamsite1.com",
      "toxicity": 95,
      "reason": "Known spam network",
      "da": 12,
      "pa": 8,
      "spam_score": 89,
      "first_seen": "2024-01-15",
      "anchor_text": "click here",
      "status": "active",
      "type": "spam"
    },
    {
      "url": "https://lowquality2.net/random-page",
      "domain": "lowquality2.net",
      "toxicity": 87,
      "reason": "Low quality content",
      "da": 15,
      "pa": 12,
      "spam_score": 73,
      "first_seen": "2024-02-03",
      "anchor_text": "best website",
      "status": "active",
      "type": "low_quality"
    },
    {
      "url": "https://penalized3.org/link-farm",
      "domain": "penalized3.org",
      "toxicity": 92,
      "reason": "Google penalized",
      "da": 8,
      "pa": 5,
      "spam_score": 95,
      "first_seen": "2024-01-28",
      "anchor_text": "digital marketing",
      "status": "active",
      "type": "penalized"
    },
    {
      "url": "https://irrelevant4.biz/unrelated",
      "domain": "irrelevant4.biz",
      "toxicity": 78,
      "reason": "Irrelevant content",
      "da": 25,
      "pa": 18,
      "spam_score": 45,
      "first_seen": "2024-02-12",
      "anchor_text": "gaming site",
      "status": "active",
      "type": "irrelevant"
    }
  ];

  List<Map<String, dynamic>> disavowHistory = [
    {
      "file": "disavow_2024_03_15.txt",
      "date": "2024-03-15",
      "domains": 45,
      "urls": 123,
      "status": "Submitted",
      "processed": true
    },
    {
      "file": "disavow_2024_01_20.txt",
      "date": "2024-01-20",
      "domains": 32,
      "urls": 89,
      "status": "Processed",
      "processed": true
    },
    {
      "file": "disavow_2023_11_10.txt",
      "date": "2023-11-10",
      "domains": 28,
      "urls": 67,
      "status": "Processed",
      "processed": true
    }
  ];

  List<String> selectedUrls = [];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Disavow Links",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Toxic Links", icon: Icon(Icons.warning)),
        Tab(text: "Disavow File", icon: Icon(Icons.file_copy)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildToxicLinksTab(),
        _buildDisavowFileTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildToxicLinksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalysisForm(),
          if (domain.isNotEmpty) ...[
            _buildToxicOverview(),
            _buildFilterButtons(),
            _buildToxicLinksList(),
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
            "Toxic Link Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Domain",
            value: domain,
            hint: "example.com",
            onChanged: (value) {
              domain = value;
              setState(() {});
            },
          ),
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

  Widget _buildToxicOverview() {
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
            "Toxic Links Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildOverviewCard("Total Toxic", "${toxicLinks.length}", dangerColor, Icons.dangerous),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("High Risk", "3", dangerColor, Icons.error),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Medium Risk", "1", warningColor, Icons.warning),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Selected", "${selectedUrls.length}", primaryColor, Icons.check_box),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
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
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButtons() {
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
            "Filter & Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              QButton(
                label: "Select All High Risk",
                size: bs.sm,
                onPressed: () => _selectHighRisk(),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Clear Selection",
                size: bs.sm,
                onPressed: () => _clearSelection(),
              ),
              Spacer(),
              QButton(
                label: "Add to Disavow",
                size: bs.sm,
                icon: Icons.add,
                onPressed: selectedUrls.isNotEmpty ? () => _addToDisavow() : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToxicLinksList() {
    return Column(
      spacing: spSm,
      children: toxicLinks.map((link) {
        bool isSelected = selectedUrls.contains("${link["url"]}");
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _toggleSelection("${link["url"]}"),
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: primaryColor),
                      ),
                      child: Icon(
                        Icons.check,
                        size: 14,
                        color: isSelected ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${link["domain"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${link["url"]}",
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
                      color: _getToxicityColor((link["toxicity"] as int)).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Risk ${link["toxicity"]}%",
                      style: TextStyle(
                        fontSize: 11,
                        color: _getToxicityColor((link["toxicity"] as int)),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Reason: ${link["reason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Anchor Text: \"${link["anchor_text"]}\"",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildLinkMetric("DA", "${link["da"]}", Icons.domain),
                  ),
                  Expanded(
                    child: _buildLinkMetric("PA", "${link["pa"]}", Icons.article),
                  ),
                  Expanded(
                    child: _buildLinkMetric("Spam Score", "${link["spam_score"]}", Icons.report),
                  ),
                  Expanded(
                    child: _buildLinkMetric("First Seen", "${link["first_seen"]}", Icons.calendar_today),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLinkMetric(String label, String value, IconData icon) {
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
                fontSize: 11,
                fontWeight: FontWeight.bold,
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

  Widget _buildDisavowFileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDisavowGenerator(),
          _buildDisavowPreview(),
        ],
      ),
    );
  }

  Widget _buildDisavowGenerator() {
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
            "Disavow File Generator",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Generate a properly formatted disavow file for Google Search Console. Add URLs or domains you want to disavow.",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          QMemoField(
            label: "URLs/Domains to Disavow",
            value: disavowContent,
            hint: "Enter URLs or domains, one per line...",
            onChanged: (value) {
              disavowContent = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Generate File",
                  size: bs.md,
                  onPressed: () => _generateDisavowFile(),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Download",
                size: bs.md,
                icon: Icons.download,
                onPressed: disavowContent.isNotEmpty ? () => _downloadDisavowFile() : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDisavowPreview() {
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
                "Disavow File Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (disavowContent.isNotEmpty)
                QButton(
                  label: "Copy",
                  size: bs.sm,
                  icon: Icons.copy,
                  onPressed: () => _copyDisavowFile(),
                ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 300,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(20)),
            ),
            child: SingleChildScrollView(
              child: Text(
                disavowContent.isEmpty 
                  ? "# Disavow file content will appear here\n# Format examples:\n# Disavow specific URLs:\nhttp://example.com/bad-page.html\n\n# Disavow entire domains:\ndomain:bad-domain.com"
                  : disavowContent,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: primaryColor,
                  height: 1.5,
                ),
              ),
            ),
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
                  Icons.info,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Upload this file to Google Search Console > Disavow Links tool. Changes may take weeks to process.",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildHistoryHeader(),
          _buildHistoryList(),
        ],
      ),
    );
  }

  Widget _buildHistoryHeader() {
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
            "Disavow History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Track your previous disavow file submissions and their processing status.",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return Column(
      spacing: spSm,
      children: disavowHistory.map((history) {
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
                          "${history["file"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Submitted: ${history["date"]}",
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
                      color: _getStatusColor("${history["status"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${history["status"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: _getStatusColor("${history["status"]}"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildHistoryMetric("Domains", "${history["domains"]}", Icons.domain),
                  ),
                  Expanded(
                    child: _buildHistoryMetric("URLs", "${history["urls"]}", Icons.link),
                  ),
                  QButton(
                    label: "View File",
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

  Widget _buildHistoryMetric(String label, String value, IconData icon) {
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

  Color _getToxicityColor(int toxicity) {
    if (toxicity >= 90) return dangerColor;
    if (toxicity >= 80) return warningColor;
    if (toxicity >= 70) return infoColor;
    return successColor;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Processed":
        return successColor;
      case "Submitted":
        return warningColor;
      case "Pending":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _analyzeBacklinks() {
    if (domain.isEmpty) {
      se("Please enter a domain");
      return;
    }
    
    loading = true;
    setState(() {});
    
    // Simulate analysis
    Future.delayed(Duration(seconds: 3), () {
      loading = false;
      setState(() {});
      ss("Backlink analysis completed successfully");
    });
  }

  void _toggleSelection(String url) {
    if (selectedUrls.contains(url)) {
      selectedUrls.remove(url);
    } else {
      selectedUrls.add(url);
    }
    setState(() {});
  }

  void _selectHighRisk() {
    selectedUrls.clear();
    for (var link in toxicLinks) {
      if ((link["toxicity"] as int) >= 90) {
        selectedUrls.add("${link["url"]}");
      }
    }
    setState(() {});
    ss("High risk links selected");
  }

  void _clearSelection() {
    selectedUrls.clear();
    setState(() {});
    ss("Selection cleared");
  }

  void _addToDisavow() {
    String newContent = selectedUrls.join('\n');
    if (disavowContent.isNotEmpty) {
      disavowContent += '\n' + newContent;
    } else {
      disavowContent = newContent;
    }
    selectedUrls.clear();
    setState(() {});
    ss("Selected URLs added to disavow file");
  }

  void _generateDisavowFile() {
    if (disavowContent.isEmpty) {
      se("Please add URLs or domains to disavow");
      return;
    }
    
    // Format the disavow file properly
    List<String> lines = disavowContent.split('\n');
    List<String> formattedLines = [];
    
    formattedLines.add("# Disavow file generated on ${DateTime.now().toString().split(' ')[0]}");
    formattedLines.add("# Format: domain:example.com for entire domains");
    formattedLines.add("# Format: http://example.com/page.html for specific URLs");
    formattedLines.add("");
    
    for (String line in lines) {
      if (line.trim().isNotEmpty) {
        formattedLines.add(line.trim());
      }
    }
    
    disavowContent = formattedLines.join('\n');
    setState(() {});
    ss("Disavow file generated successfully");
  }

  void _downloadDisavowFile() {
    ss("Disavow file downloaded successfully");
  }

  void _copyDisavowFile() {
    ss("Disavow file content copied to clipboard");
  }
}
