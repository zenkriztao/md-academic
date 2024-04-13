import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:academic/theme.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoPlayer extends StatefulWidget {
  final String path;

  const VideoPlayer({super.key, required this.path});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  // Dummy data untuk deskripsi video
  final String videoTitle = '200.000+ Tahun Perjalanan Manusia, dalam 13 Menit';
  final String videoDescription =
      "Dalam perjalanan epik ini, kita menjelajahi jejak masa lalu manusia yang membentang lebih dari 200.000 tahun dalam durasi singkat 13 menit. Terowongan waktu membawa kita melintasi berbagai zaman, dari masa prasejarah yang misterius hingga era modern yang canggih. Dalam perjalanan ini, kita menyaksikan evolusi manusia, dari awal kehidupan manusia purba hingga kecanggihan teknologi masa kini. Kita memelajari pencapaian besar dan peristiwa penting yang membentuk peradaban kita, serta bagaimana perjalanan ini mempengaruhi dunia yang kita tinggali saat ini. Dengan narasi yang mendalam dan visual yang mengesankan, video ini bukan hanya sebuah tutorial, tetapi juga sebuah perjalanan yang mendalam ke dalam sejarah dan evolusi manusia.";

  Future<void> initializeVideo() async {
    videoPlayerController = VideoPlayerController.network(widget.path);
    await videoPlayerController?.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () => debugPrint('Option 1 pressed!'),
            iconData: Icons.chat,
            title: 'Option 1',
          ),
          OptionItem(
            onTap: () => debugPrint('Option 2 pressed!'),
            iconData: Icons.share,
            title: 'Option 2',
          ),
        ];
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    initializeVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: Text(
          "Streaming Belajar",
          style: GoogleFonts.sora(color: whiteColor),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            child: chewieController != null &&
                    chewieController!.videoPlayerController.value.isInitialized
                ? Chewie(
                    controller: chewieController!,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      videoTitle,
                      style: GoogleFonts.sora(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      videoDescription,
                      style: GoogleFonts.sora(
                        fontSize: 14,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Aksi saat tombol ditekan
                          },
                          style: ElevatedButton.styleFrom(
                            primary: greenColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Penjelasan',
                            style: GoogleFonts.sora(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Aksi saat tombol ditekan
                          },
                          style: ElevatedButton.styleFrom(
                            primary: brownColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Mulai Kuis',
                            style: GoogleFonts.sora(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }
}
