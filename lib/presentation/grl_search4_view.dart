import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSearch4View extends StatefulWidget {
  @override
  State<GrlSearch4View> createState() => _GrlSearch4ViewState();
}

class _GrlSearch4ViewState extends State<GrlSearch4View> {
  String searchQuery = "";
  String selectedJobType = "all";
  String selectedLocation = "all";
  String selectedExperience = "all";
  String selectedSalary = "all";
  bool isRemoteOnly = false;

  List<Map<String, dynamic>> quickSearches = [
    {"title": "Remote Jobs", "icon": Icons.home_work, "count": 1250},
    {"title": "Full Time", "icon": Icons.work, "count": 890},
    {"title": "Part Time", "icon": Icons.schedule, "count": 450},
    {"title": "Internship", "icon": Icons.school, "count": 220}
  ];

  List<Map<String, dynamic>> jobListings = [
    {
      "id": 1,
      "title": "Senior Flutter Developer",
      "company": "TechCorp Inc.",
      "location": "San Francisco, CA",
      "type": "Full-time",
      "experience": "Senior",
      "salary": "120k - 160k",
      "remote": true,
      "posted": "2 days ago",
      "logo": "https://picsum.photos/60/60?random=1&keyword=company",
      "tags": ["Flutter", "Dart", "Mobile Development", "iOS", "Android"],
      "description": "We're looking for a senior Flutter developer to join our growing mobile team. You'll be responsible for building cross-platform applications.",
      "applicants": 45,
      "featured": true,
      "urgent": false
    },
    {
      "id": 2,
      "title": "UI/UX Designer",
      "company": "Design Studio Pro",
      "location": "New York, NY",
      "type": "Full-time",
      "experience": "Mid-level",
      "salary": "80k - 110k",
      "remote": false,
      "posted": "1 week ago",
      "logo": "https://picsum.photos/60/60?random=2&keyword=design",
      "tags": ["Figma", "Adobe XD", "Prototyping", "User Research"],
      "description": "Join our creative team to design beautiful and intuitive user experiences for web and mobile applications.",
      "applicants": 78,
      "featured": false,
      "urgent": true
    },
    {
      "id": 3,
      "title": "Product Manager",
      "company": "StartupX",
      "location": "Austin, TX",
      "type": "Full-time",
      "experience": "Senior",
      "salary": "130k - 180k",
      "remote": true,
      "posted": "3 days ago",
      "logo": "https://picsum.photos/60/60?random=3&keyword=startup",
      "tags": ["Product Strategy", "Agile", "Analytics", "Leadership"],
      "description": "Lead product development initiatives and work closely with engineering and design teams to deliver exceptional user experiences.",
      "applicants": 23,
      "featured": true,
      "urgent": false
    },
    {
      "id": 4,
      "title": "Junior Frontend Developer",
      "company": "WebDev Solutions",
      "location": "Remote",
      "type": "Full-time",
      "experience": "Entry-level",
      "salary": "60k - 80k",
      "remote": true,
      "posted": "5 days ago",
      "logo": "https://picsum.photos/60/60?random=4&keyword=web",
      "tags": ["React", "JavaScript", "HTML", "CSS", "Git"],
      "description": "Perfect opportunity for a junior developer to grow their skills in a supportive environment while working on exciting projects.",
      "applicants": 156,
      "featured": false,
      "urgent": false
    }
  ];

  List<Map<String, dynamic>> jobTypes = [
    {"label": "All Types", "value": "all"},
    {"label": "Full-time", "value": "full_time"},
    {"label": "Part-time", "value": "part_time"},
    {"label": "Contract", "value": "contract"},
    {"label": "Internship", "value": "internship"}
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": "all"},
    {"label": "San Francisco", "value": "san_francisco"},
    {"label": "New York", "value": "new_york"},
    {"label": "Austin", "value": "austin"},
    {"label": "Remote", "value": "remote"}
  ];

  List<Map<String, dynamic>> experienceLevels = [
    {"label": "All Levels", "value": "all"},
    {"label": "Entry-level", "value": "entry"},
    {"label": "Mid-level", "value": "mid"},
    {"label": "Senior", "value": "senior"},
    {"label": "Executive", "value": "executive"}
  ];

