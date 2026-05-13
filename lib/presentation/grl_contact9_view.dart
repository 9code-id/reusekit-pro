import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlContact9View extends StatefulWidget {
  @override
  State<GrlContact9View> createState() => _GrlContact9ViewState();
}

class _GrlContact9ViewState extends State<GrlContact9View> {
  String searchQuery = "";
  String selectedCategory = "all";
  bool showAdvancedSearch = false;
  String nameFilter = "";
  String emailFilter = "";
  String phoneFilter = "";
  String companyFilter = "";
  String tagFilter = "";
  String locationFilter = "";
  
  List<Map<String, dynamic>> contacts = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 (555) 123-4567",
      "company": "Tech Solutions Inc.",
      "position": "Senior Developer",
      "location": "New York, NY",
      "tags": ["colleague", "developer", "tech"],
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "lastContact": DateTime.now().subtract(Duration(days: 2)),
      "category": "work",
      "notes": "Lead developer on the mobile app project. Very responsive via email.",
      "socialMedia": {
        "linkedin": "sarah-johnson-dev",
        "twitter": "@sarahj_codes",
      },
    },
    {
      "id": 2,
      "name": "Michael Chen",
      "email": "michael.chen@business.com",
      "phone": "+1 (555) 987-6543",
      "company": "Global Enterprises",
      "position": "Product Manager",
      "location": "San Francisco, CA",
      "tags": ["client", "manager", "important"],
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "lastContact": DateTime.now().subtract(Duration(hours: 5)),
      "category": "business",
      "notes": "Key stakeholder for the Q3 product launch. Prefers phone calls over emails.",
      "socialMedia": {
        "linkedin": "michael-chen-pm",
      },
    },
    {
      "id": 3,
      "name": "Emma Wilson",
      "email": "emma.wilson@gmail.com",
      "phone": "+1 (555) 456-7890",
      "company": "Freelancer",
      "position": "UX Designer",
      "location": "Austin, TX",
      "tags": ["designer", "creative", "freelancer"],
      "avatar": "https://picsum.photos/100/100?random=3&keyword=designer",
      "lastContact": DateTime.now().subtract(Duration(days: 7)),
      "category": "personal",
      "notes": "Talented designer with great attention to detail. Works remotely.",
      "socialMedia": {
        "behance": "emmawilson-ux",
        "dribbble": "emmaw_designs",
      },
    },
    {
      "id": 4,
      "name": "David Rodriguez",
      "email": "d.rodriguez@legal.com",
      "phone": "+1 (555) 321-0987",
      "company": "Rodriguez & Associates",
      "position": "Legal Counsel",
      "location": "Chicago, IL",
      "tags": ["lawyer", "legal", "advisor"],
      "avatar": "https://picsum.photos/100/100?random=4&keyword=lawyer",
      "lastContact": DateTime.now().subtract(Duration(days: 14)),
      "category": "business",
      "notes": "Corporate lawyer specializing in tech startups. Very thorough and professional.",
      "socialMedia": {
        "linkedin": "david-rodriguez-legal",
      },
    },
    {
      "id": 5,
      "name": "Lisa Park",
      "email": "lisa.park@design.studio",
      "phone": "+1 (555) 654-3210",
      "company": "Creative Studio",
      "position": "Art Director",
      "location": "Los Angeles, CA",
      "tags": ["creative", "director", "design"],
      "avatar": "https://picsum.photos/100/100?random=5&keyword=artist",
      "lastContact": DateTime.now().subtract(Duration(days: 1)),
      "category": "work",
      "notes": "Creative director with excellent taste. Always delivers on time.",
      "socialMedia": {
        "instagram": "@lisapark_creative",
        "behance": "lisapark-studio",
      },
    },
  ];

  List<String> categories = ["all", "work", "business", "personal", "family", "friends"];
  List<String> availableTags = ["colleague", "developer", "tech", "client", "manager", "important", "designer", "creative", "freelancer", "lawyer", "legal", "advisor", "director", "design"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredContacts = contacts.where((contact) {
      bool matchesSearch = searchQuery.isEmpty ||
          contact["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          contact["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          contact["phone"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          contact["company"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || contact["category"] == selectedCategory;
      
      bool matchesAdvanced = true;
      if (showAdvancedSearch) {
        matchesAdvanced = (nameFilter.isEmpty || contact["name"].toString().toLowerCase().contains(nameFilter.toLowerCase())) &&
                         (emailFilter.isEmpty || contact["email"].toString().toLowerCase().contains(emailFilter.toLowerCase())) &&
                         (phoneFilter.isEmpty || contact["phone"].toString().toLowerCase().contains(phoneFilter.toLowerCase())) &&
                         (companyFilter.isEmpty || contact["company"].toString().toLowerCase().contains(companyFilter.toLowerCase())) &&
                         (tagFilter.isEmpty || (contact["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(tagFilter.toLowerCase()))) &&
                         (locationFilter.isEmpty || contact["location"].toString().toLowerCase().contains(locationFilter.toLowerCase()));
      }
      
      return matchesSearch && matchesCategory && matchesAdvanced;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Advanced Search"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveSearchQuery(),
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => _showSearchHistory(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Basic Search
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search contacts...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    QButton(
                      icon: showAdvancedSearch ? Icons.expand_less : Icons.expand_more,
                      size: bs.sm,
                      onPressed: () {
                        showAdvancedSearch = !showAdvancedSearch;
                        setState(() {});
                      },
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                // Category Filter
                QHorizontalScroll(
                  children: categories.map((category) => GestureDetector(
                    onTap: () {
                      selectedCategory = category;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: selectedCategory == category ? primaryColor : Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedCategory == category ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  )).toList(),
                ),

                // Advanced Search Fields
                if (showAdvancedSearch) ...[
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Advanced Filters",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        
                        // Name and Email
                        Row(
                          children: [
                            Expanded(
                              child: QTextField(
                                label: "Name",
                                value: nameFilter,
                                onChanged: (value) {
                                  nameFilter = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: QTextField(
                                label: "Email",
                                value: emailFilter,
                                onChanged: (value) {
                                  emailFilter = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spMd),
                        
                        // Phone and Company
                        Row(
                          children: [
                            Expanded(
                              child: QTextField(
                                label: "Phone",
                                value: phoneFilter,
                                onChanged: (value) {
                                  phoneFilter = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: QTextField(
                                label: "Company",
                                value: companyFilter,
                                onChanged: (value) {
                                  companyFilter = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spMd),
                        
                        // Tag and Location
                        Row(
                          children: [
                            Expanded(
                              child: QTextField(
                                label: "Tags",
                                value: tagFilter,
                                onChanged: (value) {
                                  tagFilter = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: QTextField(
                                label: "Location",
                                value: locationFilter,
                                onChanged: (value) {
                                  locationFilter = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spMd),
                        
                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Clear Filters",
                                size: bs.sm,
                                onPressed: () => _clearFilters(),
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: QButton(
                                label: "Save Search",
                                size: bs.sm,
                                onPressed: () => _saveSearchQuery(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Results Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: Colors.grey[100],
            child: Row(
              children: [
                Text(
                  "Found ${filteredContacts.length} contacts",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => _exportSearchResults(filteredContacts),
                  child: Row(
                    children: [
                      Icon(
                        Icons.download,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Export",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Results List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        // Avatar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${contact["avatar"]}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        
                        SizedBox(width: spMd),
                        
                        // Contact Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${contact["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                              SizedBox(height: spXs),
                              
                              Text(
                                "${contact["position"]} at ${contact["company"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              
                              SizedBox(height: spXs),
                              
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${contact["email"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spXs),
                              
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${contact["phone"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spSm),
                              
                              // Tags
                              Wrap(
                                spacing: spXs,
                                children: (contact["tags"] as List).take(3).map((tag) => Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "$tag",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )).toList(),
                              ),
                            ],
                          ),
                        ),
                        
                        // Actions
                        Column(
                          children: [
                            QButton(
                              icon: Icons.visibility,
                              size: bs.sm,
                              onPressed: () => _viewContact(contact),
                            ),
                            SizedBox(height: spSm),
                            GestureDetector(
                              onTap: () => _showContactActions(contact),
                              child: Icon(
                                Icons.more_vert,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSavedSearches(),
        backgroundColor: primaryColor,
        child: Icon(
          Icons.bookmark,
          color: Colors.white,
        ),
      ),
    );
  }

  void _clearFilters() {
    nameFilter = "";
    emailFilter = "";
    phoneFilter = "";
    companyFilter = "";
    tagFilter = "";
    locationFilter = "";
    searchQuery = "";
    selectedCategory = "all";
    setState(() {});
  }

  void _saveSearchQuery() {
    ss("Search query saved successfully");
  }

  void _showSearchHistory() {
    // Show recent searches
  }

  void _exportSearchResults(List<Map<String, dynamic>> results) {
    ss("Exporting ${results.length} contacts...");
  }

  void _viewContact(Map<String, dynamic> contact) {
    // Navigate to contact details
  }

  void _showContactActions(Map<String, dynamic> contact) {
    // Show contact action menu
  }

  void _showSavedSearches() {
    // Show saved search queries
  }
}
