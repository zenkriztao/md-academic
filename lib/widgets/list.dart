import 'package:academic/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:academic/controllers/list_controller.dart';
import 'package:academic/models/rating.dart';
import 'package:academic/widgets/list_item.dart';

class RatingList extends StatefulWidget {
  final RatingListController controller;

  const RatingList({super.key, required this.controller});

  @override
  State<RatingList> createState() => _RatingListState();
}

class _RatingListState extends State<RatingList> {
  @override
  void initState() {
    super.initState();
    widget.controller.pagingController.addPageRequestListener((pageKey) {
      widget.controller.fetchRatings(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Rating>.separated(
      separatorBuilder: (context, index) => Divider(
        color: brownColor,
        thickness: 1.0,
      ),
      pagingController: widget.controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Rating>(
        noItemsFoundIndicatorBuilder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Anda belum memiliki rating.",
                textAlign: TextAlign.center,
                style: GoogleFonts.sora(
                  color: brownColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Tekan tombol rating baru untuk menambahkan.",
                textAlign: TextAlign.center,
                style: GoogleFonts.sora(
                  color: whiteColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        itemBuilder: (context, item, index) => ListTile(
          tileColor: whiteColor,
          title: ListItem(
            rating: item,
            controller: widget.controller,
          ),
          onTap: () => widget.controller.onTap(item),
        ),
      ),
    );
  }
}
