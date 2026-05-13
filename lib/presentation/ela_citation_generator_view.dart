import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaCitationGeneratorView extends StatefulWidget {
  const ElaCitationGeneratorView({super.key});

  @override
  State<ElaCitationGeneratorView> createState() => _ElaCitationGeneratorViewState();
}

class _ElaCitationGeneratorViewState extends State<ElaCitationGeneratorView> {
  String selectedStyle = "MLA";
  String selectedSource = "Book";
  String generatedCitation = "";
  bool loading = false;
  bool showPreview = false;

  // Form fields
  String title = "";
  String author = "";
  String publisher = "";
  String publishYear = "";
  String pageNumbers = "";
  String url = "";
  String accessDate = "";
  String edition = "";
  String location = "";
  String doi = "";

  final List<Map<String, dynamic>> citationStyles = [
    {"label": "MLA (Modern Language Association)", "value": "MLA"},
    {"label": "APA (American Psychological Association)", "value": "APA"},
    {"label": "Chicago/Turabian", "value": "Chicago"},
    {"label": "Harvard", "value": "Harvard"},
  ];

  final List<Map<String, dynamic>> sourceTypes = [
    {"label": "Book", "value": "Book"},
    {"label": "Website", "value": "Website"},
    {"label": "Journal Article", "value": "Journal"},
    {"label": "Newspaper Article", "value": "Newspaper"},
    {"label": "Magazine Article", "value": "Magazine"},
    {"label": "Encyclopedia", "value": "Encyclopedia"},
    {"label": "Online Database", "value": "Database"},
    {"label": "Documentary", "value": "Documentary"},
  ];

  final List<Map<String, dynamic>> recentCitations = [
    {
      "id": 1,
      "title": "To Kill a Mockingbird",
      "author": "Harper Lee",
      "style": "MLA",
      "source": "Book",
      "citation": "Lee, Harper. To Kill a Mockingbird. Harper Perennial Modern Classics, 1960.",
      "date": "2024-03-15",
    },
    {
      "id": 2,
      "title": "The American Dream in Literature",
      "author": "Smith, John",
      "style": "APA",
      "source": "Website",
      "citation": "Smith, J. (2023). The American dream in literature. Literature Review Online. https://litreview.com/american-dream",
      "date": "2024-03-14",
    },
    {
      "id": 3,
      "title": "Social Issues in Classic Literature",
      "author": "Johnson, Mary",
      "style": "Chicago",
      "source": "Journal",
      "citation": "Johnson, Mary. \"Social Issues in Classic Literature.\" Literary Analysis Quarterly 45, no. 2 (2023): 123-145.",
      "date": "2024-03-13",
    },
  ];

