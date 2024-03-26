import 'package:afrigas/screen/registermob.dart';
import 'package:afrigas/screen/signmob.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';


class _Scope extends InheritedWidget {
  _Scope({
    Key? key,
    required Widget child,
    required this.state,
  }) : super(key: key, child: child);

  final _WelcomeScreenState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      (oldWidget as _Scope).state != state;
}

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  static _WelcomeScreenState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_Scope>()!.state;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 4; i++) {
      _nodes.add(FocusNode());
      if (i < 2) {
        _formkeys.add(GlobalKey<FormState>());
      }
      _textController.add(TextEditingController());
    }
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
    for (var i = 0; i < 4; i++) {
      _nodes[i].dispose();
      _textController[i].dispose();
    }
  }

  PageController? _pageController;
  final _nodes = <FocusNode>[];
  final _formkeys = <GlobalKey<FormState>>[];
  final _textController = <TextEditingController>[];

  Future<List<Widget>> _firebase() async {
    return <Widget>[
      AppScreen(),

      Signmob(
        formKeys: _formkeys[0],
        textControllers: [_textController[0], _textController[1]],
        nodes: [_nodes[0], _nodes[1]],
      ),
      Registermob(
        formKeys: _formkeys[1],
        textControllers: [_textController[2], _textController[3]],
        nodes: [_nodes[2], _nodes[3]],
      ),
    ];
  }

  int currentPage = 0;

  void onBack() {
    currentPage--;
    _pageController!.animateToPage(
      currentPage,
      duration: Duration(seconds: 1),
      curve: Curves.linear,
    );
  }

  void jumpLogin() {
    _pageController!.animateToPage(
      2,
      duration: Duration(seconds: 1),
      curve: Curves.linear,
    );
  }
  void jumpSign() {
    _pageController!.animateToPage(
      1,
      duration: Duration(seconds: 1),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _Scope(
      state: this,
      child: Scaffold(
        body: Stack(
          children: [
            FutureBuilder<List<Widget>>(
              future: _firebase(),
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  final data = snapshots.data;
                  return PageView.builder(
                    controller: _pageController,
                    onPageChanged: (page) => currentPage = page,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      FocusScope.of(context)
                          .requestFocus(_nodes[index == 0 ? 0 : index + 1]);
                      return data[index];
                    },
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