  List<Map<String, dynamic>> salaryRanges = [
    {"label": "All Salaries", "value": "all"},
    {"label": "Under \$60k", "value": "under_60k"},
    {"label": "\$60k - \$100k", "value": "60k_100k"},
    {"label": "\$100k - \$150k", "value": "100k_150k"},
    {"label": "Over \$150k", "value": "over_150k"}
  ];

  List<Map<String, dynamic>> get filteredJobs {
    List<Map<String, dynamic>> filtered = jobListings;
    
    if (selectedJobType != "all") {
      filtered = filtered.where((job) => 
        job["type"].toString().toLowerCase().replaceAll("-", "_").contains(selectedJobType.replaceAll("_", ""))
      ).toList();
    }
    
    if (isRemoteOnly) {
      filtered = filtered.where((job) => job["remote"] as bool).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Search"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              // Show saved jobs
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show advanced filters
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
            // Search Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Find Your Dream Job",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Discover opportunities that match your skills and passion",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                  
                  // Search Input
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm),
                            child: QTextField(
                              label: "Job title, keywords, or company",
                              value: searchQuery,
                              hint: "e.g. Flutter Developer",
                              onChanged: (value) {
                                searchQuery = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(spXs),
                          child: QButton(
                            icon: Icons.search,
                            size: bs.sm,
                            onPressed: () {
                              // Perform search
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Quick Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Job Type",
                    items: jobTypes,
                    value: selectedJobType,
                    onChanged: (value, label) {
                      selectedJobType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Location",
                    items: locations,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Remote Toggle
            QSwitch(
              items: [
                {
                  "label": "Remote Jobs Only",
                  "value": true,
                  "checked": isRemoteOnly,
                }
              ],
              value: [if (isRemoteOnly) {"label": "Remote Jobs Only", "value": true, "checked": true}],
              onChanged: (values, ids) {
                isRemoteOnly = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Content based on search state
            if (searchQuery.isEmpty) ...[
              // Quick Search Options
              Text(
                "Quick Search",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.all(spXs),
                minItemWidth: 200,
                children: quickSearches.map((quick) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            quick["icon"] as IconData,
                            size: 32,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${quick["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(quick["count"] as int)} jobs",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Featured Jobs
              SizedBox(height: spMd),
              Text(
                "Featured Jobs",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QHorizontalScroll(
                children: jobListings.where((job) => job["featured"] as bool).map((job) {
                  return Container(
                    width: 280,
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: Border.all(color: primaryColor, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Featured Badge
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.white,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Featured",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Job Content
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    child: Image.network(
                                      "${job["logo"]}",
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${job["title"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${job["company"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${job["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${job["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (job["remote"] as bool) ...[
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "Remote",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: infoColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                "${job["salary"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
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

            // Search Results
            if (searchQuery.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${filteredJobs.length} jobs found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Sort by: Relevance",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),

              // Job Listings
              Column(
                spacing: spSm,
                children: filteredJobs.map((job) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: (job["featured"] as bool)
                          ? Border.all(color: primaryColor, width: 1)
                          : null,
                    ),
                    child: Column(
                      children: [
                        // Urgent Badge
                        if (job["urgent"] as bool) ...[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusSm),
                                topRight: Radius.circular(radiusSm),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.flash_on,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Urgent Hiring",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        // Job Content
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    child: Image.network(
                                      "${job["logo"]}",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs,
                                      children: [
                                        Text(
                                          "${job["title"]}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${job["company"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 16,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${job["location"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            if (job["remote"] as bool) ...[
                                              SizedBox(width: spSm),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: spXs,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: infoColor.withAlpha(30),
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Text(
                                                  "Remote",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: infoColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.bookmark_border,
                                      color: disabledBoldColor,
                                    ),
                                    onPressed: () {
                                      // Save job
                                    },
                                  ),
                                ],
                              ),

                              Text(
                                "${job["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Job Details
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${job["type"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${job["experience"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Tags
                              if (job["tags"] != null) ...[
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: spXs,
                                  children: (job["tags"] as List).take(4).map((tag) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: disabledColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "$tag",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],

                              // Bottom Info
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${job["salary"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                      Text(
                                        "Posted ${job["posted"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${(job["applicants"] as int)} applicants",
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
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
