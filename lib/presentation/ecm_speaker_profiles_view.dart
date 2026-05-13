import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmSpeakerProfilesView extends StatefulWidget {
  const EcmSpeakerProfilesView({super.key});

  @override
  State<EcmSpeakerProfilesView> createState() => _EcmSpeakerProfilesViewState();
}

class _EcmSpeakerProfilesViewState extends State<EcmSpeakerProfilesView> {
  String searchQuery = "";
  String selectedExpertise = "All";
  String selectedLocation = "All";
  bool showFeaturedOnly = false;

  List<Map<String, dynamic>> expertiseOptions = [
    {"label": "All Expertise", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Business", "value": "Business"},
    {"label": "Design", "value": "Design"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Leadership", "value": "Leadership"},
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": "All"},
    {"label": "United States", "value": "US"},
    {"label": "Europe", "value": "EU"},
    {"label": "Asia Pacific", "value": "APAC"},
    {"label": "Virtual Only", "value": "Virtual"},
  ];

  List<Map<String, dynamic>> speakerProfiles = [
    {
      "id": "1",
      "name": "Dr. Sarah Johnson",
      "title": "Chief Technology Officer",
      "company": "TechCorp Solutions",
      "bio": "Dr. Johnson is a renowned technology leader with over 15 years of experience in AI and machine learning. She has led digital transformation initiatives at Fortune 500 companies and is a sought-after speaker on emerging technologies.",
      "avatar": "https://picsum.photos/200/200?random=1&keyword=speaker",
      "cover_image": "https://picsum.photos/800/300?random=1&keyword=conference",
      "location": "San Francisco, CA",
      "country": "US",
      "expertise": ["Artificial Intelligence", "Machine Learning", "Digital Transformation", "Leadership"],
      "languages": ["English", "Spanish"],
      "rating": 4.8,
      "reviews_count": 156,
      "sessions_delivered": 47,
      "years_experience": 15,
      "education": "PhD Computer Science, Stanford University",
      "certifications": ["AWS Solutions Architect", "Google Cloud Professional"],
      "social_linkedin": "https://linkedin.com/in/sarahjohnson",
      "social_twitter": "@sarahjohnson_ai",
      "social_website": "https://sarahjohnson.ai",
      "is_featured": true,
      "is_available": true,
      "speaking_fee_range": "15000-25000",
      "travel_required": true,
      "virtual_available": true,
      "achievements": [
        "TEDx Speaker - 2M+ views",
        "MIT Technology Review 35 Under 35",
        "Women in Tech Leadership Award 2023"
      ],
      "sample_topics": [
        "The Future of AI in Business",
        "Leading Digital Transformation",
        "Ethics in Machine Learning"
      ]
    },
    {
      "id": "2",
      "name": "Michael Chen",
      "title": "Senior Software Engineer",
      "company": "DevStudio",
      "bio": "Michael is a passionate full-stack developer with expertise in scalable web applications and cloud architecture. He has built systems handling millions of users and loves sharing his knowledge through workshops and technical talks.",
      "avatar": "https://picsum.photos/200/200?random=2&keyword=speaker",
      "cover_image": "https://picsum.photos/800/300?random=2&keyword=technology",
      "location": "Seattle, WA",
      "country": "US",
      "expertise": ["Web Development", "Cloud Architecture", "DevOps", "Microservices"],
      "languages": ["English", "Mandarin"],
      "rating": 4.6,
      "reviews_count": 89,
      "sessions_delivered": 32,
      "years_experience": 8,
      "education": "MS Computer Science, University of Washington",
      "certifications": ["Kubernetes Administrator", "Docker Certified Associate"],
      "social_linkedin": "https://linkedin.com/in/michaelchen",
      "social_twitter": "@devmike",
      "social_website": "https://michaelchen.dev",
      "is_featured": false,
      "is_available": true,
      "speaking_fee_range": "5000-10000",
      "travel_required": false,
      "virtual_available": true,
      "achievements": [
        "Open Source Contributor - 10k+ GitHub stars",
        "AWS Community Hero",
        "Tech Conference Speaker of the Year 2022"
      ],
      "sample_topics": [
        "Building Scalable Web Applications",
        "Kubernetes in Production",
        "Modern DevOps Practices"
      ]
    },
    {
      "id": "3",
      "name": "Emily Rodriguez",
      "title": "Head of Design",
      "company": "Creative Solutions",
      "bio": "Emily is an award-winning UX designer and design strategist. She specializes in design thinking methodologies and has helped numerous startups and enterprises create user-centered digital experiences.",
      "avatar": "https://picsum.photos/200/200?random=3&keyword=speaker",
      "cover_image": "https://picsum.photos/800/300?random=3&keyword=design",
      "location": "Barcelona, Spain",
      "country": "EU",
      "expertise": ["UX Design", "Design Thinking", "Product Strategy", "User Research"],
      "languages": ["English", "Spanish", "French"],
      "rating": 4.7,
      "reviews_count": 67,
      "sessions_delivered": 28,
      "years_experience": 10,
      "education": "MFA Interaction Design, RISD",
      "certifications": ["Google UX Design Certificate", "Design Thinking Facilitator"],
      "social_linkedin": "https://linkedin.com/in/emilyrodriguez",
      "social_twitter": "@emilydesigns",
      "social_website": "https://emilyrodriguez.design",
      "is_featured": true,
      "is_available": true,
      "speaking_fee_range": "8000-15000",
      "travel_required": true,
      "virtual_available": true,
      "achievements": [
        "UX Design Awards Winner 2023",
        "Design Week Speaker",
        "Forbes 30 Under 30 Design"
      ],
      "sample_topics": [
        "Design Thinking for Innovation",
        "The Future of UX Design",
        "Building Design Systems"
      ]
    },
    {
      "id": "4",
      "name": "David Wilson",
      "title": "Marketing Director",
      "company": "Growth Partners",
      "bio": "David is a growth marketing expert who has helped scale dozens of companies from startup to IPO. He specializes in data-driven marketing strategies and has a proven track record of driving explosive growth.",
      "avatar": "https://picsum.photos/200/200?random=4&keyword=speaker",
      "cover_image": "https://picsum.photos/800/300?random=4&keyword=marketing",
      "location": "London, UK",
      "country": "EU",
      "expertise": ["Digital Marketing", "Growth Hacking", "Analytics", "Brand Strategy"],
      "languages": ["English"],
      "rating": 4.5,
      "reviews_count": 124,
      "sessions_delivered": 41,
      "years_experience": 12,
      "education": "MBA Marketing, London Business School",
      "certifications": ["Google Analytics Certified", "Facebook Marketing Expert"],
      "social_linkedin": "https://linkedin.com/in/davidwilson",
      "social_twitter": "@davidgrowth",
      "social_website": "https://davidwilson.marketing",
      "is_featured": false,
      "is_available": false,
      "speaking_fee_range": "10000-18000",
      "travel_required": true,
      "virtual_available": true,
      "achievements": [
        "Marketing Week Awards Winner",
        "Growth Marketing Conference Keynote",
        "CMO of the Year Finalist 2022"
      ],
      "sample_topics": [
        "Growth Marketing Strategies",
        "Data-Driven Marketing",
        "Building Viral Products"
      ]
    },
    {
      "id": "5",
      "name": "Akiko Tanaka",
      "title": "Innovation Consultant",
      "company": "Future Labs Tokyo",
      "bio": "Akiko is a leading innovation strategist helping organizations navigate digital transformation. She combines Eastern and Western business philosophies to create sustainable innovation frameworks.",
      "avatar": "https://picsum.photos/200/200?random=5&keyword=speaker",
      "cover_image": "https://picsum.photos/800/300?random=5&keyword=innovation",
      "location": "Tokyo, Japan",
      "country": "APAC",
      "expertise": ["Innovation Strategy", "Digital Transformation", "Business Culture", "Startup Ecosystem"],
      "languages": ["Japanese", "English"],
      "rating": 4.9,
      "reviews_count": 203,
      "sessions_delivered": 65,
      "years_experience": 18,
      "education": "PhD Business Innovation, University of Tokyo",
      "certifications": ["Innovation Management Professional", "Lean Startup Facilitator"],
      "social_linkedin": "https://linkedin.com/in/akikotanaka",
      "social_twitter": "@akiko_innovation",
      "social_website": "https://akikotanaka.com",
      "is_featured": true,
      "is_available": true,
      "speaking_fee_range": "12000-20000",
      "travel_required": true,
      "virtual_available": true,
      "achievements": [
        "World Innovation Forum Keynote",
        "Harvard Business Review Contributor",
        "Japan Innovation Award 2023"
      ],
      "sample_topics": [
        "Innovation in the Digital Age",
        "East Meets West: Business Innovation",
        "Building Innovation Culture"
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredProfiles {
    List<Map<String, dynamic>> filtered = speakerProfiles;
    
    if (selectedExpertise != "All") {
      filtered = filtered.where((profile) {
        return (profile["expertise"] as List).any((skill) => 
          skill.toLowerCase().contains(selectedExpertise.toLowerCase()));
      }).toList();
    }
    
    if (selectedLocation != "All") {
      if (selectedLocation == "Virtual") {
        filtered = filtered.where((profile) => profile["virtual_available"] == true).toList();
      } else {
        filtered = filtered.where((profile) => profile["country"] == selectedLocation).toList();
      }
    }
    
    if (showFeaturedOnly) {
      filtered = filtered.where((profile) => profile["is_featured"] == true).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((profile) {
        return profile["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               profile["company"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               profile["bio"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               (profile["expertise"] as List).any((skill) => skill.toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }
    
    // Sort by rating and featured status
    filtered.sort((a, b) {
      if (a["is_featured"] != b["is_featured"]) {
        return b["is_featured"] ? 1 : -1;
      }
      return (b["rating"] as double).compareTo(a["rating"] as double);
    });
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speaker Profiles"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.person_search,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Speaker Profiles",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Discover and connect with industry experts",
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
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search speakers",
                    value: searchQuery,
                    hint: "Search by name, company, or expertise",
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
                  onPressed: () {},
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Expertise",
                    items: expertiseOptions,
                    value: selectedExpertise,
                    onChanged: (value, label) {
                      selectedExpertise = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Location",
                    items: locationOptions,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QSwitch(
              items: [
                {
                  "label": "Show Featured Only",
                  "value": true,
                  "checked": showFeaturedOnly,
                }
              ],
              value: [
                if (showFeaturedOnly)
                  {
                    "label": "Show Featured Only",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showFeaturedOnly = values.isNotEmpty;
                setState(() {});
              },
            ),

            Container(
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
                      Icon(
                        Icons.people,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Expert Speakers",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${filteredProfiles.length} profiles",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  if (filteredProfiles.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.person_off,
                            size: 48,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No speakers found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search or filters",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...List.generate(filteredProfiles.length, (index) {
                      final speaker = filteredProfiles[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(bottom: spMd),
                          decoration: BoxDecoration(
                            color: speaker["is_featured"] 
                                ? primaryColor.withAlpha(5)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: speaker["is_featured"] 
                                  ? primaryColor.withAlpha(30)
                                  : disabledOutlineBorderColor,
                            ),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Cover Image with Featured Badge
                              Stack(
                                children: [
                                  Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(radiusMd),
                                        topRight: Radius.circular(radiusMd),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage("${speaker["cover_image"]}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if (speaker["is_featured"])
                                    Positioned(
                                      top: spSm,
                                      right: spSm,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: warningColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 10,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 2),
                                            Text(
                                              "FEATURED",
                                              style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (!speaker["is_available"])
                                    Positioned(
                                      top: spSm,
                                      left: spSm,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: dangerColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "UNAVAILABLE",
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              
                              Padding(
                                padding: EdgeInsets.all(spSm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Speaker Info with Avatar
                                    Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(radiusSm),
                                            border: Border.all(color: Colors.white, width: 3),
                                            image: DecorationImage(
                                              image: NetworkImage("${speaker["avatar"]}"),
                                              fit: BoxFit.cover,
                                            ),
                                            boxShadow: [shadowSm],
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${speaker["name"]}",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                              Text(
                                                "${speaker["title"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              Text(
                                                "${speaker["company"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: warningColor,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "${speaker["rating"]}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: disabledBoldColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "(${speaker["reviews_count"]} reviews)",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: disabledColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spSm),
                                    
                                    // Bio
                                    Text(
                                      "${speaker["bio"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                        height: 1.4,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: spSm),
                                    
                                    // Location and Experience
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${speaker["location"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.work,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${speaker["years_experience"]} years",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.event,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${speaker["sessions_delivered"]} sessions delivered",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "\$${speaker["speaking_fee_range"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spSm),
                                    
                                    // Expertise Tags
                                    Wrap(
                                      spacing: spXs,
                                      runSpacing: spXs,
                                      children: (speaker["expertise"] as List).take(4).map((skill) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: primaryColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "$skill",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: primaryColor,
                                            ),
                                          ),
                                        );
                                      }).toList().cast<Widget>(),
                                    ),
                                    SizedBox(height: spSm),
                                    
                                    // Availability Indicators
                                    Row(
                                      children: [
                                        if (speaker["virtual_available"])
                                          Container(
                                            margin: EdgeInsets.only(right: spXs),
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: successColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.videocam,
                                                  size: 10,
                                                  color: successColor,
                                                ),
                                                SizedBox(width: 2),
                                                Text(
                                                  "Virtual",
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    color: successColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (speaker["travel_required"])
                                          Container(
                                            margin: EdgeInsets.only(right: spXs),
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: infoColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.flight,
                                                  size: 10,
                                                  color: infoColor,
                                                ),
                                                SizedBox(width: 2),
                                                Text(
                                                  "Travels",
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    color: infoColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        Spacer(),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: (speaker["languages"] as List).take(2).map((lang) {
                                            return Container(
                                              margin: EdgeInsets.only(left: 2),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 4,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: disabledColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "$lang",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            );
                                          }).toList().cast<Widget>(),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spSm),
                                    
                                    // Action Buttons
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 36,
                                            child: QButton(
                                              label: "View Profile",
                                              size: bs.sm,
                                              onPressed: () {},
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Expanded(
                                          child: Container(
                                            height: 36,
                                            decoration: BoxDecoration(
                                              color: speaker["is_available"]
                                                  ? primaryColor.withAlpha(20)
                                                  : disabledColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Center(
                                              child: Text(
                                                speaker["is_available"] ? "Contact" : "Unavailable",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: speaker["is_available"]
                                                      ? primaryColor
                                                      : disabledColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: 36,
                                            height: 36,
                                            decoration: BoxDecoration(
                                              color: disabledColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Icon(
                                              Icons.bookmark_border,
                                              size: 18,
                                              color: disabledBoldColor,
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
                        ),
                      );
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
