
import 'package:flutter/cupertino.dart';
import 'package:revent/models/commons.dart';
import 'package:revent/models/event.dart';
import 'package:revent/models/location.dart';
import 'package:revent/widgets/event_map_widget.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: EventMapWidget(<Event>[],),
    );
  }
}
