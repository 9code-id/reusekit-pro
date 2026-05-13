import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLibrary5View extends StatefulWidget {
  @override
  State<GrlLibrary5View> createState() => _GrlLibrary5ViewState();
}

class _GrlLibrary5ViewState extends State<GrlLibrary5View> {
  int currentTab = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> myBooks = [
    {
      "id": 1,
      "title": "Advanced Flutter Development",
      "author": "John Smith",
      "cover": "https://picsum.photos/300/400?random=1&keyword=flutter",
      "borrowDate": "2024-12-15",
      "dueDate": "2024-12-29",
      "status": "Active",
      "renewCount": 1,
      "maxRenewals": 3,
      "fine": 0.0,
    },
    {
      "id": 2,
      "title": "Machine Learning Basics",
      "author": "Dr. Sarah Johnson",
      "cover": "https://picsum.photos/300/400?random=2&keyword=ai",
      "borrowDate": "2024-12-10",
      "dueDate": "2024-12-24",
      "status": "Overdue",
      "renewCount": 2,
      "maxRenewals": 3,
      "fine": 5.50,
    },
    {
      "id": 3,
      "title": "Design Patterns",
      "author": "Gang of Four",
      "cover": "https://picsum.photos/300/400?random=3&keyword=design",
      "borrowDate": "2024-12-01",
      "dueDate": "2024-12-15",
      "status": "Returned",
      "renewCount": 0,
      "maxRenewals": 3,
      "fine": 0.0,
    },
  ];

  List<Map<String, dynamic>> reservations = [
    {
      "id": 1,
      "title": "Quantum Computing",
      "author": "Dr. Michael Chen",
      "cover": "https://picsum.photos/300/400?random=4&keyword=quantum",
      "reservedDate": "2024-12-20",
      "position": 2,
      "estimatedAvailable": "2024-12-28",
      "status": "Waiting",
    },
    {
      "id": 2,
      "title": "Blockchain Technology",
      "author": "Alice Brown",
      "cover": "https://picsum.photos/300/400?random=5&keyword=blockchain",
      "reservedDate": "2024-12-18",
      "position": 1,
      "estimatedAvailable": "2024-12-25",
      "status": "Ready for Pickup",
    },
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "id": 1,
      "title": "Clean Code",
      "author": "Robert Martin",
      "cover": "https://picsum.photos/300/400?random=6&keyword=code",
      "rating": 4.8,
      "reason": "Based on your interest in software development",
      "category": "Programming",
    },
    {
      "id": 2,
      "title": "The Pragmatic Programmer",
      "author": "Dave Thomas",
      "cover": "https://picsum.photos/300/400?random=7&keyword=programming",
      "rating": 4.9,
      "reason": "Recommended by readers like you",
      "category": "Programming",
    },
    {
      "id": 3,
      "title": "Data Science Handbook",
      "author": "Jake VanderPlas",
      "cover": "https://picsum.photos/300/400?random=8&keyword=data",
      "rating": 4.7,
      "reason": "Follows your ML reading history",
      "category": "Data Science",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Overdue":
        return dangerColor;
      case "Returned":
        return disabledBoldColor;
      case "Ready for Pickup":
        return successColor;
      case "Waiting":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  int _getDaysUntilDue(String dueDate) {
    final due = DateTime.parse(dueDate);
    final now = DateTime.now();
    return due.difference(now).inDays;
  }

  Widget _buildMyBooksTab() {
    return Column(
      spacing: spSm,
      children: [
        // Search Bar
        QTextField(
          label: "Search my books",
          value: searchQuery,
          hint: "Search by title or author",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),

        // Summary Cards
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Text(
                      "${myBooks.where((b) => b["status"] == "Active").length}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Active",
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
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: dangerColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Text(
                      "${myBooks.where((b) => b["status"] == "Overdue").length}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Overdue",
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
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Text(
                      "\$${((myBooks.map((b) => b["fine"] as double).fold<double>(0.0, (sum, fine) => sum + fine))).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Total Fines",
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
        ),

        // Books List
        ...myBooks.map((book) {
          final daysUntilDue = _getDaysUntilDue(book["dueDate"] as String);
          return Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: book["status"] == "Overdue" 
                ? Border.all(color: dangerColor, width: 2)
                : null,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${book["cover"]}",
                    width: 60,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${book["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor(book["status"] as String),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${book["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "by ${book["author"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (book["status"] != "Returned")
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Due: ${DateTime.parse(book["dueDate"] as String).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: book["status"] == "Overdue" ? dangerColor : disabledBoldColor,
                                fontWeight: book["status"] == "Overdue" ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                            if (book["status"] == "Active")
                              Text(
                                " (${daysUntilDue} days left)",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: daysUntilDue <= 3 ? warningColor : successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      if ((book["fine"] as double) > 0)
                        Row(
                          children: [
                            Icon(
                              Icons.payment,
                              size: 14,
                              color: dangerColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Fine: \$${(book["fine"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          Text(
                            "Renewals: ${book["renewCount"]}/${book["maxRenewals"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          if (book["status"] == "Active" && (book["renewCount"] as int) < (book["maxRenewals"] as int))
                            QButton(
                              label: "Renew",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          if (book["status"] == "Overdue")
                            QButton(
                              label: "Pay Fine",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildReservationsTab() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(color: infoColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: infoColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reservation System",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Books will be held for 3 days once available. You'll receive a notification when ready for pickup.",
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
        ),

        ...reservations.map((reservation) {
          return Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: reservation["status"] == "Ready for Pickup"
                ? Border.all(color: successColor, width: 2)
                : null,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${reservation["cover"]}",
                    width: 60,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${reservation["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor(reservation["status"] as String),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${reservation["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "by ${reservation["author"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.queue,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Position: #${reservation["position"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Est. Available: ${DateTime.parse(reservation["estimatedAvailable"] as String).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Reserved: ${DateTime.parse(reservation["reservedDate"] as String).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            label: reservation["status"] == "Ready for Pickup" ? "Pickup" : "Cancel",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildRecommendationsTab() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(color: primaryColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personalized Recommendations",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Based on your reading history and preferences, we've selected books you might enjoy.",
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
        ),

        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: recommendations.map((book) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                    child: Image.network(
                      "${book["cover"]}",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${book["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "by ${book["author"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: warningColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${book["rating"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${book["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${book["reason"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Add to Wishlist",
                            size: bs.sm,
                            onPressed: () {},
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "My Library",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "My Books", icon: Icon(Icons.library_books)),
        Tab(text: "Reservations", icon: Icon(Icons.bookmark)),
        Tab(text: "Recommendations", icon: Icon(Icons.auto_awesome)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildMyBooksTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildReservationsTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildRecommendationsTab(),
        ),
      ],
    );
  }
}
