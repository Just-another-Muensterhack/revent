import 'package:flutter/material.dart';

class FloatingNavbarItem {
  final String label;
  final Icon icon;
  final Widget customWidget;

  FloatingNavbarItem({
    this.icon,
    this.label,
    this.customWidget,
  });
}

class FloatingNavbar extends StatelessWidget {
  final List<FloatingNavbarItem> items;
  final int currentIndex;
  final void Function(int val) onTap;
  final Color selectedBackgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Color backgroundColor;

  FloatingNavbar({
    Key key,
    this.items,
    this.currentIndex,
    this.onTap,
    this.backgroundColor = Colors.black,
    this.selectedBackgroundColor = Colors.white,
    this.selectedItemColor = Colors.black,
    this.unselectedItemColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Colors.transparent,
        elevation: 8,
        child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
            child: Container(
                height: 64,
                padding: EdgeInsets.fromLTRB(48, 0, 48, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28.0),
                    color: Color.fromRGBO(130, 81, 202, 1.0)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: items
                        .asMap()
                        .map((i, f) =>
                        MapEntry(i, Container(
                            child: Container(
                                child: IconButton(
                                  tooltip: f.label,
                                  iconSize: 32,
                                  icon: f.icon,
                                  color: currentIndex == i ? Colors.white : Colors.black,
                                  onPressed: () {
                                    onTap(i);
                                  },
                                )
                            )
                        )))
                        .values
                        .toList()
                )
            )
        )
    );
  }
}
