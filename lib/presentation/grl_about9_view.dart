import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAbout9View extends StatefulWidget {
  @override
  State<GrlAbout9View> createState() => _GrlAbout9ViewState();
}

class _GrlAbout9ViewState extends State<GrlAbout9View> {
  String selectedNewsCategory = 'all';
  
  List<Map<String, dynamic>> categories = [
    {"label": "All News", "value": "all"},
    {"label": "Product Updates", "value": "product"},
    {"label": "Company News", "value": "company"},
    {"label": "Industry Insights", "value": "industry"},
    {"label": "Press Releases", "value": "press"},
  ];

  List<Map<String, dynamic>> newsArticles = [
    {
      "title": "Introducing AI-Powered Analytics Dashboard",
      "excerpt": "We're excited to announce the launch of our new AI-powered analytics dashboard that provides deeper insights and automated recommendations.",
      "category": "product",
      "date": DateTime.now().subtract(Duration(days: 2)),
      "readTime": "3 min read",
      "author": "Product Team",
      "image": "https://picsum.photos/400/250?random=1&keyword=analytics",
      "featured": true,
      "views": 1523,
      "likes": 234,
    },
    {
      "title": "TechCorp Raises \$15M Series B Funding",
      "excerpt": "We've successfully closed our Series B funding round to accelerate product development and global expansion initiatives.",
      "category": "company",
      "date": DateTime.now().subtract(Duration(days: 5)),
      "readTime": "5 min read",
      "author": "Leadership Team",
      "image": "https://picsum.photos/400/250?random=2&keyword=funding",
      "featured": true,
      "views": 2847,
      "likes": 456,
    },
    {
      "title": "2024 Digital Transformation Trends",
      "excerpt": "Our analysis of the key digital transformation trends that will shape businesses in 2024 and beyond.",
      "category": "industry",
      "date": DateTime.now().subtract(Duration(days: 7)),
      "readTime": "8 min read",
      "author": "Research Team",
      "image": "https://picsum.photos/400/250?random=3&keyword=technology",
      "featured": false,
      "views": 1876,
      "likes": 189,
    },
    {
      "title": "New Mobile App Version 3.0 Released",
      "excerpt": "Our latest mobile app update includes enhanced performance, new features, and improved user experience.",
      "category": "product",
      "date": DateTime.now().subtract(Duration(days: 10)),
      "readTime": "4 min read",
      "author": "Mobile Team",
      "image": "https://picsum.photos/400/250?random=4&keyword=mobile",
      "featured": false,
      "views": 1234,
      "likes": 156,
    },
    {
      "title": "TechCorp Named 'Best Workplace 2024'",
      "excerpt": "We're honored to be recognized as one of the best workplaces by the Great Place to Work Institute.",
      "category": "company",
      "date": DateTime.now().subtract(Duration(days: 14)),
      "readTime": "2 min read",
      "author": "HR Team",
      "image": "https://picsum.photos/400/250?random=5&keyword=workplace",
      "featured": false,
      "views": 987,
      "likes": 123,
    },
    {
      "title": "Enhanced Security Features Now Available",
      "excerpt": "We've implemented advanced security measures including two-factor authentication and end-to-end encryption.",
      "category": "product",
      "date": DateTime.now().subtract(Duration(days: 18)),
      "readTime": "6 min read",
      "author": "Security Team",
      "image": "https://picsum.photos/400/250?random=6&keyword=security",
      "featured": false,
      "views": 1567,
      "likes": 278,
    },
    {
      "title": "Official Statement on Data Privacy",
      "excerpt": "Our commitment to protecting user privacy and the new measures we're implementing to ensure data security.",
      "category": "press",
      "date": DateTime.now().subtract(Duration(days: 21)),
      "readTime": "3 min read",
      "author": "Legal Team",
      "image": "https://picsum.photos/400/250?random=7&keyword=privacy",
      "featured": false,
      "views": 2156,
      "likes": 345,
    },
    {
      "title": "Q4 2024 Performance Highlights",
      "excerpt": "A comprehensive overview of our achievements and milestones reached in the fourth quarter of 2024.",
      "category": "company",
      "date": DateTime.now().subtract(Duration(days: 25)),
      "readTime": "7 min read",
      "author": "Executive Team",
      "image": "https://picsum.photos/400/250?random=8&keyword=performance",
      "featured": false,
      "views": 3421,
      "likes": 567,
    },
  ];

