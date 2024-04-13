import 'package:academic/models/behavior_models.dart';
import 'package:academic/theme.dart';
import 'package:academic/views/article/behavior_list_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BehaviorDictionaryPage extends StatefulWidget {
  const BehaviorDictionaryPage({super.key});

  @override
  State<BehaviorDictionaryPage> createState() => _BehaviorDictionaryPageState();
}

class _BehaviorDictionaryPageState extends State<BehaviorDictionaryPage> {
  List<BehaviorOverview>? behaviorOverviews;

  @override
  void initState() {
    super.initState();
    loadBehaviorOverviews();
  }

  void loadBehaviorOverviews() async {
    List<BehaviorOverview> data = await BehaviorOverview.getAllFromFirestore();
    setState(() {
      behaviorOverviews = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: blueColor,
            floating: true,
            snap: true,
            toolbarHeight: 100,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Artikel',
                  style: GoogleFonts.sora(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: whiteColor),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Material(
                  borderRadius: BorderRadius.circular(50),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: InkWell(
                    onTap: () {
                      if (behaviorOverviews != null) {
                        showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(behaviorOverviews!),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Cari Artikel',
                              style: GoogleFonts.sora(fontSize: 15)),
                          const Icon(Icons.search),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: behaviorOverviews != null
                  ? ListView.builder(
                      itemCount: behaviorOverviews?.length,
                      itemBuilder: (context, index) {
                        var behaviorOverview = behaviorOverviews?[index];
                        return BehaviorListItem(behaviorOverview!);
                      },
                    )
                  : Center(
                      child: Text('No behavior overviews found.'),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Do you want exit?'),
            content: Text('Kamu ingin Do you want exit??'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: greenColor,
                    textStyle: GoogleFonts.sora(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                style: ElevatedButton.styleFrom(
                    primary: redColor,
                    textStyle: GoogleFonts.sora(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<BehaviorOverview> behaviorOverviews;

  CustomSearchDelegate(this.behaviorOverviews);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<BehaviorOverview> matchQuery = [];
    for (BehaviorOverview behaviorOverview in behaviorOverviews) {
      if (behaviorOverview.title.toLowerCase().contains(query.toLowerCase()) ||
          behaviorOverview.description
              .toLowerCase()
              .contains(query.toLowerCase())) {
        matchQuery.add(behaviorOverview);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return BehaviorListItem(result);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
