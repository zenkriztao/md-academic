import 'package:academic/theme.dart';
import 'package:academic/views/flashcards/components/custom_snackbar.dart';
import 'package:academic/views/flashcards/models/subject_model.dart';
import 'package:academic/views/flashcards/repositories/subject_repository.dart';
import 'package:academic/views/flashcards/screens/chapters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  late Future<List<Subjects>> _subjectFuture;
  final navigatorKey = GlobalKey<NavigatorState>();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController editSubjectController = TextEditingController();

  final SubjectRepository subjectRepository = SubjectRepository();

  @override
  void initState() {
    super.initState();
    _subjectFuture = subjectRepository.getSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Navigator(
        key: navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange[100],
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: whiteColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.orange,
                        Colors.orangeAccent,
                      ],
                    ),
                  ),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Flash ',
                        style: GoogleFonts.sora(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'Card',
                            style: GoogleFonts.sora(
                              color: blueColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: FutureBuilder(
                  future: _subjectFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error ${snapshot.error}',
                        style: GoogleFonts.sora(),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Scaffold(
                        body: SingleChildScrollView(
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset('assets/images/award.gif'),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Belum ada subjek!',
                                    style: GoogleFonts.sora(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: blueColor),
                                  ),
                                  Text(
                                    'Tambahkan dengan menekan ikon +.',
                                    style: GoogleFonts.sora(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        floatingActionButton: FloatingActionButton(
                          onPressed: () {
                            openDialog(context);
                          },
                          backgroundColor: blueColor,
                          child: const Icon(Icons.add,
                              color: Color.fromARGB(255, 225, 223, 216)),
                        ),
                        floatingActionButtonLocation:
                            FloatingActionButtonLocation.endFloat,
                      );
                    } else {
                      return Scaffold(
                        body: GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(20),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: snapshot.data!.map((subject) {
                            return _buildGridItem(subject.id, subject.name);
                          }).toList(),
                        ),
                        floatingActionButton: FloatingActionButton(
                          elevation: 10.0,
                          onPressed: () {
                            openDialog(context);
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 92, 131, 116),
                          child: const Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 225, 223, 216),
                          ),
                        ),
                        floatingActionButtonLocation:
                            FloatingActionButtonLocation.endFloat,
                      );
                    }
                  }),
            ),
          );
        },
      ),
    );
  }

  void openDialog(BuildContext context) {
    showDialog(
        context: navigatorKey.currentContext as BuildContext,
        builder: (context) => Form(
              key: _formKey,
              child: AlertDialog(
                title: Text(
                  "Tambahkan Subjek",
                  style: GoogleFonts.sora(),
                ),
                content: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Silakan masukkan nama subjek";
                      }
                    },
                    controller: subjectController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Masukkan Nama Subjek",
                      hintStyle: GoogleFonts.sora(),
                    )),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Batal',
                        style: GoogleFonts.sora(),
                      )),
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          submitSubject(context, subjectController.text);
                        }
                      },
                      child: Text(
                        'Kirim',
                        style: GoogleFonts.sora(),
                      ))
                ],
              ),
            ));
  }

  void submitSubject(BuildContext context, String subjectName) {
    var uuid = const Uuid();
    String subjectId = uuid.v4();
    Subjects newSubject = Subjects(id: subjectId, name: subjectName);

    subjectRepository.addSubject(newSubject);
    Navigator.of(context).pop();

    setState(() {
      _subjectFuture = subjectRepository.getSubjects();
    });
    showSuccessSnackBar(context, "Subjek berhasil ditambahkan!");
  }

  void openEditDialog(BuildContext context, String id, String oldName) {
    editSubjectController.text = oldName;
    showDialog(
        context: navigatorKey.currentContext as BuildContext,
        builder: (context) => Form(
              key: _formKey,
              child: AlertDialog(
                title: Text(
                  "Edit Nama Subjek",
                  style: GoogleFonts.sora(),
                ),
                content: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Silakan masukkan nama subjek.";
                      }
                    },
                    controller: editSubjectController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Masukkan Nama Subjek",
                      hintStyle: GoogleFonts.sora(),
                    )),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Batal',
                        style: GoogleFonts.sora(),
                      )),
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          editSubject(context, id, editSubjectController.text);
                        }
                      },
                      child: Text(
                        'Kirim',
                        style: GoogleFonts.sora(),
                      ))
                ],
              ),
            ));
  }

  void editSubject(BuildContext context, String id, String subjectName) {
    subjectRepository.editSubject(id, subjectName);
    Navigator.of(context).pop();

    setState(() {
      _subjectFuture = subjectRepository.getSubjects();
    });
    showSuccessSnackBar(context, "Subjek berhasil diedit!");
  }

  // Card untuk setiap subjek
  Widget _buildGridItem(String id, String text) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChaptersScreen(subjectId: id)));
      },
      child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: brownColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: GoogleFonts.sora(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 244, 245, 252),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: PopupMenuButton(
                    icon: const Icon(Icons.more_vert,
                        color: Color.fromARGB(255, 244, 245, 252)),
                    itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                              child: Row(
                                children: [
                                  const Icon(Icons.edit),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Edit',
                                    style: GoogleFonts.sora(),
                                  )
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
                                  style: GoogleFonts.sora(
                                    color: Colors.red.shade600,
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              confirmDelete(context, id, text);
                            },
                          ),
                        ]),
              )
            ],
          )),
    );
  }

  // dialog untuk konfirmasi penghapusan subjek
  void confirmDelete(BuildContext context, String id, String text) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Konfirmasi",
                style: GoogleFonts.sora(),
              ),
              content: RichText(
                  text: TextSpan(
                      text: "Apakah Anda yakin ingin menghapus subjek: ",
                      style: GoogleFonts.sora(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: text,
                        style: GoogleFonts.sora(
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(text: " ?", style: GoogleFonts.sora()),
                    TextSpan(
                        text:
                            "\nAnda akan kehilangan semua kartu kilat yang ada.",
                        style: GoogleFonts.sora())
                  ])),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      'Batal',
                      style: GoogleFonts.sora(),
                    )),
                TextButton(
                    onPressed: () {
                      subjectRepository.removeSubject(id);
                      Navigator.of(context).pop();
                      setState(() {
                        _subjectFuture = subjectRepository.getSubjects();
                      });
                      showSuccessSnackBar(context, "Subjek Dihapus!");
                    },
                    child: Text(
                      'Konfirmasi',
                      style: GoogleFonts.sora(color: Colors.red),
                    )),
              ],
            ));
  }
}
