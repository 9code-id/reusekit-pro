import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaPhotoBooksView extends StatefulWidget {
  const PpaPhotoBooksView({super.key});

  @override
  State<PpaPhotoBooksView> createState() => _PpaPhotoBooksViewState();
}

class _PpaPhotoBooksViewState extends State<PpaPhotoBooksView> {
  String selectedTemplate = "Classic Wedding";
  String selectedSize = "8x10";
  String selectedCover = "Hardcover";
  String bookTitle = "";
  int selectedPhotos = 0;
  
  List<Map<String, dynamic>> templates = [
    {"label": "Classic Wedding", "value": "Classic Wedding"},
    {"label": "Baby Memories", "value": "Baby Memories"},
    {"label": "Travel Adventure", "value": "Travel Adventure"},
    {"label": "Family Portrait", "value": "Family Portrait"},
    {"label": "Graduation", "value": "Graduation"},
    {"label": "Birthday Party", "value": "Birthday Party"},
    {"label": "Anniversary", "value": "Anniversary"},
    {"label": "Custom Design", "value": "Custom Design"},
  ];

  List<Map<String, dynamic>> sizeOptions = [
    {"label": "6x6 inch", "value": "6x6"},
    {"label": "8x8 inch", "value": "8x8"},
    {"label": "8x10 inch", "value": "8x10"},
    {"label": "10x10 inch", "value": "10x10"},
    {"label": "11x14 inch", "value": "11x14"},
    {"label": "12x12 inch", "value": "12x12"},
  ];

  List<Map<String, dynamic>> coverOptions = [
    {"label": "Hardcover", "value": "Hardcover"},
    {"label": "Softcover", "value": "Softcover"},
    {"label": "Premium Hardcover", "value": "Premium Hardcover"},
    {"label": "Leather Bound", "value": "Leather Bound"},
    {"label": "Dust Jacket", "value": "Dust Jacket"},
  ];

  List<Map<String, dynamic>> photoBooks = [
    {
      "id": "book_001",
      "title": "Wedding Memories 2024",
      "template": "Classic Wedding",
      "size": "8x10",
      "cover": "Hardcover",
      "pages": 24,
      "photos": 45,
      "status": "Completed",
      "createdDate": "2024-06-16",
      "lastModified": "2024-06-16",
      "price": 49.99,
      "thumbnail": "https://picsum.photos/150/200?random=1&keyword=wedding",
    },
    {
      "id": "book_002",
      "title": "Family Vacation 2024",
      "template": "Travel Adventure",
      "size": "10x10",
      "cover": "Premium Hardcover",
      "pages": 32,
      "photos": 68,
      "status": "In Progress",
      "createdDate": "2024-06-15",
      "lastModified": "2024-06-16",
      "price": 65.99,
      "thumbnail": "https://picsum.photos/150/200?random=2&keyword=travel",
    },
    {
      "id": "book_003",
      "title": "Baby's First Year",
      "template": "Baby Memories",
      "size": "8x8",
      "cover": "Softcover",
      "pages": 20,
      "photos": 35,
      "status": "Draft",
      "createdDate": "2024-06-14",
      "lastModified": "2024-06-15",
      "price": 29.99,
      "thumbnail": "https://picsum.photos/150/200?random=3&keyword=baby",
    },
  ];

  List<Map<String, dynamic>> featuredTemplates = [
    {
      "name": "Classic Wedding",
      "description": "Elegant layouts for your special day",
      "pages": "20-40 pages",
      "price": "From \$39.99",
      "thumbnail": "https://picsum.photos/200/150?random=4&keyword=wedding",
    },
    {
      "name": "Travel Adventure",
      "description": "Document your journeys around the world",
      "pages": "24-48 pages",
      "price": "From \$44.99",
      "thumbnail": "https://picsum.photos/200/150?random=5&keyword=travel",
    },
    {
      "name": "Baby Memories",
      "description": "Capture precious moments of growth",
      "pages": "16-32 pages",
      "price": "From \$29.99",
      "thumbnail": "https://picsum.photos/200/150?random=6&keyword=baby",
    },
    {
      "name": "Family Portrait",
      "description": "Celebrate your family bonds",
      "pages": "20-36 pages", 
      "price": "From \$34.99",
      "thumbnail": "https://picsum.photos/200/150?random=7&keyword=family",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Books"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showPhotoBookGuide();
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              _showCart();
            },
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
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.menu_book,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create Beautiful Photo Books",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Turn your digital photos into premium quality photo books",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Featured Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: featuredTemplates.map((template) {
                return _buildTemplateCard(template);
              }).toList(),
            ),

            Text(
              "Create New Photo Book",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
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
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Book Title",
                    value: bookTitle,
                    hint: "Enter your photo book title",
                    onChanged: (value) {
                      bookTitle = value;
                      setState(() {});
                    },
                  ),