  List<Map<String, dynamic>> upcomingEvents = [
    {
      "title": "TechCorp Annual Conference 2024",
      "date": DateTime.now().add(Duration(days: 30)),
      "location": "San Francisco, CA",
      "type": "Conference",
      "description": "Join us for our biggest event of the year featuring keynotes, workshops, and networking opportunities.",
    },
    {
      "title": "Product Demo Webinar",
      "date": DateTime.now().add(Duration(days: 15)),
      "location": "Online",
      "type": "Webinar",
      "description": "Live demonstration of our latest features and Q&A session with our product team.",
    },
    {
      "title": "Developer Workshop",
      "date": DateTime.now().add(Duration(days: 45)),
      "location": "New York, NY",
      "type": "Workshop",
      "description": "Hands-on workshop for developers to learn about our APIs and integration capabilities.",
    },
  ];

  List<Map<String, dynamic>> mediaKit = [
    {
      "title": "Company Logos",
      "description": "High-resolution logos in various formats",
      "icon": Icons.image,
      "color": primaryColor,
    },
    {
      "title": "Product Screenshots",
      "description": "Latest product interface screenshots",
      "icon": Icons.screenshot,
      "color": infoColor,
    },
    {
      "title": "Executive Photos",
      "description": "Professional headshots of our leadership team",
      "icon": Icons.person,
      "color": successColor,
    },
    {
      "title": "Press Release Templates",
      "description": "Ready-to-use press release formats",
      "icon": Icons.article,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredNews = selectedNewsCategory == 'all' 
        ? newsArticles 
        : newsArticles.where((article) => article["category"] == selectedNewsCategory).toList();
    
    final featuredArticles = filteredNews.where((article) => article["featured"] == true).toList();
    final regularArticles = filteredNews.where((article) => article["featured"] == false).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("News & Updates"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
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
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.newspaper,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Text(
                          "Latest Updates",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Stay informed with the latest news, product updates, and industry insights from TechCorp. Get the inside scoop on our innovations and achievements.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Newsletter Signup
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.email,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Subscribe to Newsletter",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Get updates delivered to your inbox",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Subscribe",
                    size: bs.sm,
                    onPressed: () {
                      ss("Subscribed to newsletter!");
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // News Categories
            Row(
              children: [
                Text(
                  "Latest News",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${filteredNews.length} articles",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Category Filter
            QHorizontalScroll(
              children: categories.map((category) {
                final isSelected = selectedNewsCategory == category["value"];
                return GestureDetector(
                  onTap: () {
                    selectedNewsCategory = category["value"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Text(
                      "${category["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Featured Articles
            if (featuredArticles.isNotEmpty) ...[
              Text(
                "Featured Stories",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QHorizontalScroll(
                children: featuredArticles.map((article) => Container(
                  width: 320,
                  margin: EdgeInsets.only(right: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                          image: DecorationImage(
                            image: NetworkImage("${article["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black.withAlpha(150)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(spMd),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "FEATURED",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${article["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${article["excerpt"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spMd),
                            Row(
                              children: [
                                Text(
                                  "${(article["date"] as DateTime).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "•",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${article["readTime"]}",
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
                )).toList(),
              ),
              SizedBox(height: spMd),
            ],
            
            // Recent Articles
            Text(
              "Recent Articles",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...regularArticles.map((article) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      image: DecorationImage(
                        image: NetworkImage("${article["image"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${article["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${article["excerpt"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Text(
                              "${(article["date"] as DateTime).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "•",
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${article["readTime"]}",
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
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.visibility,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${article["views"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 14,
                            color: dangerColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${article["likes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Upcoming Events
            Text(
              "Upcoming Events",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...upcomingEvents.map((event) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.event,
                          color: infoColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${event["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${event["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${event["type"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${(event["date"] as DateTime).dMMMy}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${event["location"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Learn More",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Media Kit
            Text(
              "Media Kit",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: mediaKit.map((item) => Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: (item["color"] as Color).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        item["icon"] as IconData,
                        color: item["color"] as Color,
                        size: 32,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${item["title"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["description"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Download",
                        size: bs.sm,
                        onPressed: () {
                          ss("Download started");
                        },
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
