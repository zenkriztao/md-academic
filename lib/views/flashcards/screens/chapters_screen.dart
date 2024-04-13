import 'package:academic/theme.dart';
import 'package:academic/views/flashcards/components/custom_snackbar.dart';
import 'package:academic/views/flashcards/models/subject_model.dart';
import 'package:academic/views/flashcards/repositories/subject_repository.dart';
import 'package:academic/views/flashcards/screens/flashcard_screen.dart';
import 'package:academic/views/flashcards/screens/subject_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChaptersScreen extends StatefulWidget {
  final String subjectId;

  const ChaptersScreen({Key? key, required this.subjectId}) : super(key: key);

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  final _formKey = GlobalKey<FormState>();
  late Future<Subjects?> _subjectFuture;
  final SubjectRepository subjectRepository = SubjectRepository();

  final navigatorKey = GlobalKey<NavigatorState>();

  final TextEditingController chapterController = TextEditingController();
  final TextEditingController editChapterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _subjectFuture = subjectRepository.getSubjectById(widget.subjectId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SubjectScreen()));
        return true;
      },
      child: FutureBuilder(
          future: _subjectFuture,
          builder: (context, AsyncSnapshot<Subjects?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error ${snapshot.error}');
            } else {
              Subjects subject = snapshot.data!;
              List<String> chapters =
                  subject.chapters != null ? subject.chapters!.split(",") : [];
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    subject.name,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.sora(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: blueColor,
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: blueColor,
                  onPressed: () {
                    openDialog(context, subject.id);
                  },
                  child: const Icon(Icons.add,
                      color: Color.fromARGB(255, 225, 223, 216)),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                body: chapters.isNotEmpty
                    ? ListView(
                        padding: const EdgeInsets.all(10),
                        children: chapters.map((each) {
                          return _buildCard(subject.id, each);
                        }).toList(),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/bab.gif',
                              height: 300,
                              width: 300,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Belum ada bab!',
                              style: GoogleFonts.sora(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: blueColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Tambahkan menggunakan ikon +.',
                              style: GoogleFonts.sora(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            }
          }),
    );
  }

  void openDialog(BuildContext context, String id) {
    showDialog(
        context: context,
        builder: (context) => Form(
              key: _formKey,
              child: AlertDialog(
                title: Text("Tambah Bab", style: GoogleFonts.sora()),
                content: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Masukkan nama bab!";
                    }
                  },
                  controller: chapterController,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: "Masukkan Nama Bab",
                      hintStyle: GoogleFonts.sora()),
                  textCapitalization: TextCapitalization.words,
                ),
                contentPadding: const EdgeInsets.all(20),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Batal', style: GoogleFonts.sora())),
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          submitChapter(context, id, chapterController.text);
                        }
                      },
                      child: Text('Kirim', style: GoogleFonts.sora()))
                ],
              ),
            ));
  }

  void submitChapter(
      BuildContext context, String subjectId, String chapterName) async {
    await subjectRepository.addChapterToSubject(subjectId, chapterName);
    Navigator.of(context).pop();

    setState(() {
      _subjectFuture = subjectRepository.getSubjectById(widget.subjectId);
    });
    showSuccessSnackBar(context, "Bab ditambahkan!");
  }

  Widget _buildCard(String id, String text) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FlashcardScreen(subjectId: id, chapterName: text)));
      },
      child: Card(
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tileColor: brownColor,
          title: Text(
            text,
            style: GoogleFonts.sora(
              color: const Color.fromARGB(255, 244, 245, 252),
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1.2,
            ),
          ),
          trailing: PopupMenuButton(
              icon: const Icon(Icons.more_vert,
                  color: Color.fromARGB(255, 244, 245, 252)),
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                        child: Row(
                          children: [
                            const Icon(Icons.edit),
                            const SizedBox(width: 8),
                            Text('Edit', style: GoogleFonts.sora())
                          ],
                        ),
                        onTap: () {
                          openEditDialog(context, id, text);
                        }),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red.shade700),
                          const SizedBox(width: 8),
                          Text(
                            'Hapus',
                            style: GoogleFonts.sora(color: Colors.red.shade600),
                          )
                        ],
                      ),
                      onTap: () {
                        confirmDelete(context, id, text);
                      },
                    ),
                  ]),
        ),
      ),
    );
  }

  void openEditDialog(BuildContext context, String id, String oldName) {
    editChapterController.text = oldName;
    showDialog(
        context: context,
        builder: (context) => Form(
              key: _formKey,
              child: AlertDialog(
                title: Text("Edit Nama Bab", style: GoogleFonts.sora()),
                content: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukkan nama bab!";
                      }
                    },
                    controller: editChapterController,
                    autofocus: true,
                    decoration: InputDecoration(
                        hintText: "Masukkan Nama Bab",
                        hintStyle: GoogleFonts.sora())),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Batal', style: GoogleFonts.sora())),
                  TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await subjectRepository.editChapter(
                              id, editChapterController.text, oldName);
                          Navigator.of(context).pop();
                          setState(() {
                            _subjectFuture =
                                subjectRepository.getSubjectById(id);
                          });
                          showSuccessSnackBar(context, "Bab berhasil diedit!");
                        }
                      },
                      child: Text('Kirim', style: GoogleFonts.sora()))
                ],
              ),
            ));
  }

  // dialog to confirm chapter deletion
  void confirmDelete(BuildContext context, String id, String text) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Konfirmasi", style: GoogleFonts.sora()),
              content: RichText(
                  text: TextSpan(
                      text: "Apakah anda yakin ingin menghapus bab : ",
                      style:
                          GoogleFonts.sora(fontSize: 20, color: Colors.black),
                      children: <TextSpan>[
                    TextSpan(
                        text: text,
                        style: GoogleFonts.sora(fontWeight: FontWeight.bold)),
                    TextSpan(text: " ?")
                  ])),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('Batal', style: GoogleFonts.sora())),
                TextButton(
                    onPressed: () async {
                      await subjectRepository.removeChapterFromSubject(
                          id, text);
                      Navigator.of(context).pop();
                      setState(() {
                        _subjectFuture =
                            subjectRepository.getSubjectById(widget.subjectId);
                      });
                      showSuccessSnackBar(context, "Bab dihapus!");
                    },
                    child: Text(
                      'Konfirmasi',
                      style: GoogleFonts.sora(color: Colors.red),
                    )),
              ],
            ));
  }
}
