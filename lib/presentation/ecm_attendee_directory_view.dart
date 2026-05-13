import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmAttendeeDirectoryView extends StatefulWidget {
  const EcmAttendeeDirectoryView({super.key});

  @override
  State<EcmAttendeeDirectoryView> createState() => _EcmAttendeeDirectoryViewState();
}

class _EcmAttendeeDirectoryViewState extends State<EcmAttendeeDirectoryView> {
  String searchQuery = "";
  String selectedIndustry = "all";
  String selectedRole = "all";
  bool showContactsOnly = false;

  List<Map<String, dynamic>> attendees = [
    {
      "id": 1,
      "name": "Alex Johnson",
      "title": "Senior Software Engineer",
      "company": "TechCorp",
      "industry": "Technology",
      "location": "San Francisco, CA",
      "avatar": "https://picsum.photos/80/80?random=1&face",
      "bio": "Passionate about building scalable web applications and mentoring junior developers.",
      "skills": ["JavaScript", "React", "Node.js", "Python", "AWS"],
      "interests": ["AI/ML", "Open Source", "Startups"],
      "experience_years": 8,
      "education": "BS Computer Science - Stanford University",
      "social_links": {
        "linkedin": "linkedin.com/in/alexjohnson",
        "twitter": "@alexjohnsondev",
        "github": "github.com/alexjohnson"
      },
      "contact_info": {
        "email": "alex.johnson@techcorp.com",
        "phone": "+1 555-0150",
        "website": "alexjohnson.dev"
      },
      "availability": "Available for networking",
      "looking_for": ["Collaboration opportunities", "Tech discussions", "Mentorship"],
      "offering": ["Code reviews", "Architecture advice", "Career guidance"],
      "is_contact": false,
    },
    {
      "id": 2,
      "name": "Sarah Chen",
      "title": "Product Manager",
      "company": "Innovation Labs",
      "industry": "Technology",
      "location": "New York, NY",
      "avatar": "https://picsum.photos/80/80?random=2&face",
      "bio": "Product strategist with focus on user experience and data-driven decisions.",
      "skills": ["Product Strategy", "User Research", "Analytics", "Agile", "Design Thinking"],
      "interests": ["UX Design", "Data Science", "Product Innovation"],
      "experience_years": 6,
      "education": "MBA - Harvard Business School",
      "social_links": {
        "linkedin": "linkedin.com/in/sarahchen",
        "twitter": "@sarahpm"
      },
      "contact_info": {
        "email": "sarah.chen@innovlabs.com",
        "phone": "+1 555-0151"
      },
      "availability": "Open to meetings",
      "looking_for": ["Product partnerships", "User feedback", "Industry insights"],
      "offering": ["Product advice", "User research", "Market analysis"],
      "is_contact": true,
    },
    {
      "id": 3,
      "name": "Michael Rodriguez",
      "title": "Investment Director",
      "company": "Venture Capital Partners",
      "industry": "Finance",
      "location": "Austin, TX",
      "avatar": "https://picsum.photos/80/80?random=3&face",
      "bio": "Early-stage investor focused on fintech and healthcare innovations.",
      "skills": ["Investment Analysis", "Due Diligence", "Portfolio Management", "Financial Modeling"],
      "interests": ["Fintech", "Healthcare", "SaaS", "B2B Platforms"],
      "experience_years": 12,
      "education": "MBA Finance - Wharton School",
      "social_links": {
        "linkedin": "linkedin.com/in/michaelrodriguez",
        "website": "vcpartners.com/team/michael"
      },
      "contact_info": {
        "email": "m.rodriguez@vcpartners.com",
        "phone": "+1 555-0152"
      },
      "availability": "Limited availability",
      "looking_for": ["Investment opportunities", "Startup pitches", "Industry reports"],
      "offering": ["Funding", "Strategic advice", "Network connections"],
      "is_contact": false,
    },
    {
      "id": 4,
      "name": "Dr. Amanda Foster",
      "title": "Research Scientist",
      "company": "AI Research Institute",
      "industry": "Research",
      "location": "Boston, MA",
      "avatar": "https://picsum.photos/80/80?random=4&face",
      "bio": "Leading research in machine learning and natural language processing.",
      "skills": ["Machine Learning", "Deep Learning", "NLP", "Python", "TensorFlow"],
      "interests": ["AI Ethics", "Computer Vision", "Research Collaboration"],
      "experience_years": 10,
      "education": "PhD Computer Science - MIT",
      "social_links": {
        "linkedin": "linkedin.com/in/amandafoster",
        "website": "airesearch.org/team/amanda"
      },
      "contact_info": {
        "email": "amanda.foster@airesearch.org",
        "phone": "+1 555-0153"
      },
      "availability": "Available for collaborations",
      "looking_for": ["Research partnerships", "Academic collaborations", "Tech discussions"],
      "offering": ["Research expertise", "Technical consulting", "Academic insights"],
      "is_contact": true,
    },
  ];

