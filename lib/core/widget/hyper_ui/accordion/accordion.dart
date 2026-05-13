import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AccordionSection extends StatelessWidget {
  final String title;
  final List<AccordionItem> children;

  const AccordionSection(
      {super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: fsLg,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        ...children,
      ],
    );
  }
}

class AccordionItem extends StatefulWidget {
  final String title;
  final Widget content;
  final IconData? icon;

  const AccordionItem({
    super.key,
    required this.title,
    required this.content,
    this.icon,
  });

  @override
  _AccordionItemState createState() => _AccordionItemState();
}

class _AccordionItemState extends State<AccordionItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              child: Row(
                children: [
                  if (widget.icon != null) Icon(widget.icon, size: iconSm),
                  if (widget.icon != null) SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: textColor,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [widget.content],
              ),
            ),
        ],
      ),
    );
  }
}
