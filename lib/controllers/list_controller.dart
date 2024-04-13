import 'package:academic/main.dart';
import 'package:academic/models/rating.dart';
import 'package:academic/views/mood/detail.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:academic/services/db.dart';

class RatingListController {
  PagingController<int, Rating> pagingController =
      PagingController(firstPageKey: 0);
  final int pageSize = 10;

  void fetchRatings(int pageKey) {
    final List<Rating> ratings = DatabaseService.getSortedRatings(
        pageKey * pageSize, (pageKey + 1) * pageSize);
    ratings.length < pageSize
        ? pagingController.appendLastPage(ratings)
        : pagingController.appendPage(ratings, pageKey + 1);
  }

  void onTap(Rating rating) {
    Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => Detail(
              rating: rating,
              refresher: (_) {
                pagingController.refresh();
              })),
    );
  }
}
