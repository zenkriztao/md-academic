import 'package:academic/widgets/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    Key? key,
    required this.controller,
    required this.expanded,
    required this.onMenuTap,
  }) : super(key: key);

  final TextEditingController controller;
  final bool expanded;
  final onMenuTap;

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  int tab = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      width: MediaQuery.of(context).size.width,
      height: widget.expanded
          ? MediaQuery.of(context).size.height * 0.35
          : MediaQuery.of(context).size.height * 0.19,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Hi, Akshay.",
                    style: TextStyle(
                        color: Color(0xFF343434),
                        fontSize: 24,
                        fontFamily: 'Red Hat Display',
                        fontWeight: material.FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    child: material.CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                    onTap: widget.onMenuTap,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CupertinoTextField(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: material.Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      offset: Offset(0, 10),
                      color: Color(0x1A636363),
                    ),
                  ]),
              padding: EdgeInsets.all(10),
              style: TextStyle(
                  color: Color(0xFF343434),
                  fontSize: 18,
                  fontFamily: 'Red Hat Display'),
              enableInteractiveSelection: true,
              controller: widget.controller,
              expands: false,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter
              ],
              keyboardType: TextInputType.text,
              suffix: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.asset(
                  'assets/images/icon/avatar.png',
                  width: 36,
                  height: 36,
                ),
              ),
              textInputAction: TextInputAction.search,
              textCapitalization: TextCapitalization.words,
              placeholder: "Search",
              placeholderStyle: TextStyle(
                  color: Color(0xFFADADAD),
                  fontSize: 18,
                  fontFamily: 'Red Hat Display'),
            ),
          ),
          widget.expanded
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.165,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 10, 30),
                        child: CardWidget(
                          gradient: false,
                          button: true,
                          duration: 200,
                          border: tab == index
                              ? Border(
                                  bottom: BorderSide(
                                      color: tab == 0
                                          ? Color(0xFF2828FF)
                                          : tab == 1
                                              ? Color(0xFFFF2E2E)
                                              : tab == 2
                                                  ? Color(0xFFFFD700)
                                                  : Color(0xFF33FF33),
                                      width: 5),
                                )
                              : null,
                          child: Center(
                            child: Column(
                              mainAxisAlignment:
                                  material.MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/icon/avatar.png',
                                  width: 36,
                                  height: 36,
                                ),
                                Text(index == 0
                                    ? "Maths"
                                    : index == 1
                                        ? "Physics"
                                        : index == 2
                                            ? "Chemistry"
                                            : "Biology")
                              ],
                            ),
                          ),
                          func: () {
                            setState(() {
                              tab = index;
                            });
                          },
                        ),
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
