import 'dart:convert';
import 'dart:io';
import 'package:academic/models/video_list_model.dart';
import 'package:http/http.dart';

class Repository {
  final videoBaseUrl = 'www.googleapis.com';

  Future<List<VideoList>> getVideoList() async {
    Map<String, String> parameter = {
      'part': 'snippet',
      'playlistId': "PLCnD2jU_siVqL0uTAXDfPunGepfVIF_59",
      'maxResults': '50',
      'key': "AIzaSyAAQl8ycfWmSeV89694GPrSAab_r9lUYtg",
    };
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    Uri uri = Uri.https(videoBaseUrl, '/youtube/v3/playlistItems', parameter);

    try {
      Response response = await get(uri, headers: header);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> itemList = data['items'];
        final List<VideoList> videoList =
            itemList.map((item) => VideoList.fromJson(item)).toList();
        return videoList;
      } else {
        throw Exception('Failed to load video list');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<VideoList> getVideoById({required String id}) async {
    Map<String, String> parameter = {
      'part': 'snippet',
      'id': id,
      'key': "AIzaSyAAQl8ycfWmSeV89694GPrSAab_r9lUYtg",
    };
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    Uri uri = Uri.https(videoBaseUrl, '/youtube/v3/videos', parameter);

    try {
      Response response = await get(uri, headers: header);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> itemList = data['items'];
        final video = VideoList.fromJson(itemList[0]);
        return video;
      } else {
        throw Exception('Failed to load video');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }
}
