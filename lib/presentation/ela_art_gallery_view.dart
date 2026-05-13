import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaArtGalleryView extends StatefulWidget {
  const ElaArtGalleryView({super.key});

  @override
  State<ElaArtGalleryView> createState() => _ElaArtGalleryViewState();
}

class _ElaArtGalleryViewState extends State<ElaArtGalleryView> {
  String selectedPeriod = "All";
  String selectedStyle = "All";
  String selectedArtist = "All";
  String searchQuery = "";
  bool loading = false;
  bool showFavorites = false;
  List<String> favoriteArtworks = [];

  List<Map<String, dynamic>> periods = [
    {"label": "All", "value": "All"},
    {"label": "Renaissance", "value": "Renaissance"},
    {"label": "Baroque", "value": "Baroque"},
    {"label": "Impressionism", "value": "Impressionism"},
    {"label": "Modern", "value": "Modern"},
    {"label": "Contemporary", "value": "Contemporary"},
  ];

  List<Map<String, dynamic>> styles = [
    {"label": "All", "value": "All"},
    {"label": "Painting", "value": "Painting"},
    {"label": "Sculpture", "value": "Sculpture"},
    {"label": "Drawing", "value": "Drawing"},
    {"label": "Photography", "value": "Photography"},
    {"label": "Digital Art", "value": "Digital Art"},
  ];

  List<Map<String, dynamic>> artists = [
    {"label": "All", "value": "All"},
    {"label": "Leonardo da Vinci", "value": "Leonardo da Vinci"},
    {"label": "Vincent van Gogh", "value": "Vincent van Gogh"},
    {"label": "Pablo Picasso", "value": "Pablo Picasso"},
    {"label": "Claude Monet", "value": "Claude Monet"},
    {"label": "Michelangelo", "value": "Michelangelo"},
  ];