  void _generateCitation() {
    if (title.isEmpty || author.isEmpty) {
      se("Please fill in at least the title and author fields");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate citation generation
    Future.delayed(Duration(seconds: 2), () {
      generatedCitation = _buildCitation();
      loading = false;
      showPreview = true;
      setState(() {});
      ss("Citation generated successfully!");
    });
  }

  String _buildCitation() {
    switch (selectedStyle) {
      case "MLA":
        return _buildMLACitation();
      case "APA":
        return _buildAPACitation();
      case "Chicago":
        return _buildChicagoCitation();
      case "Harvard":
        return _buildHarvardCitation();
      default:
        return "";
    }
  }

  String _buildMLACitation() {
    switch (selectedSource) {
      case "Book":
        String citation = "$author. $title.";
        if (edition.isNotEmpty) citation += " $edition ed.";
        if (publisher.isNotEmpty) citation += " $publisher,";
        if (publishYear.isNotEmpty) citation += " $publishYear.";
        return citation;
      case "Website":
        String citation = "$author. \"$title.\"";
        if (publisher.isNotEmpty) citation += " $publisher,";
        if (publishYear.isNotEmpty) citation += " $publishYear,";
        if (url.isNotEmpty) citation += " $url.";
        if (accessDate.isNotEmpty) citation += " Accessed ${DateTime.parse(accessDate).dMMMy}.";
        return citation;
      default:
        return "$author. \"$title.\" $publisher, $publishYear.";
    }
  }

  String _buildAPACitation() {
    switch (selectedSource) {
      case "Book":
        String citation = "$author ($publishYear). $title.";
        if (publisher.isNotEmpty) citation += " $publisher.";
        return citation;
      case "Website":
        String citation = "$author ($publishYear). $title.";
        if (publisher.isNotEmpty) citation += " $publisher.";
        if (url.isNotEmpty) citation += " $url";
        return citation;
      default:
        return "$author ($publishYear). $title. $publisher.";
    }
  }

  String _buildChicagoCitation() {
    switch (selectedSource) {
      case "Book":
        return "$author. $title. $location: $publisher, $publishYear.";
      case "Website":
        String citation = "$author. \"$title.\"";
        if (publisher.isNotEmpty) citation += " $publisher.";
        if (accessDate.isNotEmpty) citation += " Accessed ${DateTime.parse(accessDate).dMMMy}.";
        if (url.isNotEmpty) citation += " $url.";
        return citation;
      default:
        return "$author. \"$title.\" $publisher, $publishYear.";
    }
  }

  String _buildHarvardCitation() {
    return "$author $publishYear, '$title', $publisher.";
  }

  void _saveCitation() {
    if (generatedCitation.isEmpty) return;
    
    final newCitation = {
      "id": recentCitations.length + 1,
      "title": title,
      "author": author,
      "style": selectedStyle,
      "source": selectedSource,
      "citation": generatedCitation,
      "date": DateTime.now().toIso8601String().split('T')[0],
    };
    
    recentCitations.insert(0, newCitation);
    setState(() {});
    ss("Citation saved to your library");
  }

  void _clearForm() {
    title = "";
    author = "";
    publisher = "";
    publishYear = "";
    pageNumbers = "";
    url = "";
    accessDate = "";
    edition = "";
    location = "";
    doi = "";
    generatedCitation = "";
    showPreview = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Citation Generator"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              _showCitationGuide();
            },
          ),
          IconButton(
            icon: Icon(Icons.library_books),
            onPressed: () {
              _showSavedCitations();
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Citation Style and Source Type
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Citation Settings",
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
                                label: "Citation Style",
                                items: citationStyles,
                                value: selectedStyle,
                                onChanged: (value, label) {
                                  selectedStyle = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QDropdownField(
                                label: "Source Type",
                                items: sourceTypes,
                                value: selectedSource,
                                onChanged: (value, label) {
                                  selectedSource = value;
                                  _clearForm();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Source Information Form
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Source Information",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "Clear Form",
                              size: bs.sm,
                              onPressed: _clearForm,
                            ),
                          ],
                        ),
                        
                        // Basic Information
                        QTextField(
                          label: "Title *",
                          value: title,
                          hint: "Enter the title of your source",
                          validator: Validator.required,
                          onChanged: (value) {
                            title = value;
                            setState(() {});
                          },
                        ),
                        
                        QTextField(
                          label: "Author *",
                          value: author,
                          hint: "Last, First name format",
                          validator: Validator.required,
                          onChanged: (value) {
                            author = value;
                            setState(() {});
                          },
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: QTextField(
                                label: "Publisher",
                                value: publisher,
                                hint: "Publishing company or website",
                                onChanged: (value) {
                                  publisher = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "Publication Year",
                                value: publishYear,
                                hint: "YYYY",
                                onChanged: (value) {
                                  publishYear = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),

                        // Source-specific fields
                        if (selectedSource == "Book") ...[
                          Row(
                            children: [
                              Expanded(
                                child: QTextField(
                                  label: "Edition",
                                  value: edition,
                                  hint: "2nd, 3rd, etc.",
                                  onChanged: (value) {
                                    edition = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QTextField(
                                  label: "Location",
                                  value: location,
                                  hint: "City of publication",
                                  onChanged: (value) {
                                    location = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],

                        if (selectedSource == "Website" || selectedSource == "Database") ...[
                          QTextField(
                            label: "URL",
                            value: url,
                            hint: "https://example.com",
                            onChanged: (value) {
                              url = value;
                              setState(() {});
                            },
                          ),
                          QDatePicker(
                            label: "Access Date",
                            value: accessDate.isNotEmpty ? DateTime.parse(accessDate) : DateTime.now(),
                            onChanged: (value) {
                              accessDate = value.toIso8601String().split('T')[0];
                              setState(() {});
                            },
                          ),
                        ],

                        if (selectedSource == "Journal" || selectedSource == "Magazine") ...[
                          Row(
                            children: [
                              Expanded(
                                child: QTextField(
                                  label: "Page Numbers",
                                  value: pageNumbers,
                                  hint: "123-145",
                                  onChanged: (value) {
                                    pageNumbers = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QTextField(
                                  label: "DOI",
                                  value: doi,
                                  hint: "Digital Object Identifier",
                                  onChanged: (value) {
                                    doi = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Generate Citation Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Generate Citation",
                      size: bs.md,
                      onPressed: _generateCitation,
                    ),
                  ),

                  // Generated Citation Preview
                  if (showPreview && generatedCitation.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: successColor.withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check_circle, color: successColor),
                              SizedBox(width: spSm),
                              Text(
                                "Generated Citation ($selectedStyle Style)",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: disabledOutlineBorderColor),
                            ),
                            child: SelectableText(
                              generatedCitation,
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                height: 1.5,
                              ),
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Copy Citation",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Copy to clipboard
                                    ss("Citation copied to clipboard");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Save Citation",
                                  size: bs.sm,
                                  onPressed: _saveCitation,
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.share,
                                size: bs.sm,
                                onPressed: () {
                                  ss("Citation shared successfully");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  // Recent Citations
                  if (recentCitations.isNotEmpty) ...[
                    Text(
                      "Recent Citations",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    ...recentCitations.take(3).map((citation) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
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
                                Expanded(
                                  child: Text(
                                    "${citation["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${citation["style"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "by ${citation["author"]} • ${citation["source"]} • ${DateTime.parse(citation["date"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(5),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${citation["citation"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                QButton(
                                  label: "Copy",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Citation copied to clipboard");
                                  },
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  label: "Reuse",
                                  size: bs.sm,
                                  onPressed: () {
                                    title = citation["title"];
                                    author = citation["author"];
                                    selectedStyle = citation["style"];
                                    selectedSource = citation["source"];
                                    setState(() {});
                                    ss("Citation loaded for editing");
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ],
              ),
            ),
    );
  }

  void _showCitationGuide() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Citation Style Guide",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStyleGuide("MLA Style", "Modern Language Association format, commonly used in humanities and literature.", primaryColor),
                      _buildStyleGuide("APA Style", "American Psychological Association format, used in psychology and social sciences.", successColor),
                      _buildStyleGuide("Chicago Style", "Used in history and literature, offers both notes-bibliography and author-date systems.", infoColor),
                      _buildStyleGuide("Harvard Style", "Author-date system used widely in sciences and social sciences.", warningColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStyleGuide(String title, String description, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showSavedCitations() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Saved Citations (${recentCitations.length})",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              Expanded(
                child: ListView.builder(
                  itemCount: recentCitations.length,
                  itemBuilder: (context, index) {
                    final citation = recentCitations[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${citation["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${citation["style"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${citation["citation"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              QButton(
                                label: "Copy",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Citation copied to clipboard");
                                },
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                label: "Edit",
                                size: bs.sm,
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Load citation for editing
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