  List<Map<String, dynamic>> industryOptions = [
    {"label": "All Industries", "value": "all"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Healthcare", "value": "Healthcare"},
    {"label": "Research", "value": "Research"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Design", "value": "Design"},
  ];

  List<Map<String, dynamic>> roleOptions = [
    {"label": "All Roles", "value": "all"},
    {"label": "Engineer", "value": "engineer"},
    {"label": "Manager", "value": "manager"},
    {"label": "Director", "value": "director"},
    {"label": "CEO/Founder", "value": "ceo"},
    {"label": "Researcher", "value": "researcher"},
    {"label": "Designer", "value": "designer"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendee Directory"),
        actions: [
          IconButton(
            icon: Icon(Icons.contacts),
            onPressed: () {
              si("My contacts not implemented");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildDirectoryStats(),
            _buildAttendeeGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
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
            "Search & Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search attendees...",
                  value: searchQuery,
                  hint: "Name, company, skills, or interests",
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
                onPressed: () {
                  // Perform search
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Industry",
                  items: industryOptions,
                  value: selectedIndustry,
                  onChanged: (value, label) {
                    selectedIndustry = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Role",
                  items: roleOptions,
                  value: selectedRole,
                  onChanged: (value, label) {
                    selectedRole = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Show my contacts only",
                "value": true,
                "checked": showContactsOnly,
              }
            ],
            value: [
              if (showContactsOnly)
                {
                  "label": "Show my contacts only",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              showContactsOnly = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDirectoryStats() {
    int totalAttendees = attendees.length;
    int myContacts = attendees.where((a) => a["is_contact"] == true).length;
    List<String> topIndustries = attendees
        .map((a) => a["industry"] as String)
        .toSet()
        .toList();
    int availableForNetworking = attendees.where((a) => 
        a["availability"].toString().toLowerCase().contains("available")).length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.people,
                  size: 28,
                  color: primaryColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$totalAttendees",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Attendees",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.contacts,
                  size: 28,
                  color: successColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$myContacts",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "My Contacts",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.business,
                  size: 28,
                  color: infoColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "${topIndustries.length}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Industries",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.accessibility,
                  size: 28,
                  color: warningColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$availableForNetworking",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Available",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttendeeGrid() {
    List<Map<String, dynamic>> filteredAttendees = attendees.where((attendee) {
      bool industryMatch = selectedIndustry == "all" || attendee["industry"] == selectedIndustry;
      bool roleMatch = selectedRole == "all" || 
                      attendee["title"].toString().toLowerCase().contains(selectedRole == "engineer" ? "engineer" :
                      selectedRole == "manager" ? "manager" :
                      selectedRole == "director" ? "director" :
                      selectedRole == "ceo" ? "ceo" :
                      selectedRole == "researcher" ? "research" :
                      selectedRole == "designer" ? "design" : selectedRole);
      bool contactMatch = !showContactsOnly || attendee["is_contact"] == true;
      bool searchMatch = searchQuery.isEmpty ||
                        attendee["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                        attendee["company"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                        (attendee["skills"] as List).any((skill) => skill.toString().toLowerCase().contains(searchQuery.toLowerCase())) ||
                        (attendee["interests"] as List).any((interest) => interest.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      
      return industryMatch && roleMatch && contactMatch && searchMatch;
    }).toList();

    return Container(
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
          Row(
            children: [
              Text(
                "Directory",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredAttendees.length} attendees",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (filteredAttendees.isEmpty) ...[
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 32,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "No attendees found",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredAttendees.map((attendee) => _buildAttendeeCard(attendee)).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAttendeeCard(Map<String, dynamic> attendee) {
    bool isContact = attendee["is_contact"] as bool;
    String availability = attendee["availability"];
    Color availabilityColor = availability.toLowerCase().contains("available") ? successColor :
                             availability.toLowerCase().contains("limited") ? warningColor : dangerColor;

    List<String> skills = (attendee["skills"] as List).cast<String>();
    List<String> interests = (attendee["interests"] as List).cast<String>();
    List<String> lookingFor = (attendee["looking_for"] as List).cast<String>();
    List<String> offering = (attendee["offering"] as List).cast<String>();

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isContact ? successColor : primaryColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("${attendee["avatar"]}"),
                  ),
                  if (isContact)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${attendee["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${attendee["title"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${attendee["company"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${attendee["location"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${attendee["bio"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          // Availability Status
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: availabilityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
              border: Border.all(color: availabilityColor.withAlpha(50)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.circle,
                  size: 8,
                  color: availabilityColor,
                ),
                SizedBox(width: spXs),
                Text(
                  availability,
                  style: TextStyle(
                    fontSize: 10,
                    color: availabilityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Experience & Education
          Row(
            children: [
              Icon(
                Icons.work,
                size: 12,
                color: infoColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${attendee["experience_years"]} years experience",
                style: TextStyle(
                  fontSize: 10,
                  color: infoColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          // Skills
          if (skills.isNotEmpty) ...[
            Text(
              "Skills",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: skills.take(3).map((skill) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Text(
                  skill,
                  style: TextStyle(
                    fontSize: 9,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),
            if (skills.length > 3)
              Text(
                "... and ${skills.length - 3} more",
                style: TextStyle(
                  fontSize: 9,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],

          // Interests
          if (interests.isNotEmpty) ...[
            Text(
              "Interests",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: interests.take(3).map((interest) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: warningColor.withAlpha(50)),
                ),
                child: Text(
                  interest,
                  style: TextStyle(
                    fontSize: 9,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),
          ],

          // Looking For & Offering
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Looking for:",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    ...lookingFor.take(2).map((item) => Text(
                      "• $item",
                      style: TextStyle(
                        fontSize: 9,
                        color: successColor,
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Offering:",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    ...offering.take(2).map((item) => Text(
                      "• $item",
                      style: TextStyle(
                        fontSize: 9,
                        color: dangerColor,
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: isContact ? "View Contact" : "Add Contact",
                  size: bs.sm,
                  onPressed: () {
                    if (!isContact) {
                      attendee["is_contact"] = true;
                      setState(() {});
                      ss("Added ${attendee["name"]} to contacts");
                    } else {
                      si("Contact details not implemented");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.message,
                size: bs.sm,
                onPressed: () {
                  si("Message feature not implemented");
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  si("More options not implemented");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
