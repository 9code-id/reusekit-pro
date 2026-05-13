import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmProductImagesView extends StatefulWidget {
  const IwmProductImagesView({super.key});

  @override
  State<IwmProductImagesView> createState() => _IwmProductImagesViewState();
}

class _IwmProductImagesViewState extends State<IwmProductImagesView> {
  int selectedTab = 0;
  String selectedCategory = "all";
  String searchQuery = "";
  bool isGridView = true;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Home & Garden", "value": "home"},
    {"label": "Sports", "value": "sports"},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": "PROD001",
      "name": "Wireless Headphones",
      "sku": "WH-2024-001",
      "category": "electronics",
      "mainImage": "https://picsum.photos/300/300?random=1&keyword=headphones",
      "images": [
        "https://picsum.photos/300/300?random=1&keyword=headphones",
        "https://picsum.photos/300/300?random=2&keyword=headphones",
        "https://picsum.photos/300/300?random=3&keyword=headphones",
        "https://picsum.photos/300/300?random=4&keyword=headphones",
      ],
      "imageCount": 4,
      "lastUpdated": "2024-01-15",
      "status": "Complete",
    },
    {
      "id": "PROD002",
      "name": "Smart Watch",
      "sku": "SW-2024-002",
      "category": "electronics",
      "mainImage": "https://picsum.photos/300/300?random=5&keyword=watch",
      "images": [
        "https://picsum.photos/300/300?random=5&keyword=watch",
        "https://picsum.photos/300/300?random=6&keyword=watch",
      ],
      "imageCount": 2,
      "lastUpdated": "2024-01-14",
      "status": "Incomplete",
    },
    {
      "id": "PROD003",
      "name": "Running Shoes",
      "sku": "RS-2024-003",
      "category": "sports",
      "mainImage": "https://picsum.photos/300/300?random=7&keyword=shoes",
      "images": [
        "https://picsum.photos/300/300?random=7&keyword=shoes",
        "https://picsum.photos/300/300?random=8&keyword=shoes",
        "https://picsum.photos/300/300?random=9&keyword=shoes",
        "https://picsum.photos/300/300?random=10&keyword=shoes",
        "https://picsum.photos/300/300?random=11&keyword=shoes",
      ],
      "imageCount": 5,
      "lastUpdated": "2024-01-16",
      "status": "Complete",
    },
    {
      "id": "PROD004",
      "name": "Cotton T-Shirt",
      "sku": "CT-2024-004",
      "category": "clothing",
      "mainImage": "https://picsum.photos/300/300?random=12&keyword=shirt",
      "images": [
        "https://picsum.photos/300/300?random=12&keyword=shirt",
      ],
      "imageCount": 1,
      "lastUpdated": "2024-01-13",
      "status": "Incomplete",
    },
    {
      "id": "PROD005",
      "name": "Garden Tools Set",
      "sku": "GT-2024-005",
      "category": "home",
      "mainImage": "https://picsum.photos/300/300?random=13&keyword=tools",
      "images": [
        "https://picsum.photos/300/300?random=13&keyword=tools",
        "https://picsum.photos/300/300?random=14&keyword=tools",
        "https://picsum.photos/300/300?random=15&keyword=tools",
      ],
      "imageCount": 3,
      "lastUpdated": "2024-01-12",
      "status": "Complete",
    },
  ];

  List<Map<String, dynamic>> imageStats = [
    {
      "title": "Total Products",
      "value": 156,
      "subtitle": "With Images",
      "icon": Icons.inventory,
      "color": primaryColor,
    },
    {
      "title": "Complete Sets",
      "value": 128,
      "subtitle": "82% Complete",
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "Missing Images",
      "value": 28,
      "subtitle": "Need Attention",
      "icon": Icons.image_not_supported,
      "color": warningColor,
    },
    {
      "title": "Total Images",
      "value": 486,
      "subtitle": "Stored",
      "icon": Icons.photo_library,
      "color": infoColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Product Images",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Gallery", icon: Icon(Icons.photo_library)),
        Tab(text: "Management", icon: Icon(Icons.settings)),
        Tab(text: "Statistics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildGalleryTab(),
        _buildManagementTab(),
        _buildStatisticsTab(),
      ],
    );
  }

  Widget _buildGalleryTab() {
    List<Map<String, dynamic>> filteredProducts = products.where((product) {
      bool categoryMatch = selectedCategory == "all" || product["category"] == selectedCategory;
      bool searchMatch = searchQuery.isEmpty || 
          (product["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (product["sku"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGalleryFilters(),
          _buildImageStats(),
          if (isGridView) _buildGridView(filteredProducts) else _buildListView(filteredProducts),
        ],
      ),
    );
  }

  Widget _buildManagementTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildManagementActions(),
          _buildBulkUploadSection(),
          _buildImageProcessingQueue(),
        ],
      ),
    );
  }

  Widget _buildStatisticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailedStats(),
          _buildImageAnalytics(),
          _buildStorageUsage(),
        ],
      ),
    );
  }

  Widget _buildGalleryFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.search, color: disabledBoldColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Search products...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: isGridView ? Icons.list : Icons.grid_view,
                size: bs.sm,
                onPressed: () {
                  isGridView = !isGridView;
                  setState(() {});
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add_photo_alternate,
                label: "Add Images",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageStats() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: imageStats.map((stat) => _buildStatCard(stat)).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>> products) {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: products.map((product) => _buildProductImageCard(product)).toList(),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> products) {
    return Column(
      spacing: spSm,
      children: products.map((product) => _buildProductImageListItem(product)).toList(),
    );
  }

  Widget _buildProductImageCard(Map<String, dynamic> product) {
    Color statusColor = product["status"] == "Complete" ? successColor : warningColor;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  topRight: Radius.circular(radiusMd),
                ),
                child: Image.network(
                  "${product["mainImage"]}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${product["status"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.photo, color: Colors.white, size: 12),
                      SizedBox(width: 2),
                      Text(
                        "${product["imageCount"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "SKU: ${product["sku"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Updated: ${product["lastUpdated"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.edit,
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
  }

  Widget _buildProductImageListItem(Map<String, dynamic> product) {
    Color statusColor = product["status"] == "Complete" ? successColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${product["mainImage"]}",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "SKU: ${product["sku"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.photo, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${product["imageCount"]} images",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${product["status"]}",
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildManagementActions() {
    return Container(
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
            "Image Management Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Bulk Upload",
                  icon: Icons.cloud_upload,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Compress Images",
                  icon: Icons.compress,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Generate Thumbnails",
                  icon: Icons.photo_size_select_small,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Watermark Images",
                  icon: Icons.branding_watermark,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulkUploadSection() {
    return Container(
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
            "Bulk Upload Center",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: primaryColor.withAlpha(50),
                style: BorderStyle.solid,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload,
                  size: 48,
                  color: primaryColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "Drop files here or click to upload",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Supported: JPG, PNG, WebP (Max 10MB each)",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageProcessingQueue() {
    List<Map<String, dynamic>> processingQueue = [
      {"filename": "product_001.jpg", "status": "Processing", "progress": 0.75},
      {"filename": "product_002.png", "status": "Waiting", "progress": 0.0},
      {"filename": "product_003.jpg", "status": "Complete", "progress": 1.0},
    ];

    return Container(
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
            "Processing Queue",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...processingQueue.map((item) => _buildQueueItem(item)),
        ],
      ),
    );
  }

  Widget _buildQueueItem(Map<String, dynamic> item) {
    Color statusColor = _getProcessingStatusColor(item["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(Icons.image, color: primaryColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${item["filename"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          if (item["status"] == "Processing")
            LinearProgressIndicator(
              value: item["progress"],
              backgroundColor: disabledOutlineBorderColor,
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailedStats() {
    return Container(
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
            "Detailed Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildDetailedStatCard("Average Images per Product", "3.1", Icons.photo),
              _buildDetailedStatCard("Most Popular Format", "JPEG (67%)", Icons.image),
              _buildDetailedStatCard("Largest Image", "8.4 MB", Icons.file_present),
              _buildDetailedStatCard("Processing Time", "2.3 sec avg", Icons.timer),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryColor, size: 20),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageAnalytics() {
    return Container(
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
            "Image Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.analytics,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Image Upload Trends",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
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

  Widget _buildStorageUsage() {
    return Container(
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
            "Storage Usage",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Used: 2.4 GB of 10 GB",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: 0.24,
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Upgrade",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getProcessingStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "processing":
        return warningColor;
      case "complete":
        return successColor;
      case "waiting":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
