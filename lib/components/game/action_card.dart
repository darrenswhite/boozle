import 'package:boozle/components/game/action.dart';
import 'package:boozle/components/players/player.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final Action action;
  final Player player;

  ActionCard(this.action, this.player, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color playerColor =
        player != null && action.affectsPlayer ? player.color : null;
    Color cardColor = action.image != null
        ? Theme.of(context).primaryColor.withOpacity(0.75)
        : null;
    List<Widget> columnWidgets = [];

    columnWidgets.add(new ListTile(
      title: new Text(action.name,
          style: new TextStyle(fontWeight: FontWeight.w500)),
      leading: new Icon(
        Icons.arrow_forward,
        color: playerColor,
      ),
    ));

    columnWidgets.add(new Divider());

    if (player != null && action.affectsPlayer) {
      columnWidgets.add(new ListTile(
        title: new Text(player.name,
            style: new TextStyle(fontWeight: FontWeight.w500)),
        leading: new Icon(
          Icons.contacts,
          color: playerColor,
        ),
      ));
    }

    columnWidgets.add(new ListTile(
      title: new Text(action.description),
      leading: new Icon(
        Icons.description,
        color: playerColor,
      ),
    ));

    return new Card(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: columnWidgets,
      ),
      color: cardColor,
    );
  }
}
