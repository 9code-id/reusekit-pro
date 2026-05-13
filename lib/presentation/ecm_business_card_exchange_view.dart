import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmBusinessCardExchangeView extends StatefulWidget {
  const EcmBusinessCardExchangeView({super.key});

  @override
  State<EcmBusinessCardExchangeView> createState() => _EcmBusinessCardExchangeViewState();
}

class _EcmBusinessCardExchangeViewState extends State<EcmBusinessCardExchangeView> {
  String searchQuery = "";
  String selectedFilter = "All";
  bool isMyCardVisible = true;
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Contacts", "value": "All"},
    {"label": "Recent Exchanges", "value": "Recent"},
    {"label": "Favorites", "value": "Favorites"},
    {"label": "Pending Requests", "value": "Pending"},
  ];

  Map<String, dynamic> myBusinessCard = {
    "name": "John Smith",
    "title": "Senior Product Manager",
    "company": "TechCorp Solutions",
    "phone": "+1 (555) 123-4567",
    "email": "john.smith@techcorp.com",
    "website": "www.techcorp.com",
    "linkedin": "linkedin.com/in/johnsmith",
    "address": "123 Business Ave, Tech City, TC 12345",
    "qr_code": "https://picsum.photos/150/150?random=1&keyword=qr",
    "avatar": "https://picsum.photos/100/100?random=1&keyword=person"
  };

  List<Map<String, dynamic>> exchangedCards = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "title": "Marketing Director",
      "company": "Creative Agency",
      "phone": "+1 (555) 987-6543",
      "email": "sarah.j@creativeagency.com",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=person",
      "exchanged_date": "2024-01-15",
      "status": "Connected",
      "is_favorite": true,
      "meeting_notes": "Discussed potential collaboration on Q2 campaign"
    },
    {
      "id": "2",
      "name": "Michael Chen",
      "title": "Software Engineer",
      "company": "DevStudio",
      "phone": "+1 (555) 456-7890",
      "email": "m.chen@devstudio.com",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=person",
      "exchanged_date": "2024-01-14",
      "status": "Pending",
      "is_favorite": false,
      "meeting_notes": "Met at tech conference, interested in our APIs"
    },
    {
      "id": "3",
      "name": "Emily Rodriguez",
      "title": "Sales Manager",
      "company": "Global Solutions",
      "phone": "+1 (555) 321-0987",
      "email": "e.rodriguez@globalsolutions.com",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=person",
      "exchanged_date": "2024-01-13",
      "status": "Connected",
      "is_favorite": false,
      "meeting_notes": "Potential client for our enterprise package"
    },
  ];

  List<Map<String, dynamic>> get filteredCards {
    List<Map<String, dynamic>> filtered = exchangedCards;
    
    if (selectedFilter != "All") {
      if (selectedFilter == "Recent") {
        filtered = filtered.where((card) {
          DateTime exchangedDate = DateTime.parse(card["exchanged_date"]);
          return DateTime.now().difference(exchangedDate).inDays <= 7;
        }).toList();
      } else if (selectedFilter == "Favorites") {
        filtered = filtered.where((card) => card["is_favorite"] == true).toList();
      } else if (selectedFilter == "Pending") {
        filtered = filtered.where((card) => card["status"] == "Pending").toList();
      }
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((card) {
        return card["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               card["company"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               card["title"].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Cards"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
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
                    Icons.swap_horiz,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Digital Business Card Exchange",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Share and collect business cards seamlessly",
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
                      Text(
                        "My Business Card",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          isMyCardVisible = !isMyCardVisible;
                          setState(() {});
                        },
                        child: Icon(
                          isMyCardVisible ? Icons.visibility : Icons.visibility_off,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  if (isMyCardVisible) ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            primaryColor,
                            primaryColor.withAlpha(200),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${myBusinessCard["avatar"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${myBusinessCard["name"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "${myBusinessCard["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withAlpha(200),
                                      ),
                                    ),
                                    Text(
                                      "${myBusinessCard["company"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withAlpha(180),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Image.network(
                                  "${myBusinessCard["qr_code"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Share QR Code",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(color: Colors.white.withAlpha(100)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Edit Card",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
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

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search contacts",
                    value: searchQuery,
                    hint: "Search by name, company, or title",
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

            QDropdownField(
              label: "Filter Contacts",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
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
                        Icons.contacts,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Exchanged Business Cards",
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
                          "${filteredCards.length} contacts",
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
                  if (filteredCards.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.contact_page_outlined,
                            size: 48,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No contacts found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search or filter",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...List.generate(filteredCards.length, (index) {
                      final card = filteredCards[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor.withAlpha(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage("${card["avatar"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${card["name"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          if (card["is_favorite"])
                                            Icon(
                                              Icons.favorite,
                                              size: 14,
                                              color: warningColor,
                                            ),
                                        ],
                                      ),
                                      Text(
                                        "${card["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${card["company"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: card["status"] == "Connected"
                                        ? successColor.withAlpha(20)
                                        : warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${card["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: card["status"] == "Connected"
                                          ? successColor
                                          : warningColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "${card["email"]}",
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
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${card["phone"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Exchanged ${DateTime.parse(card["exchanged_date"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            if (card["meeting_notes"] != null && card["meeting_notes"].isNotEmpty) ...[
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.note,
                                      size: 12,
                                      color: infoColor,
                                    ),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        "${card["meeting_notes"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: infoColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 32,
                                    child: QButton(
                                      label: "Contact",
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Container(
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "View Details",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: disabledColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
