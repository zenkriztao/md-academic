import 'package:academic/common/gap.dart';
import 'package:academic/repository/repostiory.dart';
import 'package:academic/theme.dart';
import 'package:academic/views/videos/videoplay_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});
  static const routeName = '/video_page';

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: blueColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigasi kembali ke halaman sebelumnya
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Video',
                style: GoogleFonts.sora(color: whiteColor, fontSize: 20)),
          ],
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: Repository().getVideoList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 8),
                separatorBuilder: (context, index) => const VerticalGap10(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data![index];
                  final formattedDate =
                      formatRelativeTime(data.snippet!.publishedAt.toString());
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayer(
                            path:
                                "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                data.snippet!.thumbnails!.standard!.url
                                    .toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      'https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const HorizontalGap10(),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.snippet!.title.toString(),
                                      style: GoogleFonts.sora(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const VerticalGap5(),
                                    Text(
                                      '${data.snippet!.channelTitle} • $formattedDate',
                                      style: GoogleFonts.sora(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: blueColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  String formatRelativeTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 0) {
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'just now';
    }
  }
}
