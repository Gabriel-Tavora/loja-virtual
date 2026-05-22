import 'package:flutter/material.dart';

class DrawerPageTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  const DrawerPageTile(
    this.icon,
    this.text,
    this.controller,
    this.page, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentPage =
        controller.hasClients ? controller.page?.round() ?? 0 : 0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: SizedBox(
          height: 65,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: currentPage == page
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
              const SizedBox(width: 20),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: currentPage == page
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
