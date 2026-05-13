import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaResumeViewerView extends StatefulWidget {
  const RhaResumeViewerView({super.key});

  @override
  State<RhaResumeViewerView> createState() => _RhaResumeViewerViewState();
}

class _RhaResumeViewerViewState extends State<RhaResumeViewerView> {
  bool isFullscreen = false;
  double zoomLevel = 1.0;
  int currentPage = 1;
  int totalPages = 3;
  String viewMode = "resume"; // resume, cover_letter, portfolio
  bool isLoading = false;
  bool isBookmarked = false;
  String selectedText = "";
  List<Map<String, dynamic>> annotations = [];

  // Mock candidate data
  Map<String, dynamic> candidate = {
    "id": "cand_001",
    "name": "Sarah Johnson",
    "email": "sarah.johnson@email.com",
    "phone": "+1 (555) 123-4567",
    "position": "Senior Frontend Developer",
    "experience": "5+ years",
    "location": "San Francisco, CA",
    "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
    "resume_url": "https://example.com/resume.pdf",
    "cover_letter_url": "https://example.com/cover.pdf",
    "portfolio_url": "https://example.com/portfolio.pdf"
  };

  List<Map<String, dynamic>> documentSections = [
    {
      "title": "Personal Information",
      "page": 1,
      "content": "Contact details and basic information"
    },
    {
      "title": "Professional Summary",
      "page": 1,
      "content": "Executive summary of experience and skills"
    },
    {
      "title": "Work Experience",
      "page": 1,
      "content": "Detailed employment history and achievements"
    },
    {
      "title": "Education",
      "page": 2,
      "content": "Academic qualifications and certifications"
    },
    {
      "title": "Skills & Technologies",
      "page": 2,
      "content": "Technical and soft skills assessment"
    },
    {
      "title": "Projects & Achievements",
      "page": 3,
      "content": "Notable projects and accomplishments"
    }
  ];

