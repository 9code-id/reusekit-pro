import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:reusekit/core.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

late SharedPreferences prefs;
Future<void> initSharedPreferences() async {
  prefs = await SharedPreferences.getInstance();
  print("SharedPreferences initialized");
}

class AppView extends StatefulWidget {
  AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  String searchQuery = "";
  bool isAppsGridMode = false;
  bool isAutoPlaying = false;
  bool shouldStopAutoPlay = false;

  // Filter views based on search query
  Map<String, List<Map<String, dynamic>>> get filteredViews {
    if (searchQuery.isEmpty) {
      return views;
    }

    Map<String, List<Map<String, dynamic>>> filtered = {};

    for (var groupEntry in views.entries) {
      List<Map<String, dynamic>> filteredItems = groupEntry.value
          .where((item) => item['title']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();

      if (filteredItems.isNotEmpty) {
        filtered[groupEntry.key] = filteredItems;
      }
    }

    return filtered;
  }

  int getAllGroupViewCounts() {
    int totalCount = 0;
    for (var groupEntry in views.entries) {
      totalCount += groupEntry.value.length;
    }
    return totalCount;
  }

  Future<int> requestInputIndex() async {
    int? inputIndex = await showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Start Index'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter index (1-based)'),
            onSubmitted: (value) {
              Navigator.of(context).pop(int.tryParse(value));
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
    return inputIndex ?? 0; // Default to 1 if cancelled
  }

  // Auto-play all views with 2 second delay
  Future<void> _autoPlayAllViews(int startIndex, int ms) async {
    startIndex = await requestInputIndex();

    setState(() {
      isAutoPlaying = true;
      shouldStopAutoPlay = false;
    });

    var count = getAllGroupViewCounts();
    var index = 0;
    for (var groupEntry in views.entries) {
      for (var item in groupEntry.value) {
        if (shouldStopAutoPlay) {
          break;
        }
        index++;

        // Skip views before startIndex
        if (index < startIndex) {
          continue;
        }

        var currentViewName = item['view'].toString();
        prefs.setString('current_view', item["relativePath"]);
        printo("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        printo("CURRENT VIEW: ${currentViewName} ($index/${count})");
        printo("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        offAll(item['view']);
        await Future.delayed(Duration(milliseconds: ms));
      }
      if (shouldStopAutoPlay) {
        break;
      }
    }

    setState(() {
      isAutoPlaying = false;
      shouldStopAutoPlay = false;
    });

    flutterErrorHandlerSaveLogs();
    offAll(AppView());
  }

  // Auto-play and capture all views with 4 second delay, capture after 2 seconds
  Future<void> _autoPlayAndCaptureAllViews() async {
    setState(() {
      isAutoPlaying = true;
      shouldStopAutoPlay = false;
    });

    List<String> screenshots = [];

    var number = 1;
    var viewCount = 0;
    for (var groupEntry in views.entries) {
      viewCount += groupEntry.value.length;
    }

    for (var groupEntry in views.entries) {
      for (var item in groupEntry.value) {
        if (shouldStopAutoPlay) {
          break;
        }

        var className = item['className'].toString();

        WidgetsToImageController widgetToImagecontroller =
            WidgetsToImageController();

        offAll(WidgetsToImage(
          child: item["view"],
          controller: widgetToImagecontroller,
        ));
        await Future.delayed(Duration(seconds: 2));

        if (shouldStopAutoPlay) {
          break;
        }

        // Capture screenshot
        try {
          Uint8List? bytes = await widgetToImagecontroller.capture();
          if (bytes != null) {
            //if windows, create file n.png to output directory
            if (!kIsWeb && Platform.isWindows) {
              var dirPath =
                  "C:\Users\Administrator\Desktop\reusekit_screenshots";
              if (Directory("${dirPath}").existsSync() == false) {
                Directory("${dirPath}").createSync();
              }
              String outputPath = '${dirPath}\\$className.png';
              await File(outputPath).writeAsBytes(bytes);
              print('Screenshot saved to $outputPath');
            }
            //else if android save to temporary directory
            else if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
              await ImageGallerySaverPlus.saveImage(bytes);
            }

            String base64Image = base64Encode(bytes);
            screenshots.add(base64Image);
          }
          print('Screenshot captured: ${item['title']} ($number/${viewCount})');
          number++;
        } catch (e) {
          print('Error capturing screenshot: $e');
        }

        await Future.delayed(Duration(seconds: 1));
      }
      if (shouldStopAutoPlay) {
        break;
      }
    }

    setState(() {
      isAutoPlaying = false;
      shouldStopAutoPlay = false;
    });

    if (!shouldStopAutoPlay) {
      offAll(AppView());
    }
  }

  void _stopAutoPlay() {
    setState(() {
      shouldStopAutoPlay = true;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initSharedPreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalItems =
        filteredViews.values.fold(0, (sum, list) => sum + list.length);
    int originalTotal = views.values.fold(0, (sum, list) => sum + list.length);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'App Navigation ${searchQuery.isEmpty ? originalTotal : '$totalItems/$originalTotal'}'),
        actions: [
          IconButton(
            icon: Icon(isAppsGridMode ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isAppsGridMode = !isAppsGridMode;
              });
            },
            tooltip: isAppsGridMode ? 'List View' : 'Apps Grid',
          ),
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: isAutoPlaying ? null : () => _autoPlayAllViews(0, 100),
            tooltip: 'Play All Views (Fast)',
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: isAutoPlaying ? null : () => _autoPlayAllViews(0, 2000),
            tooltip: 'Play All Views',
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: isAutoPlaying ? null : _autoPlayAndCaptureAllViews,
            tooltip: 'Capture All Views',
          ),
        ],
      ),
      floatingActionButton: isAutoPlaying
          ? FloatingActionButton(
              onPressed: _stopAutoPlay,
              backgroundColor: dangerColor,
              tooltip: 'Stop AutoPlay',
              child: Icon(
                Icons.stop,
                color: Colors.white,
              ),
            )
          : null,
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: QTextField(
              label: "Search Views",
              value: searchQuery,
              hint: "Type to search for views...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),

          // Results
          Expanded(
            child: filteredViews.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          'No views found',
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          'Try searching with different keywords',
                          style: TextStyle(
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : isAppsGridMode
                    ? _AppsGridView(
                        filteredViews: filteredViews,
                        searchQuery: searchQuery,
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: spMd),
                        itemCount: filteredViews.length,
                        itemBuilder: (context, index) {
                          final groupName = filteredViews.keys.elementAt(index);
                          final groupItems = filteredViews[groupName]!;
                          return _GroupSection(
                            groupName: groupName,
                            items: groupItems,
                            searchQuery: searchQuery,
                            groupIndex: index + 1,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class _GroupSection extends StatefulWidget {
  final String groupName;
  final List<Map<String, dynamic>> items;
  final String searchQuery;
  final int groupIndex;

  _GroupSection({
    required this.groupName,
    required this.items,
    this.searchQuery = "",
    required this.groupIndex,
  });

  @override
  State<_GroupSection> createState() => _GroupSectionState();
}

class _GroupSectionState extends State<_GroupSection> {
  bool isExpanded = true;

  // Auto-play views in this group with 2 second delay
  Future<void> _autoPlayGroupViews(int ms) async {
    var index = 0;
    var count = widget.items.length;
    for (var item in widget.items) {
      index++;
      var currentViewName = item['view'].toString();
      prefs.setString('current_view', item["relativePath"]);
      printo("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      printo("CURRENT VIEW: ${currentViewName} ($index/${count})");
      printo("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      offAll(item['view']);
      await Future.delayed(Duration(milliseconds: ms));
    }
    offAll(AppView());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(radiusMd),
              bottom: isExpanded ? Radius.zero : Radius.circular(radiusMd),
            ),
            child: Container(
              height: cardHeaderMaxHeight,
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(radiusMd),
                  bottom: isExpanded ? Radius.zero : Radius.circular(radiusMd),
                ),
              ),
              child: Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: Text(
                      '${widget.groupIndex}. ${widget.groupName} (${widget.items.length})',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 16.0,
                    ),
                    onPressed: () => _autoPlayGroupViews(250),
                    tooltip: 'Play Group Views',
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 16.0,
                    ),
                    onPressed: () => _autoPlayGroupViews(2000),
                    tooltip: 'Play Group Views',
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                    size: 16.0,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            ResponsiveGridView(
              padding: EdgeInsets.all(spSm),
              minItemWidth: 160,
              shrinkWrap: true,
              children: widget.items.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> item = entry.value;
                return StaggeredGridTile.fit(
                  crossAxisCellCount: 1,
                  child: _GridItem(
                    title: item['title'],
                    onTap: item['onTap'],
                    searchQuery: widget.searchQuery,
                    itemIndex: index + 1,
                    appNumber: widget.groupIndex,
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String searchQuery;
  final int? itemIndex;
  final int? appNumber;

  _GridItem({
    required this.title,
    required this.onTap,
    this.searchQuery = "",
    this.itemIndex,
    this.appNumber,
  });
  @override
  Widget build(BuildContext context) {
    var fixedTitle = title;
    //remove "View" from last word if it exists
    if (fixedTitle.endsWith('View')) {
      fixedTitle = fixedTitle.substring(0, fixedTitle.length - 4).trim();
    }
    // Add numbering if both appNumber and itemIndex are provided
    if (appNumber != null && itemIndex != null) {
      fixedTitle = '$appNumber.$itemIndex. $fixedTitle';
    } else if (itemIndex != null) {
      // Fallback to old format if appNumber is not provided
      fixedTitle = '$itemIndex. $fixedTitle';
    }

    // Highlight search query if present
    Widget titleWidget;
    if (searchQuery.isNotEmpty &&
        fixedTitle.toLowerCase().contains(searchQuery.toLowerCase())) {
      final regex = RegExp(RegExp.escape(searchQuery), caseSensitive: false);
      final matches = regex.allMatches(fixedTitle);

      if (matches.isNotEmpty) {
        List<TextSpan> spans = [];
        int lastMatchEnd = 0;

        for (final match in matches) {
          if (match.start > lastMatchEnd) {
            spans.add(TextSpan(
              text: fixedTitle.substring(lastMatchEnd, match.start),
              style: TextStyle(
                fontSize: 10,
                color: textColor,
              ),
            ));
          }

          spans.add(TextSpan(
            text: fixedTitle.substring(match.start, match.end),
            style: TextStyle(
              fontSize: 10,
              color: primaryColor,
              fontWeight: FontWeight.bold,
              backgroundColor: primaryColor.withAlpha(50),
            ),
          ));

          lastMatchEnd = match.end;
        }

        if (lastMatchEnd < fixedTitle.length) {
          spans.add(TextSpan(
            text: fixedTitle.substring(lastMatchEnd),
            style: TextStyle(
              fontSize: 10,
              color: textColor,
            ),
          ));
        }

        titleWidget = RichText(
          text: TextSpan(children: spans),
          overflow: TextOverflow.ellipsis,
        );
      } else {
        titleWidget = Text(
          fixedTitle,
          style: TextStyle(
            fontSize: 10,
            color: textColor,
          ),
          overflow: TextOverflow.ellipsis,
        );
      }
    } else {
      titleWidget = Text(
        fixedTitle,
        style: TextStyle(
          fontSize: 10,
          color: textColor,
        ),
        overflow: TextOverflow.ellipsis,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radiusSm),
        child: Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: primaryColor.withAlpha(50),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(child: titleWidget),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppsGridView extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> filteredViews;
  final String searchQuery;

  _AppsGridView({
    required this.filteredViews,
    this.searchQuery = "",
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 160,
      children: filteredViews.entries.map((groupEntry) {
        return StaggeredGridTile.fit(
          crossAxisCellCount: 1,
          child: _AppGridItem(
            groupName: groupEntry.key,
            items: groupEntry.value,
            searchQuery: searchQuery,
          ),
        );
      }).toList(),
    );
  }
}

class _AppGridItem extends StatelessWidget {
  final String groupName;
  final List<Map<String, dynamic>> items;
  final String searchQuery;

  _AppGridItem({
    required this.groupName,
    required this.items,
    this.searchQuery = "",
  });
  String _formatAppName(String groupName) {
    // Convert snake_case to Title Case
    return groupName
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    String appName = _formatAppName(groupName);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          to(AppViewsDetailView(
            appName: appName,
            groupName: groupName,
            items: items,
            searchQuery: searchQuery,
          ));
        },
        borderRadius: BorderRadius.circular(radiusMd),
        child: Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border.all(
              color: primaryColor.withAlpha(50),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Text(
                          "${items.length} views",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppViewsDetailView extends StatefulWidget {
  final String appName;
  final String groupName;
  final List<Map<String, dynamic>> items;
  final String searchQuery;

  AppViewsDetailView({
    super.key,
    required this.appName,
    required this.groupName,
    required this.items,
    this.searchQuery = "",
  });

  @override
  State<AppViewsDetailView> createState() => _AppViewsDetailViewState();
}

class _AppViewsDetailViewState extends State<AppViewsDetailView> {
  String localSearchQuery = "";

  List<Map<String, dynamic>> get filteredItems {
    if (localSearchQuery.isEmpty) {
      return widget.items;
    }

    return widget.items
        .where((item) => item['title']
            .toString()
            .toLowerCase()
            .contains(localSearchQuery.toLowerCase()))
        .toList();
  }

  // Auto-play views in this app with 2 second delay
  Future<void> _autoPlayAppViews(int ms) async {
    for (var item in filteredItems) {
      item['onTap']();
      await Future.delayed(Duration(milliseconds: ms));
    }
    offAll(AppView());
  }

  @override
  void initState() {
    super.initState();
    localSearchQuery = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.appName} (${filteredItems.length})'),
        actions: [
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: () => _autoPlayAppViews(100),
            tooltip: 'Play All Views',
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () => _autoPlayAppViews(2000),
            tooltip: 'Play All Views',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: QTextField(
              label: "Search ${widget.appName} Views",
              value: localSearchQuery,
              hint: "Type to search for views...",
              onChanged: (value) {
                localSearchQuery = value;
                setState(() {});
              },
            ),
          ),

          // Results
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          'No views found',
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          'Try searching with different keywords',
                          style: TextStyle(
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ResponsiveGridView(
                    padding: EdgeInsets.all(spMd),
                    minItemWidth: 160,
                    children: filteredItems.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> item = entry.value;
                      return StaggeredGridTile.fit(
                        crossAxisCellCount: 1,
                        child: _GridItem(
                          title: item['title'],
                          onTap: item['onTap'],
                          searchQuery: localSearchQuery,
                          itemIndex: index + 1,
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
