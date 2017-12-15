import 'package:boozle/components/game/action.dart';
import 'package:boozle/components/players/player.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  static final tweenIn = new Tween<Offset>(
    begin: const Offset(-1.0, 0.0),
    end: Offset.zero,
  );
  static final tweenOut = new Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.0, 0.0),
  );

  final Action action;
  final Player player;

  ActionCard(this.action, this.player, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget actionWidget = buildAction(context);
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (action.image != null) {
      return new Stack(
        children: <Widget>[
          new DecoratedBox(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage(action.image), fit: BoxFit.cover),
            ),
            child: new Container(),
          ),
          new Column(
            mainAxisAlignment:
                landscape ? MainAxisAlignment.end : MainAxisAlignment.center,
            children: <Widget>[
              new Card(
                color: Theme.of(context).primaryColor.withAlpha(100),
                child: actionWidget,
              ),
            ],
          ),
        ],
      );
    }

    return new Card(child: actionWidget);
  }

  Widget buildAction(BuildContext context) {
    Color playerColor =
        player != null && action.affectsPlayer ? player.color : null;
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

    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: columnWidgets,
    );
  }

  Widget slide(Animation<double> parent, Tween<Offset> tween, Curve curve) {
    return new SlideTransition(
      position: tween.animate(new CurvedAnimation(
        parent: parent,
        curve: curve,
      )),
      child: this,
    );
  }

  Widget slideIn(Animation<double> parent) {
    return slide(parent, tweenIn, Curves.elasticOut);
  }

  Widget slideOut(Animation<double> parent) {
    return slide(parent, tweenOut, Curves.elasticIn);
  }
}