  List<Map<String, dynamic>> artworks = [
    {
      "id": "1",
      "title": "Mona Lisa",
      "artist": "Leonardo da Vinci",
      "year": 1503,
      "period": "Renaissance",
      "style": "Painting",
      "medium": "Oil on poplar wood",
      "dimensions": "77 cm × 53 cm",
      "location": "Louvre Museum, Paris",
      "image": "https://picsum.photos/400/500?random=1&keyword=monalisa",
      "description": "Portrait of Lisa Gherardini, wife of a Florentine merchant",
      "significance": "Most famous painting in the world, known for the subject's enigmatic smile",
      "techniques": ["Sfumato", "Atmospheric perspective", "Oil painting"],
      "themes": ["Portrait", "Renaissance humanism", "Feminine beauty"],
      "funFacts": [
        "The painting has no visible eyebrows or eyelashes",
        "It was stolen in 1911 and missing for two years",
        "Napoleon hung it in his bedroom for a time",
        "The subject's identity was debated for centuries"
      ],
      "rating": 4.9,
      "views": 12500000,
    },
    {
      "id": "2",
      "title": "Starry Night",
      "artist": "Vincent van Gogh",
      "year": 1889,
      "period": "Modern",
      "style": "Painting",
      "medium": "Oil on canvas",
      "dimensions": "73.7 cm × 92.1 cm",
      "location": "Museum of Modern Art, New York",
      "image": "https://picsum.photos/400/500?random=2&keyword=starrynight",
      "description": "View from van Gogh's asylum room window with an imaginary village",
      "significance": "One of the most recognizable paintings in Western art",
      "techniques": ["Impasto", "Post-impressionism", "Swirling brushstrokes"],
      "themes": ["Mental state", "Nature", "Night sky", "Village life"],
      "funFacts": [
        "Painted while van Gogh was in a mental asylum",
        "The cypress tree dominates the left side",
        "The painting depicts both observed and imagined elements",
        "It has inspired countless reproductions and parodies"
      ],
      "rating": 4.8,
      "views": 8900000,
    },
    {
      "id": "3",
      "title": "Guernica",
      "artist": "Pablo Picasso",
      "year": 1937,
      "period": "Modern",
      "style": "Painting",
      "medium": "Oil on canvas",
      "dimensions": "349.3 cm × 776.6 cm",
      "location": "Museo Reina Sofía, Madrid",
      "image": "https://picsum.photos/400/500?random=3&keyword=guernica",
      "description": "Response to the bombing of Guernica during Spanish Civil War",
      "significance": "Powerful anti-war statement and symbol of peace",
      "techniques": ["Cubism", "Monochromatic palette", "Fragmented forms"],
      "themes": ["War", "Suffering", "Political protest", "Human tragedy"],
      "funFacts": [
        "Painted in black, white, and gray only",
        "Took Picasso about a month to complete",
        "Toured the world as a symbol of peace",
        "Banned from Spain during Franco's dictatorship"
      ],
      "rating": 4.7,
      "views": 6700000,
    },
    {
      "id": "4",
      "title": "Water Lilies",
      "artist": "Claude Monet",
      "year": 1919,
      "period": "Impressionism",
      "style": "Painting",
      "medium": "Oil on canvas",
      "dimensions": "200 cm × 850 cm",
      "location": "Musée de l'Orangerie, Paris",
      "image": "https://picsum.photos/400/500?random=4&keyword=waterlilies",
      "description": "Series of paintings depicting Monet's garden pond at Giverny",
      "significance": "Masterpiece of Impressionism and precursor to abstract art",
      "techniques": ["Impressionism", "Plein air painting", "Color theory"],
      "themes": ["Nature", "Light reflection", "Garden beauty", "Serenity"],
      "funFacts": [
        "Monet painted over 250 water lily paintings",
        "Created in his own garden pond",
        "Painted despite failing eyesight",
        "Influenced abstract expressionist painters"
      ],
      "rating": 4.6,
      "views": 5400000,
    },
    {
      "id": "5",
      "title": "The Creation of Adam",
      "artist": "Michelangelo",
      "year": 1512,
      "period": "Renaissance",
      "style": "Painting",
      "medium": "Fresco",
      "dimensions": "280 cm × 570 cm",
      "location": "Sistine Chapel, Vatican",
      "image": "https://picsum.photos/400/500?random=5&keyword=sistinechapel",
      "description": "Scene from the Book of Genesis painted on the Sistine Chapel ceiling",
      "significance": "One of the most famous religious artworks in Western art",
      "techniques": ["Fresco painting", "Renaissance perspective", "Anatomical accuracy"],
      "themes": ["Biblical narrative", "Divine creation", "Human form", "Spirituality"],
      "funFacts": [
        "Part of the larger Sistine Chapel ceiling",
        "Took 4 years to complete the entire ceiling",
        "Michelangelo painted lying on his back",
        "The famous touching fingers scene"
      ],
      "rating": 4.9,
      "views": 11200000,
    },
    {
      "id": "6",
      "title": "The Persistence of Memory",
      "artist": "Salvador Dalí",
      "year": 1931,
      "period": "Modern",
      "style": "Painting",
      "medium": "Oil on canvas",
      "dimensions": "24 cm × 33 cm",
      "location": "Museum of Modern Art, New York",
      "image": "https://picsum.photos/400/500?random=6&keyword=dali",
      "description": "Surrealist painting featuring melting clocks in a dreamscape",
      "significance": "Icon of Surrealism exploring concepts of time and memory",
      "techniques": ["Surrealism", "Hyperrealism", "Symbolic imagery"],
      "themes": ["Time", "Memory", "Dreams", "Subconscious"],
      "funFacts": [
        "Inspired by melted Camembert cheese",
        "One of the most recognizable surrealist works",
        "Small size but enormous impact",
        "Features Dalí's hometown landscape"
      ],
      "rating": 4.5,
      "views": 7800000,
    },
  ];

