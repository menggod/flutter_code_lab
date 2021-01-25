import 'package:flutter/material.dart';

class LeakCheckWidget extends StatefulWidget {
  final Widget child;

  LeakCheckWidget({this.child});

  @override
  _LeakCheckWidgetState createState() => _LeakCheckWidgetState(child);
}

class _LeakCheckWidgetState extends State<LeakCheckWidget> {
  final Widget _child;

  _LeakCheckWidgetState(this._child);

  @override
  Widget build(BuildContext context) {
    return _child;
  }

  @override
  void dispose() {
    // resolveTree(context);
    super.dispose();
    debugPrint('menggod leak_widget dispose: ');
  }

  RenderObjectElement resolveTree(BuildContext context) {
    Element currentPage;
    List<RenderObjectElement> inBounds = new List();
    BuildContext _buildContext = context;
    ModalRoute rootRoute = ModalRoute.of(context);

    void filter(Element element) {
      ModalRoute route = ModalRoute.of(element);
      debugPrint(
          'menggod leak_widget filter: ${rootRoute.settings.name}  ${route.settings.name} ${element.widget}');
      element.visitChildren(filter);
    }

    _buildContext.visitChildElements(filter);
    RenderObjectElement topElement;
    ModalRoute route = currentPage != null ? ModalRoute.of(currentPage) : null;
    return topElement;
  }
}