                  QDropdownField(
                    label: "Template",
                    items: templates,
                    value: selectedTemplate,
                    onChanged: (value, label) {
                      selectedTemplate = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Size",
                          items: sizeOptions,
                          value: selectedSize,
                          onChanged: (value, label) {
                            selectedSize = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Cover Type",
                          items: coverOptions,
                          value: selectedCover,
                          onChanged: (value, label) {
                            selectedCover = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Select Photos",
                          size: bs.md,
                          icon: Icons.photo_library,
                          onPressed: () {
                            _selectPhotosForBook();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "$selectedPhotos selected",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Estimated Price",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "• $selectedSize $selectedCover: \$${_calculatePrice().toStringAsFixed(2)}",
                          style: TextStyle(color: disabledBoldColor, fontSize: 14),
                        ),
                        Text(
                          "• Estimated pages: ${(selectedPhotos / 2.5).ceil() + 4}",
                          style: TextStyle(color: disabledBoldColor, fontSize: 14),
                        ),
                        if (selectedPhotos > 0) ...[
                          Text(
                            "• $selectedPhotos photos included",
                            style: TextStyle(color: disabledBoldColor, fontSize: 14),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            QButton(
              label: "Create Photo Book",
              size: bs.md,
              icon: Icons.add,
              onPressed: () {
                _createPhotoBook();
              },
            ),

            Text(
              "My Photo Books",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: photoBooks.map((book) {
                return _buildPhotoBookCard(book);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Image.network(
              "${template["thumbnail"]}",
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${template["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${template["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "${template["pages"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${template["price"]}",
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Use Template",
                    size: bs.sm,
                    onPressed: () {
                      setState(() {
                        selectedTemplate = template["name"];
                      });
                      ss("Template ${template["name"]} selected");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoBookCard(Map<String, dynamic> book) {
    Color statusColor = _getBookStatusColor(book["status"]);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Stack(
              children: [
                Image.network(
                  "${book["thumbnail"]}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(200),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${book["status"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${book["title"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${book["template"]} • ${book["size"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.photo,
                      color: disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${book["photos"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.pages,
                      color: disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${book["pages"]}p",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(book["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: book["status"] == "Completed" ? "Order Print" : "Edit",
                        size: bs.sm,
                        onPressed: () {
                          if (book["status"] == "Completed") {
                            _orderPhotoBook(book["id"]);
                          } else {
                            _editPhotoBook(book["id"]);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    QButton(
                      label: "Preview",
                      size: bs.sm,
                      icon: Icons.visibility,
                      onPressed: () {
                        _previewPhotoBook(book["id"]);
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Share",
                      size: bs.sm,
                      icon: Icons.share,
                      onPressed: () {
                        _sharePhotoBook(book["id"]);
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        _deletePhotoBook(book["id"]);
                      },
                      child: Icon(
                        Icons.delete,
                        color: dangerColor,
                        size: 18,
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
  }

  Color _getBookStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Draft":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  double _calculatePrice() {
    double basePrice = 29.99;
    
    if (selectedSize == "10x10" || selectedSize == "11x14" || selectedSize == "12x12") {
      basePrice += 15.0;
    } else if (selectedSize == "8x10") {
      basePrice += 10.0;
    }
    
    if (selectedCover == "Premium Hardcover") {
      basePrice += 20.0;
    } else if (selectedCover == "Leather Bound") {
      basePrice += 35.0;
    } else if (selectedCover == "Hardcover") {
      basePrice += 10.0;
    }
    
    return basePrice;
  }

  void _selectPhotosForBook() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Photos"),
          content: Text("Photo selection interface would be implemented here."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Select (25)",
              size: bs.sm,
              onPressed: () {
                setState(() {
                  selectedPhotos = 25;
                });
                Navigator.pop(context);
                ss("25 photos selected for photo book");
              },
            ),
          ],
        );
      },
    );
  }

  void _createPhotoBook() {
    if (bookTitle.isEmpty) {
      se("Please enter a book title");
      return;
    }
    
    if (selectedPhotos == 0) {
      se("Please select photos for your book");
      return;
    }

    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Photo book created successfully!");
      setState(() {
        bookTitle = "";
        selectedPhotos = 0;
      });
    });
  }

  void _showPhotoBookGuide() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Photo Book Guide"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Creating the perfect photo book:"),
              SizedBox(height: spSm),
              Text("1. Choose a template that matches your theme"),
              Text("2. Select high-quality photos"),
              Text("3. Arrange photos chronologically or by theme"),
              Text("4. Add captions and text"),
              Text("5. Review and order your book"),
            ],
          ),
          actions: [
            QButton(
              label: "Got it",
              size: bs.sm,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _showCart() {
    si("Showing shopping cart");
  }

  void _editPhotoBook(String bookId) {
    si("Editing photo book $bookId");
  }

  void _previewPhotoBook(String bookId) {
    si("Previewing photo book $bookId");
  }

  void _sharePhotoBook(String bookId) {
    si("Sharing photo book $bookId");
  }

  void _orderPhotoBook(String bookId) {
    ss("Photo book added to cart");
  }

  void _deletePhotoBook(String bookId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this photo book?");
    if (isConfirmed) {
      ss("Photo book deleted successfully");
    }
  }
}