  List<Map<String, dynamic>> quickActions = [
    {"icon": Icons.bookmark_border, "label": "Bookmark", "action": "bookmark"},
    {"icon": Icons.share, "label": "Share", "action": "share"},
    {"icon": Icons.download, "label": "Download", "action": "download"},
    {"icon": Icons.print, "label": "Print", "action": "print"},
    {"icon": Icons.comment, "label": "Add Note", "action": "note"},
    {"icon": Icons.flag, "label": "Flag", "action": "flag"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildDocumentTabs(),
          _buildToolbar(),
          Expanded(
            child: Row(
              children: [
                if (!isFullscreen) _buildSidebar(),
                Expanded(child: _buildDocumentViewer()),
              ],
            ),
          ),
          _buildBottomControls(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${candidate["name"]}",
            style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
          ),
          Text(
            "${candidate["position"]}",
            style: TextStyle(fontSize: 12, color: disabledBoldColor),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen),
          onPressed: () {
            isFullscreen = !isFullscreen;
            setState(() {});
          },
        ),
        PopupMenuButton(
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(Icons.edit, size: 20),
                  SizedBox(width: spSm),
                  Text("Edit Annotations"),
                ],
              ),
            ),
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(Icons.compare_arrows, size: 20),
                  SizedBox(width: spSm),
                  Text("Compare Documents"),
                ],
              ),
            ),
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(Icons.history, size: 20),
                  SizedBox(width: spSm),
                  Text("Version History"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDocumentTabs() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
      ),
      child: Row(
        children: [
          _buildTabButton("Resume", "resume", Icons.description),
          SizedBox(width: spSm),
          _buildTabButton("Cover Letter", "cover_letter", Icons.mail),
          SizedBox(width: spSm),
          _buildTabButton("Portfolio", "portfolio", Icons.work),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.visibility, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "Last viewed 2 hours ago",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, String mode, IconData icon) {
    bool isSelected = viewMode == mode;
    return GestureDetector(
      onTap: () {
        viewMode = mode;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? primaryColor : disabledBoldColor,
            ),
            SizedBox(width: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? primaryColor : disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
      ),
      child: Row(
        children: [
          // Zoom controls
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.zoom_out),
                onPressed: zoomLevel > 0.5 ? () {
                  zoomLevel = (zoomLevel - 0.1).clamp(0.5, 3.0);
                  setState(() {});
                } : null,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm),
                child: Text(
                  "${(zoomLevel * 100).round()}%",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                icon: Icon(Icons.zoom_in),
                onPressed: zoomLevel < 3.0 ? () {
                  zoomLevel = (zoomLevel + 0.1).clamp(0.5, 3.0);
                  setState(() {});
                } : null,
              ),
            ],
          ),
          
          SizedBox(width: spMd),
          
          // Quick actions
          ...quickActions.take(4).map((action) => Padding(
            padding: EdgeInsets.only(right: spSm),
            child: IconButton(
              icon: Icon(
                action["action"] == "bookmark" && isBookmarked 
                  ? Icons.bookmark 
                  : action["icon"] as IconData,
                color: action["action"] == "bookmark" && isBookmarked 
                  ? warningColor 
                  : disabledBoldColor,
              ),
              tooltip: action["label"],
              onPressed: () => _handleQuickAction(action["action"]),
            ),
          )).toList(),
          
          Spacer(),
          
          // Search in document
          SizedBox(
            width: 200,
            child: QTextField(
              label: "Search in document",
              value: "",
              hint: "Find text...",
              onChanged: (value) => _searchInDocument(value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: disabledOutlineBorderColor)),
      ),
      child: Column(
        children: [
          // Document sections
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Document Sections",
                  style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: spSm),
                ...documentSections.map((section) => _buildSectionItem(section)).toList(),
              ],
            ),
          ),
          
          // Annotations
          Expanded(
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Annotations",
                        style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      QButton(
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () => _addAnnotation(),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  if (annotations.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.note_add, size: 32, color: disabledBoldColor),
                          SizedBox(height: spSm),
                          Text(
                            "No annotations yet",
                            style: TextStyle(color: disabledBoldColor),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Select text and add notes",
                            style: TextStyle(fontSize: 12, color: disabledColor),
                          ),
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: annotations.length,
                        itemBuilder: (context, index) {
                          final annotation = annotations[index];
                          return _buildAnnotationItem(annotation);
                        },
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

  Widget _buildSectionItem(Map<String, dynamic> section) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: GestureDetector(
        onTap: () => _jumpToPage((section["page"] as int)),
        child: Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: currentPage == section["page"] 
              ? primaryColor.withAlpha(20)
              : Colors.transparent,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: currentPage == section["page"] 
                ? primaryColor
                : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: currentPage == section["page"] 
                    ? primaryColor
                    : disabledBoldColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Center(
                  child: Text(
                    "${section["page"]}",
                    style: TextStyle(
                      fontSize: 10,
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
                      "${section["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: currentPage == section["page"] 
                          ? primaryColor
                          : Colors.black,
                      ),
                    ),
                    Text(
                      "${section["content"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnnotationItem(Map<String, dynamic> annotation) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.yellow[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: warningColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.note, size: 16, color: warningColor),
              SizedBox(width: spXs),
              Text(
                "Page ${annotation["page"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: warningColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _deleteAnnotation(annotation),
                child: Icon(Icons.close, size: 16, color: disabledBoldColor),
              ),
            ],
          ),
          SizedBox(height: spXs),
          if (annotation["selectedText"] != null)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "\"${annotation["selectedText"]}\"",
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: disabledBoldColor,
                ),
              ),
            ),
          SizedBox(height: spXs),
          Text(
            "${annotation["note"]}",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: spXs),
          Text(
            "${annotation["timestamp"]}",
            style: TextStyle(fontSize: 10, color: disabledColor),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentViewer() {
    return Container(
      color: Colors.grey[100],
      child: Stack(
        children: [
          // Document content
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Center(
              child: Container(
                width: 595 * zoomLevel, // A4 width
                constraints: BoxConstraints(
                  minHeight: 842 * zoomLevel, // A4 height
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowMd],
                ),
                child: _buildDocumentContent(),
              ),
            ),
          ),
          
          // Loading overlay
          if (isLoading)
            Container(
              color: Colors.black.withAlpha(50),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: spSm),
                      Text("Loading document..."),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDocumentContent() {
    return Container(
      padding: EdgeInsets.all(spLg * zoomLevel),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Document header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${candidate["name"]}",
                      style: TextStyle(
                        fontSize: (fsH2 * zoomLevel),
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs * zoomLevel),
                    Text(
                      "${candidate["position"]}",
                      style: TextStyle(
                        fontSize: (fsH5 * zoomLevel),
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${candidate["avatar"]}",
                  width: 80 * zoomLevel,
                  height: 80 * zoomLevel,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd * zoomLevel),
          
          // Contact information
          Row(
            children: [
              Icon(Icons.email, size: 16 * zoomLevel, color: primaryColor),
              SizedBox(width: spXs * zoomLevel),
              Text(
                "${candidate["email"]}",
                style: TextStyle(fontSize: 14 * zoomLevel),
              ),
              SizedBox(width: spMd * zoomLevel),
              Icon(Icons.phone, size: 16 * zoomLevel, color: primaryColor),
              SizedBox(width: spXs * zoomLevel),
              Text(
                "${candidate["phone"]}",
                style: TextStyle(fontSize: 14 * zoomLevel),
              ),
            ],
          ),
          
          SizedBox(height: spLg * zoomLevel),
          
          // Document sections based on current page
          ..._getPageContent(),
        ],
      ),
    );
  }

  List<Widget> _getPageContent() {
    switch (currentPage) {
      case 1:
        return [
          _buildSection("Professional Summary", 
            "Experienced Frontend Developer with 5+ years of expertise in React, Vue.js, and modern web technologies. Proven track record of delivering high-quality user interfaces and leading development teams in fast-paced environments."),
          _buildSection("Work Experience", 
            "Senior Frontend Developer at TechCorp (2020-Present)\n• Led development of responsive web applications serving 100K+ users\n• Implemented modern React architecture reducing load times by 40%\n• Mentored junior developers and established coding standards\n\nFrontend Developer at StartupXYZ (2018-2020)\n• Built customer-facing dashboards using Vue.js and D3.js\n• Collaborated with UX team to implement pixel-perfect designs\n• Optimized application performance achieving 95+ Lighthouse scores"),
        ];
      case 2:
        return [
          _buildSection("Education", 
            "Bachelor of Computer Science\nUniversity of California, Berkeley (2014-2018)\nGPA: 3.8/4.0\n\nRelevant Coursework: Data Structures, Algorithms, Web Development, Software Engineering"),
          _buildSection("Skills & Technologies", 
            "Frontend: React, Vue.js, Angular, TypeScript, JavaScript (ES6+)\nStyling: CSS3, SASS, Tailwind CSS, Material-UI\nTools: Git, Webpack, Vite, Jest, Cypress\nOther: Node.js, REST APIs, GraphQL, Agile methodologies"),
        ];
      case 3:
        return [
          _buildSection("Projects & Achievements", 
            "E-commerce Platform Redesign\n• Led UI/UX redesign resulting in 25% increase in conversions\n• Implemented responsive design supporting all device types\n• Integrated payment gateways and inventory management\n\nOpen Source Contributions\n• Contributor to popular React component library (500+ stars)\n• Maintained documentation and community support\n• Published npm packages with 10K+ weekly downloads"),
          _buildSection("Certifications", 
            "• AWS Certified Developer Associate (2023)\n• Google Analytics Certified (2022)\n• Scrum Master Certified (2021)"),
        ];
      default:
        return [];
    }
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: (fsH5 * zoomLevel),
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm * zoomLevel),
        Container(
          width: double.infinity,
          height: 2 * zoomLevel,
          color: primaryColor.withAlpha(50),
        ),
        SizedBox(height: spSm * zoomLevel),
        Text(
          content,
          style: TextStyle(
            fontSize: (14 * zoomLevel),
            height: 1.5,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: spLg * zoomLevel),
      ],
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
      ),
      child: Row(
        children: [
          // Page navigation
          Row(
            children: [
              QButton(
                icon: Icons.chevron_left,
                size: bs.sm,
                onPressed: currentPage > 1 ? () {
                  currentPage--;
                  setState(() {});
                } : null,
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Page $currentPage of $totalPages",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.chevron_right,
                size: bs.sm,
                onPressed: currentPage < totalPages ? () {
                  currentPage++;
                  setState(() {});
                } : null,
              ),
            ],
          ),
          
          Spacer(),
          
          // Action buttons
          QButton(
            label: "Add to Shortlist",
            icon: Icons.star_border,
            size: bs.sm,
            onPressed: () => _addToShortlist(),
          ),
          SizedBox(width: spSm),
          QButton(
            label: "Schedule Interview",
            icon: Icons.calendar_today,
            size: bs.sm,
            onPressed: () => _scheduleInterview(),
          ),
        ],
      ),
    );
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case "bookmark":
        isBookmarked = !isBookmarked;
        setState(() {});
        ss(isBookmarked ? "Document bookmarked" : "Bookmark removed");
        break;
      case "share":
        _showShareDialog();
        break;
      case "download":
        _downloadDocument();
        break;
      case "print":
        _printDocument();
        break;
      case "note":
        _addAnnotation();
        break;
      case "flag":
        _flagDocument();
        break;
    }
  }

  void _searchInDocument(String query) {
    // Implement document search functionality
    if (query.isNotEmpty) {
      si("Searching for: $query");
    }
  }

  void _jumpToPage(int page) {
    currentPage = page;
    setState(() {});
  }

  void _addAnnotation() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) => _buildAddAnnotationSheet(),
    );
  }

  Widget _buildAddAnnotationSheet() {
    String noteText = "";
    String selectedText = this.selectedText;
    
    return Container(
      padding: EdgeInsets.only(
        left: spMd,
        right: spMd,
        top: spMd,
        bottom: MediaQuery.of(context).viewInsets.bottom + spMd,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add Annotation",
            style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: spMd),
          
          if (selectedText.isNotEmpty) ...[
            Text(
              "Selected Text:",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: spXs),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Text(
                selectedText,
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(height: spSm),
          ],
          
          QMemoField(
            label: "Add your note",
            value: noteText,
            hint: "Enter your annotation here...",
            onChanged: (value) => noteText = value,
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  size: bs.sm,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add Note",
                  size: bs.sm,
                  onPressed: () {
                    if (noteText.isNotEmpty) {
                      annotations.add({
                        "id": DateTime.now().millisecondsSinceEpoch.toString(),
                        "page": currentPage,
                        "selectedText": selectedText.isNotEmpty ? selectedText : null,
                        "note": noteText,
                        "timestamp": DateTime.now().toString().substring(0, 16),
                      });
                      setState(() {});
                      Navigator.pop(context);
                      ss("Annotation added successfully");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _deleteAnnotation(Map<String, dynamic> annotation) {
    annotations.removeWhere((item) => item["id"] == annotation["id"]);
    setState(() {});
    ss("Annotation deleted");
  }

  void _showShareDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Share Document"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Email"),
              onTap: () {
                Navigator.pop(context);
                ss("Email sharing initiated");
              },
            ),
            ListTile(
              leading: Icon(Icons.link),
              title: Text("Copy Link"),
              onTap: () {
                Navigator.pop(context);
                ss("Link copied to clipboard");
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("Share with Team"),
              onTap: () {
                Navigator.pop(context);
                ss("Shared with team members");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _downloadDocument() {
    isLoading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      isLoading = false;
      setState(() {});
      ss("Document downloaded successfully");
    });
  }

  void _printDocument() {
    si("Print dialog opened");
  }

  void _flagDocument() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Flag Document"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("Inappropriate Content"),
              onTap: () {
                Navigator.pop(context);
                sw("Document flagged for inappropriate content");
              },
            ),
            ListTile(
              title: Text("Fake Information"),
              onTap: () {
                Navigator.pop(context);
                sw("Document flagged for fake information");
              },
            ),
            ListTile(
              title: Text("Copyright Violation"),
              onTap: () {
                Navigator.pop(context);
                sw("Document flagged for copyright violation");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addToShortlist() {
    ss("Candidate added to shortlist");
  }

  void _scheduleInterview() {
    si("Interview scheduling opened");
  }
}