  List<Map<String, dynamic>> get filteredArtworks {
    var filtered = artworks.where((artwork) {
      bool periodMatch = selectedPeriod == "All" || artwork["period"] == selectedPeriod;
      bool styleMatch = selectedStyle == "All" || artwork["style"] == selectedStyle;
      bool artistMatch = selectedArtist == "All" || artwork["artist"] == selectedArtist;
      bool searchMatch = searchQuery.isEmpty ||
          artwork["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          artwork["artist"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool favoriteMatch = !showFavorites || favoriteArtworks.contains(artwork["id"]);
      return periodMatch && styleMatch && artistMatch && searchMatch && favoriteMatch;
    }).toList();

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Art Gallery"),
        actions: [
          IconButton(
            icon: Icon(
              showFavorites ? Icons.favorite : Icons.favorite_border,
              color: showFavorites ? dangerColor : null,
            ),
            onPressed: () {
              showFavorites = !showFavorites;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.palette),
            onPressed: () {
              // Navigate to art techniques
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
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.museum,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Virtual Art Gallery",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Explore masterpieces from history's greatest artists",
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

            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Search & Filter",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  QTextField(
                    label: "Search artworks or artists...",
                    value: searchQuery,
                    hint: "Enter artwork title or artist name",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: periods,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Style",
                          items: styles,
                          value: selectedStyle,
                          onChanged: (value, label) {
                            selectedStyle = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Artist",
                    items: artists,
                    value: selectedArtist,
                    onChanged: (value, label) {
                      selectedArtist = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Statistics Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredArtworks.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Artworks",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${favoriteArtworks.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Favorites",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${((filteredArtworks.map((a) => a["views"] as int).reduce((a, b) => a + b)) / 1000000).toStringAsFixed(1)}M",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Views",
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

            // Quick Actions
            if (!showFavorites)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Virtual Tour",
                            icon: Icons.tour,
                            size: bs.sm,
                            onPressed: () {
                              // Start virtual tour
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Art Quiz",
                            icon: Icons.quiz,
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to art quiz
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Artworks Grid
            Row(
              children: [
                Expanded(
                  child: Text(
                    showFavorites ? "Favorite Artworks" : "Gallery Collection",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (filteredArtworks.isNotEmpty)
                  Text(
                    "${filteredArtworks.length} artworks",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
              ],
            ),
            
            if (filteredArtworks.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      showFavorites ? Icons.favorite_border : Icons.search_off,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      showFavorites 
                          ? "No favorite artworks yet"
                          : "No artworks match your filters",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      showFavorites
                          ? "Add artworks to favorites by tapping the heart icon"
                          : "Try adjusting your search criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredArtworks.map((artwork) {
                  final isFavorite = favoriteArtworks.contains(artwork["id"]);
                  
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Artwork Image
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(radiusMd),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(radiusMd),
                                ),
                                child: Image.network(
                                  "${artwork["image"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: spXs,
                              right: spXs,
                              child: GestureDetector(
                                onTap: () {
                                  if (isFavorite) {
                                    favoriteArtworks.remove(artwork["id"]);
                                  } else {
                                    favoriteArtworks.add(artwork["id"]);
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [shadowSm],
                                  ),
                                  child: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? dangerColor : disabledBoldColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: spXs,
                              left: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${artwork["period"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Content
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${artwork["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${artwork["artist"]} • ${artwork["year"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${artwork["description"]}",
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
                                    Icons.star,
                                    size: 14,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${artwork["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.visibility,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${((artwork["views"] as int) / 1000000).toStringAsFixed(1)}M",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${artwork["style"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${artwork["location"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    _showArtworkDetails(artwork);
                                  },
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
        ),
      ),
    );
  }

  void _showArtworkDetails(Map<String, dynamic> artwork) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: EdgeInsets.only(top: spSm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Header
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${artwork["title"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${artwork["artist"]} • ${artwork["year"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            final isFavorite = favoriteArtworks.contains(artwork["id"]);
                            if (isFavorite) {
                              favoriteArtworks.remove(artwork["id"]);
                            } else {
                              favoriteArtworks.add(artwork["id"]);
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              favoriteArtworks.contains(artwork["id"]) 
                                  ? Icons.favorite 
                                  : Icons.favorite_border,
                              color: favoriteArtworks.contains(artwork["id"]) 
                                  ? dangerColor 
                                  : disabledBoldColor,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Image
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Image.network(
                          "${artwork["image"]}",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),

                    // Basic Info
                    _buildDetailSection("Artwork Information", [
                      {"label": "Medium", "value": "${artwork["medium"]}"},
                      {"label": "Dimensions", "value": "${artwork["dimensions"]}"},
                      {"label": "Period", "value": "${artwork["period"]}"},
                      {"label": "Style", "value": "${artwork["style"]}"},
                      {"label": "Location", "value": "${artwork["location"]}"},
                      {"label": "Rating", "value": "${artwork["rating"]}/5.0"},
                      {"label": "Views", "value": "${((artwork["views"] as int) / 1000000).toStringAsFixed(1)}M"},
                    ]),

                    // Description and Significance
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${artwork["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Historical Significance",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "${artwork["significance"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Techniques
                    _buildListSection("Artistic Techniques", artwork["techniques"]),

                    // Themes
                    _buildListSection("Themes", artwork["themes"]),

                    // Fun Facts
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "Fun Facts",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ...((artwork["funFacts"] as List).map((fact) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  margin: EdgeInsets.only(top: 6),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "$fact",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList()),
                        ],
                      ),
                    ),

                    // Close Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Close",
                        size: bs.md,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Map<String, String>> info) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...info.map((item) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    "${item["label"]}:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${item["value"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildListSection(String title, List<dynamic> items) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: items.map((item) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$item",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
