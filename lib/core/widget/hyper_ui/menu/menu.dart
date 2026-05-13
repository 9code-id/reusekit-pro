import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class QGridMenu extends StatelessWidget {
  final int crossAxisCount;
  final double? childAspectRatio;
  final List<Map<String, dynamic>> items;

  const QGridMenu({
    super.key,
    required this.items,
    this.crossAxisCount = 2,
    this.childAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final safeCrossAxisCount =
                constraints.maxWidth < 360 ? 1 : crossAxisCount.clamp(1, 6);

            return GridView.builder(
              padding: EdgeInsets.all(spXl),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: childAspectRatio ?? (1.0 / 0.6),
                crossAxisCount: safeCrossAxisCount,
                mainAxisSpacing: spMd,
                crossAxisSpacing: spMd,
              ),
              itemCount: items.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var item = items[index];
                return InkWell(
                  onTap: () {
                    if (item["on_tap"] != null) {
                      item["on_tap"]();
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => item["view"]),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            child: FittedBox(
                              child: Icon(
                                item["icon"],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: spXs),
                          child: Text(
                            '${item["label"]}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: fsMd,
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

/*
//#TEMPLATE q_menu
QGridMenu(
  items: [
    {
      "label": "Product",
      "icon": Icons.store,
      "view": FavoriteView(),
    },
    {
      "label": "Customer",
      "icon": Icons.people,
      "view": FavoriteView(),
    },
    {
      "label": "Supplier",
      "icon": Icons.emoji_people,
      "view": FavoriteView(),
    },
    {
      "label": "User",
      "icon": Icons.person,
      "view": FavoriteView(),
    },
    {
      "label": "Report",
      "icon": Icons.list_alt,
      "view": FavoriteView(),
    },
    {
      "label": "Stock",
      "icon": Icons.numbers,
      "view": FavoriteView(),
    },
    {
      "label": "Export/Import",
      "icon": Icons.import_contacts,
      "view": FavoriteView(),
    },
    {
      "label": "Backup/Restore",
      "icon": Icons.backup,
      "view": FavoriteView(),
    }
  ],
),
//#END
*/
